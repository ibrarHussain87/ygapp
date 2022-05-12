class CreateFiberResponse {
  CreateFiberResponse({
    required this.status,
    required this.responseCode,
    required this.data,
    required this.message,
  });
  late final bool status;
  late final int responseCode;
  Data? data;
  late final String message;

  CreateFiberResponse.fromJson(Map<String, dynamic> json){
    status = json['status'];
    responseCode = json['response_code'];
    message = json['message'];
    if(json['data'] != null){
      data = Data.fromJson(json['data']);
    }
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['response_code'] = responseCode;
    _data['data'] = data!.toJson();
    _data['message'] = message;
    return _data;
  }
}

class Data {
  Data({
    required this.spcCategoryIdfk,
    required this.spcUserIdfk,
    required this.spcLocalInternational,
    required this.spcFiberMaterialIdfk,
    required this.spcFiberLengthIdfk,
    required this.spcGradeIdfk,
    required this.spcMicronaireIdfk,
    required this.spcMoistureIdfk,
    required this.spcTrashIdfk,
    required this.spcRdIdfk,
    required this.spcGptIdfk,
    required this.spcAppearanceIdfk,
    required this.spcBrandIdfk,
    required this.spcProductionYear,
    required this.spcOriginIdfk,
    required this.spcCertificateIdfk,
    required this.fbpPrice,
    required this.fbpCountUnitIdfk,
    required this.fbpDeliveryPeriodIdfk,
    required this.fbpAvailableForMarketIdfk,
    required this.fbpPriceTermsIdfk,
    required this.fbpMinQuantity,
    required this.fbpDescription,
    required this.fbpSpecificationsIdfk,
    required this.fbpCategoryIdfk,
  });
  late final String? spcCategoryIdfk;
  late final String? spcUserIdfk;
  late final String? spcLocalInternational;
  late final String? spcFiberMaterialIdfk;
  late final String? spcFiberLengthIdfk;
  late final String? spcGradeIdfk;
  late final String? spcMicronaireIdfk;
  late final String? spcMoistureIdfk;
  late final String? spcTrashIdfk;
  late final String? spcRdIdfk;
  late final String? spcGptIdfk;
  late final String? spcAppearanceIdfk;
  late final String? spcBrandIdfk;
  late final String? spcProductionYear;
  late final String? spcOriginIdfk;
  late final String? spcCertificateIdfk;
  late final String? fbpPrice;
  late final String? fbpCountUnitIdfk;
  late final String? fbpDeliveryPeriodIdfk;
  late final String? fbpAvailableForMarketIdfk;
  late final String? fbpPriceTermsIdfk;
  late final String? fbpMinQuantity;
  late final String? fbpDescription;
  late final int? fbpSpecificationsIdfk;
  late final int? fbpCategoryIdfk;

  Data.fromJson(Map<String, dynamic> json){
    spcCategoryIdfk = json['spc_category_idfk'];
    spcUserIdfk = json['spc_user_idfk'];
    spcLocalInternational = json['spc_local_international'];
    spcFiberMaterialIdfk = json['spc_fiber_material_idfk'];
    spcFiberLengthIdfk = json['spc_fiber_length_idfk'];
    spcGradeIdfk = json['spc_grade_idfk'];
    spcMicronaireIdfk = json['spc_micronaire_idfk'];
    spcMoistureIdfk = json['spc_moisture_idfk'];
    spcTrashIdfk = json['spc_trash_idfk'];
    spcRdIdfk = json['spc_rd_idfk'];
    spcGptIdfk = json['spc_gpt_idfk'];
    spcAppearanceIdfk = json['spc_appearance_idfk'];
    spcBrandIdfk = json['spc_brand_idfk'];
    spcProductionYear = json['spc_production_year'];
    spcOriginIdfk = json['spc_origin_idfk'];
    spcCertificateIdfk = json['spc_certificate_idfk'];
    fbpPrice = json['fbp_price'];
    fbpCountUnitIdfk = json['fbp_count_unit_idfk'];
    fbpDeliveryPeriodIdfk = json['fbp_delivery_period_idfk'];
    fbpAvailableForMarketIdfk = json['fbp_available_for_market_idfk'];
    fbpPriceTermsIdfk = json['fbp_price_terms_idfk'];
    fbpMinQuantity = json['fbp_min_quantity'];
    fbpDescription = json['fbp_description'];
    fbpSpecificationsIdfk = json['fbp_specifications_idfk'];
    fbpCategoryIdfk = json['fbp_category_idfk'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['spc_category_idfk'] = spcCategoryIdfk;
    _data['spc_user_idfk'] = spcUserIdfk;
    _data['spc_local_international'] = spcLocalInternational;
    _data['spc_fiber_material_idfk'] = spcFiberMaterialIdfk;
    _data['spc_fiber_length_idfk'] = spcFiberLengthIdfk;
    _data['spc_grade_idfk'] = spcGradeIdfk;
    _data['spc_micronaire_idfk'] = spcMicronaireIdfk;
    _data['spc_moisture_idfk'] = spcMoistureIdfk;
    _data['spc_trash_idfk'] = spcTrashIdfk;
    _data['spc_rd_idfk'] = spcRdIdfk;
    _data['spc_gpt_idfk'] = spcGptIdfk;
    _data['spc_appearance_idfk'] = spcAppearanceIdfk;
    _data['spc_brand_idfk'] = spcBrandIdfk;
    _data['spc_production_year'] = spcProductionYear;
    _data['spc_origin_idfk'] = spcOriginIdfk;
    _data['spc_certificate_idfk'] = spcCertificateIdfk;
    _data['fbp_price'] = fbpPrice;
    _data['fbp_count_unit_idfk'] = fbpCountUnitIdfk;
    _data['fbp_delivery_period_idfk'] = fbpDeliveryPeriodIdfk;
    _data['fbp_available_for_market_idfk'] = fbpAvailableForMarketIdfk;
    _data['fbp_price_terms_idfk'] = fbpPriceTermsIdfk;
    _data['fbp_min_quantity'] = fbpMinQuantity;
    _data['fbp_description'] = fbpDescription;
    _data['fbp_specifications_idfk'] = fbpSpecificationsIdfk;
    _data['fbp_category_idfk'] = fbpCategoryIdfk;
    return _data;
  }
}