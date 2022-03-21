class SyncRequestModel {

  String? categoryId;

  SyncRequestModel({this.categoryId,});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'category_id': categoryId!.trim(),
    };

    return map;
  }
}
