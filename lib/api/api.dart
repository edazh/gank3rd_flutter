import 'package:dio/dio.dart';
import 'package:gank3rd/api/service.dart';
import 'package:gank3rd/model/gank.dart';

Future<List<Gank>> random() async {
  List<Gank> ganks = <Gank>[];
  Response response = await dio.get('/random/data/Android/20');
  response.data['results'].forEach((v) {
    ganks.add(Gank.fromJson(v));
  });

  return ganks;
}
