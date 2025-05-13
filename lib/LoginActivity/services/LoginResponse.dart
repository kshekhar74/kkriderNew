// models/login_model.dart
class Employee {
  final int id;
  final String fullName;
  final String mobileNo;
  final String empId;
  final String city;

  Employee({
    required this.id,
    required this.fullName,
    required this.mobileNo,
    required this.empId,
    required this.city,
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json['ID'],
      fullName: json['FullName'],
      mobileNo: json['MobileNo'],
      empId: json['EmpId'],
      city: json['City'],
    );
  }
}

class LoginResponse {
  final String status;
  final String message;
  final List<Employee> data;

  LoginResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      status: json['status'],
      message: json['MSG'],
      data: (json['data'] as List<dynamic>)
          .map((e) => Employee.fromJson(e))
          .toList(),
    );
  }
}
