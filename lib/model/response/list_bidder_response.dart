class ListBiddersResponse {
  ListBiddersResponse({
    required this.status,
    required this.responseCode,
    required this.data,
    required this.message,
  });
  late final bool status;
  late final int responseCode;
  late final List<Data> data;
  late final String message;

  ListBiddersResponse.fromJson(Map<String, dynamic> json){
    status = json['status'];
    responseCode = json['response_code'];
    data = List.from(json['data']).map((e)=>Data.fromJson(e)).toList();
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['response_code'] = responseCode;
    _data['data'] = data.map((e)=>e.toJson()).toList();
    _data['message'] = message;
    return _data;
  }
}

class Data {
  Data({
    required this.bidId,
    required this.bidCategoryIdfk,
    required this.bidSpecificationIdfk,
    required this.bidUserIdfk,
  });
  late final int bidId;
  late final String bidCategoryIdfk;
  late final String bidSpecificationIdfk;
  late final String bidUserIdfk;

  Data.fromJson(Map<String, dynamic> json){
    bidId = json['bid_id'];
    bidCategoryIdfk = json['bid_category_idfk'];
    bidSpecificationIdfk = json['bid_specification_idfk'];
    bidUserIdfk = json['bid_user_idfk'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['bid_id'] = bidId;
    _data['bid_category_idfk'] = bidCategoryIdfk;
    _data['bid_specification_idfk'] = bidSpecificationIdfk;
    _data['bid_user_idfk'] = bidUserIdfk;
    return _data;
  }
}