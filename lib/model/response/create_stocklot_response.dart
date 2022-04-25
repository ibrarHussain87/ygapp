class CreateStockLotResponse {
  bool? status;
  int? responseCode;
  Data? data;
  String? message;

  CreateStockLotResponse(
      {this.status, this.responseCode, this.data, this.message});

  CreateStockLotResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    responseCode = json['response_code'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['response_code'] = this.responseCode;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  int? userId;
  String? spcCategoryIdfk;
  String? subCategoryId;
  String? avability;
  String? priceTermId;
  String? isOffering;
  String? locality;
  String? isVerified;
  String? isFeatured;
  List<StocklotSpecificationDetails>? stocklotSpecificationDetails;

  Data(
      {this.userId,
        this.spcCategoryIdfk,
        this.subCategoryId,
        this.avability,
        this.priceTermId,
        this.isOffering,
        this.locality,
        this.isVerified,
        this.isFeatured,
        this.stocklotSpecificationDetails});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    spcCategoryIdfk = json['spc_category_idfk'].toString();
    subCategoryId = json['sub_category_id'];
    avability = json['availablity'];
    priceTermId = json['price_term_id'];
    isOffering = json['is_offering'];
    locality = json['locality'];
    isVerified = json['is_verified'];
    isFeatured = json['is_featured'];
    if (json['spec_details'] != null) {
      stocklotSpecificationDetails = <StocklotSpecificationDetails>[];
      json['stocklot_specification_details'].forEach((v) {
        stocklotSpecificationDetails!
            .add( StocklotSpecificationDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['spc_category_idfk'] = this.spcCategoryIdfk;
    data['sub_category_id'] = this.subCategoryId;
    data['avability_id'] = this.avability;
    data['price_term_id'] = this.priceTermId;
    data['is_offering'] = this.isOffering;
    data['is_verified'] = this.isVerified;
    data['is_featured'] = this.isFeatured;
    data['locality'] = this.locality;
    if (this.stocklotSpecificationDetails != null) {
      data['stocklot_specification_details'] =
          this.stocklotSpecificationDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StocklotSpecificationDetails {
  String? specificationId;
  String? categoryId;
  String? quantity;
  String? unitId;
  String? price;
  // String? description;

  StocklotSpecificationDetails(
      {this.specificationId,
        this.categoryId,
        this.quantity,
        this.unitId,
        this.price,
        /*this.description*/});

  StocklotSpecificationDetails.fromJson(Map<String, dynamic> json) {
    specificationId = json['specification_id'];
    categoryId = json['category_id'];
    quantity = json['quantity'];
    unitId = json['unit_id'];
    price = json['price'];
    // description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['specification_id'] = this.specificationId;
    data['category_id'] = this.categoryId;
    data['quantity'] = this.quantity;
    data['unit_id'] = this.unitId;
    data['price'] = this.price;
    // data['description'] = this.description;
    return data;
  }
}
