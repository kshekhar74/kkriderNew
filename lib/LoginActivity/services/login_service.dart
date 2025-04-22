// lib/services/login_service.dart

import 'package:dio/dio.dart';
import 'package:kk_new_project/core/constants.dart';
import '../models/login_response.dart';
class LoginService {
  final Dio _dio = Dio(BaseOptions(baseUrl: Constants.baseUrl));
  Future<LoginResponse> loginWithUseridPassword(String userid,String password) async {
    final response = await _dio.get(
      Constants.loginEndpoint,
      queryParameters: {'userid': userid,'password': password},
    );
    return LoginResponse.fromJson(response.data);
  }
}
