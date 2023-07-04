class ServerResponse {
  ServerResponse({
    required this.code,
    required this.success,
    required this.message,
    required this.statusCode,
  });
  int? code;
  bool? success;
  String? message;
  int? statusCode;

  ServerResponse.fromJson(Map<String, dynamic> json){
    code = json['code'];
    success = json['success'];
    message = json['message'];
    statusCode = json['status_code'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['code'] = code;
    _data['success'] = success;
    _data['message'] = message;
    _data['status_code'] = statusCode;
    return _data;
  }
}