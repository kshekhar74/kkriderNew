import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../Register/Service/RegiResponse.dart';
import 'AvlService.dart';

// StateNotifier provider for loginControllerProvider
final avlControllerProvider = StateNotifierProvider<AvlController, bool>((ref) {
  return AvlController(ref); // Pass ref to the controller
});

class AvlController extends StateNotifier<bool> {
  final Ref ref; // Use Ref to read other providers

  AvlController(this.ref)
    : super(false); // Initialize state with false (not loading)

  // Login method to authenticate the user
  Future<RegiResponse> avlApi(
    String DeliveryDate,
    int Userid,
    String Remark,
    int DCID,
    int CDCType,
    int Status,
  ) async {
    state = true; // Set loading state to true

    try {
      // Access LoginService via the ref.read() method
      final leadService = ref.read(registerServiceProvider);
      final response = await leadService.avlAPI(
        DeliveryDate,
        Userid,
        Remark,
        DCID,
        CDCType,
        Status,
      );
      state = false; // Set loading state to false after successful login
      return response;
    } catch (e) {
      state = false; // Set loading state to false if an error occurs
      throw Exception('register failed: ${e.toString()}');
    }
  }
}

// Provider for the LoginService
final registerServiceProvider = Provider<AvlService>((ref) => AvlService());
