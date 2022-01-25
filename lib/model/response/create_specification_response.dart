class CreateBidResponse {
  CreateBidResponse({
    required this.status,
    required this.responseCode,
    required this.data,
    required this.message,
  });
  late final bool status;
  late final int responseCode;
  late final CreateSpecificationData data;
  late final String message;

  CreateBidResponse.fromJson(Map<String, dynamic> json){
    status = json['status'];
    responseCode = json['response_code'];
    data = CreateSpecificationData.fromJson(json['data']);
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

class CreateSpecificationData {
  CreateSpecificationData({
    required this.bidCategoryIdfk,
    required this.bidSpecificationIdfk,
    required this.bidUserIdfk,
    required this.bidPrice,
  });
  String? bidCategoryIdfk;
  String? bidSpecificationIdfk;
  String? bidUserIdfk;
  String? bidPrice;

  CreateSpecificationData.fromJson(Map<String, dynamic> json){
    bidCategoryIdfk = json['bid_category_idfk'];
    bidSpecificationIdfk = json['bid_specification_idfk'];
    bidUserIdfk = json['bid_user_idfk'];
    bidPrice = json['bid_price'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['bid_category_idfk'] = bidCategoryIdfk;
    _data['bid_specification_idfk'] = bidSpecificationIdfk;
    _data['bid_user_idfk'] = bidUserIdfk;
    _data['bid_price'] = bidPrice;
    return _data;
  }
}