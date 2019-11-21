import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gank3rd/model/gank.dart';
import 'package:gank3rd/page/brower_page.dart';
import 'package:gank3rd/api/api.dart';

final List<Tab> _gankTabs = <Tab>[
  Tab(text: 'Android'),
  Tab(text: 'iOS'),
  Tab(text: '前端'),
  Tab(text: '拓展资源'),
  Tab(text: '休息视频'),
];

class GankPage extends StatefulWidget {
  @override
  _GankPageState createState() => _GankPageState();
}

class _GankPageState extends State<GankPage> {
  final List<Gank> _gankList = [];
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('didChangeDependencies');
    random().then((List<Gank> ganks) {
      setState(() {
        _gankList.addAll(ganks);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _gankTabs.length,
      initialIndex: 0,
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              child: SliverSafeArea(
                top: false,
                sliver: SliverAppBar(
                  title: Text('Gank'),
                  pinned: true,
                  floating: true,
                  forceElevated: innerBoxIsScrolled,
                  bottom: TabBar(
                    isScrollable: true,
                    tabs: _gankTabs,
                  ),
                ),
              ),
            ),
          ];
        },
        body: TabBarView(
          dragStartBehavior: DragStartBehavior.down,
          children: _gankTabs.map((Tab tab) {
            return SafeArea(
              top: false,
              bottom: false,
              child: Builder(
                builder: (BuildContext context) {
                  return CustomScrollView(
                    key: PageStorageKey<String>(tab.text),
                    slivers: <Widget>[
                      SliverOverlapInjector(
                        handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                            context),
                      ),
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            return GankTile(gank: _gankList[index]);
                          },
                          childCount: _gankList.length,
                        ),
                      ),
                    ],
                  );
                },
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class GankTile extends StatelessWidget {
  final Gank gank;
  GankTile({Key key, this.gank}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        Icons.android,
        color: Colors.lightGreen,
      ),
      title: Text(gank.desc ?? ''),
      subtitle: Text(gank.who ?? '佚名'),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => BrowerPage(
                  url: gank.url,
                  title: gank.desc,
                )));
      },
    );
  }
}

class GankList extends StatefulWidget {
  final String category;
  const GankList({Key key, @required this.category})
      : assert(category != null),
        super(key: key);
  @override
  _GankListState createState() => _GankListState();
}

class _GankListState extends State<GankList> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        ListTile(
          title: Text(widget.category),
          onTap: () {},
        ),
        ListTile(
          title: Text(widget.category),
          onTap: () {},
        ),
      ],
    );
  }
}

class GankHeaderDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;
  const GankHeaderDelegate({this.tabBar});
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return tabBar;
  }

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => false;
}
