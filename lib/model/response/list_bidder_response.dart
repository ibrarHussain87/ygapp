class ListBiddersResponse {
  ListBiddersResponse({
    required this.status,
    required this.responseCode,
    required this.data,
    required this.message,
  });
  late final bool status;
  late final int responseCode;
  late final List<ListBiddersData> data;
  late final String message;

  ListBiddersResponse.fromJson(Map<String, dynamic> json){
    status = json['status'];
    responseCode = json['response_code'];
    data = List.from(json['data']).map((e)=>ListBiddersData.fromJson(e)).toList();
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

class ListBiddersData {
  ListBiddersData({
    required this.bidId,
    required this.category,
    this.specificationName,
    this.userName,
    required this.userId,
    this.price,
    required this.isAccepted,
    required this.date,
  });

  late final int bidId;
  late final String? category;
  late final String? specificationName;
  late final String? userName;
  late final String? userId;
  late final String? price;
  late final String? isAccepted;
  late final String? date;

  ListBiddersData.fromJson(Map<String, dynamic> json){
    bidId = json['bid_id'];
    category = json['category'];
    specificationName = json['specification_name'];
    userName = json['user_name'];
    userId = json['user_id'];
    price = json['price'];
    isAccepted = json['is_accepted'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['bid_id'] = bidId;
    _data['category'] = category;
    _data['specification_name'] = specificationName;
    _data['user_name'] = userName;
    _data['user_id'] = userId;
    _data['price'] = price;
    _data['is_accepted'] = isAccepted;
    _data['date'] = date;
    return _data;
  }
}