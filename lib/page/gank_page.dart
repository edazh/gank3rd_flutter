import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gank3rd/model/gank.dart';
import 'dart:convert';

class GankPage extends StatefulWidget {
  @override
  _GankPageState createState() => _GankPageState();
}

class _GankPageState extends State<GankPage> {
  final List<Gank> _gankList = [];
  Future<List<Gank>> _randomGanks;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _randomGanks = _fetchRandomGanks(false);
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => _fetchRandomGanks(true),
      child: FutureBuilder<List<Gank>>(
        future: _randomGanks,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return _buildGankList(snapshot.data);
          } else if (snapshot.hasError) {
            return new Text("${snapshot.error}");
          }
          // By default, show a loading spinner
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  //Gank列表
  Widget _buildGankList(List<Gank> gankList) {
    return ListView.builder(
      itemCount: gankList.length,
      physics: const AlwaysScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        print('itemIndex:$index');
        return GankTile(gankList[index]);
      },
    );
  }

  Future<List<Gank>> _fetchRandomGanks(bool isRefresh) async {
    if (isRefresh) {
      _gankList.clear();
    }
    print('getdata=========>isRefresh:$isRefresh');
    Dio dio = Dio(Options(
      baseUrl: 'https://gank.io/api',
      connectTimeout: 10000,
      receiveTimeout: 3000,
    ));
    Response response = await dio.get('/random/data/Android/2');
    Result result = Result.fromJson(response.data);
    print(jsonEncode(result));
    // return dio.get('random/data/Android/20').then((res) {
    //   if (res.data != null) {
    //     var data = res.data['results'];
    //     for (var item in data) {
    //       _gankList.add(Gank.fromJson(item));
    //     }
    //   }
    //   // setState(() {});
    //   return _gankList;
    // });
  }
}

//Gank列表项目
class GankTile extends StatelessWidget {
  final Gank gank;
  const GankTile(this.gank);
  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.parse(gank.pubTime);
    String dateString =
        '${date.year}-${date.month}-${date.day} ${date.hour}:${date.minute}';
    Widget _gankTile = ListTile(
      title: Text(gank.desc),
      subtitle: Row(
        children: <Widget>[
          Text(gank.who ?? '匿名用户'),
          SizedBox(width: 8.0),
          Text(dateString),
        ],
      ),
      onTap: () => print('tap gank item'),
    );
    return _gankTile;
  }
}

class Result {
  final bool error;
  final List<Item> results;
  Result.fromJson(Map<String, dynamic> json)
      : results = (json['results'] as List)
            .map((item) => Item.fromJson(item))
            .toList(),
        error = json['error'];

  Map<String, dynamic> toJson() =>
      {'error': error, 'results': results};
}

class Item {
  final String desc;
  final String type;
  final String url;
  Item.fromJson(Map<String, dynamic> json)
      : desc = json['desc'],
        url = json['url'],
        type = json['type'];

  Map<String, dynamic> toJson() => {'desc': desc, 'url': url, 'type': type};
}
