import 'package:floor/floor.dart';
import 'package:yg_app/model/response/common_response_models/category_response.dart';
import 'package:yg_app/model/response/common_response_models/companies_reponse.dart';


class CountriesSyncResponse {
  bool? status;
  String? message;
  Data? data;
  int? responseCode;
  int? code;

  CountriesSyncResponse(
      {this.status, this.message, this.data, this.responseCode, this.code});

  CountriesSyncResponse.fromJson(Map<String, dynamic> json) {
    status = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    responseCode = json['response_code'];
    code = json['code'];
  }

//  Map<String, dynamic> toJson() {
//    final Map<String, dynamic> data = Map<String, dynamic>();
//    data['status'] = status;
//    data['message'] = message;
//    if (this.data != null) {
//      data['data'] = this.data!.toJson();
//    }
//    data['response_code'] = responseCode;
//    data['code'] = code;
//    return data;
//  }
}


class Data {

  late final List<Countries> countries;
  late final List<Categories> categories;

  Data({required this.countries,required this.categories});

  Data.fromJson(Map<String, dynamic> json) {

    countries =json['countries'].map<Countries>((
        json) {
      return Countries.fromJson(json);
    }).toList();

    categories =json['categories'].map<Categories>((
        json) {
      return Categories.fromJson(json);
    }).toList();
  }


}

@Entity(tableName: 'countries')
class Countries {
  @PrimaryKey(autoGenerate:false)
  int? conId;
  String? conName;
  String? countryIso;
  String? countryIso3;
  String? countryCurrencyName;
  String? countryCurrencyCode;
  String? countryCurrencySymbol;
  String? countryPhoneCode;
  String? countryContinent;
  String? countryStatus;
  String? mainFlagImage;
  String? extralarge;
  String? large;
  String? medium;

  Countries(
      {this.conId,
        this.conName,
        this.countryIso,
        this.countryIso3,
        this.countryCurrencyName,
        this.countryCurrencyCode,
        this.countryCurrencySymbol,
        this.countryPhoneCode,
        this.countryContinent,
        this.countryStatus,
        this.mainFlagImage,
        this.extralarge,
        this.large,
        this.medium});

  Countries.fromJson(Map<String, dynamic> json) {
    conId = json['country_id'];
    conName = json['country_name'];
    countryIso = json['country_iso'];
    countryIso3 = json['country_iso3'];
    countryCurrencyName = json['country_currency_name'];
    countryCurrencyCode = json['country_currency_code'];
    countryCurrencySymbol = json['country_currency_symbol'];
    countryPhoneCode = json['country_phone_code'];
    countryContinent = json['country_continent'];
    countryStatus = json['country_status'];
    mainFlagImage = json['main_flag_image'];
    extralarge = json['extralarge'];
    large = json['large'];
    medium = json['medium'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['country_id'] = this.conId;
    data['country_name'] = this.conName;
    data['country_iso'] = this.countryIso;
    data['country_iso3'] = this.countryIso3;
    data['country_currency_name'] = this.countryCurrencyName;
    data['country_currency_code'] = this.countryCurrencyCode;
    data['country_currency_symbol'] = this.countryCurrencySymbol;
    data['country_phone_code'] = this.countryPhoneCode;
    data['country_continent'] = this.countryContinent;
    data['country_status'] = this.countryStatus;
    data['main_flag_image'] = this.mainFlagImage;
    data['extralarge'] = this.extralarge;
    data['large'] = this.large;
    data['medium'] = this.medium;
    return data;
  }

  @override
  String toString() {
    // TODO: implement toString
    return "$countryCurrencyName ($countryCurrencySymbol)";
  }
}