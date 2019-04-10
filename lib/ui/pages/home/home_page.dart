import 'package:flutter/material.dart';
import 'package:wanandroid_flutter/model/home_banner.dart';
import 'package:wanandroid_flutter/model/home_chapter_list.dart';
import 'package:wanandroid_flutter/net/ApiService.dart';
import 'package:wanandroid_flutter/ui/pages/news_detail_pages.dart';
import 'package:wanandroid_flutter/utils/style_utils.dart';
import 'package:wanandroid_flutter/utils/view_utils.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  List<Data> _listBanner = [];
  List<Datas> _listChapter = [];
  int page = 0;

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _initScrollListener();
    _loadBannerData();
    _loadChapterData();
  }

  @override
  Widget build(BuildContext context) {
    if (_listChapter.length == 0 || _listBanner.length == 0) {
      return Center(child: CircularProgressIndicator());
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text('首页'),
          centerTitle: true,
        ),
        body: RefreshIndicator(
            child: ListView.builder(
                controller: _scrollController,
                itemCount: _listChapter.length + 1,
                itemBuilder: (context, index) {
                  return _buildItem(index);
                }),
            onRefresh: _onRefresh),
      );
    }
  }
  ///加载轮播图
  _loadBannerData() {
    ApiService.getHomeBannerData().then((banner) {
      setState(() {
        _listBanner = banner.data;
      });
    });
  }

  ///加载列表数据
  _loadChapterData() {
    ApiService.getHomeChapterListData(page).then((list) {
      setState(() {
        _listChapter.addAll(list.data.datas);
      });
    });
  }

  ///刷新
  Future<void> _onRefresh() async {
    page = 1;
    ApiService.getHomeChapterListData(page).then((list) {
      setState(() {
        _listChapter = list.data.datas;
      });
    });
  }

  ///初始化listview监听
  void _initScrollListener() {
    _scrollController.addListener(() {
      var p = _scrollController.position.pixels;
      var max = _scrollController.position.maxScrollExtent;
      if (p == max) {
        page++;
        _loadChapterData();
      }
    });
  }
  ///listview Item布局
  Widget _buildItem(int index) {
    if (index == 0) {
      return _creatBanner();
    } else if (index < _listChapter.length) {
      return _buildMainItem(index);
    } else {
      return ViewUtils.creatLoadMore();
    }
  }

  ///广告轮播
  Widget _creatBanner() {
    return Container(
      height: 150.0,
      padding: EdgeInsets.all(2.0),
      child: Swiper(
        autoplay: true,
        pagination: SwiperPagination(
            alignment: Alignment.bottomRight,
            builder: SwiperPagination.fraction),
        itemCount: _listBanner.length,
        onTap: (index) => _goToWebView(_listBanner[index].url),
        itemBuilder: (context, index) {
          return Image.network(
            _listBanner[index].imagePath,
            fit: BoxFit.cover,
          );
        },
      ),
    );
  }

  ///listview主布局
  _buildMainItem(int index) {
    var chapterData = _listChapter[index];
    return InkWell(
        onTap: () => _goToWebView(chapterData.link),
        child: Card(
          margin: EdgeInsets.all(6.0),
          child: Column(
//        mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(chapterData.title.replaceAll('&quot;', ''),
                    style: StyleUtils.TITLE_TEXT_STYLE),
              ),
              Padding(
                  padding: EdgeInsets.fromLTRB(8.0, 1.0, 8.0, 1.0),
                  child: Text(
                    '${(chapterData.superChapterName)}/${(chapterData.chapterName)}',
                    style: TextStyle(fontSize: 13.0, color: Colors.blue[300]),
                  )),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.person,
                      color: Colors.grey,
                      size: 22.0,
                    ),
                    Text(chapterData.author, style: StyleUtils.SUB_TEXT_STYLE),
                    Expanded(
                        flex: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Icon(
                              Icons.timer,
                              color: Colors.grey,
                              size: 22.0,
                            ),
                            Text(chapterData.niceDate,
                                style: StyleUtils.SUB_TEXT_STYLE)
                          ],
                        ))
                  ],
                ),
              )
            ],
          ),
        ));
  }

  ///跳转web查看详情
  void _goToWebView(String url) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (ctx) => NewsDetailPage(id: url)));
  }


}
