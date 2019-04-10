import 'package:wanandroid_flutter/model/home_banner.dart';
import 'package:wanandroid_flutter/model/home_chapter_list.dart';
import 'package:wanandroid_flutter/model/project_bean.dart';
import 'package:wanandroid_flutter/model/project_content.dart';

import 'HttpUtil.dart';

class ApiService {
  static const TAG = 'ApiService=====';

  ///首页banner  https://www.wanandroid.com/banner/json
  static const HOME_BANNER = 'banner/json';

  /// 首页文章列表 https://www.wanandroid.com/article/list/0/json
  static const HOME_CHAPTER_LIST = 'article/list/';

  ///项目 分类  'https://www.wanandroid.com/project/tree/json'
  static const PROJECT_CATEGORY = 'project/tree/json';



  ///获取首页banner
  static Future<HomeBanner> getHomeBannerData() async {
    try {
      var response = await HttpUtil().get(HOME_BANNER);
      var homeBanner = HomeBanner.fromJson(response.data);
//      print('错误码code--------${homeBanner.errorCode}${homeBanner.errorMsg}');
      return HomeBanner.fromJson(response.data);
    } catch (e, s) {
      print('TAG$s');
      return null;
    }
  }

  ///获取首页文章列表 [page]页数
  static Future<HomeChapterList> getHomeChapterListData(int page) async {
    try {
      var response = await HttpUtil().get('$HOME_CHAPTER_LIST$page/json');
      return HomeChapterList.fromJson(response.data);
    } catch (e, s) {
      print('TAG$s');
      return null;
    }
  }

  ///获取项目分类
  static Future<ProjectBean> getProjectCategory() async {
    try {
      var response = await HttpUtil().get(PROJECT_CATEGORY);
      return ProjectBean.fromJson(response.data);
    } catch (e, s) {
      print('TAG$s');
      return null;
    }
  }

  ///获取项目分类下的列表
  static Future<ProjectContent> getProjectContent(int page, int id) async{
    try {
      var response = await HttpUtil().get('project/list/$page/json?cid=$id');
      return ProjectContent.fromJson(response.data);
    } catch (e, s) {
      print('TAG$s');
      return null;
    }
  }
}
