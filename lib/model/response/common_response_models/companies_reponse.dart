import 'package:floor/floor.dart';

@Entity(tableName: 'companies')
class Companies {
  Companies({
    required this.id,
    required this.name,
    required this.gst,
    this.logo,
    this.tradeMark,
    required this.address,
    required this.countryId,
    required this.cityStateId,
    required this.zipCode,
    required this.websiteUrl,
    required this.whatsappNumber,
    required this.wechatNumber,
    required this.telephoneNumber,
    required this.emailId,
    required this.maxProduction,
    required this.noOfUnits,
    required this.yearEstablished,
    required this.tradeCategory,
    required this.licenseHolder,
    required this.isVerified,
    this.rating,
  });
  @PrimaryKey(autoGenerate: false)
  late final int id;
  late final String? name;
  late final String? gst;
  @ignore
  late final Null logo;
  @ignore
  late final Null tradeMark;
  late final String? address;
  late final String? countryId;
  late final String? cityStateId;
  late final String? zipCode;
  late final String? websiteUrl;
  late final String? whatsappNumber;
  late final String? wechatNumber;
  late final String? telephoneNumber;
  late final String? emailId;
  late final String? maxProduction;
  late final String? noOfUnits;
  late final String? yearEstablished;
  late final String? tradeCategory;
  late final String? licenseHolder;
  late final String? isVerified;
  @ignore
  late final Null rating;

  Companies.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    gst = json['gst'];
    logo = null;
    tradeMark = null;
    address = json['address'];
    countryId = json['country_id'];
    cityStateId = json['city_state_id'];
    zipCode = json['zip_code'];
    websiteUrl = json['website_url'];
    whatsappNumber = json['whatsapp_number'];
    wechatNumber = json['wechat_number'];
    telephoneNumber = json['telephone_number'];
    emailId = json['email_id'];
    maxProduction = json['max_production'];
    noOfUnits = json['no_of_units'];
    yearEstablished = json['year_established'];
    tradeCategory = json['trade_category'];
    licenseHolder = json['license_holder'];
    isVerified = json['is_verified'];
    rating = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['gst'] = gst;
    _data['logo'] = logo;
    _data['trade_mark'] = tradeMark;
    _data['address'] = address;
    _data['country_id'] = countryId;
    _data['city_state_id'] = cityStateId;
    _data['zip_code'] = zipCode;
    _data['website_url'] = websiteUrl;
    _data['whatsapp_number'] = whatsappNumber;
    _data['wechat_number'] = wechatNumber;
    _data['telephone_number'] = telephoneNumber;
    _data['email_id'] = emailId;
    _data['max_production'] = maxProduction;
    _data['no_of_units'] = noOfUnits;
    _data['year_established'] = yearEstablished;
    _data['trade_category'] = tradeCategory;
    _data['license_holder'] = licenseHolder;
    _data['is_verified'] = isVerified;
    _data['rating'] = rating;
    return _data;
  }

  @override
  String toString() {
    // TODO: implement toString
    return name??"";
  }
}