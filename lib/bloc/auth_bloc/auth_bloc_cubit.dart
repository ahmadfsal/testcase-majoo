import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:majootestcase/bloc/home_bloc/home_bloc_cubit.dart';
import 'package:majootestcase/helper/db_helper.dart';
import 'package:majootestcase/models/user.dart';
import 'package:majootestcase/ui/auth/login_page.dart';
import 'package:majootestcase/ui/home/home_bloc_screen.dart';
import 'package:majootestcase/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_bloc_state.dart';

class AuthBlocCubit extends Cubit<AuthBlocState> {
  AuthBlocCubit() : super(AuthBlocInitialState());

  void fetchHistoryLogin() async {
    emit(AuthBlocInitialState());
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool? isLoggedIn = sharedPreferences.getBool(StorageKeyConstant.isLoggedIn);

    if (isLoggedIn == null) {
      emit(AuthBlocLoginState());
    } else {
      if (isLoggedIn) {
        emit(AuthBlocLoggedInState());
      } else {
        emit(AuthBlocLoginState());
      }
    }
  }

  void loginUser(User user, BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    DatabaseHelper databaseHelper = DatabaseHelper.instance;
    final connectivity = Connectivity();

    try {
      emit(AuthBlocLoadingState());
      List<Map<String, dynamic>>? data =
          await databaseHelper.getByEmailAndPassword(
        user.email,
        user.password,
      );

      if (data!.isNotEmpty) {
        await sharedPreferences.setBool(StorageKeyConstant.isLoggedIn, true);
        String data = user.toJson().toString();
        await sharedPreferences.setString(StorageKeyConstant.userValue, data);
        emit(AuthBlocLoggedInState());

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Login Berhasil'),
        ));

        gotoHomepage(context, connectivity);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Login gagal, periksa kembali inputan anda'),
        ));
      }
    } catch (e) {}
  }

  void registerUser(User user, BuildContext context) async {
    Connectivity connectivity = Connectivity();
    DatabaseHelper db = DatabaseHelper.instance;
    int? result = await db.insert(user);

    if (result != 0) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Register Berhasil'),
      ));
      gotoHomepage(context, connectivity);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Email sudah terdaftar'),
      ));
    }
  }

  void logout(BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // Clear saved preferences from local storage
    await sharedPreferences.clear();
    // Close Alert Dialog
    Navigator.pop(context);
    // Pop to login screen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (context) => AuthBlocCubit(),
          child: LoginPage(),
        ),
      ),
    );
  }

  void gotoHomepage(BuildContext context, Connectivity connectivity) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (context) => HomeBlocCubit(connectivity: connectivity),
          child: HomeBlocScreen(),
        ),
      ),
    );
  }
}
