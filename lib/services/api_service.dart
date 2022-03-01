import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:majootestcase/models/movie_response.dart';
import 'package:majootestcase/services/dio_config_service.dart' as dioConfig;

class ApiServices {
  Future<MovieResponse>? getMovieList() async {
    try {
      var dio = await dioConfig.dio();
      Response response = await dio.get("");
      MovieResponse movieResponse =
          MovieResponse.fromJson(jsonDecode(response.toString()));

      return movieResponse;
    } catch (e) {
      throw 'Error getMovieList';
    }
  }
}
