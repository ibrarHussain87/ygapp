import 'package:yg_app/model/response/fabric_response/fabric_specification_response.dart';


class FabricUpdateResponse {
  bool? status;
  String? message;
  List<FabricSpecification>? data;
  int? responseCode;
  int? code;

  FabricUpdateResponse(
      {this.status, this.message, this.data, this.responseCode, this.code});

  FabricUpdateResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <FabricSpecification>[];
      json['data'].forEach((v) {
        data!.add(FabricSpecification.fromJson(v));
      });
    }
    responseCode = json['response_code'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['response_code'] = this.responseCode;
    data['code'] = this.code;
    return data;
  }
}

