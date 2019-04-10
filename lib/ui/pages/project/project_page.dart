import 'package:flutter/material.dart';
import 'package:wanandroid_flutter/model/project_bean.dart';
import 'package:wanandroid_flutter/net/ApiService.dart';
import 'package:wanandroid_flutter/ui/pages/project/project_detail_page.dart';

class ProjectPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ProjectState();
}

class _ProjectState extends State<ProjectPage> {
  List<ProjectData> _dataList =[];

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {

    if (_dataList.length==0) {
      return Center(child: CircularProgressIndicator());
    } else {
      return DefaultTabController(
          child: Scaffold(
            appBar: AppBar(
              title: Text('项目'),
              centerTitle: true,
              bottom: TabBar(
                tabs: _buildTabs(),
                indicatorColor: Colors.blueAccent,
                isScrollable: true,
              ),
            ),
            body: TabBarView(
              children: _buildTabBarView(),
            ),
          ),
          length: _dataList.length);
    }

  }
  ///获取tabs
  List<Tab> _buildTabs() {
    List<Tab> _tabList = [];
    for (var value in _dataList) {
      _tabList.add(Tab(
        text: value.name.replaceAll('&amp;', ''),
      ));
    }
    return _tabList;
  }

  ///获取tabview
  _buildTabBarView() {
    List<Widget> tabBarView = [];
    for (var value in _dataList) {
      tabBarView.add(ProjectDetailPage(
        id: value.id,
      ));
    }
    return tabBarView;
  }
  void getData() {
    ApiService.getProjectCategory().then((list) {
      setState(() {
        _dataList = list.data;
      });
    });
  }
}
