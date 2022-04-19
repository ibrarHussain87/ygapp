import 'package:floor/floor.dart';

@Entity(tableName: 'countries')
class Countries {
  Countries({
    required this.conId,
    required this.conName,
    required this.conIsoCode_2,
    required this.conIsoCode_3,
    required this.conCurrency,
    required this.conAddressFormat,
    required this.conPostcodeRequired,
    required this.conIsActive,
  });

  @PrimaryKey(autoGenerate: false)
  late final int conId;
  String? conName;
  String? conIsoCode_2;
  String? conIsoCode_3;
  String? conCurrency;
  String? conAddressFormat;
  String? conPostcodeRequired;
  String? conIsActive;

  Countries.fromJson(Map<String, dynamic> json){
    conId = json['con_id'];
    conName = json['con_name'];
    conIsoCode_2 = json['con_iso_code_2'];
    conIsoCode_3 = json['con_iso_code_3'];
    conCurrency = json['con_currency'];
    conAddressFormat = json['con_address_format'];
    conPostcodeRequired = json['con_postcode_required'];
    conIsActive = json['con_is_active'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['con_id'] = conId;
    _data['con_name'] = conName;
    _data['con_iso_code_2'] = conIsoCode_2;
    _data['con_iso_code_3'] = conIsoCode_3;
    _data['con_currency'] = conCurrency;
    _data['con_address_format'] = conAddressFormat;
    _data['con_postcode_required'] = conPostcodeRequired;
    _data['con_is_active'] = conIsActive;
    return _data;
  }

  @override
  String toString() {
    // TODO: implement toString
    return "$conName ($conCurrency)";
  }
}