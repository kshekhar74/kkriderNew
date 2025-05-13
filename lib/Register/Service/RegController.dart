import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'RegiResponse.dart';
import 'RegiService.dart';

// StateNotifier provider for loginControllerProvider
final regControllerProvider = StateNotifierProvider<RegController, bool>((ref) {
  return RegController(ref);  // Pass ref to the controller
});

class RegController extends StateNotifier<bool> {
  final Ref ref;  // Use Ref to read other providers

  RegController(this.ref) : super(false);  // Initialize state with false (not loading)

  // Login method to authenticate the user
  Future<RegiResponse> register(String FullName,String MobileNo,String EmpId,
  String City, String AreaName, int WorkingType ,String Password) async {
    state = true;  // Set loading state to true

    try {
      // Access LoginService via the ref.read() method
      final regService = ref.read(registerServiceProvider);
      final response = await regService.register(FullName, MobileNo,EmpId,City,AreaName,WorkingType,Password);
      state = false;  // Set loading state to false after successful login
      return response;
    } catch (e) {
      state = false;  // Set loading state to false if an error occurs
      throw Exception('register failed: ${e.toString()}');
    }
  }
}

// Provider for the LoginService
final registerServiceProvider = Provider<RegiService>((ref) => RegiService());
