import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';

class HttpUtil {
  static const BASE_URL = 'https://www.wanandroid.com/';

  factory HttpUtil() => instance;
  static final HttpUtil instance = HttpUtil._internal();
  Dio dio;

  HttpUtil._internal() {
    if (dio == null) {
      BaseOptions options = BaseOptions();
      options.baseUrl = BASE_URL;
      options.receiveTimeout = 1000 * 8; // 8 秒
      options.connectTimeout = 1000 * 6; // 6 秒
      dio = Dio(options);
    }

  }

  ///-GET请求
  ///[path]是拼接在[BASE_URL]后面的 ，[parms]为可选请求参数
  Future<Response> get(String path, [Map<String, dynamic> parms]) async {
    print('Httputil------->GET   path:$path  parms:$parms');
    if (parms != null) {
      var response = await dio.get(path, queryParameters: parms);
      return response;
    } else {
      var response = await dio.get(path);
      return response;
    }
  }

  ///-POST请求
  ///[path]是拼接在[BASE_URL]后面的 ，[parms]为可选请求参数
  Future<Response> post(String path, [Map<String, dynamic> parms]) async {
    print('Httputil------->POST   path:$path  parms:$parms');
    if (parms != null) {
      var response = await dio.post(path, queryParameters: parms);
      return response;
    } else {
      var response = await dio.post(path);
      return response;
    }
  }
}
