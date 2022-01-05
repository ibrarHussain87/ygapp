class GetYarnSpecificationResponse {
  GetYarnSpecificationResponse({
    required this.status,
    required this.responseCode,
    required this.data,
    required this.message,
  });

  late final bool status;
  late final int responseCode;
  late final YarnSpecificationData data;
  late final String message;

  GetYarnSpecificationResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    responseCode = json['response_code'];
    data = YarnSpecificationData.fromJson(json['data']);
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

class YarnSpecificationData {
  YarnSpecificationData({
    required this.specification,
  });

  late final List<YarnSpecification> specification;

  YarnSpecificationData.fromJson(Map<String, dynamic> json) {
    specification = List.from(json['specification'])
        .map((e) => YarnSpecification.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['specification'] = specification.map((e) => e.toJson()).toList();
    return _data;
  }
}

class YarnSpecification {
  YarnSpecification({
    this.yarnTitle,
    this.yarnDetails,
    required this.locality,
    required this.yarnFamily,
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
    required this.yarnGrade,
    required this.yarnCertification,
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
    required this.priceUnit,
    this.unitCount,
    required this.weightCone,
    required this.weightBag,
    required this.conesBag,
    this.packing,
    this.paymentType,
    this.lcType,
    this.is_featured,
    this.is_verified,
    required this.deliveryPeriod,
    this.available,
    required this.priceTerms,
    required this.minQuantity,
    required this.description,
    required this.pictures,
    required this.certifications,
  });

  late final String? yarnTitle;
  late final String? yarnDetails;
  late final String? locality;
  late final String? yarnFamily;
  late final String? yarnBlend;
  late final String? yarnRtio;
  late final String? yarnUsage;
  late final String? yarnPattern;
  late final String? yarnPatternCharectristic;
  late final String? yarnOrientation;
  late final String? yarnTwistDirection;
  late final String? count;
  late final String? dtyFilament;
  late final String? fdyFilament;
  late final String? yarnPly;
  late final String? yarnSpunTechnique;
  late final String? yarnQuality;
  late final String? yarnGrade;
  late final String? yarnCertification;
  late final String? yarnColorTreatmentMethod;
  late final String? yarnDyingMethod;
  late final String? color;
  late final String? yarnApperance;
  late final String? actualYarnCount;
  late final String? qlt;
  late final String? clsp;
  late final String? uniformity;
  late final String? cv;
  late final String? thinPlaces;
  late final String? is_featured;
  late final String? is_verified;
  late final String? thickPlaces;
  late final String? naps;
  late final String? priceUnit;
  late final String? unitCount;
  late final String? weightCone;
  late final String? weightBag;
  late final String? conesBag;
  late final String? packing;
  late final String? paymentType;
  late final String? lcType;
  late final String? deliveryPeriod;
  late final String? available;
  late final String? priceTerms;
  late final String? minQuantity;
  late final String? description;
  late final List<dynamic> pictures;
  late final List<dynamic> certifications;

  YarnSpecification.fromJson(Map<String, dynamic> json) {
    yarnTitle = null;
    yarnDetails = null;
    locality = json['locality'];
    yarnFamily = json['yarn_family'];
    yarnBlend = json['yarn_blend'];
    yarnRtio = json['yarn_rtio'];
    yarnUsage = json['yarn_usage'];
    yarnPattern = json['yarn_pattern'];
    yarnPatternCharectristic = json['yarn_pattern_charectristic'];
    yarnOrientation = json['yarn_orientation'];
    yarnTwistDirection = json['yarn_twist_direction'];
    count = null;
    dtyFilament = json['dty_filament'];
    fdyFilament = json['fdy_filament'];
    yarnPly = json['yarn_ply'];
    yarnSpunTechnique = json['yarn_spun_technique'];
    yarnQuality = null;
    yarnGrade = json['yarn_grade'];
    yarnCertification = json['yarn_certification'];
    yarnColorTreatmentMethod = null;
    yarnDyingMethod = json['yarn_dying_method'];
    color = null;
    yarnApperance = json['yarn_apperance'];
    actualYarnCount = json['actual_yarn_count'];
    qlt = json['qlt'];
    clsp = json['clsp'];
    uniformity = null;
    cv = json['cv'];
    thinPlaces = json['thin_places'];
    thickPlaces = json['thick_places'];
    naps = json['naps'];
    priceUnit = json['price_unit'];
    unitCount = null;
    weightCone = json['weight_cone'];
    weightBag = json['weight_bag'];
    conesBag = json['cones_bag'];
    is_featured = json['is_featured'];
    is_verified = json['is_verified'];
    packing = null;
    paymentType = null;
    lcType = null;
    deliveryPeriod = json['delivery_period'];
    available = null;
    priceTerms = json['price_terms'];
    minQuantity = json['min_quantity'];
    description = json['description'];
    pictures = List.castFrom<dynamic, dynamic>(json['pictures']);
    certifications = List.castFrom<dynamic, dynamic>(json['certifications']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['yarn_title'] = yarnTitle;
    _data['yarn_details'] = yarnDetails;
    _data['locality'] = locality;
    _data['yarn_family'] = yarnFamily;
    _data['yarn_blend'] = yarnBlend;
    _data['yarn_rtio'] = yarnRtio;
    _data['yarn_usage'] = yarnUsage;
    _data['yarn_pattern'] = yarnPattern;
    _data['yarn_pattern_charectristic'] = yarnPatternCharectristic;
    _data['yarn_orientation'] = yarnOrientation;
    _data['yarn_twist_direction'] = yarnTwistDirection;
    _data['count'] = count;
    _data['dty_filament'] = dtyFilament;
    _data['fdy_filament'] = fdyFilament;
    _data['yarn_ply'] = yarnPly;
    _data['yarn_spun_technique'] = yarnSpunTechnique;
    _data['yarn_quality'] = yarnQuality;
    _data['yarn_grade'] = yarnGrade;
    _data['yarn_certification'] = yarnCertification;
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
    _data['packing'] = packing;
    _data['payment_type'] = paymentType;
    _data['lc_type'] = lcType;
    _data['delivery_period'] = deliveryPeriod;
    _data['available'] = available;
    _data['price_terms'] = priceTerms;
    _data['min_quantity'] = minQuantity;
    _data['description'] = description;
    _data['pictures'] = pictures;
    _data['certifications'] = certifications;
    return _data;
  }
}
