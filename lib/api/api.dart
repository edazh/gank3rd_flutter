import 'package:dio/dio.dart';

final Options _options = Options(
  baseUrl: 'https://gank.io/api',
  connectTimeout: 5000,
);
final Dio dio = Dio(_options);

