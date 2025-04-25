

class VehicleResponse {
  final String status;
  final String msg;
  final List<VehicleTypeModel> vehicleTypes;

  VehicleResponse({
    required this.status,
    required this.msg,
    required this.vehicleTypes,
  });

  factory VehicleResponse.fromJson(Map<String, dynamic> json) {
    final List types = json['fE_VehicleType_Models'];
    return VehicleResponse(
      status: json['status'],
      msg: json['msg'],
      vehicleTypes: types.map((e) => VehicleTypeModel.fromJson(e)).toList(),
    );
  }
}

class VehicleTypeModel {
  final int id;
  final String vehicleType;
  final String? imageUrl;

  VehicleTypeModel({
    required this.id,
    required this.vehicleType,
    this.imageUrl,
  });

  factory VehicleTypeModel.fromJson(Map<String, dynamic> json) {
    return VehicleTypeModel(
      id: json['id'],
      vehicleType: json['vehicleType'],
      imageUrl: json['imageUrl'],
    );
  }
}
