import 'package:gank3rd/api/service.dart';
import 'package:gank3rd/model/gank.dart';

Future<List<Gank>> random() async {
  List<Gank> ganks = <Gank>[];
  await dio.get('path');
  return ganks;
}
