import '../../response/common_response_models/countries_response.dart';

class LoginRequestModel {
  String? username;
  String? password;
  Countries? country;

  LoginRequestModel({this.username, this.password,this.country});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'username': username!.trim(),
      'password': password!.trim()
    };

    return map;
  }
}
