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
  String? comapnyId;
  String? comapnyName;
  String? otherCompany;
  Countries? country;

  SignUpRequestModel(

      {this.name,this.email, this.password,this.countryId,this.cityStateId,this.operator,this.telephoneNumber,this.config,
        this.comapnyId,this.comapnyName,this.otherCompany,this.country});

  Map<String, dynamic> toJson() {

    Map<String, dynamic> map = {
      'name': name.toString().trim(),
//      'name': name!.trim(),
      'email': email.toString().trim(),
//      'email': email!.trim(),
      'password': password!.trim(),
      'country_id': countryId!.trim(),
      'company': company!.trim(),
      'city_state_id': cityStateId!.trim(),
      'operator': operator!.trim(),
      'telephone_number': telephoneNumber.toString().trim(),
//      'telephone_number': telephoneNumber!.trim()
      'company_id': comapnyId ?? '-1',
      'company_name': comapnyName ?? company,
      'other_company': '1'
    };

    return map;
  }
}
