class FiberSpecificationResponse {
  FiberSpecificationResponse({
    required this.status,
    required this.responseCode,
    required this.data,
    required this.message,
  });
  late final bool status;
  late final int responseCode;
  late final Data data;
  late final String message;

  FiberSpecificationResponse.fromJson(Map<String, dynamic> json){
    status = json['status'];
    responseCode = json['response_code'];
    data = Data.fromJson(json['data']);
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

class Data {
  Data({
    required this.specification,
  });
  late final List<Specification> specification;

  Data.fromJson(Map<String, dynamic> json){
    specification = List.from(json['specification']).map((e)=>Specification.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['specification'] = specification.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Specification {
  Specification({
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
    required this.unitCount,
    required this.deliveryPeriod,
    required this.available,
    required this.priceTerms,
    this.minQuantity,
    required this.description,
    required this.pictures,
  });
  late final String? businessArea;
  late final String? locality;
  late final String? material;
  late final String? length;
  late final String? grade;
  late final String? micronaire;
  late final String? moisture;
  late final String? trash;
  late final String? rd;
  late final String? gpt;
  late final String? apperance;
  late final String? brand;
  late final String? productYear;
  late final String? origin;
  late final String? certification;
  late final String? priceUnit;
  late final String? unitCount;
  late final String? deliveryPeriod;
  late final String? available;
  late final String? priceTerms;
  late final String? minQuantity;
  late final String? description;
  late final List<Pictures> pictures;

  Specification.fromJson(Map<String, dynamic> json){
    businessArea = json['business_area'];
    locality = json['locality'];
    material = json['material'];
    length = json['length'];
    grade = json['grade']??"";
    micronaire = json['micronaire'];
    moisture = json["moisture"];
    trash = json['trash'];
    rd = json['rd'];
    gpt = json['gpt']??"";
    apperance = json['apperance'];
    brand = json['brand']??"";
    productYear = json['product_year'];
    origin = json['origin']??"";
    certification = json['certification'];
    priceUnit = json['price_unit'];
    unitCount = json['unit_count'];
    deliveryPeriod = json['delivery_period'];
    available = json['available'];
    priceTerms = json['price_terms'];
    minQuantity = json['min_quantity'];
    description = json['description'];
    pictures = List.from(json['pictures']).map((e)=>Pictures.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
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
    _data['apperance'] = apperance;
    _data['brand'] = brand;
    _data['product_year'] = productYear;
    _data['origin'] = origin;
    _data['certification'] = certification;
    _data['price_unit'] = priceUnit;
    _data['unit_count'] = unitCount;
    _data['delivery_period'] = deliveryPeriod;
    _data['available'] = available;
    _data['price_terms'] = priceTerms;
    _data['min_quantity'] = minQuantity;
    _data['description'] = description;
    _data['pictures'] = pictures.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Pictures {
  Pictures({
    required this.picture,
  });
  late final String picture;

  Pictures.fromJson(Map<String, dynamic> json){
    picture = json['picture'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['picture'] = picture;
    return _data;
  }
}