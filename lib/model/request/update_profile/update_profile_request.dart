
class UpdateProfileRequestModel {

  String? id;
  String? ntn_number;
  String? name;
  String? countryId;
  String? company;
  String? cityStateId;
  String? operator;
  String? telephoneNumber;

  UpdateProfileRequestModel({this.id,this.ntn_number,this.name,this.countryId,this.cityStateId,this.operator,this.telephoneNumber});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'id': id!.trim(),
      'ntn_number': ntn_number!.trim(),
      'name': name!.trim(),
      'country_id': countryId!.trim(),
      'company': company!.trim(),
      'city_state_id': cityStateId!.trim(),
      'operator': operator!.trim(),
      'telephone_number': telephoneNumber!.trim()
    };

    return map;
  }
}
