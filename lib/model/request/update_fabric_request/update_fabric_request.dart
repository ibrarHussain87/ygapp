class UpdateFabricRequestModel {

  String? category_id;
  String? specification_id;
  String? specification_status;
  String? specification_quantity;
  String? specification_rate;
  String? specification_delivery_period;


  UpdateFabricRequestModel({
    this.category_id,
    this.specification_id,
    this.specification_status,
    this.specification_quantity,
    this.specification_rate,
    this.specification_delivery_period,
  });

  Map<String, String> toJson() {
    Map<String, String> map = {
      'category_id': category_id?? "",
      'specification_id': specification_id?? "",
      'specification_status': specification_status?? "",
      'specification_quantity': specification_quantity?? "",
      'specification_rate': specification_rate?? "",
      'specification_delivery_period': specification_delivery_period?? "",

    };

    return map;
  }
}
