import 'package:yg_app/model/response/common_response_models/countries_response.dart';

class SignUpRequestModel {

  String? name;
  String? email;
  String? password;
  String? countryId;
  String? company;
  String? cityStateId;
  String? operator;
  String? telephoneNumber;
  String? config;
  Countries? country;

  SignUpRequestModel(

      {this.name,this.email, this.password,this.countryId,this.cityStateId,this.operator,this.telephoneNumber,this.config,
        this.country});

  Map<String, dynamic> toJson() {

    Map<String, dynamic> map = {
      'name': name!.trim(),
      'email': email!.trim(),
      'password': password!.trim(),
      'country_id': countryId!.trim(),
      'company': company!.trim(),
      'city_state_id': cityStateId!.trim(),
      'operator': operator!.trim(),
      'telephone_number': telephoneNumber!.trim()
    };

    return map;
  }
}
