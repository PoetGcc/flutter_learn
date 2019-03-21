import 'package:flutter/material.dart';

import 'package:flutter_learn/module/home_page.dart';
import 'package:flutter_learn/module/list_page.dart';

/// 入口
void main() => runApp(MyApp());

/// App
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: NavigationPage(),
    );
  }
}

/// 导航 Widget
class NavigationPage extends StatefulWidget {
  @override
  _NavigationState createState() => _NavigationState();
}

/// 导航 State
class _NavigationState extends State<NavigationPage> {
  /// 选择Page Index
  int _selectedIndex = 0;

  /// Page 页面
  var _pageList;

  /// 初始化资源
  @override
  void initState() {
    super.initState();
    initPage();
  }

  /// 初始化 Page List
  void initPage() {
    _pageList = [
      new MyHomePage(),
      new ListPage(),
      new MyHomePage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold 路由页骨架
    return Scaffold(
      body: _pageList[_selectedIndex],
      // 底部导航栏
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home')),
          BottomNavigationBarItem(
              icon: Icon(Icons.android), title: Text('List')),
          BottomNavigationBarItem(icon: Icon(Icons.mood), title: Text('Me')),
        ],
        currentIndex: _selectedIndex,
        fixedColor: Colors.teal,
        onTap: _onItemTapped,
      ),
    );
  }

  /// 点击选择项
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
