import 'dart:convert';

/// status : true
/// response_code : 200
/// data : {"specification":[{"id":103,"user_id":"29","category_id":"Yarn Waste","unit":null,"availablity":"international","price_term":"Credit","spec_details":[{"sub_category_id":"Nimafill","quantity":"59","unit":null,"price":"79","description":"sb"}],"pictures":[],"date":"2022-04-14"},{"id":101,"user_id":"39","category_id":"Yarn Waste","unit":null,"availablity":"Pakistan","price_term":"Credit","spec_details":[{"sub_category_id":"Nimafill","quantity":"250","unit":null,"price":"1800","description":"test"},{"sub_category_id":"Hard Waste","quantity":"20","unit":null,"price":"1000","description":"test"}],"pictures":[],"date":"2022-04-13"},{"id":100,"user_id":"39","category_id":"Cotton Waste","unit":null,"availablity":"Pakistan","price_term":"Cash","spec_details":[{"sub_category_id":"Cotton Seed","quantity":"50","unit":null,"price":"50000","description":"2000 KG Cotton Waste"}],"pictures":[],"date":"2022-04-13"},{"id":99,"user_id":"29","category_id":"Fabrics","unit":null,"availablity":"Pakistan","price_term":"Credit","spec_details":[{"sub_category_id":"Gerige Fabrics","quantity":"6","unit":null,"price":"4","description":"assalam"},{"sub_category_id":"Dyed Fabrics","quantity":"6","unit":null,"price":"4","description":"r"},{"sub_category_id":"Bleached","quantity":"6","unit":null,"price":"4","description":"3"}],"pictures":[],"date":"2022-04-13"},{"id":98,"user_id":"29","category_id":"Fabrics","unit":null,"availablity":"Pakistan","price_term":"Adjustments","spec_details":[{"sub_category_id":"Dyed Fabrics","quantity":"91","unit":null,"price":"49","description":"sb"},{"sub_category_id":"Bleached","quantity":"59","unit":null,"price":"7","description":"sbsb"}],"pictures":[],"date":"2022-04-13"},{"id":97,"user_id":"29","category_id":"Yarn Waste","unit":null,"availablity":"Pakistan","price_term":"Cash","spec_details":[{"sub_category_id":"Nimafill","quantity":"59","unit":null,"price":"79","description":"svbs"}],"pictures":[],"date":"2022-04-13"},{"id":96,"user_id":"29","category_id":"Fabrics","unit":null,"availablity":"international","price_term":"Credit","spec_details":[{"sub_category_id":"Dyed Fabrics","quantity":"46","unit":null,"price":"23","description":"zvsvvd"}],"pictures":[],"date":"2022-04-13"}]}
/// message : "Yarn specification fetched successfully!!!"

StockLotSpecificationResponse stockLotSpecificationResponseFromJson(
        String str) =>
    StockLotSpecificationResponse.fromJson(json.decode(str));

String stockLotSpecificationResponseToJson(
        StockLotSpecificationResponse data) =>
    json.encode(data.toJson());

class StockLotSpecificationResponse {
  StockLotSpecificationResponse({
    bool? status,
    int? responseCode,
    StockLotSpecificationData? data,
    String? message,
  }) {
    _status = status;
    _responseCode = responseCode;
    _data = data;
    _message = message;
  }

  StockLotSpecificationResponse.fromJson(dynamic json) {
    _status = json['status'];
    _responseCode = json['response_code'];
    _data = json['data'] != null ? StockLotSpecificationData.fromJson(json['data']) : null;
    _message = json['message'];
  }

  bool? _status;
  int? _responseCode;
  StockLotSpecificationData? _data;
  String? _message;

  StockLotSpecificationResponse copyWith({
    bool? status,
    int? responseCode,
    StockLotSpecificationData? data,
    String? message,
  }) =>
      StockLotSpecificationResponse(
        status: status ?? _status,
        responseCode: responseCode ?? _responseCode,
        data: data ?? _data,
        message: message ?? _message,
      );

  bool? get status => _status;

  int? get responseCode => _responseCode;

  StockLotSpecificationData? get data => _data;

  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['response_code'] = _responseCode;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    map['message'] = _message;
    return map;
  }
}

