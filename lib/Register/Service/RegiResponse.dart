class RegiResponse {
  final String status;
  final String msg;

  RegiResponse({required this.status, required this.msg});
  factory RegiResponse.fromJson(Map<String, dynamic> json) {

    return RegiResponse(
      status: json['status'] ?? '0',
      msg: json['MSG'] ?? 'Unknown error',
    );
  }
}

