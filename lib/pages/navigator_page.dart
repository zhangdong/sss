import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_template_mini/pages/home_page.dart';
import 'package:flutter_template_mini/pages/me_page.dart';
import 'package:flutter_template_mini/common/my_color.dart';

class NavigatorPage extends StatefulWidget {
  const NavigatorPage({Key? key}) : super(key: key);

  @override
  _NavigatorPageState createState() => _NavigatorPageState();
}

class _NavigatorPageState extends State<NavigatorPage> {
  // 默认的颜色
  final _defaultColor = Colors.grey;
  // 选中后的颜色
  final _activeColor = MyColor.primary;
  // 当前索引
  int _currentIndex = 0;
  // 页面
  final List<Widget> _pages = [
    HomePage(),
    MePage(),
  ];
  // 上次点击时间
  DateTime? _lastPressedAt;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: exitApp,
        child: _pages[_currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: _activeColor,
        items: [
          _bottomItem('首页', Icons.home_outlined),
          _bottomItem('我的', Icons.person_outline),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }

  // 底部 Item
  BottomNavigationBarItem _bottomItem(String label, IconData icon) {
    return BottomNavigationBarItem(
      label: label,
      icon: Icon(icon, color: _defaultColor),
      activeIcon: Icon(icon, color: _activeColor),
    );
  }

  // 退出 app
  Future<bool> exitApp() async {
    if (_lastPressedAt == null ||
        DateTime.now().difference(_lastPressedAt!) > Duration(seconds: 2)) {
      EasyLoading.showToast('再点一次退出');
      // 两次点击间隔超过2秒则重新计时
      _lastPressedAt = DateTime.now();
      return Future.value(false);
    }
    return Future.value(true);
  }
}
