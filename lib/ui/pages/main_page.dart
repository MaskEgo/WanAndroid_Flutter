import 'package:flutter/material.dart';
import 'package:wanandroid_flutter/ui/pages/home/home_page.dart';
import 'package:wanandroid_flutter/ui/pages/mine/mine.dart';
import 'package:wanandroid_flutter/ui/pages/official/official_account.dart';
import 'package:wanandroid_flutter/ui/pages/project/project_page.dart';

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainState();
}

class _MainState extends State<MainPage> {
  List<BottomNavigationBarItem> _listItem;
  int _currentIndex = 0;
  DateTime _lastPressedAt; //上次点击时间
  @override
  void initState() {
    super.initState();
    _listItem = [
      BottomNavigationBarItem(title: Text('首页'), icon: Icon(Icons.home)),
      BottomNavigationBarItem(title: Text('项目'), icon: Icon(Icons.cloud_done)),
      BottomNavigationBarItem(title: Text('公众号'), icon: Icon(Icons.poll)),
      BottomNavigationBarItem(title: Text('我的'), icon: Icon(Icons.person)),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_lastPressedAt == null ||
            DateTime.now().difference(_lastPressedAt) > Duration(seconds: 1)) {
          //两次点击间隔超过1秒则重新计时
          _lastPressedAt = DateTime.now();
          return false;
        }
        return true;
      },
      child: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: _buildBody(),
        ),
        bottomNavigationBar: _buildBottomNavigationBar(),
      ),
    );
  }


  ///内容主体
  List<Widget> _buildBody() {
    return [HomePage(), ProjectPage(), OfficialAccountPage(), MinePage()];
  }

  ///构建底部导航tab栏
  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      items: _listItem,
      currentIndex: _currentIndex,
      type: BottomNavigationBarType.fixed,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
    );
  }
}
