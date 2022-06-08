
class UpdateProfileRequestModel {

  String? id;
  String? ntn_number;
  String? postalCode;
  String? name;
  String? countryId;
  String? company;
  String? cityStateId;
  String? city;
  String? email;
  String? whatsapp;
  String? address;
  String? telephoneNumber;

  UpdateProfileRequestModel({this.whatsapp,this.address,this.city,this.email,this.name,this.countryId,this.cityStateId,this.postalCode,this.telephoneNumber});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
//      'id': id!.trim(),
      'email': email?.trim(),
//      'ntn_number': ntn_number!.trim(),
      'name': name?.trim(),
      'country_id': countryId?.trim(),
      'company_id': '1',
      'state_id': cityStateId?.trim(),
      'whatsapp': whatsapp?.trim(),
      'address': address?.trim(),
      'city': city?.trim(),
      'postal_code': postalCode?.trim(),
      'telephone_number': telephoneNumber?.trim()
    };

    return map;
  }
}
