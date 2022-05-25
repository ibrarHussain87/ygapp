import 'package:yg_app/model/response/common_response_models/countries_response.dart';

class SignUpRequestModel {
  String? userName;
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
      {this.userName,
      this.name,
      this.email,
      this.password,
      this.countryId,
      this.cityStateId,
      this.operator,
      this.telephoneNumber,
      this.config,
      this.comapnyId,
      this.comapnyName,
      this.otherCompany,
      this.country});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'name': name.toString().trim(),
      'username': telephoneNumber == null
          ? email.toString().trim()
          : telephoneNumber.toString().trim(),
      'password': password.toString().trim(),
      'country_id': countryId.toString().trim(),
      'company': company.toString().trim(),
      'city_state_id': cityStateId.toString().trim(),
      'operator': operator.toString().trim(),
      'telephone_number': telephoneNumber.toString().trim(),
      'company_id': comapnyId,
      'company_name': comapnyName ?? company,
      'other_company': otherCompany,
      'operator_id': '4'
    };

    return map;
  }
}
