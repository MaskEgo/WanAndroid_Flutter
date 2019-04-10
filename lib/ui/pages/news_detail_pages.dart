import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class NewsDetailPage extends StatefulWidget {
  String id;

  NewsDetailPage({Key key, this.id}) : super(key: key);

  @override
  State<StatefulWidget> createState() => new NewsDetailPageState(id: this.id);
}

class NewsDetailPageState extends State<NewsDetailPage> {
  String id;
  String detailDataStr;
  final flutterWebViewPlugin =  FlutterWebviewPlugin();

  NewsDetailPageState({Key key, this.id});

  @override
  void initState() {
    super.initState();
    // 监听WebView的加载事件
    flutterWebViewPlugin.onStateChanged.listen((state) {
      print("state: ${state.type}");
      if (state.type == WebViewState.finishLoad) {
        // 加载完成
        setState(() {
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> titleContent = [];
    titleContent.add(Text(
      "页面详情",
      style: TextStyle(color: Colors.white),
    ));

    titleContent.add( Container(width: 50.0));
    return  WebviewScaffold(
      url: this.id,
      appBar:  AppBar(
        title:  Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: titleContent,
        ),
        iconTheme:  IconThemeData(color: Colors.white),
      ),
      withZoom: false,
      withLocalStorage: true,
      withJavascript: true,
    );
  }
}
