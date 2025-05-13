import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../Register/Service/RegiResponse.dart';
import 'LeadService.dart';

// StateNotifier provider for loginControllerProvider
final leadControllerProvider = StateNotifierProvider<LeadController, bool>((ref) {
  return LeadController(ref);  // Pass ref to the controller
});

class LeadController extends StateNotifier<bool> {
  final Ref ref;  // Use Ref to read other providers

  LeadController(this.ref) : super(false);  // Initialize state with false (not loading)

  // Login method to authenticate the user
  Future<RegiResponse> leadRegi(String RiderName,String MobileNo,String CurrentStatus,
      String AreaName, int RiderType, String Remark ,String RiderStatus,int UserID) async {
    state = true;  // Set loading state to true

    try {
      // Access LoginService via the ref.read() method
      final leadService = ref.read(registerServiceProvider);
      final response = await leadService.registerLead(RiderName, MobileNo,CurrentStatus,AreaName,RiderType,Remark,RiderStatus,UserID);
      state = false;  // Set loading state to false after successful login
      return response;
    } catch (e) {
      state = false;  // Set loading state to false if an error occurs
      throw Exception('register failed: ${e.toString()}');
    }
  }
}

// Provider for the LoginService
final registerServiceProvider = Provider<LeadService>((ref) => LeadService());
