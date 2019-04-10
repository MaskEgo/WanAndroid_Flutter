import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wanandroid_flutter/events/change_theme_color_event.dart';
import 'package:wanandroid_flutter/ui/pages/Main_page.dart';
import 'package:wanandroid_flutter/utils/EventBusUtils.dart';
import 'package:wanandroid_flutter/utils/sp_util.dart';
import 'package:wanandroid_flutter/utils/theme_util.dart';

void main() {
  runApp(WanAndroidApp());
  if (Platform.isAndroid) {
    var style = SystemUiOverlayStyle(statusBarColor: Colors.transparent); //状态栏透明
    SystemChrome.setSystemUIOverlayStyle(style);
  }
}

class WanAndroidApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _WanAndroidState();
}

class _WanAndroidState extends State<WanAndroidApp> {
  Color themeColor;

  @override
  void initState() {
    super.initState();
    _initDefultThemColor();
    _initThemeColorListener();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '玩安卓Flutter',
      home: MainPage(),
      theme:  ThemeData(primaryColor: themeColor),
//    是否右上角显示Debug标签  debugShowCheckedModeBanner: false,
      showPerformanceOverlay: false,
    );
  }

  ///初始化默认主题配色
  _initDefultThemColor() {
    SpUtil.getColorTheme().then((onValue) {
     setState(() {
       themeColor = ThemeUtil.supportColors[onValue];
     });
    });
  }

  ///设置eventBUs监听[ChangeThemeColorEvent]
  _initThemeColorListener() {
    EventBusUtils.eventBus.on<ChangeThemeColorEvent>().listen((event) {
      setState(() {
        themeColor = event.color;
      });
    });
  }
}
