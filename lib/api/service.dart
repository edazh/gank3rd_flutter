import 'package:dio/dio.dart';

BaseOptions _options = BaseOptions(
  baseUrl: 'http://gank.io/api',
  connectTimeout: 5000,
  receiveTimeout: 3000,
);
final Dio dio = Dio(_options)
  ..interceptors.add(
    InterceptorsWrapper(
      onRequest: (RequestOptions options) {
        return options;
      },
      onResponse: (Response response) {
        print(response.data);
        return response;
      },
      onError: (DioError error) {
        // print(error);
        return error;
      },
    ),
  );