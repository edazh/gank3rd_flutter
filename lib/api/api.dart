import 'package:dio/dio.dart';

class Api {
  static final Options _options = Options(
    baseUrl: 'https://gank.io/api',
    connectTimeout: 5000,
  );
  static final Dio dio = Dio(_options);

  static Future<Response<T>> get<T>(String path, {dynamic data}) async {
    return await dio.get<T>(path, data: data);
  }

  static Future<Response<T>> post<T>(String path, {dynamic data}) async {
    return await dio.post<T>(path, data: data);
  }
}
