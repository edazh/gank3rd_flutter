import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:gank3rd/model/gank.dart';

class GankPage extends StatelessWidget {
  final List<Gank> gankList = [];
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Gank>>(
      future: getData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return _buildGankList(snapshot.data);
        } else if (snapshot.hasError) {
          return new Text("${snapshot.error}");
        }

        // By default, show a loading spinner
        return Center(child:CircularProgressIndicator());
      },
    );
  }

  //Gank列表项
  Widget _buildGankTile(Gank gank) {
    DateTime date = DateTime.parse(gank.pubTime);
    String dateString =
        '${date.year}-${date.month}-${date.day} ${date.hour}:${date.minute}';
    return ListTile(
      title: Text(gank.desc),
      subtitle: Row(
        children: <Widget>[
          Text(gank.who),
          SizedBox(width: 8.0),
          Text(dateString),
        ],
      ),
      onTap: getData,
    );
  }

  //Gank列表
  Widget _buildGankList(List<Gank> gankList) {
    return ListView.builder(
      itemCount: gankList.length,
      itemBuilder: (context, index) => _buildGankTile(gankList[index]),
    );
  }

  Future<List<Gank>> getData() async {
    Dio dio = Dio(Options(
      baseUrl: 'https://gank.io/api/',
      connectTimeout: 5000,
      receiveTimeout: 3000,
    ));
    // Response response = await dio.get('/random/data/Android/2');
    return dio.get('random/data/Android/20').then((res) {
      var data = res.data['results'];
      for (var item in data) {
        gankList.add(Gank.fromJson(item));
      }
      return gankList;
    });

    // print(response.data);
    // print(response.headers);
    // print(response.request);
    // print(response.statusCode);
  }
}
