// lib/services/api_service.dart
// lib/services/api_service.dart
import 'package:dio/dio.dart';

import '../rnd/Lead/VehicleResponse.dart';

class ApiServiceLead {
  final Dio _dio = Dio();

  Future<VehicleResponse> fetchVehicleTypes() async {
    final response = await _dio.get('http://knet.kisankonnect.com/SRIT3O/api/Rider/FE_VehicleType_Select');
    return VehicleResponse.fromJson(response.data);
  }
}
