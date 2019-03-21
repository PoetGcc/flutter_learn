import 'package:dio/dio.dart';

/// 考虑使用一个 Dio 单例
class DioHttp {
  /// 工厂模式
  factory DioHttp() => _getInstance();
  static DioHttp get instance => _getInstance();
  static DioHttp _instance;

  /// Dio
  var _dio;

  /// 初始化
  DioHttp._internal() {
    initDio();
  }
  
  static DioHttp _getInstance() {
    if (_instance == null) {
      _instance = new DioHttp._internal();
    }
    return _instance;
  }

  /// 初始化 Dio
  void initDio() {
    _dio = new Dio();
    // 开启请求日志
    _dio.interceptors.add(LogInterceptor(
        requestHeader: false, responseHeader: true, responseBody: false));
  }

  Dio dio() {
    return _dio;
  }
}
