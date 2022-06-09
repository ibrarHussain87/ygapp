
class UpdateBusinessRequestModel {

  String? employment_role;
  String? ntn_number;
  String? trade_mark;
  String? name;
  String? designation_idfk;
  String? postalCode;
  String? countryId;
  String? company;
  String? companyId;
  String? cityStateId;
  String? city;
  String? website;
  String? address;

  UpdateBusinessRequestModel({this.companyId,this.website,this.postalCode,this.ntn_number,this.address,this.city,this.designation_idfk,this.name,this.countryId,this.cityStateId,this.employment_role,this.trade_mark,this.company
  });



  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
//      'id': id!.trim(),
      'ubi_gst_ntn_number': ntn_number?.trim(),
//      'ntn_number': ntn_number!.trim(),
      'ubi_name': name?.trim(),
      'ubi_country_idfk': countryId?.trim(),
      'company_id': companyId?.trim() ?? "",
      'ubi_state_idfk': cityStateId?.trim(),
      'ubi_website': website?.trim(),
      'ubi_address': address?.trim(),
      'ubi_city_idfk': city?.trim(),
      'ubi_zipcode': postalCode?.trim(),
      'ubi_trade_mark': trade_mark?.trim(),
      'ubi_employment_role': employment_role?.trim(),
      'ubi_designation_idfk': designation_idfk?.trim()
    };

    return map;
  }
}
