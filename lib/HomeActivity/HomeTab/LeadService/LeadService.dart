import 'package:dio/dio.dart';
import 'package:kk_new_project/core/Constants.dart';

import '../../../Register/Service/RegiResponse.dart';

class LeadService {
  final Dio _dio = Dio();
  Future<RegiResponse> registerLead(String RiderName,String MobileNo,String CurrentStatus,
      String AreaName, int RiderType, String Remark ,String RiderStatus,int UserID) async {
    try {
      final response = await _dio.post(
        Constants.IN_FRNewRiderLeadEndpoint,
        data: {"RiderName": RiderName,"MobileNo": MobileNo,"CurrentStatus": CurrentStatus,
          "AreaName": AreaName,
          "RiderType": RiderType, "Remark": Remark,"RiderStatus": RiderStatus,"UserID": UserID},
      );

      return RegiResponse.fromJson(response.data);
    } catch (e) {
      throw Exception('register failed: ${e.toString()}');
    }
  }
}
