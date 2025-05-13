import 'package:dio/dio.dart';
import 'package:kk_new_project/core/Constants.dart';

import '../../../Register/Service/RegiResponse.dart';

class AvlService {
  final Dio _dio = Dio();

  Future<RegiResponse> avlAPI(
    String DeliveryDate,
    int Userid,
    String Remark,
    int DCID,
    int CDCType,
    int Status,
  ) async {
    try {
      final response = await _dio.post(
        Constants.IN_FRAvailableStatusEndpoint,
        data: {
          "DeliveryDate": DeliveryDate,
          "Userid": Userid,
          "Remark": Remark,
          "DCID": DCID,
          "CDCType": CDCType,
          "Status": Status,
        },
      );

      return RegiResponse.fromJson(response.data);
    } catch (e) {
      throw Exception('register failed: ${e.toString()}');
    }
  }
}
