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

  ListBiddersResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    responseCode = json['response_code'];
    data = List.from(json['data'])
        .map((e) => ListBiddersData.fromJson(e))
        .toList();
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['response_code'] = responseCode;
    _data['data'] = data.map((e) => e.toJson()).toList();
    _data['message'] = message;
    return _data;
  }
}

class ListBiddersData {
  ListBiddersData({
    required this.bidId,
    required this.category,
    required this.categoryId,
    this.specificationName,
    this.specificationId,
    this.userName,
    required this.userId,
    this.price,
    required this.isAccepted,
    required this.date,
  });

  late final int bidId;
  String? category;
  String? categoryId;
  String? specificationName;
  String? specificationId;
  String? userName;
  String? userId;
  String? price;
  String? isAccepted;
  String? date;

  ListBiddersData.fromJson(Map<String, dynamic> json) {
    bidId = json['bid_id'];
    category = json['category'];
    categoryId = json['category_id'];
    specificationName = json['specification_name'];
    specificationId = json['specification_id'];
    userName = json['user_name'];
    userId = json['user_id'];
    price = json['price'];
    isAccepted = json['status'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['bid_id'] = bidId;
    _data['category'] = category;
    _data['category_id'] = categoryId;
    _data['specification_id'] = specificationId;
    _data['specification_name'] = specificationName;
    _data['user_name'] = userName;
    _data['user_id'] = userId;
    _data['price'] = price;
    _data['status'] = isAccepted;
    _data['date'] = date;
    return _data;
  }
}
