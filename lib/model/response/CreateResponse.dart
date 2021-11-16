class CreateResponse {
  CreateResponse({
    required this.code,
    required this.success,
    required this.message,
    required this.statusCode,
  });
  late final int code;
  late final bool success;
  late final String message;
  late final int statusCode;

  CreateResponse.fromJson(Map<String, dynamic> json){
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


