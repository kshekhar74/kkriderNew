import 'package:dio/dio.dart';
import 'package:kk_new_project/core/Constants.dart';
import 'RegiResponse.dart';

class RegiService {
  final Dio _dio = Dio();
  Future<RegiResponse> register(String FullName,String MobileNo,String EmpId,
      String City, String AreaName, int WorkingType ,String Password) async {
    try {
      final response = await _dio.post(
        Constants.registerEndpoint,
        data: {"FullName": FullName,"MobileNo": MobileNo,"EmpId": EmpId,
          "City": City,
          "AreaName": AreaName, "WorkingType": WorkingType,"Password": Password},
      );

      return RegiResponse.fromJson(response.data);
    } catch (e) {
      throw Exception('register failed: ${e.toString()}');
    }
  }
}
