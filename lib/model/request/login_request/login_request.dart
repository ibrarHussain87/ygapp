import '../../response/common_response_models/countries_response.dart';

class LoginRequestModel {
  String? phone;
  String? email;
  String? password;
  Countries? country;

  LoginRequestModel({this.phone, this.password,this.country,this.email});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
<<<<<<< HEAD
      'telephone_number': phone != null?  phone!.trim().toString():null,
      'email':email != null? email!.trim().toString():null,
=======
      'telephone_number': username!.trim(),
>>>>>>> dev-asad
      'password': password!.trim()
    };

    return map;
  }
}
