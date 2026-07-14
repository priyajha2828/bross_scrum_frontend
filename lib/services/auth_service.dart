import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../config/api_constant.dart';
import 'dio_client.dart';

class AuthService {

  // Login
  Future<Response> login({
    required String email,
    required String password,
  }) async {
    debugPrint("Inside auth service: ");
    return await DioClient.dio.post(
      ApiConstant.login,
      data: {
        "email": email,
        "password": password,
      },
    );
  }

  // Signup
  Future<Response> signup({
    required String fullName,
    required String username,
    required String email,
    required String password,
  }) async {
    final response = await DioClient.dio.post(
      ApiConstant.signup,
      data: {
        "fullName": fullName,
        "username": username,
        "email": email,
        "password": password,
      },
    );
    debugPrint("APierror");
    debugPrint(response.toString());
    return response;
  }

  // Verify OTP
  Future<Response> verifyOtp({
    required String email,
    required String otp,
  }) async {
    return await DioClient.dio.post(
      ApiConstant.verifyOtp,
      data: {
        "email": email,
        "otp": otp,
      },
    );
  }

  // Forgot Password
  Future<Response> forgotPassword(String email) async {
    return await DioClient.dio.post(
      ApiConstant.forgotPassword,
      data: {
        "email": email,
      },
    );
  }

  // Get Profile
  Future<Response> getProfile() async {
    return await DioClient.dio.get(
      ApiConstant.me,
    );
  }

  // Logout (optional)
  Future<Response> logout() async {
    return await DioClient.dio.post(
      ApiConstant.logout,
    );
  }
}