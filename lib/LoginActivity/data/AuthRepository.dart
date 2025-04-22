
import '../models/login_response.dart';
import '../services/login_service.dart';

class AuthRepository {
  final LoginService loginService;
  AuthRepository(this.loginService);
  Future<LoginResponse> login(String userid,String password) async {
    try {
      return await loginService.loginWithUseridPassword(userid,password);
    } catch (e) {
      return LoginResponse(status: 'error', msg: 'API Error: $e');
    }
  }
  Future<LoginResponse> logout(String userid,String password) async {
    try {
      return await loginService.loginWithUseridPassword(userid,password);
    } catch (e) {
      return LoginResponse(status: 'error', msg: 'API Error: $e');
    }
  }
}
