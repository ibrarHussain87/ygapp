import 'package:floor/floor.dart';
import 'package:yg_app/helper_utils/type_converter.dart';

class AuthResponse {
  AuthResponse({
    required this.code,
    required this.success,
    required this.message,
    required this.errors,
    required this.statusCode,
    required this.data,
  });
  int? code;
  bool? success;
  String? message;
  Map<String,dynamic>? errors;
  int? statusCode;
  Data? data;

  AuthResponse.fromJson(Map<String, dynamic> json){
    code = json['code'];
    success = json['success'];
    message = json['message'];
    if(json['errors'] != null) {
      errors = json['errors'];
    }
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
    if(errors != null) {
      _data['errors'] = errors;
    }
    _data['status_code'] = statusCode;
    if(data!= null){
      _data['data'] = data!.toJson();
    }
    return _data;
  }
}


class UpdateProfileResponse {
  UpdateProfileResponse({
    required this.code,
    required this.status,
    required this.message,
    required this.responseCode,
    required this.data,
  });
  int? code;
  bool? status;
  String? message;
  int? responseCode;
  User? data;

  UpdateProfileResponse.fromJson(Map<String, dynamic> json){
    code = json['code'];
    status = json['status'];
    message = json['message'];
    responseCode = json['response_code'];
    if (json['data'] != null) {
      data = User.fromJson(json['data']);
    }
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
    if(data!= null){
      _data['data'] = data!.toJson();
    }
    return _data;
  }
}

class Data {
  Data({
    required this.user,
    required this.token,
  });
  User? user;
  String? token;

  Data.fromJson(Map<String, dynamic> json){
    user = User.fromJson(json['user']);
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    if(user!= null){
      _data['user'] = user!.toJson();
    }
    _data['token'] = token;
    return _data;
  }
}


class BusinessInfo {


  String? employmentRole;
  String? ntn_number;
  String? trade_mark;
  String? name;
  String? id;
  String? designation_idfk;
  String? postalCode;
  String? countryId;
  String? userId;
  String? cityStateId;
  String? city;
  String? website;
  String? address;

  BusinessInfo({this.website,this.postalCode,this.ntn_number,this.address,this.city,this.designation_idfk,this.name,this.countryId,this.cityStateId,this.employmentRole,this.trade_mark,this.userId
  });



  Map<String, dynamic>? toJson() {
  Map<String, dynamic>? map = {
    'ubi_id': id?.trim(),
  'ubi_gst_ntn_number': ntn_number?.trim(),
  'ubi_name': name?.trim(),
  'ubi_country_idfk': countryId?.trim(),
  'ubi_state_idfk': cityStateId?.trim(),
  'ubi_user_idfk': userId?.trim(),
  'ubi_website': website?.trim(),
  'ubi_address': address?.trim(),
  'ubi_city_idfk': city?.trim(),
  'ubi_zipcode': postalCode?.trim(),
  'ubi_trade_mark': trade_mark?.trim(),
  'ubi_employment_role': employmentRole?.trim(),
  'ubi_designation_idfk': designation_idfk?.trim()
  };

  return map;
  }

  BusinessInfo.fromJson(Map<String, dynamic>? json){
    id = json?['ubi_id'];
    name = json?['ubi_name'];
    userId = json?['ubi_user_idfk'];
    website = json?['ubi_website'];
    address = json?['ubi_address'];
    city = json?['ubi_city_idfk'];
    postalCode = json?['ubi_zipcode'];
    trade_mark = json?['ubi_trade_mark'];
    employmentRole = json?['ubi_employment_role'];
    designation_idfk = json?['ubi_designation_idfk'];
    countryId = json?['ubi_country_idfk'];
    cityStateId = json?['ubi_state_idfk'];
    ntn_number = json?['ubi_gst_ntn_number'];
  }


}


@Entity(tableName: 'user_table')
class User{
  User({
    required this.id,
    required this.name,
    required this.username,
    required this.telephoneNumber,
    required this.operatorId,
    required this.status,
    this.lastActive,
    this.fcmToken,
    this.otp,
    this.postalCode,
    required this.countryId,
    this.cityStateId,
    this.profileStatus,
    required this.email,
    this.emailVerifiedAt,
    this.company,
    this.ntn_number,
    this.user_country,
    this.city_state_name,
    required this.roleId,
    this.apiToken,
    this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.businessInfo,
    // required this.certifications,
  });
  @PrimaryKey(autoGenerate: false)
  int? id;
  String? name;
  String? username;
  String? telephoneNumber;
  String? operatorId;
  String? status;
  String? lastActive;
  String? fcmToken;
  String? otp;
  String? postalCode;
  String? countryId;
  String? cityStateId;
  String? profileStatus;
  String? email;
  String? emailVerifiedAt;
  String? company;
  String? companyId;
  String? ntn_number;
  String? user_country;
  String? city_state_name;
  String? roleId;
  String? apiToken;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;
//  BusinessInfo? businessInfo;
  String? businessInfo;
  // @ignore
  // late final List<dynamic> certifications;


  User.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    username = json['username'];
    telephoneNumber = json['telephone_number'];
    operatorId = json['operator_id'];
    status = json['status'];
    lastActive = json['last_active'];
    fcmToken = json['fcm_token'];
    otp = json['otp'];
    postalCode = json['postal_code'];
    countryId = json['country_id'];
    cityStateId = json['city_state_id'];
    profileStatus = json['profile_status'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    company = json['company'];
    companyId= json['company_idfk'];
    ntn_number = json['ntn_number'];
    user_country = json['user_country'];
    city_state_name = json['city_state'];
    roleId = json['role_id'];
    apiToken = json['api_token'];
    deletedAt = null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
//    businessInfo = BusinessInfo.fromJson(json['business_info']);
    businessInfo = json['business_info'].toString();
    // certifications = List.castFrom<dynamic, dynamic>(json['certifications']);
  }

  Map<String, dynamic>? toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['username'] = username;
    _data['telephone_number'] = telephoneNumber;
    _data['operator_id'] = operatorId;
    _data['status'] = status;
    _data['last_active'] = lastActive;
    _data['fcm_token'] = fcmToken;
    _data['otp'] = otp;
    _data['postal_code'] = postalCode;
    _data['country_id'] = countryId;
    _data['city_state_id'] = cityStateId;
    _data['profile_status'] = profileStatus;
    _data['email'] = email;
    _data['email_verified_at'] = emailVerifiedAt;
    _data['company'] = company;
    _data['company_idfk'] = countryId;
    _data['ntn_number'] = ntn_number;
    _data['user_country'] = user_country;
    _data['city_state'] = city_state_name;
    _data['role_id'] = roleId;
    _data['api_token'] = apiToken;
    _data['deleted_at'] = deletedAt;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['business_info'] = businessInfo;
    // _data['certifications'] = certifications;
    return _data;
  }

}