/// specification : [{"id":103,"user_id":"29","category_id":"Yarn Waste","unit":null,"availablity":"international","price_term":"Credit","spec_details":[{"sub_category_id":"Nimafill","quantity":"59","unit":null,"price":"79","description":"sb"}],"pictures":[],"date":"2022-04-14"},{"id":101,"user_id":"39","category_id":"Yarn Waste","unit":null,"availablity":"Pakistan","price_term":"Credit","spec_details":[{"sub_category_id":"Nimafill","quantity":"250","unit":null,"price":"1800","description":"test"},{"sub_category_id":"Hard Waste","quantity":"20","unit":null,"price":"1000","description":"test"}],"pictures":[],"date":"2022-04-13"},{"id":100,"user_id":"39","category_id":"Cotton Waste","unit":null,"availablity":"Pakistan","price_term":"Cash","spec_details":[{"sub_category_id":"Cotton Seed","quantity":"50","unit":null,"price":"50000","description":"2000 KG Cotton Waste"}],"pictures":[],"date":"2022-04-13"},{"id":99,"user_id":"29","category_id":"Fabrics","unit":null,"availablity":"Pakistan","price_term":"Credit","spec_details":[{"sub_category_id":"Gerige Fabrics","quantity":"6","unit":null,"price":"4","description":"assalam"},{"sub_category_id":"Dyed Fabrics","quantity":"6","unit":null,"price":"4","description":"r"},{"sub_category_id":"Bleached","quantity":"6","unit":null,"price":"4","description":"3"}],"pictures":[],"date":"2022-04-13"},{"id":98,"user_id":"29","category_id":"Fabrics","unit":null,"availablity":"Pakistan","price_term":"Adjustments","spec_details":[{"sub_category_id":"Dyed Fabrics","quantity":"91","unit":null,"price":"49","description":"sb"},{"sub_category_id":"Bleached","quantity":"59","unit":null,"price":"7","description":"sbsb"}],"pictures":[],"date":"2022-04-13"},{"id":97,"user_id":"29","category_id":"Yarn Waste","unit":null,"availablity":"Pakistan","price_term":"Cash","spec_details":[{"sub_category_id":"Nimafill","quantity":"59","unit":null,"price":"79","description":"svbs"}],"pictures":[],"date":"2022-04-13"},{"id":96,"user_id":"29","category_id":"Fabrics","unit":null,"availablity":"international","price_term":"Credit","spec_details":[{"sub_category_id":"Dyed Fabrics","quantity":"46","unit":null,"price":"23","description":"zvsvvd"}],"pictures":[],"date":"2022-04-13"}]

StockLotSpecificationData dataFromJson(String str) => StockLotSpecificationData.fromJson(json.decode(str));

String dataToJson(StockLotSpecificationData data) => json.encode(data.toJson());

class StockLotSpecificationData {
  StockLotSpecificationData({
    List<StockLotSpecification>? specification,
  }) {
    _specification = specification;
  }

  StockLotSpecificationData.fromJson(dynamic json) {
    if (json['specification'] != null) {
      _specification = [];
      json['specification'].forEach((v) {
        _specification?.add(StockLotSpecification.fromJson(v));
      });
    }
  }

  List<StockLotSpecification>? _specification;

  StockLotSpecificationData copyWith({
    List<StockLotSpecification>? specification,
  }) =>
      StockLotSpecificationData(
        specification: specification ?? _specification,
      );

