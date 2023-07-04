


class SpecificationUpdateResponse {
  bool? status;
  String? message;
  dynamic data;
  int? responseCode;
  int? code;

  SpecificationUpdateResponse(
      {this.status, this.message, this.data, this.responseCode, this.code});

  SpecificationUpdateResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    // if (json['data'] != null) {
    //   data = <FabricSpecification>[];
    //   json['data'].forEach((v) {
    //     data!.add(FabricSpecification.fromJson(v));
    //   });
    // }
    data = json['data'];
    responseCode = json['response_code'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['data'] = this.data;
    // if (this.data != null) {
    //   data['data'] = this.data!.map((v) => v.toJson()).toList();
    // }

    data['response_code'] = this.responseCode;
    data['code'] = this.code;
    return data;
  }
}

