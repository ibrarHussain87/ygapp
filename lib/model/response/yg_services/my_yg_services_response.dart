class MyYgServicesResponse {
  bool? status;
  String? message;
  Data? data;
  int? responseCode;
  int? code;

  MyYgServicesResponse(
      {this.status, this.message, this.data, this.responseCode, this.code});

  MyYgServicesResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    responseCode = json['response_code'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['response_code'] = responseCode;
    data['code'] = code;
    return data;
  }
}

class Data {
  List<MyYgServices>? myYgServices;

  Data({this.myYgServices});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['my_yg_services'] != null) {
      myYgServices = <MyYgServices>[];
      json['my_yg_services'].forEach((v) {
        myYgServices!.add(MyYgServices.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (myYgServices != null) {
      data['my_yg_services'] =
          myYgServices!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MyYgServices {
  int? ygserviceId;
  String? serviceTypeIdfk;
  String? ygserviceUserIdfk;
  String? ygserviceContactDetails;
  String? ygserviceCompanyName;
  String? ygserviceName;
  String? ygserviceContactNumber;
  String? ygserviceAddress;
  String? ygserviceEmail;
  String? ygserviceNearestLandmark;
  String? ygserviceSecondryContactName;
  String? ygserviceSecondryContactNumber;
  String? ygserviceDetails;
  String? ygserviceSpecialInstruction;
  String? ygserviceSuitableDatetime;
  String? createdBy;
  String? updatedBy;

  MyYgServices(
      {this.ygserviceId,
        this.serviceTypeIdfk,
        this.ygserviceUserIdfk,
        this.ygserviceContactDetails,
        this.ygserviceCompanyName,
        this.ygserviceName,
        this.ygserviceContactNumber,
        this.ygserviceAddress,
        this.ygserviceEmail,
        this.ygserviceNearestLandmark,
        this.ygserviceSecondryContactName,
        this.ygserviceSecondryContactNumber,
        this.ygserviceDetails,
        this.ygserviceSpecialInstruction,
        this.ygserviceSuitableDatetime,
        this.createdBy,
        this.updatedBy});

  MyYgServices.fromJson(Map<String, dynamic> json) {
    ygserviceId = json['ygservice_id'];
    serviceTypeIdfk = json['service_type_idfk'];
    ygserviceUserIdfk = json['ygservice_user_idfk'];
    ygserviceContactDetails = json['ygservice_contact_details'];
    ygserviceCompanyName = json['ygservice_company_name'];
    ygserviceName = json['ygservice_name'];
    ygserviceContactNumber = json['ygservice_contact_number'];
    ygserviceAddress = json['ygservice_address'];
    ygserviceEmail = json['ygservice_email'];
    ygserviceNearestLandmark = json['ygservice_nearest_landmark'];
    ygserviceSecondryContactName = json['ygservice_secondry_contact_name'];
    ygserviceSecondryContactNumber = json['ygservice_secondry_contact_number'];
    ygserviceDetails = json['ygservice_details'];
    ygserviceSpecialInstruction = json['ygservice_special_instruction'];
    ygserviceSuitableDatetime = json['ygservice_suitable_datetime'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ygservice_id'] = ygserviceId;
    data['service_type_idfk'] = serviceTypeIdfk;
    data['ygservice_user_idfk'] = ygserviceUserIdfk;
    data['ygservice_contact_details'] = ygserviceContactDetails;
    data['ygservice_company_name'] = ygserviceCompanyName;
    data['ygservice_name'] = ygserviceName;
    data['ygservice_contact_number'] = ygserviceContactNumber;
    data['ygservice_address'] = ygserviceAddress;
    data['ygservice_email'] = ygserviceEmail;
    data['ygservice_nearest_landmark'] = ygserviceNearestLandmark;
    data['ygservice_secondry_contact_name'] = ygserviceSecondryContactName;
    data['ygservice_secondry_contact_number'] = ygserviceSecondryContactNumber;
    data['ygservice_details'] = ygserviceDetails;
    data['ygservice_special_instruction'] = ygserviceSpecialInstruction;
    data['ygservice_suitable_datetime'] = ygserviceSuitableDatetime;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    return data;
  }
}

