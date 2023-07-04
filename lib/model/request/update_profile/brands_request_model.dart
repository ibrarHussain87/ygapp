class BrandsRequestModel {
  String? brdId;
  String? brdName;
  String? brdOther;

  BrandsRequestModel({this.brdId, this.brdName, this.brdOther});

  BrandsRequestModel.fromJson(Map<String, dynamic> json) {
    brdId = json['brd_id'];
    brdName = json['brd_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['brand_id'] = brdId ?? "";
    data['brand_name'] = brdName;
    data['other_brand'] = brdId!=null ? "0" : "1";
    return data;
  }
}