  List<StockLotSpecification>? get specification => _specification;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_specification != null) {
      map['specification'] = _specification?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : 103
/// user_id : "29"
/// category_id : "Yarn Waste"
/// unit : null
/// availablity : "international"
/// price_term : "Credit"
/// spec_details : [{"sub_category_id":"Nimafill","quantity":"59","unit":null,"price":"79","description":"sb"}]
/// pictures : []
/// date : "2022-04-14"

StockLotSpecification specificationFromJson(String str) =>
    StockLotSpecification.fromJson(json.decode(str));

String specificationToJson(StockLotSpecification data) => json.encode(data.toJson());

class StockLotSpecification {
  StockLotSpecification({
    int? id,
    String? userId,
    String? categoryId,
    String? unit,
    String? availablity,
    String? priceTerm,
    List<SpecDetails>? specDetails,
    // List<String>? pictures,
    String? date,
  }) {
    _id = id;
    _userId = userId;
    _categoryId = categoryId;
    _unit = unit;
    _availablity = availablity;
    _priceTerm = priceTerm;
    _specDetails = specDetails;
    // _pictures = pictures;
    _date = date;
  }

  StockLotSpecification.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _categoryId = json['category_id'];
    _unit = json['unit'];
    _availablity = json['availablity'];
    _priceTerm = json['price_term'];
    if (json['spec_details'] != null) {
      _specDetails = [];
      json['spec_details'].forEach((v) {
        _specDetails?.add(SpecDetails.fromJson(v));
      });
    }
    // if (json['pictures'] != null) {
    //   _pictures = [];
    //   json['pictures'].forEach((v) {
    //     _pictures?.add(v.fromJson(v));
    //   });
    // }
    _date = json['date'];
  }

  int? _id;
  String? _userId;
  String? _categoryId;
  String? _unit;
  String? _availablity;
  String? _priceTerm;
  List<SpecDetails>? _specDetails;
  List<String>? _pictures;
  String? _date;

  StockLotSpecification copyWith({
    int? id,
    String? userId,
    String? categoryId,
    String? unit,
    String? availablity,
    String? priceTerm,
    List<SpecDetails>? specDetails,
    List<String>? pictures,
    String? date,
  }) =>
      StockLotSpecification(
        id: id ?? _id,
        userId: userId ?? _userId,
        categoryId: categoryId ?? _categoryId,
        unit: unit ?? _unit,
        availablity: availablity ?? _availablity,
        priceTerm: priceTerm ?? _priceTerm,
        specDetails: specDetails ?? _specDetails,
        // pictures: pictures ?? _pictures,
        date: date ?? _date,
      );

  int? get id => _id;

  String? get userId => _userId;

  String? get categoryId => _categoryId;

  String? get unit => _unit;

  String? get availablity => _availablity;

  String? get priceTerm => _priceTerm;

  List<SpecDetails>? get specDetails => _specDetails;

  // List<String>? get pictures => _pictures;

  String? get date => _date;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['category_id'] = _categoryId;
    map['unit'] = _unit;
    map['availablity'] = _availablity;
    map['price_term'] = _priceTerm;
    if (_specDetails != null) {
      map['spec_details'] = _specDetails?.map((v) => v.toJson()).toList();
    }
    // if (_pictures != null) {
    //   map['pictures'] = _pictures?.map((v) => v.toJson()).toList();
    // }
    map['date'] = _date;
    return map;
  }
}

/// sub_category_id : "Nimafill"
/// quantity : "59"
/// unit : null
/// price : "79"
/// description : "sb"

SpecDetails specDetailsFromJson(String str) =>
    SpecDetails.fromJson(json.decode(str));

String specDetailsToJson(SpecDetails data) => json.encode(data.toJson());

class SpecDetails {
  SpecDetails({
    String? subCategoryId,
    String? quantity,
    dynamic unit,
    String? price,
    String? description,
  }) {
    _subCategoryId = subCategoryId;
    _quantity = quantity;
    _unit = unit;
    _price = price;
    _description = description;
  }

  SpecDetails.fromJson(dynamic json) {
    _subCategoryId = json['sub_category_id'];
    _quantity = json['quantity'];
    _unit = json['unit'];
    _price = json['price'];
    _description = json['description'];
  }

  String? _subCategoryId;
  String? _quantity;
  dynamic _unit;
  String? _price;
  String? _description;

  SpecDetails copyWith({
    String? subCategoryId,
    String? quantity,
    dynamic unit,
    String? price,
    String? description,
  }) =>
      SpecDetails(
        subCategoryId: subCategoryId ?? _subCategoryId,
        quantity: quantity ?? _quantity,
        unit: unit ?? _unit,
        price: price ?? _price,
        description: description ?? _description,
      );

  String? get subCategoryId => _subCategoryId;

  String? get quantity => _quantity;

  dynamic get unit => _unit;

  String? get price => _price;

  String? get description => _description;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['sub_category_id'] = _subCategoryId;
    map['quantity'] = _quantity;
    map['unit'] = _unit;
    map['price'] = _price;
    map['description'] = _description;
    return map;
  }
}
