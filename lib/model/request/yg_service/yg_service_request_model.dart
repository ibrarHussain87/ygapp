
class YGServiceRequestModel {

  String? serviceTypeId;
  String? name;
  String? companyName;
  String? contactDetails;
  String? landMark;
  String? email;
  String? address;
  String? telephoneNumber;
  String? secNumber;
  String? secName;
  String? details;
  String? specialInstructions;
  String? dateTime;

  YGServiceRequestModel({this.serviceTypeId,this.contactDetails,this.companyName,this.landMark,
    this.specialInstructions,this.address,this.secName,this.email,this.name,this.secNumber,
    this.details,this.dateTime,this.telephoneNumber});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'service_type_idfk': serviceTypeId?.trim(),
      'ygservice_email': email?.trim(),
      'ygservice_name': name?.trim(),
      'ygservice_contact_details': contactDetails?.trim(),
      'ygservice_company_name': companyName?.trim(),
      'ygservice_nearest_landmark': landMark?.trim(),
      'ygservice_special_instruction': specialInstructions?.trim(),
      'ygservice_address': address?.trim(),
      'ygservice_suitable_datetime': dateTime?.trim(),
      'ygservice_details': details?.trim(),
      'ygservice_contact_number': telephoneNumber?.trim(),
      'ygservice_secondry_contact_name': secName?.trim(),
      'ygservice_secondry_contact_number': secNumber?.trim(),
    };

    return map;
  }
}
