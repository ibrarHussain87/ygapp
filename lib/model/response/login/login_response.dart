class LoginResponse {
  LoginResponse({
    required this.code,
    required this.success,
    required this.message,
    required this.statusCode,
    required this.data,
  });
  late final int code;
  late final bool success;
  late final String message;
  late final int statusCode;
  late final Data data;

  LoginResponse.fromJson(Map<String, dynamic> json){
    code = json['code'];
    success = json['success'];
    message = json['message'];
    statusCode = json['status_code'];
    data = Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['code'] = code;
    _data['success'] = success;
    _data['message'] = message;
    _data['status_code'] = statusCode;
    _data['data'] = data.toJson();
    return _data;
  }
}

class Data {
  Data({
    required this.user,
    required this.token,
  });
  late final User user;
  late final String token;

  Data.fromJson(Map<String, dynamic> json){
    user = User.fromJson(json['user']);
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['user'] = user.toJson();
    _data['token'] = token;
    return _data;
  }
}

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
    required this.roleId,
    this.apiToken,
    this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.certifications,
  });
  late final int id;
  late final String name;
  late final String telephoneNumber;
  late final String operatorId;
  late final String status;
  late final Null lastActive;
  late final Null fcmToken;
  late final Null otp;
  late final Null postalCode;
  late final String countryId;
  late final Null cityStateId;
  late final Null profileStatus;
  late final String email;
  late final Null emailVerifiedAt;
  late final String roleId;
  late final Null apiToken;
  late final Null deletedAt;
  late final String createdAt;
  late final String updatedAt;
  late final List<dynamic> certifications;

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
    roleId = json['role_id'];
    apiToken = null;
    deletedAt = null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    certifications = List.castFrom<dynamic, dynamic>(json['certifications']);
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
    _data['role_id'] = roleId;
    _data['api_token'] = apiToken;
    _data['deleted_at'] = deletedAt;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['certifications'] = certifications;
    return _data;
  }
}