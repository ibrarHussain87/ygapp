import 'package:floor/floor.dart';
import 'package:yg_app/model/response/common_response_models/brands_response.dart';
import 'package:yg_app/model/response/common_response_models/certification_response.dart';
import 'package:yg_app/model/response/common_response_models/city_state_response.dart';
import 'package:yg_app/model/response/common_response_models/countries_response.dart';
import 'package:yg_app/model/response/common_response_models/fiber_apperance.dart';
import 'package:yg_app/model/response/common_response_models/fiber_delievery_period.dart';
import 'package:yg_app/model/response/common_response_models/grade.dart';
import 'package:yg_app/model/response/common_response_models/lc_type_response.dart';
import 'package:yg_app/model/response/common_response_models/packing_response.dart';
import 'package:yg_app/model/response/common_response_models/payment_type_response.dart';
import 'package:yg_app/model/response/common_response_models/ports_response.dart';
import 'package:yg_app/model/response/common_response_models/price_term.dart';
import 'package:yg_app/model/response/common_response_models/unit_of_count.dart';

class YarnSyncResponse {
  YarnSyncResponse({
    required this.status,
    required this.responseCode,
    required this.data,
    required this.message,
  });
  late final bool status;
  late final int responseCode;
  late final YarnData data;
  late final String message;

  YarnSyncResponse.fromJson(Map<String, dynamic> json){
    status = json['status'];
    responseCode = json['response_code'];
    data = YarnData.fromJson(json['data']);
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['response_code'] = responseCode;
    _data['data'] = data.toJson();
    _data['message'] = message;
    return _data;
  }
}

class YarnData {
  YarnData({
    required this.yarn,
  });
  late final Yarn yarn;

  YarnData.fromJson(Map<String, dynamic> json){
    yarn = Yarn.fromJson(json['yarn']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['yarn'] = yarn.toJson();
    return _data;
  }
}

class Yarn {
  Yarn({
    required this.colorTreatmentMethod,
    required this.dyingMethod,
    required this.family,
    required this.orientation,
    required this.pattern,
    required this.patternCharectristic,
    required this.ply,
    required this.quality,
    required this.countries,
    required this.cityState,
    required this.ports,
    required this.lcTypes,
    required this.paymentTypes,
    required this.packing,
    required this.setting,
    required this.spunTechnique,
    required this.twistDirection,
    required this.usage,
    required this.blends,
    required this.grades,
    required this.certification,
    required this.apperance,
    required this.priceTerms,
    required this.deliveryPeriod,
    required this.units,
    required this.companies,
    required this.brands,
  });
  late final List<ColorTreatmentMethod> colorTreatmentMethod;
  late final List<DyingMethod> dyingMethod;
  late final List<Family> family;
  late final List<Orientation> orientation;
  late final List<Pattern> pattern;
  late final List<PatternCharectristic> patternCharectristic;
  late final List<Ply> ply;
  late final List<Quality> quality;
  late final List<Countries> countries;
  late final List<CityState> cityState;
  late final List<Ports> ports;
  late final List<LcType> lcTypes;
  late final List<PaymentType> paymentTypes;
  late final List<Packing> packing;
  late final List<YarnSetting> setting;
  late final List<SpunTechnique> spunTechnique;
  late final List<TwistDirection> twistDirection;
  late final List<Usage> usage;
  late final List<Blends> blends;
  late final List<Grades> grades;
  late final List<Certification> certification;
  late final List<Apperance> apperance;
  late final List<FPriceTerms> priceTerms;
  late final List<DeliveryPeriod> deliveryPeriod;
  late final List<Units> units;
  late final List<Companies> companies;
  late final List<Brands> brands;

