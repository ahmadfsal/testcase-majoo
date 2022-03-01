import 'dart:io';
import 'package:majootestcase/models/user.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static const _databaseName = "majoo_testcase.db";
  static const _databaseVersion = 1;

  static const table = 'users';

  static const columnId = 'id';
  static const columnUsername = 'username';
  static const columnEmail = 'email';
  static const columnPassword = 'password';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(
      'CREATE TABLE $table ($columnId INTEGER PRIMARY KEY, '
      '$columnUsername TEXT, $columnEmail TEXT, $columnPassword TEXT)',
    );
  }

  Map<String, dynamic> rows(User user) {
    return {
      columnUsername: user.userName,
      columnEmail: user.email,
      columnPassword: user.password
    };
  }

  Future<int?> insert(User user) async {
    Database? db = await instance.database;

    // Check if email is already exist in database
    List<Map<String, dynamic>>? data = await db?.query(
      table,
      where: '$columnEmail = ?',
      whereArgs: [user.email],
    );

    if (data!.isEmpty) {
      // return "id" from inserted row
      return await db?.insert(table, rows(user));
    } else {
      return 0;
    }
  }

  Future<List<Map<String, dynamic>>?> getByEmailAndPassword(
      String email, String password) async {
    Database? db = await instance.database;
    return await db?.query(
      table,
      where: '$columnEmail = ? AND $columnPassword = ?',
      whereArgs: [email, password],
    );
  }
}
