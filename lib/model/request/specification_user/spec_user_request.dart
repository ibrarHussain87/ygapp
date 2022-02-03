class SpecificationRequestModel {

  String? spc_id;
  String? category_id;

  SpecificationRequestModel({this.spc_id, this.category_id});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'spc_id': spc_id!.trim(),
      'category_id': category_id!.trim()
    };

    return map;
  }
}
