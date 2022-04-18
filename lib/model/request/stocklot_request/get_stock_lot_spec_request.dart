class GetStockLotSpecRequestModel{
  String? spcUserIdfk;
  String? categoryId;
  String? isOffering;
  String? localInternational;
  String? stocklotCategoryId;
  String? stocklotSubCategoryId;

  GetStockLotSpecRequestModel({this.spcUserIdfk, this.categoryId,
    this.isOffering,
    this.stocklotCategoryId,
    this.stocklotSubCategoryId,
    this.localInternational});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'spc_user_idfk': spcUserIdfk!.trim(),
      'category_id': categoryId!.trim(),
      'is_offering': isOffering!.trim(),
      'locality': localInternational!.trim(),
      'stocklot_category_id': stocklotCategoryId,
      'stocklot_sub_category_id': stocklotSubCategoryId,
    };

    return map;
  }

}
