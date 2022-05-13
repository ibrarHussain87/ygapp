import '../../certifications_model.dart';

class FiberSpecificationResponse {
  FiberSpecificationResponse({
    required this.status,
    required this.responseCode,
    required this.data,
    required this.message,
  });

  late final bool status;
  late final int responseCode;
  late final FiberSpecificationData data;
  late final String message;

  FiberSpecificationResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    responseCode = json['response_code'];
    var dataList = json['data'];
    if (dataList is List<dynamic>) {
      if (dataList.isEmpty) {
        data = FiberSpecificationData(specification: []);
      }
    } else {
      data = FiberSpecificationData.fromJson(json['data']);
    }
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

class FiberSpecificationData {
  FiberSpecificationData({
    required this.specification,
  });

  late final List<Specification> specification;

  FiberSpecificationData.fromJson(Map<String, dynamic> json) {
    specification = List.from(json['specification'])
        .map((e) => Specification.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['specification'] = specification.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Specification {
  Specification({
    required this.spcId,
    required this.spc_user_id,
    this.formation,
    required this.company,
    required this.categoryId,
    this.businessArea,
    required this.locality,
    required this.material,
    required this.length,
    required this.grade,
    required this.micronaire,
    this.moisture,
    required this.trash,
    required this.rd,
    required this.gpt,
    this.apperance,
    required this.brand,
    required this.productYear,
    required this.origin,
    required this.certification,
    required this.priceUnit,
    required this.cityState,
    required this.port,
    required this.lotNumber,
    required this.unitCount,
    required this.deliveryPeriod,
    required this.available,
    required this.priceTerms,
    this.minQuantity,
    this.origin_fiber_spc,
    required this.is_offering,
  required this.isVerified,
    required this.isFeatured,
    required this.description,
    required this.date,
    required this.pictures,
    required this.certifications,
  });

  late final int spcId;
  String? nature_id;
  String? spc_user_id;
  String? company;
  List<Formation>? formation;
  String? categoryId;
  String? businessArea;
  String? locality;
  String? material;
  String? length;
  String? grade;
  String? micronaire;
  String? moisture;
  String? trash;
  String? rd;
  String? gpt;
  String? origin_fiber_spc;
  String? apperance;
  String? brand;
  String? productYear;
  String? origin;
  String? certification;
  String? priceUnit;
  String? cityState;
  String? port;
  String? lotNumber;
  String? unitCount;
  String? deliveryPeriod;
  String? available;
  String? priceTerms;
  String? minQuantity;
  String? is_offering;
  String? isVerified;
  String? isFeatured;
  String? description;
  String? date;
  List<Pictures>? pictures;
  List<CertificationModel>? certifications;

  Specification.fromJson(Map<String, dynamic> json) {
    spcId = json['spc_id'];
    nature_id = json['nature_id'];
    company = json['company'];
    spc_user_id = json['spc_user_id'];
    // formation = json['formation'];
    categoryId = json['category_id'];
    businessArea = json['business_area'];
    locality = json['locality'];
    material = json['material'];
    length = json['length'];
    grade = json['grade'];
    micronaire = json['micronaire'];
    moisture = json["moisture"];
    trash = json['trash'];
    rd = json['rd'];
    gpt = json['gpt'];
    apperance = json['apperance'];
    brand = json['brand'];
    productYear = json['product_year'];
    origin = json['origin'];
    certification = json['certification'];
    priceUnit = json['price_unit'];
    cityState = json['city_state'];
    port = json['port'];
    lotNumber = json['lot_number'];
    unitCount = json['unit_count'];
    origin_fiber_spc = json['origin_fiber_spc'];
    deliveryPeriod = json['delivery_period'];
    available = json['available'];
    priceTerms = json['price_terms'];
    minQuantity = json['min_quantity'];
    is_offering = json['is_offering'];
    isFeatured = json['is_featured'];
    isVerified = json['is_verified'];
    description = json['description'];
    date = json['date'];

    if (json['formation'] != null) {
      formation = <Formation>[];
      json['formation'].forEach((v) {
        formation!.add(Formation.fromJson(v));
      });
    }
    if (json['pictures'] != null) {
      pictures =
          List.from(json['pictures']).map((e) => Pictures.fromJson(e)).toList();
    }
    if (json['certifications'] != null) {
      certifications =
          List.from(json['certifications']).map((e) => CertificationModel.fromJson(e)).toList();
    }
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['spc_id'] = spcId;
    _data['company'] = company;
    _data['nature_id'] = nature_id;
    _data['spc_user_id'] = spc_user_id;
    _data['category_id'] = categoryId;
    _data['business_area'] = businessArea;
    _data['locality'] = locality;
    _data['material'] = material;
    _data['length'] = length;
    _data['grade'] = grade;
    _data['micronaire'] = micronaire;
    _data['moisture'] = moisture;
    _data['trash'] = trash;
    _data['rd'] = rd;
    _data['gpt'] = gpt;
    _data['origin_fiber_spc'] = origin_fiber_spc;
    _data['apperance'] = apperance;
    _data['brand'] = brand;
    _data['product_year'] = productYear;
    _data['origin'] = origin;
    _data['certification'] = certification;
    _data['price_unit'] = priceUnit;
    _data['city_state'] = cityState;
    _data['port'] = port;
    _data['lot_number'] = lotNumber;
    _data['unit_count'] = unitCount;
    _data['delivery_period'] = deliveryPeriod;
    _data['available'] = available;
    _data['price_terms'] = priceTerms;
    _data['min_quantity'] = minQuantity;
    _data['is_featured'] = isFeatured;
    _data['is_offering'] = is_offering;
    _data['is_verified'] = isVerified;
    _data['description'] = description;
    _data['date'] = date;
    if (this.formation != null) {
      _data['formation'] = this.formation!.map((v) => v.toJson()).toList();
    }
    if (pictures != null) {
      _data['pictures'] = pictures!.map((e) => e.toJson()).toList();
    }
    if (certifications != null) {
      _data['certifications'] = certifications!.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class Formation {
  int? formationId;
  String? categoryIdfk;
  String? categoryFamilyIdfk;
  String? specificationIdfk;
  String? blendIdfk;
  String? blendName;
  String? relatedBlendIdfk;
  String? formationRatio;
  String? createdAt;
  String? createdBy;
  String? updatedAt;
  String? updatedBy;

  Formation(
      {this.formationId,
        this.categoryIdfk,
        this.categoryFamilyIdfk,
        this.specificationIdfk,
        this.blendIdfk,
        this.blendName,
        this.relatedBlendIdfk,
        this.formationRatio,
        this.createdAt,
        this.createdBy,
        this.updatedAt,
        this.updatedBy});

  Formation.fromJson(Map<String, dynamic> json) {
    formationId = json['formation_id'];
    categoryIdfk = json['category_idfk'];
    categoryFamilyIdfk = json['category_family_idfk'];
    specificationIdfk = json['specification_idfk'];
    blendIdfk = json['blend_idfk'];
    blendName = json['blend_name'];
    relatedBlendIdfk = json['related_blend_idfk'];
    formationRatio = json['formation_ratio'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    updatedAt = json['updated_at'];
    updatedBy = json['updated_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['formation_id'] = this.formationId;
    data['category_idfk'] = this.categoryIdfk;
    data['category_family_idfk'] = this.categoryFamilyIdfk;
    data['specification_idfk'] = this.specificationIdfk;
    data['blend_idfk'] = this.blendIdfk;
    data['blend_name'] = this.blendName;
    data['related_blend_idfk'] = this.relatedBlendIdfk;
    data['formation_ratio'] = this.formationRatio;
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    data['updated_at'] = this.updatedAt;
    data['updated_by'] = this.updatedBy;
    return data;
  }
}

class Pictures {
  Pictures({
    required this.picture,
  });

  String? picture;

  Pictures.fromJson(Map<String, dynamic> json) {
    picture = json['picture'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['picture'] = picture;
    return _data;
  }
}

