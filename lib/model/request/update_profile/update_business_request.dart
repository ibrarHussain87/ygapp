
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
  String? otherCompany;
  String? companyName;

  UpdateBusinessRequestModel({this.companyName,this.otherCompany,this.companyId,this.website,this.postalCode,this.ntn_number,this.address,this.city,this.designation_idfk,this.name,this.countryId,this.cityStateId,this.employment_role,this.trade_mark,this.company
  });



  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
//      'id': id!.trim(),
      'ubi_gst_ntn_number': ntn_number,
//      'ntn_number': ntn_number!.trim(),
      'ubi_name': name,
      'ubi_country_idfk': countryId,
      'company_id': companyId,
      'company_name': companyName,
      'other_company': companyId!=null ? "0":"1",
      'ubi_state_idfk': cityStateId,
      'ubi_website': website,
      'ubi_address': address,
      'ubi_city_idfk': city,
      'ubi_zipcode': postalCode,
      'ubi_trade_mark': trade_mark,
      'ubi_employment_role': employment_role,
      'ubi_designation_idfk': designation_idfk
    };

    return map;
  }
}
