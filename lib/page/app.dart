import 'package:flutter/material.dart';
import 'package:gank3rd/config/app_config.dart';
import 'package:gank3rd/widget/gank_theme.dart';
import './gank_page.dart';
import './read_page.dart';
import './weal_page.dart';
import '../api/gank_service.dart';
class GankApp extends StatefulWidget {
  @override
  _GankAppState createState() => _GankAppState();
}

class _GankAppState extends State<GankApp> {
  List<BottomNavigationBarItem> _bottomNavItems;
  int _currentIndex = 0;
  List<Widget> _pages = List();
  @override
  void initState() {
    super.initState();
    _bottomNavItems = _buildBottomNavItems();
    _pages.add(GankPage());
    _pages.add(ReadPage());
    _pages.add(WealPage());
    dio.get("/random/data/Android/20");
    print(dio);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: _pages[_currentIndex],
        appBar: AppBar(
          title: Text(AppConfig.appName),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: _bottomNavItems,
          currentIndex: _currentIndex,
          onTap: _onTapBottomNavItem,
        ),
      ),
      theme: GankTheme.gankTheme,
    );
  }

  //底部导航点击事件
  void _onTapBottomNavItem(int index) {
    setState(() => _currentIndex = index);
  }

  //创建底部导航项
  List<BottomNavigationBarItem> _buildBottomNavItems() {
    return <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: const Icon(Icons.whatshot),
        title: const Text('干货'),
      ),
      BottomNavigationBarItem(
        icon: const Icon(Icons.library_books),
        title: Text('闲读'),
      ),
      BottomNavigationBarItem(
        icon: const Icon(Icons.favorite),
        title: const Text('福利'),
      ),
    ];
  }
}
