import 'package:shared_preferences/shared_preferences.dart';
import 'theme_util.dart';

/// shared_perfence工具类
class SpUtil {
  static final String THMEME_COLOR_DES = 'themeColor';
  static final String USER_ID = 'userId';
  static final String ACCESS_TOKEN = 'accessToken';
  static final String REFRESH_TOKEN = 'refreshToken';
  static final String USER_NAME = 'userName';
  static final bool isLogin = false;

  ///返回颜色主题key [ThemeUtil]
  static Future<String> getColorTheme() async {
    var spInstance = await SharedPreferences.getInstance();
    return spInstance.get(THMEME_COLOR_DES) ?? 'defaultColor';
  }

  ///设置颜色主题key  [ThemeUtil]
  static Future<Null> setColorTheme(String color) async {
    var sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(THMEME_COLOR_DES, color);
  }
}
