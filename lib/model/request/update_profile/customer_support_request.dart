class CustomerSupportRequestModel {
  String? csTypeId;
  String? csName;
  String? csEmail;
  String? csPhone;
  String? csMessage;

  CustomerSupportRequestModel({this.csTypeId, this.csName, this.csEmail,this.csMessage,this.csPhone});

  CustomerSupportRequestModel.fromJson(Map<String, dynamic> json) {
    csTypeId = json['cstype_idfk'];
    csName = json['customer_support_name'];
    csEmail = json['customer_support_email'];
    csPhone = json['customer_support_phone'];
    csMessage = json['customer_support_message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['customer_support_email'] = csEmail;
    data['customer_support_name'] = csName;
    data['customer_support_phone'] = csPhone;
    data['customer_support_message'] = csMessage;
    data['cstype_idfk'] =  csTypeId;
    return data;
  }
}