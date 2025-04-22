// lib/providers/auth_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/AuthRepository.dart';
import '../models/login_response.dart';
import '../services/login_service.dart';

final loginServiceProvider = Provider((ref) => LoginService());
final authRepositoryProvider = Provider((ref) => AuthRepository(ref.read(loginServiceProvider)));

final loginControllerProvider = StateNotifierProvider<LoginProvider, bool>((ref) {
  return LoginProvider(ref.read(authRepositoryProvider));
});

class LoginProvider extends StateNotifier<bool> {
  final AuthRepository repository;
  LoginProvider(this.repository) : super(false);

  Future<LoginResponse> login(String userid,password) async {
    state = true;
    final result = await repository.login(userid,password);
    state = false;
    return result;
  }

}
