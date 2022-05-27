import 'dart:collection';
import 'dart:convert';

/// status : true
/// response_code : 200
/// data : {"specification":[{"id":103,"user_id":"29","company":"http://irfanjaved.co","stocklot_category_id":"5","category":"Yarn Waste","unit":null,"availablity":"international","price_term":"Credit","is_offering":"1","locality":"LOCAL","is_verified":"0","is_featured":"0","spec_details":[{"stocklot_sub_category_id":"8","sub_category":"Nimafill","quantity":"59","unit":null,"price":"79","price_unit":"PKR 79","origin":"Afghanistan","description":"sb"}],"pictures":[],"date":"2022-04-14"},{"id":101,"user_id":"39","company":"GaZ Trader","stocklot_category_id":"5","category":"Yarn Waste","unit":null,"availablity":"Pakistan","price_term":"Credit","is_offering":"1","locality":"LOCAL","is_verified":"0","is_featured":"0","spec_details":[{"stocklot_sub_category_id":"8","sub_category":"Nimafill","quantity":"250","unit":null,"price":"1800","price_unit":"PKR 1800","origin":"Afghanistan","description":"test"},{"stocklot_sub_category_id":"9","sub_category":"Hard Waste","quantity":"20","unit":null,"price":"1000","price_unit":"PKR 1000","origin":"Afghanistan","description":"test"}],"pictures":[],"date":"2022-04-13"},{"id":97,"user_id":"29","company":"http://irfanjaved.co","stocklot_category_id":"5","category":"Yarn Waste","unit":null,"availablity":"Pakistan","price_term":"Cash","is_offering":"1","locality":"LOCAL","is_verified":"0","is_featured":"0","spec_details":[{"stocklot_sub_category_id":"8","sub_category":"Nimafill","quantity":"59","unit":null,"price":"79","price_unit":"PKR 79","origin":"Afghanistan","description":"svbs"}],"pictures":[],"date":"2022-04-13"}]}
/// message : "Stocklot specification fetched successfully!!!"

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
    StockLotData? data,
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
    if (json['data'] != null) {
      if(json['data'] is List<dynamic>){
       _data = null;
      }else {
        _data = StockLotData.fromJson(json['data']);
      }
    } else {
      _data = null;
    }

    _message = json['message'];
  }

  bool? _status;
  int? _responseCode;
  StockLotData? _data;
  String? _message;

  StockLotSpecificationResponse copyWith({
    bool? status,
    int? responseCode,
    StockLotData? data,
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

  StockLotData? get data => _data;

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

/// specification : [{"id":103,"user_id":"29","company":"http://irfanjaved.co","stocklot_category_id":"5","category":"Yarn Waste","unit":null,"availablity":"international","price_term":"Credit","is_offering":"1","locality":"LOCAL","is_verified":"0","is_featured":"0","spec_details":[{"stocklot_sub_category_id":"8","sub_category":"Nimafill","quantity":"59","unit":null,"price":"79","price_unit":"PKR 79","origin":"Afghanistan","description":"sb"}],"pictures":[],"date":"2022-04-14"},{"id":101,"user_id":"39","company":"GaZ Trader","stocklot_category_id":"5","category":"Yarn Waste","unit":null,"availablity":"Pakistan","price_term":"Credit","is_offering":"1","locality":"LOCAL","is_verified":"0","is_featured":"0","spec_details":[{"stocklot_sub_category_id":"8","sub_category":"Nimafill","quantity":"250","unit":null,"price":"1800","price_unit":"PKR 1800","origin":"Afghanistan","description":"test"},{"stocklot_sub_category_id":"9","sub_category":"Hard Waste","quantity":"20","unit":null,"price":"1000","price_unit":"PKR 1000","origin":"Afghanistan","description":"test"}],"pictures":[],"date":"2022-04-13"},{"id":97,"user_id":"29","company":"http://irfanjaved.co","stocklot_category_id":"5","category":"Yarn Waste","unit":null,"availablity":"Pakistan","price_term":"Cash","is_offering":"1","locality":"LOCAL","is_verified":"0","is_featured":"0","spec_details":[{"stocklot_sub_category_id":"8","sub_category":"Nimafill","quantity":"59","unit":null,"price":"79","price_unit":"PKR 79","origin":"Afghanistan","description":"svbs"}],"pictures":[],"date":"2022-04-13"}]

StockLotData dataFromJson(String str) =>
    StockLotData.fromJson(json.decode(str));

String dataToJson(StockLotData data) => json.encode(data.toJson());

class StockLotData {
  StockLotData({
    List<StockLotSpecification>? specification,
  }) {
    _specification = specification;
  }

  StockLotData.fromJson(dynamic json) {
      if (json['specification'] != null) {
        _specification = [];
        json['specification'].forEach((v) {
          _specification?.add(StockLotSpecification.fromJson(v));
        });
      }
  }

  List<StockLotSpecification>? _specification;

  StockLotData copyWith({
    List<StockLotSpecification>? specification,
  }) =>
      StockLotData(
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
/// company : "http://irfanjaved.co"
/// stocklot_category_id : "5"
/// category : "Yarn Waste"
/// unit : null
/// availablity : "international"
/// price_term : "Credit"
/// is_offering : "1"
/// locality : "LOCAL"
/// is_verified : "0"
/// is_featured : "0"
/// spec_details : [{"stocklot_sub_category_id":"8","sub_category":"Nimafill","quantity":"59","unit":null,"price":"79","price_unit":"PKR 79","origin":"Afghanistan","description":"sb"}]
/// pictures : []
/// date : "2022-04-14"

StockLotSpecification specificationFromJson(String str) =>
    StockLotSpecification.fromJson(json.decode(str));

String specificationToJson(StockLotSpecification data) =>
    json.encode(data.toJson());

class StockLotSpecification {
  StockLotSpecification({
    int? id,
    String? userId,
    String? company,
    String? stocklotCategoryId,
    String? spc_category_name,
    String? stocklotParentFamilyName,
    String? category,
    dynamic unit,
    String? availablity,
    String? priceTerm,
    String? isOffering,
    String? locality,
    String? isVerified,
    String? isFeatured,
    String? description,
    String? country_name,
    String? port_name,
    List<SpecDetails>? specDetails,
    List<dynamic>? pictures,
    String? date,
    int? matchedCount,
    int? proposalCount,
  }) {
    _id = id;
    _userId = userId;
    _company = company;
    _stocklotCategoryId = stocklotCategoryId;
    _spc_category_name = spc_category_name;
    _stocklotParentFamilyName = stocklotParentFamilyName;
    _category = category;
    _unit = unit;
    _availablity = availablity;
    _priceTerm = priceTerm;
    _isOffering = isOffering;
    _locality = locality;
    _isVerified = isVerified;
    _isFeatured = isFeatured;
    _description = description;
    _country_name = country_name;
    _port_name = port_name;
    _specDetails = specDetails;
    _pictures = pictures;
    _matchedCount = matchedCount;
    _proposalCount = proposalCount;
    _date = date;
  }

  StockLotSpecification.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _company = json['company'];
    _stocklotCategoryId = json['spc_category_idfk'];
    _spc_category_name = json['spc_category_name'];
    _stocklotParentFamilyName = json['stocklot_parent_family_name'];
    _category = json['category'];
    _unit = json['unit'];
    _availablity = json['availablity'];
    _priceTerm = json['price_term'];
    _isOffering = json['is_offering'];
    _locality = json['locality'];
    _isVerified = json['is_verified'];
    _isFeatured = json['is_featured'];
    _description = json['description'];
    _description = json['description'];
    _country_name = json['country_name'];
    _port_name = json['port_name'];
    _matchedCount = json['matched_count'];
    _proposalCount = json['proposal_count'];
    _isFeatured = json['is_featured'];
    if (json['spec_details'] != null) {
      _specDetails = [];
      json['spec_details'].forEach((v) {
        _specDetails?.add(SpecDetails.fromJson(v));
      });
    }
    if (json['pictures'] != null) {
      _pictures = [];
      json['pictures'].forEach((v) {
        _pictures?.add(v);
      });
    }
    _date = json['date'];
  }

  int? _id;
  String? _userId;
  String? _company;
  String? _stocklotCategoryId;
  String? _spc_category_name;
  String? _stocklotParentFamilyName;
  String? _category;
  dynamic _unit;
  String? _availablity;
  String? _priceTerm;
  String? _isOffering;
  String? _locality;
  String? _isVerified;
  String? _isFeatured;
  String? _description;
  String? _country_name;
  String? _port_name;
  int? _matchedCount;
  int? _proposalCount;
  List<SpecDetails>? _specDetails;
  List<dynamic>? _pictures;
  String? _date;

  StockLotSpecification copyWith({
    int? id,
    String? userId,
    String? company,
    String? stocklotCategoryId,
    String? spc_category_name,
    String? stocklotParentFamilyName,
    String? category,
    dynamic unit,
    String? availablity,
    String? priceTerm,
    String? isOffering,
    String? locality,
    String? isVerified,
    String? isFeatured,
    String? description,
    String? country_name,
    String? port_name,
    List<SpecDetails>? specDetails,
    List<dynamic>? pictures,
    String? date,
    int? matchedCount,
    int? proposalCount,
  }) =>
      StockLotSpecification(
        id: id ?? _id,
        userId: userId ?? _userId,
        company: company ?? _company,
        stocklotCategoryId: stocklotCategoryId ?? _stocklotCategoryId,
        spc_category_name: spc_category_name ?? _spc_category_name,
        stocklotParentFamilyName: stocklotParentFamilyName ?? _stocklotParentFamilyName,
        category: category ?? _category,
        unit: unit ?? _unit,
        availablity: availablity ?? _availablity,
        priceTerm: priceTerm ?? _priceTerm,
        isOffering: isOffering ?? _isOffering,
        locality: locality ?? _locality,
        isVerified: isVerified ?? _isVerified,
        isFeatured: isFeatured ?? _isFeatured,
        description: description ?? _description,
        country_name: country_name ?? _country_name,
        port_name: port_name ?? _port_name,
        specDetails: specDetails ?? _specDetails,
        pictures: pictures ?? _pictures,
        date: date ?? _date,
        matchedCount: matchedCount ?? _matchedCount,
        proposalCount: proposalCount ?? _proposalCount,
      );

  int? get id => _id;

  String? get userId => _userId;

  String? get company => _company;

  String? get stocklotCategoryId => _stocklotCategoryId;
  String? get spc_category_name => _spc_category_name;
  String? get stocklotParentFamilyName => _stocklotParentFamilyName;

  String? get category => _category;

  dynamic get unit => _unit;

  String? get availablity => _availablity;

  String? get priceTerm => _priceTerm;
  int? get proposalCount => _proposalCount;
  int? get matchedCount => _matchedCount;

  String? get isOffering => _isOffering;

  String? get locality => _locality;

  String? get isVerified => _isVerified;

  String? get isFeatured => _isFeatured;

  String? get description => _description;
  String? get country_name => _country_name;
  String? get port_name => _port_name;

  List<SpecDetails>? get specDetails => _specDetails;

  List<dynamic>? get pictures => _pictures;

  String? get date => _date;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['company'] = _company;
    map['stocklot_category_id'] = _stocklotCategoryId;
    map['spc_category_name'] = _spc_category_name;
    map['stocklot_parent_family_name'] = _stocklotParentFamilyName;
    map['category'] = _category;
    map['unit'] = _unit;
    map['availablity'] = _availablity;
    map['price_term'] = _priceTerm;
    map['is_offering'] = _isOffering;
    map['locality'] = _locality;
    map['is_verified'] = _isVerified;
    map['is_featured'] = _isFeatured;
    map['description'] = _description;
    map['country_name'] = _country_name;
    map['port_name'] = _port_name;
    map['matched_count'] = _matchedCount;
    map['proposal_count'] = _proposalCount;
    if (_specDetails != null) {
      map['spec_details'] = _specDetails?.map((v) => v.toJson()).toList();
    }
    if (_pictures != null) {
      map['pictures'] = _pictures?.map((v) => v.toJson()).toList();
    }
    map['date'] = _date;
    return map;
  }
}

/// stocklot_sub_category_id : "8"
/// sub_category : "Nimafill"
/// quantity : "59"
/// unit : null
/// price : "79"
/// price_unit : "PKR 79"
/// origin : "Afghanistan"
/// description : "sb"

SpecDetails specDetailsFromJson(String str) =>
    SpecDetails.fromJson(json.decode(str));

String specDetailsToJson(SpecDetails data) => json.encode(data.toJson());

class SpecDetails {
  SpecDetails({
    String? stocklotSubCategoryId,
    String? subCategory,
    String? quantity,
    dynamic unit,
    String? price,
    String? priceUnit,
    String? origin,
    String? description,
  }) {
    _stocklotSubCategoryId = stocklotSubCategoryId;
    _subCategory = subCategory;
    _quantity = quantity;
    _unit = unit;
    _price = price;
    _priceUnit = priceUnit;
    _origin = origin;
    _description = description;
  }

  SpecDetails.fromJson(dynamic json) {
    _stocklotSubCategoryId = json['stocklot_family_idfk'];
    _subCategory = json['stocklot_family_name'];
    _quantity = json['quantity'];
    _unit = json['unit'];
    _price = json['price'];
    _priceUnit = json['price_unit'];
    _origin = json['origin'];
    _description = json['description'];
  }

  String? _stocklotSubCategoryId;
  String? _subCategory;
  String? _quantity;
  dynamic _unit;
  String? _price;
  String? _priceUnit;
  String? _origin;
  String? _description;

  SpecDetails copyWith({
    String? stocklotSubCategoryId,
    String? subCategory,
    String? quantity,
    dynamic unit,
    String? price,
    String? priceUnit,
    String? origin,
    String? description,
  }) =>
      SpecDetails(
        stocklotSubCategoryId: stocklotSubCategoryId ?? _stocklotSubCategoryId,
        subCategory: subCategory ?? _subCategory,
        quantity: quantity ?? _quantity,
        unit: unit ?? _unit,
        price: price ?? _price,
        priceUnit: priceUnit ?? _priceUnit,
        origin: origin ?? _origin,
        description: description ?? _description,
      );

  String? get stocklotSubCategoryId => _stocklotSubCategoryId;

  String? get subCategory => _subCategory;

  String? get quantity => _quantity;

  dynamic get unit => _unit;

  String? get price => _price;

  String? get priceUnit => _priceUnit;

  String? get origin => _origin;

  String? get description => _description;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['stocklot_sub_category_id'] = _stocklotSubCategoryId;
    map['sub_category'] = _subCategory;
    map['quantity'] = _quantity;
    map['unit'] = _unit;
    map['price'] = _price;
    map['price_unit'] = _priceUnit;
    map['origin'] = _origin;
    map['description'] = _description;
    return map;
  }
}