  Yarn.fromJson(Map<String, dynamic> json){
    colorTreatmentMethod = List.from(json['color_treatment_method']).map((e)=>ColorTreatmentMethod.fromJson(e)).toList();
    dyingMethod = List.from(json['dying_method']).map((e)=>DyingMethod.fromJson(e)).toList();
    family = List.from(json['family']).map((e)=>Family.fromJson(e)).toList();
    orientation = List.from(json['orientation']).map((e)=>Orientation.fromJson(e)).toList();
    pattern = List.from(json['pattern']).map((e)=>Pattern.fromJson(e)).toList();
    patternCharectristic = List.from(json['pattern_charectristic']).map((e)=>PatternCharectristic.fromJson(e)).toList();
    ply = List.from(json['ply']).map((e)=>Ply.fromJson(e)).toList();
    quality = List.from(json['quality']).map((e)=>Quality.fromJson(e)).toList();
    countries = List.from(json['countries']).map((e)=>Countries.fromJson(e)).toList();
    cityState = List.from(json['city_state']).map((e)=>CityState.fromJson(e)).toList();
    ports = List.from(json['ports']).map((e)=>Ports.fromJson(e)).toList();
    lcTypes = List.from(json['lc_types']).map((e)=>LcType.fromJson(e)).toList();
    paymentTypes = List.from(json['payment_types']).map((e)=>PaymentType.fromJson(e)).toList();
    packing = List.from(json['packing']).map((e)=>Packing.fromJson(e)).toList();
    setting = List.from(json['setting']).map((e)=>YarnSetting.fromJson(e)).toList();
    spunTechnique = List.from(json['spun_technique']).map((e)=>SpunTechnique.fromJson(e)).toList();
    twistDirection = List.from(json['twist_direction']).map((e)=>TwistDirection.fromJson(e)).toList();
    usage = List.from(json['usage']).map((e)=>Usage.fromJson(e)).toList();
    blends = List.from(json['blends']).map((e)=>Blends.fromJson(e)).toList();
    grades = List.from(json['grades']).map((e)=>Grades.fromJson(e)).toList();
    certification = List.from(json['certification']).map((e)=>Certification.fromJson(e)).toList();
    apperance = List.from(json['apperance']).map((e)=>Apperance.fromJson(e)).toList();
    priceTerms = List.from(json['price_terms']).map((e)=>FPriceTerms.fromJson(e)).toList();
    deliveryPeriod = List.from(json['delivery_period']).map((e)=>DeliveryPeriod.fromJson(e)).toList();
    units = List.from(json['units']).map((e)=>Units.fromJson(e)).toList();
    companies = List.from(json['companies']).map((e)=>Companies.fromJson(e)).toList();
    brands = List.from(json['brands']).map((e)=>Brands.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['color_treatment_method'] = colorTreatmentMethod.map((e)=>e.toJson()).toList();
    _data['dying_method'] = dyingMethod.map((e)=>e.toJson()).toList();
    _data['family'] = family.map((e)=>e.toJson()).toList();
    _data['orientation'] = orientation.map((e)=>e.toJson()).toList();
    _data['pattern'] = pattern.map((e)=>e.toJson()).toList();
    _data['pattern_charectristic'] = patternCharectristic.map((e)=>e.toJson()).toList();
    _data['ply'] = ply.map((e)=>e.toJson()).toList();
    _data['quality'] = quality.map((e)=>e.toJson()).toList();
    _data['countries'] = countries.map((e)=>e.toJson()).toList();
    _data['city_state'] = cityState.map((e)=>e.toJson()).toList();
    _data['ports'] = ports.map((e)=>e.toJson()).toList();
    _data['lc_types'] = lcTypes.map((e)=>e.toJson()).toList();
    _data['payment_types'] = paymentTypes.map((e)=>e.toJson()).toList();
    _data['packing'] = packing.map((e)=>e.toJson()).toList();
    _data['setting'] = setting.map((e)=>e.toJson()).toList();
    _data['spun_technique'] = spunTechnique.map((e)=>e.toJson()).toList();
    _data['twist_direction'] = twistDirection.map((e)=>e.toJson()).toList();
    _data['usage'] = usage.map((e)=>e.toJson()).toList();
    _data['blends'] = blends.map((e)=>e.toJson()).toList();
    _data['grades'] = grades.map((e)=>e.toJson()).toList();
    _data['certification'] = certification.map((e)=>e.toJson()).toList();
    _data['apperance'] = apperance.map((e)=>e.toJson()).toList();
    _data['price_terms'] = priceTerms.map((e)=>e.toJson()).toList();
    _data['delivery_period'] = deliveryPeriod.map((e)=>e.toJson()).toList();
    _data['units'] = units.map((e)=>e.toJson()).toList();
    _data['companies'] = companies.map((e)=>e.toJson()).toList();
    _data['brands'] = brands.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class ColorTreatmentMethod {
  ColorTreatmentMethod({
    required this.yctmId,
    required this.yctmName,
    required this.yctmColorMethodIdfk,
    this.yctmDescription,
    required this.yctmIsActive,
    this.yctmSortid,
  });
  late final int yctmId;
  late final String yctmName;
  late final String yctmColorMethodIdfk;
  late final Null yctmDescription;
  late final String yctmIsActive;
  late final Null yctmSortid;

  ColorTreatmentMethod.fromJson(Map<String, dynamic> json){
    yctmId = json['yctm_id'];
    yctmName = json['yctm_name'];
    yctmColorMethodIdfk = json['yctm_color_method_idfk'];
    yctmDescription = null;
    yctmIsActive = json['yctm_is_active'];
    yctmSortid = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['yctm_id'] = yctmId;
    _data['yctm_name'] = yctmName;
    _data['yctm_color_method_idfk'] = yctmColorMethodIdfk;
    _data['yctm_description'] = yctmDescription;
    _data['yctm_is_active'] = yctmIsActive;
    _data['yctm_sortid'] = yctmSortid;
    return _data;
  }

  @override
  String toString() {
    // TODO: implement toString
    return yctmName;
  }
}

class DyingMethod {
  DyingMethod({
    required this.ydmId,
    required this.ydmName,
    required this.ydmType,
    required this.ydmColorTreatmentMethodIdfk,
    this.ydmDescription,
    required this.ydmIsActive,
    this.ydmSortid,
  });
  late final int ydmId;
  late final String ydmName;
  late final String ydmType;
  late final String ydmColorTreatmentMethodIdfk;
  late final Null ydmDescription;
  late final String ydmIsActive;
  late final Null ydmSortid;

  DyingMethod.fromJson(Map<String, dynamic> json){
    ydmId = json['ydm_id'];
    ydmName = json['ydm_name'];
    ydmType = json['ydm_type'];
    ydmColorTreatmentMethodIdfk = json['ydm_color_treatment_method_idfk'];
    ydmDescription = null;
    ydmIsActive = json['ydm_is_active'];
    ydmSortid = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['ydm_id'] = ydmId;
    _data['ydm_name'] = ydmName;
    _data['ydm_type'] = ydmType;
    _data['ydm_color_treatment_method_idfk'] = ydmColorTreatmentMethodIdfk;
    _data['ydm_description'] = ydmDescription;
    _data['ydm_is_active'] = ydmIsActive;
    _data['ydm_sortid'] = ydmSortid;
    return _data;
  }

  @override
  String toString() {
    // TODO: implement toString
    return ydmName;
  }
}

class Family {
  Family({
    required this.famId,
    required this.famName,
    required this.famType,
    required this.famDescription,
    required this.catIsActive,
    this.catSortid,
  });
  late final int famId;
  late final String famName;
  late final String famType;
  late final String famDescription;
  late final String catIsActive;
  late final Null catSortid;

  Family.fromJson(Map<String, dynamic> json){
    famId = json['fam_id'];
    famName = json['fam_name'];
    famType = json['fam_type'];
    famDescription = json['fam_description'];
    catIsActive = json['cat_is_active'];
    catSortid = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['fam_id'] = famId;
    _data['fam_name'] = famName;
    _data['fam_type'] = famType;
    _data['fam_description'] = famDescription;
    _data['cat_is_active'] = catIsActive;
    _data['cat_sortid'] = catSortid;
    return _data;
  }

  @override
  String toString() {
    // TODO: implement toString
    return famName;
  }
}

class Orientation {
  Orientation({
    required this.yoId,
    required this.yoName,
    this.yoDescription,
    required this.yoIsActive,
    this.catSortid,
  });
  late final int yoId;
  late final String yoName;
  late final Null yoDescription;
  late final String yoIsActive;
  late final Null catSortid;

  Orientation.fromJson(Map<String, dynamic> json){
    yoId = json['yo_id'];
    yoName = json['yo_name'];
    yoDescription = null;
    yoIsActive = json['yo_is_active'];
    catSortid = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['yo_id'] = yoId;
    _data['yo_name'] = yoName;
    _data['yo_description'] = yoDescription;
    _data['yo_is_active'] = yoIsActive;
    _data['cat_sortid'] = catSortid;
    return _data;
  }

  @override
  String toString() {
    return yoName;
  }
}

class Pattern {
  Pattern({
    required this.ypId,
    required this.ypName,
    this.ypDescription,
    required this.ypIsActive,
    this.catSortid,
  });
  late final int ypId;
  late final String ypName;
  late final Null ypDescription;
  late final String ypIsActive;
  late final Null catSortid;

  Pattern.fromJson(Map<String, dynamic> json){
    ypId = json['yp_id'];
    ypName = json['yp_name'];
    ypDescription = null;
    ypIsActive = json['yp_is_active'];
    catSortid = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['yp_id'] = ypId;
    _data['yp_name'] = ypName;
    _data['yp_description'] = ypDescription;
    _data['yp_is_active'] = ypIsActive;
    _data['cat_sortid'] = catSortid;
    return _data;
  }
  @override
  String toString() {
    // TODO: implement toString
    return ypName;
  }
}

class PatternCharectristic {
  PatternCharectristic({
    required this.ypcId,
    required this.ypcName,
    required this.ypcPatternIdfk,
    required this.ypcDescription,
    required this.ypcIsActive,
    this.ypcSortid,
  });
  late final int ypcId;
  late final String ypcName;
  late final String ypcPatternIdfk;
  late final String ypcDescription;
  late final String ypcIsActive;
  late final Null ypcSortid;

  PatternCharectristic.fromJson(Map<String, dynamic> json){
    ypcId = json['ypc_id'];
    ypcName = json['ypc_name'];
    ypcPatternIdfk = json['ypc_pattern_idfk'];
    ypcDescription = json['ypc_description'];
    ypcIsActive = json['ypc_is_active'];
    ypcSortid = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['ypc_id'] = ypcId;
    _data['ypc_name'] = ypcName;
    _data['ypc_pattern_idfk'] = ypcPatternIdfk;
    _data['ypc_description'] = ypcDescription;
    _data['ypc_is_active'] = ypcIsActive;
    _data['ypc_sortid'] = ypcSortid;
    return _data;
  }
}

class Ply {
  Ply({
    required this.plyId,
    required this.plyName,
    this.plyDescription,
    required this.catIsActive,
    this.catSortid,
  });
  late final int plyId;
  late final String plyName;
  late final Null plyDescription;
  late final String catIsActive;
  late final Null catSortid;

  Ply.fromJson(Map<String, dynamic> json){
    plyId = json['ply_id'];
    plyName = json['ply_name'];
    plyDescription = null;
    catIsActive = json['cat_is_active'];
    catSortid = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['ply_id'] = plyId;
    _data['ply_name'] = plyName;
    _data['ply_description'] = plyDescription;
    _data['cat_is_active'] = catIsActive;
    _data['cat_sortid'] = catSortid;
    return _data;
  }
  @override
  String toString() {
    // TODO: implement toString
    return plyName;
  }
}

class Quality {
  Quality({
    required this.yqId,
    required this.yqName,
    required this.yqBlendIdfk,
    this.yqDescription,
    required this.yqIsActive,
    this.yqSortid,
  });
  late final int yqId;
  late final String yqName;
  late final String yqBlendIdfk;
  late final Null yqDescription;
  late final String yqIsActive;
  late final Null yqSortid;

  Quality.fromJson(Map<String, dynamic> json){
    yqId = json['yq_id'];
    yqName = json['yq_name'];
    yqBlendIdfk = json['yq_blend_idfk'];
    yqDescription = null;
    yqIsActive = json['yq_is_active'];
    yqSortid = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['yq_id'] = yqId;
    _data['yq_name'] = yqName;
    _data['yq_blend_idfk'] = yqBlendIdfk;
    _data['yq_description'] = yqDescription;
    _data['yq_is_active'] = yqIsActive;
    _data['yq_sortid'] = yqSortid;
    return _data;
  }

  @override
  String toString() {
    // TODO: implement toString
    return yqName;
  }
}

// class Countries {
//   Countries({
//     required this.conId,
//     required this.conName,
//     required this.conIsoCode_2,
//     required this.conIsoCode_3,
//     required this.conCurrency,
//     required this.conAddressFormat,
//     required this.conPostcodeRequired,
//     required this.conIsActive,
//   });
//   late final int conId;
//   late final String conName;
//   late final String conIsoCode_2;
//   late final String conIsoCode_3;
//   late final String conCurrency;
//   late final String conAddressFormat;
//   late final String conPostcodeRequired;
//   late final String conIsActive;
//
//   Countries.fromJson(Map<String, dynamic> json){
//     conId = json['con_id'];
//     conName = json['con_name'];
//     conIsoCode_2 = json['con_iso_code_2'];
//     conIsoCode_3 = json['con_iso_code_3'];
//     conCurrency = json['con_currency'];
//     conAddressFormat = json['con_address_format'];
//     conPostcodeRequired = json['con_postcode_required'];
//     conIsActive = json['con_is_active'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['con_id'] = conId;
//     _data['con_name'] = conName;
//     _data['con_iso_code_2'] = conIsoCode_2;
//     _data['con_iso_code_3'] = conIsoCode_3;
//     _data['con_currency'] = conCurrency;
//     _data['con_address_format'] = conAddressFormat;
//     _data['con_postcode_required'] = conPostcodeRequired;
//     _data['con_is_active'] = conIsActive;
//     return _data;
//   }
// }

// class CityState {
//   CityState({
//     required this.id,
//     required this.countryId,
//     required this.name,
//     required this.code,
//   });
//   late final int id;
//   late final String countryId;
//   late final String name;
//   late final String code;
//
//   CityState.fromJson(Map<String, dynamic> json){
//     id = json['id'];
//     countryId = json['country_id'];
//     name = json['name'];
//     code = json['code'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['id'] = id;
//     _data['country_id'] = countryId;
//     _data['name'] = name;
//     _data['code'] = code;
//     return _data;
//   }
// }
//
// class Ports {
//   Ports({
//     required this.prtId,
//     required this.prtCountryIdfk,
//     required this.prtName,
//     required this.prtIsActive,
//     this.prtSortid,
//     this.createdAt,
//     this.updatedAt,
//     this.deletedAt,
//   });
//   late final int prtId;
//   late final String prtCountryIdfk;
//   late final String prtName;
//   late final String prtIsActive;
//   late final Null prtSortid;
//   late final Null createdAt;
//   late final Null updatedAt;
//   late final Null deletedAt;
//
//   Ports.fromJson(Map<String, dynamic> json){
//     prtId = json['prt_id'];
//     prtCountryIdfk = json['prt_country_idfk'];
//     prtName = json['prt_name'];
//     prtIsActive = json['prt_is_active'];
//     prtSortid = null;
//     createdAt = null;
//     updatedAt = null;
//     deletedAt = null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['prt_id'] = prtId;
//     _data['prt_country_idfk'] = prtCountryIdfk;
//     _data['prt_name'] = prtName;
//     _data['prt_is_active'] = prtIsActive;
//     _data['prt_sortid'] = prtSortid;
//     _data['created_at'] = createdAt;
//     _data['updated_at'] = updatedAt;
//     _data['deleted_at'] = deletedAt;
//     return _data;
//   }
// }
//
// class LcTypes {
//   LcTypes({
//     required this.lcId,
//     required this.lcName,
//     required this.lcIsActive,
//     this.lcSortid,
//     this.createdAt,
//     this.updatedAt,
//     this.deletedAt,
//   });
//   late final int lcId;
//   late final String lcName;
//   late final String lcIsActive;
//   late final Null lcSortid;
//   late final Null createdAt;
//   late final Null updatedAt;
//   late final Null deletedAt;
//
//   LcTypes.fromJson(Map<String, dynamic> json){
//     lcId = json['lc_id'];
//     lcName = json['lc_name'];
//     lcIsActive = json['lc_is_active'];
//     lcSortid = null;
//     createdAt = null;
//     updatedAt = null;
//     deletedAt = null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['lc_id'] = lcId;
//     _data['lc_name'] = lcName;
//     _data['lc_is_active'] = lcIsActive;
//     _data['lc_sortid'] = lcSortid;
//     _data['created_at'] = createdAt;
//     _data['updated_at'] = updatedAt;
//     _data['deleted_at'] = deletedAt;
//     return _data;
//   }
// }
//
// class PaymentTypes {
//   PaymentTypes({
//     required this.payId,
//     this.payPriceTerrmIdfk,
//     required this.payName,
//     required this.payIsActive,
//     this.paySortid,
//     this.createdAt,
//     this.updatedAt,
//     this.deletedAt,
//   });
//   late final String payId;
//   late final Null payPriceTerrmIdfk;
//   late final String payName;
//   late final String payIsActive;
//   late final Null paySortid;
//   late final Null createdAt;
//   late final Null updatedAt;
//   late final Null deletedAt;
//
//   PaymentTypes.fromJson(Map<String, dynamic> json){
//     payId = json['pay_id'];
//     payPriceTerrmIdfk = null;
//     payName = json['pay_name'];
//     payIsActive = json['pay_is_active'];
//     paySortid = null;
//     createdAt = null;
//     updatedAt = null;
//     deletedAt = null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['pay_id'] = payId;
//     _data['pay_price_terrm_idfk'] = payPriceTerrmIdfk;
//     _data['pay_name'] = payName;
//     _data['pay_is_active'] = payIsActive;
//     _data['pay_sortid'] = paySortid;
//     _data['created_at'] = createdAt;
//     _data['updated_at'] = updatedAt;
//     _data['deleted_at'] = deletedAt;
//     return _data;
//   }
// }
//
// class Packing {
//   Packing({
//     required this.pacId,
//     required this.pacName,
//     required this.pacIsActive,
//     this.pacSortid,
//     this.createdAt,
//     this.updatedAt,
//     this.deletedAt,
//   });
//   late final int pacId;
//   late final String pacName;
//   late final String pacIsActive;
//   late final Null pacSortid;
//   late final Null createdAt;
//   late final Null updatedAt;
//   late final Null deletedAt;
//
//   Packing.fromJson(Map<String, dynamic> json){
//     pacId = json['pac_id'];
//     pacName = json['pac_name'];
//     pacIsActive = json['pac_is_active'];
//     pacSortid = null;
//     createdAt = null;
//     updatedAt = null;
//     deletedAt = null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['pac_id'] = pacId;
//     _data['pac_name'] = pacName;
//     _data['pac_is_active'] = pacIsActive;
//     _data['pac_sortid'] = pacSortid;
//     _data['created_at'] = createdAt;
//     _data['updated_at'] = updatedAt;
//     _data['deleted_at'] = deletedAt;
//     return _data;
//   }
// }

@Entity(tableName: 'yarn_settings')
class YarnSetting {
  YarnSetting({
    required this.ysId,
    required this.ysBlendIdfk,
    required this.ysFiberMaterialIdfk,
    required this.showCount,
    required this.showDannier,
    required this.dannierMinMax,
    required this.showFilament,
    required this.filamentMinMax,
    required this.showQlt,
    required this.showClsp,
    required this.showUniformity,
    required this.showCv,
    required this.showThinPlaces,
    required this.showtThickPlaces,
    required this.showNaps,
    required this.showIpmKm,
    required this.showHairness,
    required this.showRkm,
    required this.showElongation,
    required this.showTpi,
    required this.showTm,
    required this.showDty,
    required this.showFdy,
    required this.ysIsActive,
    this.ysSortid,
  });
  @PrimaryKey(autoGenerate: false)
  late final int ysId;
  late final String ysBlendIdfk;
  late final String ysFiberMaterialIdfk;
  late final String showCount;
  late final String showDannier;
  late final String dannierMinMax;
  late final String showFilament;
  late final String filamentMinMax;
  late final String showQlt;
  late final String showClsp;
  late final String showUniformity;
  late final String showCv;
  late final String showThinPlaces;
  late final String showtThickPlaces;
  late final String showNaps;
  late final String showIpmKm;
  late final String showHairness;
  late final String showRkm;
  late final String showElongation;
  late final String showTpi;
  late final String showTm;
  late final String showDty;
  late final String showFdy;
  late final String ysIsActive;
  @ignore
  late final Null ysSortid;

  YarnSetting.fromJson(Map<String, dynamic> json){
    ysId = json['ys_id'];
    ysBlendIdfk = json['ys_blend_idfk'];
    ysFiberMaterialIdfk = json['ys_fiber_material_idfk'];
    showCount = json['show_count'];
    showDannier = json['show_dannier'];
    dannierMinMax = json['dannier_min_max'];
    showFilament = json['show_filament'];
    filamentMinMax = json['filament_min_max'];
    showQlt = json['show_qlt'];
    showClsp = json['show_clsp'];
    showUniformity = json['show_uniformity'];
    showCv = json['show_cv'];
    showThinPlaces = json['show_thin_places'];
    showtThickPlaces = json['showt_thick_places'];
    showNaps = json['show_naps'];
    showIpmKm = json['show_ipm_km'];
    showHairness = json['show_hairness'];
    showRkm = json['show_rkm'];
    showElongation = json['show_elongation'];
    showTpi = json['show_tpi'];
    showTm = json['show_tm'];
    showDty = json['show_dty'];
    showFdy = json['show_fdy'];
    ysIsActive = json['ys_is_active'];
    ysSortid = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['ys_id'] = ysId;
    _data['ys_blend_idfk'] = ysBlendIdfk;
    _data['ys_fiber_material_idfk'] = ysFiberMaterialIdfk;
    _data['show_count'] = showCount;
    _data['show_dannier'] = showDannier;
    _data['dannier_min_max'] = dannierMinMax;
    _data['show_filament'] = showFilament;
    _data['filament_min_max'] = filamentMinMax;
    _data['show_qlt'] = showQlt;
    _data['show_clsp'] = showClsp;
    _data['show_uniformity'] = showUniformity;
    _data['show_cv'] = showCv;
    _data['show_thin_places'] = showThinPlaces;
    _data['showt_thick_places'] = showtThickPlaces;
    _data['show_naps'] = showNaps;
    _data['show_ipm_km'] = showIpmKm;
    _data['show_hairness'] = showHairness;
    _data['show_rkm'] = showRkm;
    _data['show_elongation'] = showElongation;
    _data['show_tpi'] = showTpi;
    _data['show_tm'] = showTm;
    _data['show_dty'] = showDty;
    _data['show_fdy'] = showFdy;
    _data['ys_is_active'] = ysIsActive;
    _data['ys_sortid'] = ysSortid;
    return _data;
  }
}

class SpunTechnique {
  SpunTechnique({
    required this.ystId,
    required this.ystName,
    required this.ystBlendIdfd,
    this.ystDescription,
    required this.ystIsActive,
    this.ystSortid,
  });
  late final int ystId;
  late final String ystName;
  late final String ystBlendIdfd;
  late final Null ystDescription;
  late final String ystIsActive;
  late final Null ystSortid;

  SpunTechnique.fromJson(Map<String, dynamic> json){
    ystId = json['yst_id'];
    ystName = json['yst_name'];
    ystBlendIdfd = json['yst_blend_idfd'];
    ystDescription = null;
    ystIsActive = json['yst_is_active'];
    ystSortid = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['yst_id'] = ystId;
    _data['yst_name'] = ystName;
    _data['yst_blend_idfd'] = ystBlendIdfd;
    _data['yst_description'] = ystDescription;
    _data['yst_is_active'] = ystIsActive;
    _data['yst_sortid'] = ystSortid;
    return _data;
  }

  @override
  String toString() {
    // TODO: implement toString
    return ystName;
  }
}

class TwistDirection {
  TwistDirection({
    required this.ytdId,
    required this.ytdName,
    this.ytdDescription,
    required this.ytdIsActive,
    this.catSortid,
  });
  late final int ytdId;
  late final String ytdName;
  late final Null ytdDescription;
  late final String ytdIsActive;
  late final Null catSortid;

  TwistDirection.fromJson(Map<String, dynamic> json){
    ytdId = json['ytd_id'];
    ytdName = json['ytd_name'];
    ytdDescription = null;
    ytdIsActive = json['ytd_is_active'];
    catSortid = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['ytd_id'] = ytdId;
    _data['ytd_name'] = ytdName;
    _data['ytd_description'] = ytdDescription;
    _data['ytd_is_active'] = ytdIsActive;
    _data['cat_sortid'] = catSortid;
    return _data;
  }

  @override
  String toString() {
    // TODO: implement toString
    return ytdName;
  }
}

class Usage {
  Usage({
    required this.yuId,
    required this.yuName,
    this.yuDescription,
    required this.yuIsActive,
    this.yuSortid,
  });
  late final int yuId;
  late final String yuName;
  late final Null yuDescription;
  late final String yuIsActive;
  late final Null yuSortid;

  Usage.fromJson(Map<String, dynamic> json){
    yuId = json['yu_id'];
    yuName = json['yu_name'];
    yuDescription = null;
    yuIsActive = json['yu_is_active'];
    yuSortid = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['yu_id'] = yuId;
    _data['yu_name'] = yuName;
    _data['yu_description'] = yuDescription;
    _data['yu_is_active'] = yuIsActive;
    _data['yu_sortid'] = yuSortid;
    return _data;
  }

  @override
  String toString() {
    // TODO: implement toString
    return yuName;
  }
}

class Blends {
  Blends({
    required this.blnId,
    required this.blnCategoryIdfk,
    required this.blnName,
    required this.blnIsActive,
    required this.blnSortid,
  });
  late final int blnId;
  late final String blnCategoryIdfk;
  late final String blnName;
  late final String blnIsActive;
  late final String blnSortid;

  Blends.fromJson(Map<String, dynamic> json){
    blnId = json['bln_id'];
    blnCategoryIdfk = json['bln_category_idfk'];
    blnName = json['bln_name'];
    blnIsActive = json['bln_is_active'];
    blnSortid = json['bln_sortid'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['bln_id'] = blnId;
    _data['bln_category_idfk'] = blnCategoryIdfk;
    _data['bln_name'] = blnName;
    _data['bln_is_active'] = blnIsActive;
    _data['bln_sortid'] = blnSortid;
    return _data;
  }

  @override
  String toString() {
    return blnName;
  }
}

// class Grades {
//   Grades({
//     required this.grdId,
//     required this.grdCategoryIdfk,
//     required this.grdName,
//     required this.grdIsActive,
//     this.grdSortid,
//   });
//   late final int grdId;
//   late final String grdCategoryIdfk;
//   late final String grdName;
//   late final String grdIsActive;
//   late final Null grdSortid;
//
//   Grades.fromJson(Map<String, dynamic> json){
//     grdId = json['grd_id'];
//     grdCategoryIdfk = json['grd_category_idfk'];
//     grdName = json['grd_name'];
//     grdIsActive = json['grd_is_active'];
//     grdSortid = null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['grd_id'] = grdId;
//     _data['grd_category_idfk'] = grdCategoryIdfk;
//     _data['grd_name'] = grdName;
//     _data['grd_is_active'] = grdIsActive;
//     _data['grd_sortid'] = grdSortid;
//     return _data;
//   }
// }
//
// class Certification {
//   Certification({
//     required this.cerId,
//     required this.cerCategoryIdfk,
//     required this.cerName,
//     this.icon,
//     required this.cerIsActive,
//     this.cerSortid,
//     required this.pictures,
//     required this.attachFiles,
//   });
//   late final int cerId;
//   late final String cerCategoryIdfk;
//   late final String cerName;
//   late final Null icon;
//   late final String cerIsActive;
//   late final Null cerSortid;
//   late final List<dynamic> pictures;
//   late final List<dynamic> attachFiles;
//
//   Certification.fromJson(Map<String, dynamic> json){
//     cerId = json['cer_id'];
//     cerCategoryIdfk = json['cer_category_idfk'];
//     cerName = json['cer_name'];
//     icon = null;
//     cerIsActive = json['cer_is_active'];
//     cerSortid = null;
//     pictures = List.castFrom<dynamic, dynamic>(json['pictures']);
//     attachFiles = List.castFrom<dynamic, dynamic>(json['attach_files']);
//   }
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['cer_id'] = cerId;
//     _data['cer_category_idfk'] = cerCategoryIdfk;
//     _data['cer_name'] = cerName;
//     _data['icon'] = icon;
//     _data['cer_is_active'] = cerIsActive;
//     _data['cer_sortid'] = cerSortid;
//     _data['pictures'] = pictures;
//     _data['attach_files'] = attachFiles;
//     return _data;
//   }
// }
//
// class Apperance {
//   Apperance({
//     required this.aprId,
//     required this.aprCategoryIdfk,
//     required this.aprName,
//     required this.aprIsActive,
//     this.aprSortid,
//   });
//   late final int aprId;
//   late final String aprCategoryIdfk;
//   late final String aprName;
//   late final String aprIsActive;
//   late final Null aprSortid;
//
//   Apperance.fromJson(Map<String, dynamic> json){
//     aprId = json['apr_id'];
//     aprCategoryIdfk = json['apr_category_idfk'];
//     aprName = json['apr_name'];
//     aprIsActive = json['apr_is_active'];
//     aprSortid = null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['apr_id'] = aprId;
//     _data['apr_category_idfk'] = aprCategoryIdfk;
//     _data['apr_name'] = aprName;
//     _data['apr_is_active'] = aprIsActive;
//     _data['apr_sortid'] = aprSortid;
//     return _data;
//   }
// }

// class PriceTerms {
//   PriceTerms({
//     required this.ptrId,
//     required this.ptrCategoryIdfk,
//     this.ptrCountryIdfk,
//     required this.ptrLocality,
//     required this.ptrName,
//     required this.ptrIsActive,
//     this.ptrSortid,
//     this.createdAt,
//     this.updatedAt,
//     this.deletedAt,
//   });
//   late final int ptrId;
//   late final String ptrCategoryIdfk;
//   late final Null ptrCountryIdfk;
//   late final String ptrLocality;
//   late final String ptrName;
//   late final String ptrIsActive;
//   late final Null ptrSortid;
//   late final Null createdAt;
//   late final Null updatedAt;
//   late final Null deletedAt;
//
//   PriceTerms.fromJson(Map<String, dynamic> json){
//     ptrId = json['ptr_id'];
//     ptrCategoryIdfk = json['ptr_category_idfk'];
//     ptrCountryIdfk = null;
//     ptrLocality = json['ptr_locality'];
//     ptrName = json['ptr_name'];
//     ptrIsActive = json['ptr_is_active'];
//     ptrSortid = null;
//     createdAt = null;
//     updatedAt = null;
//     deletedAt = null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['ptr_id'] = ptrId;
//     _data['ptr_category_idfk'] = ptrCategoryIdfk;
//     _data['ptr_country_idfk'] = ptrCountryIdfk;
//     _data['ptr_locality'] = ptrLocality;
//     _data['ptr_name'] = ptrName;
//     _data['ptr_is_active'] = ptrIsActive;
//     _data['ptr_sortid'] = ptrSortid;
//     _data['created_at'] = createdAt;
//     _data['updated_at'] = updatedAt;
//     _data['deleted_at'] = deletedAt;
//     return _data;
//   }
// }
//
// class DeliveryPeriod {
//   DeliveryPeriod({
//     required this.dprId,
//     required this.dprCategoryIdfk,
//     required this.dprName,
//     required this.dprIsActive,
//     this.dprSortid,
//     this.createdAt,
//     this.updatedAt,
//     this.deletedAt,
//   });
//   late final int dprId;
//   late final String dprCategoryIdfk;
//   late final String dprName;
//   late final String dprIsActive;
//   late final Null dprSortid;
//   late final Null createdAt;
//   late final Null updatedAt;
//   late final Null deletedAt;
//
//   DeliveryPeriod.fromJson(Map<String, dynamic> json){
//     dprId = json['dpr_id'];
//     dprCategoryIdfk = json['dpr_category_idfk'];
//     dprName = json['dpr_name'];
//     dprIsActive = json['dpr_is_active'];
//     dprSortid = null;
//     createdAt = null;
//     updatedAt = null;
//     deletedAt = null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['dpr_id'] = dprId;
//     _data['dpr_category_idfk'] = dprCategoryIdfk;
//     _data['dpr_name'] = dprName;
//     _data['dpr_is_active'] = dprIsActive;
//     _data['dpr_sortid'] = dprSortid;
//     _data['created_at'] = createdAt;
//     _data['updated_at'] = updatedAt;
//     _data['deleted_at'] = deletedAt;
//     return _data;
//   }
// }
//
// class Units {
//   Units({
//     required this.untId,
//     required this.untCategoryIdfk,
//     required this.untName,
//     required this.untIsActive,
//     this.untSortid,
//     this.createdAt,
//     this.updatedAt,
//     this.deletedAt,
//   });
//   late final int untId;
//   late final String untCategoryIdfk;
//   late final String untName;
//   late final String untIsActive;
//   late final Null untSortid;
//   late final Null createdAt;
//   late final Null updatedAt;
//   late final Null deletedAt;
//
//   Units.fromJson(Map<String, dynamic> json){
//     untId = json['unt_id'];
//     untCategoryIdfk = json['unt_category_idfk'];
//     untName = json['unt_name'];
//     untIsActive = json['unt_is_active'];
//     untSortid = null;
//     createdAt = null;
//     updatedAt = null;
//     deletedAt = null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['unt_id'] = untId;
//     _data['unt_category_idfk'] = untCategoryIdfk;
//     _data['unt_name'] = untName;
//     _data['unt_is_active'] = untIsActive;
//     _data['unt_sortid'] = untSortid;
//     _data['created_at'] = createdAt;
//     _data['updated_at'] = updatedAt;
//     _data['deleted_at'] = deletedAt;
//     return _data;
//   }
// }

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
    this.icon,
    required this.isVerified,
    required this.rating,
    required this.featured,
    required this.pictures,
    required this.attachFiles,
  });
  late final int id;
  late final String name;
  late final String gst;
  late final Null logo;
  late final Null tradeMark;
  late final String address;
  late final String countryId;
  late final String cityStateId;
  late final String zipCode;
  late final String websiteUrl;
  late final String whatsappNumber;
  late final String wechatNumber;
  late final String telephoneNumber;
  late final String emailId;
  late final String maxProduction;
  late final String noOfUnits;
  late final String yearEstablished;
  late final String tradeCategory;
  late final String licenseHolder;
  late final Null icon;
  late final String isVerified;
  late final String rating;
  late final String featured;
  late final List<dynamic> pictures;
  late final List<dynamic> attachFiles;

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
    icon = null;
    isVerified = json['is_verified'];
    rating = json['rating'];
    featured = json['featured'];
    pictures = List.castFrom<dynamic, dynamic>(json['pictures']);
    attachFiles = List.castFrom<dynamic, dynamic>(json['attach_files']);
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
    _data['icon'] = icon;
    _data['is_verified'] = isVerified;
    _data['rating'] = rating;
    _data['featured'] = featured;
    _data['pictures'] = pictures;
    _data['attach_files'] = attachFiles;
    return _data;
  }
}

// class Brands {
//   Brands({
//     required this.brdId,
//     this.brdCategoryIdfk,
//     required this.brdName,
//     required this.brdIsVerified,
//     required this.brdRating,
//     required this.brdFeatured,
//     this.icon,
//     required this.brdIsActive,
//     this.brdSortid,
//   });
//   late final int brdId;
//   late final Null brdCategoryIdfk;
//   late final String brdName;
//   late final String brdIsVerified;
//   late final String brdRating;
//   late final String brdFeatured;
//   late final Null icon;
//   late final String brdIsActive;
//   late final Null brdSortid;
//
//   Brands.fromJson(Map<String, dynamic> json){
//     brdId = json['brd_id'];
//     brdCategoryIdfk = null;
//     brdName = json['brd_name'];
//     brdIsVerified = json['brd_is_verified'];
//     brdRating = json['brd_rating'];
//     brdFeatured = json['brd_featured'];
//     icon = null;
//     brdIsActive = json['brd_is_active'];
//     brdSortid = null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['brd_id'] = brdId;
//     _data['brd_category_idfk'] = brdCategoryIdfk;
//     _data['brd_name'] = brdName;
//     _data['brd_is_verified'] = brdIsVerified;
//     _data['brd_rating'] = brdRating;
//     _data['brd_featured'] = brdFeatured;
//     _data['icon'] = icon;
//     _data['brd_is_active'] = brdIsActive;
//     _data['brd_sortid'] = brdSortid;
//     return _data;
//   }
// }