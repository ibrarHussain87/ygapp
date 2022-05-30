

import '../../certifications_model.dart';

class GetYarnSpecificationResponse {
  GetYarnSpecificationResponse({
    required this.status,
    required this.responseCode,
    required this.data,
    required this.message,
  });

  late final bool status;
  late final int responseCode;
  YarnSpecificationData? data;
  String? message;

  GetYarnSpecificationResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    responseCode = json['response_code'];
    // if(List.from(json['data']).isNotEmpty) {
    // data = YarnSpecificationData.fromJson(json['data']);
    // data = json['data'] != null ? YarnSpecificationData.fromJson(json['data']) : null;

    var dataList = json['data'];
    if (dataList is List<dynamic>) {
      if (dataList.isEmpty) {
        data = YarnSpecificationData(specification: []);
      }
    } else {
      data = YarnSpecificationData.fromJson(json['data']);
    }

    // }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['response_code'] = responseCode;
    if (data != null) {
      _data['data'] = data!.toJson();
    }
    _data['message'] = message;
    return _data;
  }
}

class YarnSpecificationData {
  YarnSpecificationData({
    required this.specification,
  });

  List<YarnSpecification>? specification;

  YarnSpecificationData.fromJson(Map<String, dynamic> json) {
    if (json['specification'] != null) {
      specification = [];
      json['specification'].forEach((v) {
        specification!.add(YarnSpecification.fromJson(v));
      });
    }

    // specification = List.from(json['specification'])
    //     .map((e) => YarnSpecification.fromJson(e))
    //     .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    // if (specification != null) {
    //   _data['specification'] = specification!.map((e) => e.toJson()).toList();
    // }
    if (specification != null) {
      _data['specification'] = specification!.map((v) => v.toJson()).toList();
    }
    return _data;
  }
}

class YarnSpecification {
  YarnSpecification({
    this.ysId,
    this.ys_user_id,
    this.category_id,
    this.yarnTitle,
    this.company,
    this.yarnDetails,
    required this.locality,
    required this.yarnFamilyId,
    required this.yarnFamily,
    this.formationDisplayText,
    this.yarnFormation,
    required this.yarnBlend,
    required this.yarnRtio,
    required this.yarnUsage,
    required this.yarnPattern,
    required this.yarnPatternCharectristic,
    required this.yarnOrientation,
    required this.yarnTwistDirection,
    this.count,
    required this.dtyFilament,
    required this.fdyFilament,
    required this.yarnPly,
    required this.yarnSpunTechnique,
    this.yarnQuality,
    this.bln_abrv,
    this.yq_abrv,
    required this.yarnGrade,
    required this.yarnCertification,
    required this.yarnCertificationStr,
    this.yarnColorTreatmentMethod,
    required this.yarnDyingMethod,
    this.color,
    required this.yarnApperance,
    required this.actualYarnCount,
    required this.qlt,
    required this.clsp,
    this.uniformity,
    required this.cv,
    required this.thinPlaces,
    required this.thickPlaces,
    required this.naps,
    required this.ys_hairness,
    required this.ys_ipm_km,
    required this.ys_elongation,
    required this.ys_tpi,
    required this.ys_tm,
    required this.priceUnit,
    this.unitCount,
    required this.weightCone,
    required this.weightBag,
    required this.conesBag,
    this.fpb_cone_type_name,
    this.paymentType,
    this.lcType,
    this.is_offering,
    this.is_featured,
    this.is_verified,
    required this.deliveryPeriod,
    this.available,
    this.port,
    required this.priceTerms,
    required this.minQuantity,
    required this.description,
    required this.ys_rkm,
    required this.pictures,
    required this.certifications,
  });

  int? ysId;
  String? ys_user_id;
  int? category_id;
  String? yarnTitle;
  String? yarnDetails;
  String? company;
  String? locality;
  String? yarnFamilyId;
  String? yarnFamily;
  String? formationDisplayText;
  List<GenericFormation>? yarnFormation;
  String? doublingMethod;
  String? yarnType;
  String? yarnBlend;
  String? yarnRtio;
  String? yarnUsage;
  String? yarnPattern;
  String? yarnPatternCharectristic;
  String? yarnOrientation;
  String? yarnTwistDirection;
  String? count;
  String? dtyFilament;
  String? fdyFilament;
  String? yarnPly;
  String? yq_abrv;
  String? bln_abrv;
  String? yarnSpunTechnique;
  String? yarnQuality;
  String? yarnGrade;
  String? yarnCertification;
  String? yarnCertificationStr;
  String? yarnColorTreatmentMethod;
  String? yarnDyingMethod;
  String? color;
  String? yarnApperance;
  String? actualYarnCount;
  String? qlt;
  String? clsp;
  String? uniformity;
  String? cv;
  String? thinPlaces;
  String? is_offering;
  String? is_featured;
  String? is_verified;
  String? thickPlaces;
  String? naps;
  String? ys_hairness;
  String? ys_tm;
  String? ys_tpi;
  String? ys_elongation;
  String? ys_ipm_km;
  String? priceUnit;
  String? unitCount;
  String? weightCone;
  String? weightBag;
  String? conesBag;
  String? fpb_cone_type_name;
  String? paymentType;
  String? lcType;
  String? deliveryPeriod;
  String? available;
  String? priceTerms;
  String? minQuantity;
  String? description;
  String? ys_doubling_method_idFk;
  String? ys_yarn_type_idfk;
  String? ys_yarn_type;
  String? ys_rkm;
  String? yarn_country;
  String? date;
  String? port;
  int? matchedCount;
  int? proposalCount;
  List<dynamic>? pictures;
  List<CertificationModel>? certifications;

