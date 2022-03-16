class GetBannersResponse {
  GetBannersResponse({
    required this.status,
    required this.responseCode,
    required this.data,
    required this.message,
  });
  late final bool status;
  late final int responseCode;
  late final BannerData data;
  late final String message;

  GetBannersResponse.fromJson(Map<String, dynamic> json){
    status = json['status'];
    responseCode = json['response_code'];
    data = BannerData.fromJson(json['data']);
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

class BannerData {
  BannerData({
     this.banners,
  });
  late final List<Banners>? banners;

  BannerData.fromJson(Map<String, dynamic> json){
    banners = List.from(json['banners']).map((e)=>Banners.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['banners'] = banners!.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Banners {
  Banners({
    required this.id,
    required this.banner,
  });
  late final int id;
  String? banner;
  String? url;

  Banners.fromJson(Map<String, dynamic> json){
    id = json['id'];
    banner = json['banner'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['banner'] = banner;
    _data['url'] = url;
    return _data;
  }
}