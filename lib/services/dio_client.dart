



import 'package:BrossScrum/config/api_constant.dart';
import 'package:dio/dio.dart';

class DioClient {
  DioClient._();

  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: ApiConstant.baseUrl,
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
      validateStatus: (status) {
      return status != null && status <= 500;
      },
      headers: {
        "Content-Type":"application/json",
      }
    )
  );
  static void setToken(String token){
    dio.options.headers['Authorization']="Bearer $token";
  }
  static void clearToken(){
    dio.options.headers.remove("Authorization");
  }
}