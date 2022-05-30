
class UpdateBusinessRequestModel {

  String? employment_role;
  String? ntn_number;
  String? trade_mark;
  String? name;
  String? designation_idfk;
  String? postalCode;
  String? countryId;
  String? company;
  String? cityStateId;
  String? city;
  String? website;
  String? address;

  UpdateBusinessRequestModel({this.website,this.postalCode,this.ntn_number,this.address,this.city,this.designation_idfk,this.name,this.countryId,this.cityStateId,this.employment_role,this.trade_mark,this.company
  });

  /*****
   *  "ubi_id": 3,
      "ubi_user_idfk": "1",
      "ubi_name": "G Cloth House",
      "ubi_gst_ntn_number": "665577XYY",
      "ubi_trade_mark": "TDMRK112222",
      "ubi_employment_role": "Role Sample B",
      "ubi_designation_idfk": "1",
      "ubi_country_idfk": "162",
      "ubi_state_idfk": "1",
      "ubi_city_idfk": "2",
      "ubi_address": "address xyz 333",
      "ubi_zipcode": "8000",
      "ubi_website": "https://www.gulahmedshop.com"

   */

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
//      'id': id!.trim(),
      'ubi_gst_ntn_number': ntn_number!.trim(),
//      'ntn_number': ntn_number!.trim(),
      'ubi_name': name!.trim(),
      'ubi_country_idfk': countryId!.trim(),
      'company_id': company?.trim() ?? "1",
      'ubi_state_idfk': cityStateId?.trim() ?? "1",
      'ubi_website': website!.trim(),
      'ubi_address': address!.trim(),
      'ubi_city_idfk': city!.trim(),
      'ubi_zipcode': postalCode!.trim(),
      'ubi_trade_mark': trade_mark!.trim(),
      'ubi_employment_role': employment_role!.trim(),
      'ubi_designation_idfk': designation_idfk!.trim()
    };

    return map;
  }
}
