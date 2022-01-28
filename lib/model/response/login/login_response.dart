import 'package:floor/floor.dart';

class LoginResponse {
  LoginResponse({
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

  LoginResponse.fromJson(Map<String, dynamic> json){
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

@Entity(tableName: 'user_table')
class User {
  User({
    required this.id,
    required this.name,
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
    // required this.certifications,
  });
  @PrimaryKey(autoGenerate: false)
  int? id;
  String? name;
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
  String? ntn_number;
  String? user_country;
  String? city_state_name;
  String? roleId;
  String? apiToken;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;
  // @ignore
  // late final List<dynamic> certifications;

  User.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    telephoneNumber = json['telephone_number'];
    operatorId = json['operator_id'];
    status = json['status'];
    lastActive = null;
    fcmToken = null;
    otp = null;
    postalCode = null;
    countryId = json['country_id'];
    cityStateId = null;
    profileStatus = null;
    email = json['email'];
    emailVerifiedAt = null;
    company = json['company'];
    ntn_number = json['ntn_number'];
    user_country = json['user_country'];
    city_state_name = json['city_state_name'];
    roleId = json['role_id'];
    apiToken = null;
    deletedAt = null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    // certifications = List.castFrom<dynamic, dynamic>(json['certifications']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
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
    _data['ntn_number'] = ntn_number;
    _data['user_country'] = user_country;
    _data['city_state_name'] = city_state_name;
    _data['role_id'] = roleId;
    _data['api_token'] = apiToken;
    _data['deleted_at'] = deletedAt;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    // _data['certifications'] = certifications;
    return _data;
  }
}