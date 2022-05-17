import 'package:floor/floor.dart';

class PreConfigResponse {
  PreConfigResponse({
    required this.code,
    required this.success,
    required this.message,
    required this.statusCode,
    required this.data,
  });
  int? code;
  bool? success;
  String? message;
  int? statusCode;
  Data? data;

  PreConfigResponse.fromJson(Map<String, dynamic> json){
    code = json['code'];
    success = json['success'];
    message = json['message'];
    statusCode = json['status_code'];
    if (json['data'] != null) {
      data = Data.fromJson(json['data']);
    }
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['code'] = code;
    _data['success'] = success;
    _data['message'] = message;
    _data['status_code'] = statusCode;
    if(data!= null){
      _data['data'] = data!.toJson();
    }
    return _data;
  }
}

class Data {
  Data({
    required this.config,
  });
  String? config;

  Data.fromJson(Map<String, dynamic> json){
    config = json['set_username'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['set_username'] = config;
    return _data;
  }
}

