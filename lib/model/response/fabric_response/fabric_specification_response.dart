import '../../certifications_model.dart';

class FabricSpecificationResponse {
  bool? status;
  String? message;
  Data? data;
  int? responseCode;
  int? code;

  FabricSpecificationResponse(
      {this.status, this.message, this.data, this.responseCode, this.code});

  FabricSpecificationResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    responseCode = json['response_code'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['response_code'] = this.responseCode;
    data['code'] = this.code;
    return data;
  }
}

class Data {
  List<FabricSpecification>? specification;

  Data({this.specification});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['specification'] != null) {
      specification = <FabricSpecification>[];
      json['specification'].forEach((v) {
        specification!.add(FabricSpecification.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.specification != null) {
      data['specification'] =
          this.specification!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FabricSpecification {
  int? fsId;
  String? fsUserId;
  String? company;
  String? fabricTitle;
  String? fabricDetails;
  String? locality;
  String? fabricFamilyId;
  String? fabricFamily;
  String? fabricBlend;
  String? fabricBlendAbrv;
  String? fabricRtio;
  String? count;
  String? fabricPly;
  String? fabricQuality;
  String? fabricGrade;
  String? fabricColorTreatmentMethod;
  String? fabricDyingTechnique;
  String? color;
  String? fabricApperance;
  String? isOffering;
  String? isFeatured;
  String? isVerified;
  String? fabricCountry;
  String? priceUnit;
  String? unitCount;
  String? weightCone;
  String? weightBag;
  String? conesBag;
  String? packing;
  String? paymentType;
  String? lcType;
  String? deliveryPeriod;
  String? available;
  String? priceTerms;
  String? minQuantity;
  String? requiredQuantity;
  String? description;
  List<Pictures>? pictures;
  List<CertificationModel>? certifications;
  String? certificationStr;
  String? date;

  FabricSpecification(
      {this.fsId,
        this.fsUserId,
        this.company,
        this.fabricTitle,
        this.fabricDetails,
        this.locality,
        this.fabricFamilyId,
        this.fabricFamily,
        this.fabricBlend,
        this.fabricBlendAbrv,
        this.fabricRtio,
        this.count,
        this.fabricPly,
        this.fabricQuality,
        this.fabricGrade,
        this.fabricColorTreatmentMethod,
        this.fabricDyingTechnique,
        this.color,
        this.fabricApperance,
        this.isOffering,
        this.isFeatured,
        this.isVerified,
        this.fabricCountry,
        this.priceUnit,
        this.unitCount,
        this.weightCone,
        this.weightBag,
        this.conesBag,
        this.packing,
        this.paymentType,
        this.lcType,
        this.deliveryPeriod,
        this.available,
        this.priceTerms,
        this.minQuantity,
        this.requiredQuantity,
        this.description,
        this.pictures,
        this.certifications,
        this.certificationStr,
        this.date});

  FabricSpecification.fromJson(Map<String, dynamic> json) {
    fsId = json['fs_id'];
    fsUserId = json['fs_user_id'];
    company = json['company'];
    fabricTitle = json['fabric_title'];
    fabricDetails = json['fabric_details'];
    locality = json['locality'];
    fabricFamilyId = json['fabric_family_id'];
    fabricFamily = json['fabric_family'];
    fabricBlend = json['fabric_blend'];
    fabricBlendAbrv = json['fabric_blend_abrv'];
    fabricRtio = json['fabric_rtio'];
    count = json['count'];
    fabricPly = json['fabric_ply'];
    fabricQuality = json['fabric_quality'];
    fabricGrade = json['fabric_grade'];
    fabricColorTreatmentMethod = json['fabric_color_treatment_method'];
    fabricDyingTechnique = json['fabric_dying_technique'];
    color = json['color'];
    fabricApperance = json['fabric_apperance'];
    isOffering = json['is_offering'];
    isFeatured = json['is_featured'];
    isVerified = json['is_verified'];
    fabricCountry = json['fabric_country'];
    priceUnit = json['price_unit'];
    unitCount = json['unit_count'];
    weightCone = json['weight_cone'];
    weightBag = json['weight_bag'];
    conesBag = json['cones_bag'];
    packing = json['packing'];
    paymentType = json['payment_type'];
    lcType = json['lc_type'];
    deliveryPeriod = json['delivery_period'];
    available = json['available'];
    priceTerms = json['price_terms'];
    minQuantity = json['min_quantity'];
    requiredQuantity = json['required_quantity'];
    description = json['description'];
    if (json['pictures'] != null) {
      pictures = <Pictures>[];
      json['pictures'].forEach((v) {
        pictures!.add(Pictures.fromJson(v));
      });
    }
    if (json['certifications'] != null) {
      certifications =
          List.from(json['certifications']).map((e) => CertificationModel.fromJson(e)).toList();
    }
    certificationStr = json['certification_str'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fs_id'] = this.fsId;
    data['fs_user_id'] = this.fsUserId;
    data['company'] = this.company;
    data['fabric_title'] = this.fabricTitle;
    data['fabric_details'] = this.fabricDetails;
    data['locality'] = this.locality;
    data['fabric_family_id'] = this.fabricFamilyId;
    data['fabric_family'] = this.fabricFamily;
    data['fabric_blend'] = this.fabricBlend;
    data['fabric_blend_abrv'] = this.fabricBlendAbrv;
    data['fabric_rtio'] = this.fabricRtio;
    data['count'] = this.count;
    data['fabric_ply'] = this.fabricPly;
    data['fabric_quality'] = this.fabricQuality;
    data['fabric_grade'] = this.fabricGrade;
    data['fabric_color_treatment_method'] = this.fabricColorTreatmentMethod;
    data['fabric_dying_technique'] = this.fabricDyingTechnique;
    data['color'] = this.color;
    data['fabric_apperance'] = this.fabricApperance;
    data['is_offering'] = this.isOffering;
    data['is_featured'] = this.isFeatured;
    data['is_verified'] = this.isVerified;
    data['fabric_country'] = this.fabricCountry;
    data['price_unit'] = this.priceUnit;
    data['unit_count'] = this.unitCount;
    data['weight_cone'] = this.weightCone;
    data['weight_bag'] = this.weightBag;
    data['cones_bag'] = this.conesBag;
    data['packing'] = this.packing;
    data['payment_type'] = this.paymentType;
    data['lc_type'] = this.lcType;
    data['delivery_period'] = this.deliveryPeriod;
    data['available'] = this.available;
    data['price_terms'] = this.priceTerms;
    data['min_quantity'] = this.minQuantity;
    data['required_quantity'] = this.requiredQuantity;
    data['description'] = this.description;
    if (this.pictures != null) {
      data['pictures'] = this.pictures!.map((v) => v.toJson()).toList();
    }
    if (this.certifications != null) {
      data['certifications'] =
          this.certifications!.map((v) => v.toJson()).toList();
    }
    data['certification_str'] = this.certificationStr;
    data['date'] = this.date;
    return data;
  }
}

class Pictures {
  String? picture;

  Pictures({this.picture});

  Pictures.fromJson(Map<String, dynamic> json) {
    picture = json['picture'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['picture'] = this.picture;
    return data;
  }
}
