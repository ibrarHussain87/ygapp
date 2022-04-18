class SpecificationUserResponse {
  bool? status;
  int? responseCode;
  SpecificationUser? data;
  String? message;

  SpecificationUserResponse(
      {this.status, this.responseCode, this.data, this.message});

  SpecificationUserResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    responseCode = json['response_code'];

    if(json['data'] is List<dynamic>){
      data = null;
    }else {
      data = SpecificationUser.fromJson(json['data']);
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['response_code'] = responseCode;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = message;
    return data;
  }
}

class SpecificationUser {
  String? name;
  String? phone;
  String? email;
  String? country;
  String? cityState;
  String? company;
  String? ntnNumber;

  SpecificationUser(
      {this.name,
        this.phone,
        this.email,
        this.country,
        this.cityState,
        this.company,
        this.ntnNumber});

  SpecificationUser.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    country = json['country'];
    cityState = json['city_state'];
    company = json['company'];
    ntnNumber = json['ntn_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['country'] = this.country;
    data['city_state'] = this.cityState;
    data['company'] = this.company;
    data['ntn_number'] = this.ntnNumber;
    return data;
  }
}