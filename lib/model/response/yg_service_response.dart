import 'package:floor/floor.dart';
import 'package:yg_app/model/response/common_response_models/brands_response.dart';


class YGServiceResponse {
  YGServiceResponse({
    required this.code,
    required this.status,
    required this.message,
    required this.responseCode,
//    required this.data,
  });
  int? code;
  bool? status;
  String? message;
  int? responseCode;
//  User? data;

  YGServiceResponse.fromJson(Map<String, dynamic> json){
    code = json['code'];
    status = json['status'];
    message = json['message'];
    responseCode = json['response_code'];
//    if (json['data'] != null) {
//      data = User.fromJson(json['data']);
//    }
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['code'] = code;
    _data['status'] = status;
    _data['message'] = message;
//    if(errors != null) {
//      _data['errors'] = errors;
//    }
    _data['response_code'] = responseCode;
//    if(data!= null){
//      _data['data'] = data!.toJson();
//    }
    return _data;
  }
}

