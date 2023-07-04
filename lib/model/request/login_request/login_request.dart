import '../../response/common_response_models/countries_response.dart';

class LoginRequestModel {
  String? phone;
  String? email;
  String? password;
  Countries? country;

  LoginRequestModel({this.phone, this.password,this.country,this.email});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'username': phone != null?  phone!.trim().toString():email != null? email!.trim().toString():null,
      'password': password!.trim()
    };

    return map;
  }
}
