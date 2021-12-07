class ChangeBidResponse {
  ChangeBidResponse({
    required this.status,
    required this.responseCode,
    required this.data,
    required this.message,
  });
  late final bool status;
  late final int responseCode;
  late final Data data;
  late final String message;

  ChangeBidResponse.fromJson(Map<String, dynamic> json){
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
    required this.bidId,
    required this.status,
  });
  late final String bidId;
  late final String status;

  Data.fromJson(Map<String, dynamic> json){
    bidId = json['bid_id'];
    status = json['bid_status'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['bid_id'] = bidId;
    _data['bid_status'] = status;
    return _data;
  }
}