  YarnSpecification.fromJson(Map<String, dynamic> json) {
    yarnTitle = json['yarn_details'];
    category_id = json['category_id'];
    company = json['company'];
    yarnDetails = json['yarn_title'];
    doublingMethod = json['ys_doubling_method'];
    ys_doubling_method_idFk = json['ys_doubling_method_idFk'];
    yarnType = json['ys_yarn_type'];
    ysId = json['ys_id'];
    ys_user_id = json['ys_user_id'];
    locality = json['locality'];
    yarnFamilyId = json['yarn_family_id'];
    yarnFamily = json['yarn_family'];
    formationDisplayText = json['formation_display_text'];
    yarnBlend = json['yarn_blend'];
    yarnRtio = json['yarn_rtio'];
    bln_abrv = json['yarn_blend_abrv'];
    yq_abrv = json['yarn_quality_abrv'];
    yarnUsage = json['yarn_usage'];
    yarnPattern = json['yarn_pattern'];
    yarnPatternCharectristic = json['yarn_pattern_charectristic'];
    yarnOrientation = json['yarn_orientation'];
    yarnTwistDirection = json['yarn_twist_direction'];
    count = json['count'];
    ys_yarn_type_idfk = json['ys_yarn_type_idfk'];
    ys_yarn_type = json['ys_yarn_type'];
    dtyFilament = json['dty_filament'];
    fdyFilament = json['fdy_filament'];
    yarnPly = json['yarn_ply'];
    yarnSpunTechnique = json['yarn_spun_technique'];
    yarnQuality = json['yarn_quality'];
    yarnGrade = json['yarn_grade'];
    yarnCertification = json['yarn_certification'];
    yarnCertificationStr = json['certification_str'];
    yarnColorTreatmentMethod = json['yarn_color_treatment_method'];
    yarnDyingMethod = json['yarn_dying_method'];
    color = json['color'];
    yarnApperance = json['yarn_apperance'];
    actualYarnCount = json['actual_yarn_count'];
    qlt = json['qlt'];
    clsp = json['clsp'];
    uniformity = json['uniformity'];
    cv = json['cv'];
    thinPlaces = json['thin_places'];
    thickPlaces = json['thick_places'];
    naps = json['naps'];
    ys_hairness = json['ys_hairness'];
    ys_ipm_km = json['ys_ipm_km'];
    ys_tpi = json['ys_tpi'];
    ys_tm = json['ys_tm'];
    ys_elongation = json['ys_elongation'];
    naps = json['naps'];
    priceUnit = json['price_unit'];
    unitCount = json['unit_count'];
    weightCone = json['weight_cone'];
    weightBag = json['weight_bag'];
    conesBag = json['cones_bag'];
    is_offering = json['is_offering'];
    is_featured = json['is_featured'];
    is_verified = json['is_verified'];
    fpb_cone_type_name = json['fpb_cone_type_name'];
    paymentType = json['payment_type'];
    lcType = json['lc_type'];
    deliveryPeriod = json['delivery_period'];
    available = json['available'];
    priceTerms = json['price_terms'];
    minQuantity = json['min_quantity'];
    description = json['description'];
    yarn_country = json['yarn_country'];
    unitCount = json['unit_count'];
    ys_rkm = json['ys_rkm'];
    port = json['port'];
    date = json['date'];
    matchedCount = json['matched_count'];
    proposalCount = json['proposal_count'];
    yarnColorTreatmentMethod = json['yarn_color_treatment_method'];
    pictures = List.castFrom<dynamic, dynamic>(json['pictures']);
    if (json['certifications'] != null) {
      certifications =
          List.from(json['certifications']).map((e) => CertificationModel.fromJson(e)).toList();
    }
    if (json['formation'] != null) {
      yarnFormation =
          List.from(json['formation']).map((e) => GenericFormation.fromJson(e)).toList();
    }
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['ys_id'] = ysId;
    _data['company'] = company;
    _data['category_id'] = category_id;
    _data['ys_user_id'] = ys_user_id;
    _data['ys_doubling_method'] = doublingMethod;
    _data['ys_doubling_method_idFk'] = ys_doubling_method_idFk;
    _data['ys_yarn_type'] = yarnType;
    _data['yarn_title'] = yarnTitle;
    _data['yarn_details'] = yarnDetails;
    _data['locality'] = locality;
    _data['yarn_family_id'] = yarnFamilyId;
    _data['yarn_family'] = yarnFamily;
    _data['formation_display_text'] = formationDisplayText;
    _data['yarn_blend'] = yarnBlend;
    _data['yarn_rtio'] = yarnRtio;
    _data['yarn_usage'] = yarnUsage;
    _data['yarn_pattern'] = yarnPattern;
    _data['yarn_quality_abrv'] = yq_abrv;
    _data['yarn_blend_abrv'] = bln_abrv;
    _data['yarn_pattern_charectristic'] = yarnPatternCharectristic;
    _data['yarn_orientation'] = yarnOrientation;
    _data['yarn_twist_direction'] = yarnTwistDirection;
    _data['count'] = count;
    _data['ys_yarn_type_idfk'] = ys_yarn_type_idfk;
    _data['ys_yarn_type'] = ys_yarn_type;
    _data['dty_filament'] = dtyFilament;
    _data['fdy_filament'] = fdyFilament;
    _data['yarn_ply'] = yarnPly;
    _data['yarn_spun_technique'] = yarnSpunTechnique;
    _data['yarn_quality'] = yarnQuality;
    _data['yarn_grade'] = yarnGrade;
    _data['yarn_certification'] = yarnCertification;
    _data['certification_str'] = yarnCertificationStr;
    _data['yarn_color_treatment_method'] = yarnColorTreatmentMethod;
    _data['yarn_dying_method'] = yarnDyingMethod;
    _data['color'] = color;
    _data['yarn_apperance'] = yarnApperance;
    _data['actual_yarn_count'] = actualYarnCount;
    _data['qlt'] = qlt;
    _data['clsp'] = clsp;
    _data['uniformity'] = uniformity;
    _data['is_featured'] = is_featured;
    _data['is_verified'] = is_verified;
    _data['cv'] = cv;
    _data['thin_places'] = thinPlaces;
    _data['thick_places'] = thickPlaces;
    _data['naps'] = naps;
      _data['price_unit'] = priceUnit;
    _data['unit_count'] = unitCount;
    _data['weight_cone'] = weightCone;
    _data['weight_bag'] = weightBag;
    _data['cones_bag'] = conesBag;
    _data['is_offering'] = is_offering;
    _data['fpb_cone_type_name'] = fpb_cone_type_name;
    _data['payment_type'] = paymentType;
    _data['lc_type'] = lcType;
    _data['delivery_period'] = deliveryPeriod;
    _data['available'] = available;
    _data['price_terms'] = priceTerms;
    _data['min_quantity'] = minQuantity;
    _data['description'] = description;
    _data['pictures'] = pictures;
    _data['yarn_country'] = yarn_country;
    _data['ys_elongation'] = ys_elongation;
    _data['ys_tm'] = ys_tm;
    _data['ys_tpi'] = ys_tpi;
    _data['ys_ipm_km'] = ys_ipm_km;
    _data['ys_hairness'] = ys_hairness;
    _data['ys_rkm'] = ys_rkm;
    _data['port'] = port;
    _data['proposal_count'] = proposalCount;
    _data['matched_count'] = matchedCount;
    _data['date'] = date;
    if (this.yarnFormation != null) {
      _data['formation'] = this.yarnFormation!.map((v) => v.toJson()).toList();
    }
    return _data;
  }
}

class GenericFormation {
  int? formationId;
  String? categoryIdfk;
  String? categoryFamilyIdfk;
  String? specificationIdfk;
  String? blendIdfk;
  String? blendName;
  String? formationRatio;

  GenericFormation(
      {this.formationId,
        this.categoryIdfk,
        this.categoryFamilyIdfk,
        this.specificationIdfk,
        this.blendIdfk,
        this.blendName,
        this.formationRatio});

  GenericFormation.fromJson(Map<String, dynamic> json) {
    formationId = json['formation_id'];
    categoryIdfk = json['category_idfk'];
    categoryFamilyIdfk = json['category_family_idfk'];
    specificationIdfk = json['specification_idfk'];
    blendIdfk = json['blend_idfk'];
    blendName = json['blend_name'];
    formationRatio = json['formation_ratio'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['formation_id'] = this.formationId;
    data['category_idfk'] = this.categoryIdfk;
    data['category_family_idfk'] = this.categoryFamilyIdfk;
    data['specification_idfk'] = this.specificationIdfk;
    data['blend_idfk'] = this.blendIdfk;
    data['blend_name'] = this.blendName;
    data['formation_ratio'] = this.formationRatio;
    return data;
  }
}
