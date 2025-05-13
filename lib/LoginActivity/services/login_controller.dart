import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'LoginRepository.dart';
import 'LoginResponse.dart';
final authRepositoryProvider = Provider<LoginRepository>((ref) => LoginRepository());

final loginControllerProvider = StateNotifierProvider<LoginController, bool>((ref) {
  final repository = ref.read(authRepositoryProvider);
  return LoginController(repository);
});

class LoginController extends StateNotifier<bool> {
  final LoginRepository repository;

  LoginController(this.repository) : super(false);

  Future<LoginResponse> login(int username, String password, String imei, String gcmId) async {
    state = true;
    try {
      final result = await repository.login(username, password, imei, gcmId);
      return result;
    } finally {
      state = false;
    }
  }
}
