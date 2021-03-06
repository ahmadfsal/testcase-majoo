import 'dart:async';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

Future<Dio> dio() async {
  var options = BaseOptions(
    baseUrl: "https://imdb8.p.rapidapi.com/auto-complete?q=game%20of%20thr",
    connectTimeout: 12000,
    receiveTimeout: 12000,
    headers: {
      "x-rapidapi-key": "6af4f77398mshb3f6cd027729468p1d6d31jsn038947888a17",
      "x-rapidapi-host": "imdb8.p.rapidapi.com"
    },
  );

  Dio dio = Dio(options)
    ..interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
      ),
    );

  return dio;
}
