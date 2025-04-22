// lib/models/login_response.dart

class LoginResponse {
  final String status;
  final String msg;
  final TruckDetail? truckDetail;

  LoginResponse({
    required this.status,
    required this.msg,
    this.truckDetail,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      status: json['status'] ?? '',
      msg: json['msg'] ?? '',
      truckDetail: json['truckDetail'] != null
          ? TruckDetail.fromJson(json['truckDetail'])
          : null,
    );
  }
}

class TruckDetail {
  final int driverID;
  final String driverName;
  final String phoneNumber;
  final String email;
  final String licenseNumber;
  final int vehicleID;
  final String vehicleNumber;
  final String homeAddress;
  final int otp;
  final bool isActive;
  final String compWhtsApp;

  TruckDetail({
    required this.driverID,
    required this.driverName,
    required this.phoneNumber,
    required this.email,
    required this.licenseNumber,
    required this.vehicleID,
    required this.vehicleNumber,
    required this.homeAddress,
    required this.otp,
    required this.isActive,
    required this.compWhtsApp,
  });

  factory TruckDetail.fromJson(Map<String, dynamic> json) {
    return TruckDetail(
      driverID: json['driverID'] ?? 0,
      driverName: json['driverName'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      email: json['email'] ?? '',
      licenseNumber: json['licenseNumber'] ?? '',
      vehicleID: json['vehicleID'] ?? 0,
      vehicleNumber: json['vehicleNumber'] ?? '',
      homeAddress: json['homeAddress'] ?? '',
      otp: json['otp'] ?? 0,
      isActive: json['isActive'] ?? false,
      compWhtsApp: json['compWhtsApp'] ?? '',
    );
  }
}
