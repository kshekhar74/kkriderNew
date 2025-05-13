import 'package:dio/dio.dart';
import 'package:kk_new_project/LoginActivity/services/LoginResponse.dart';

import '../../core/Constants.dart';
class LoginRepository {
  final Dio _dio = Dio();

  Future<LoginResponse> login(int username, String password, String imei, String gcmId) async {
    final response = await _dio.get(
      Constants.loginEndpoint,
      queryParameters: {
        'Username': username,
        'Password': password,
        'IMEINo': imei,
        'GCMID': gcmId,
      },
    );

    if (response.statusCode == 200) {
      return LoginResponse.fromJson(response.data);
    } else {
      throw Exception('Login failed: ${response.statusMessage}');
    }
  }
}
