import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gank3rd/model/gank.dart';
import '../api/gank_service.dart';

class GankPage extends StatefulWidget {
  @override
  _GankPageState createState() => _GankPageState();
}

class _GankPageState extends State<GankPage> {
  final List<Gank> _gankList = [];
  bool _isLoading = false;
  @override
  void initState() {
    super.initState();
    _initGanks();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      notificationPredicate: (ScrollNotification notification) {
        if ((notification is UserScrollNotification) &&
            notification.direction == ScrollDirection.reverse &&
            notification.metrics.atEdge &&
            !_isLoading) {
          print('到底了');
          _loadMore();
        }
        return defaultScrollNotificationPredicate(notification);
      },
      onRefresh: _initGanks,
      child: _gankList.isEmpty
          ? Center(child: CircularProgressIndicator())
          : GankList(
              ganks: _gankList,
              isLoading: _isLoading,
            ),
    );
  }

  Future _initGanks() async {
    print('init');
    List<Gank> ganks = await _fetchRandomGanks();
    _gankList.clear();
    setState(() => _gankList.addAll(ganks));
  }

  Future _loadMore() async {
    print('正在加载=============$_isLoading');
    setState(() => _isLoading = true);
    List<Gank> ganks = await _fetchRandomGanks();
    setState(() {
      _isLoading = false;
      _gankList.addAll(ganks);
    });
  }

  Future<List<Gank>> _fetchRandomGanks() async {
    final response = await dio.get('/random/data/Android/20');
    return Result.fromJson(response.data).ganks;
  }
}

class GankList extends StatelessWidget {
  const GankList({Key key, this.ganks, this.isLoading}) : super(key: key);
  final List<Gank> ganks;
  final bool isLoading;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: ganks.length + 1,
      physics: const AlwaysScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        if (index == ganks.length) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                isLoading
                    ? Container(
                        height: 16,
                        width: 16,
                        child: CircularProgressIndicator(strokeWidth: 2))
                    : Icon(Icons.arrow_upward, size: 16),
                SizedBox(width: 8),
                Text(isLoading ? '正在加载' : '上拉加载更多'),
              ],
            ),
          );
        }
        return GankTile(ganks[index]);
      },
    );
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
