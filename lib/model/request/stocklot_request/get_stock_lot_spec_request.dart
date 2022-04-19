class GetStockLotSpecRequestModel {
  String? spcUserIdfk;
  String? categoryId;
  String? isOffering;
  String? localInternational;
  String? stocklotCategoryId;
  String? stocklotSubCategoryId;
  String? priceTermId;
  String? avalibilityId;

  GetStockLotSpecRequestModel(
      {this.spcUserIdfk,
      this.categoryId,
      this.isOffering,
      this.stocklotCategoryId,
      this.stocklotSubCategoryId,
      this.localInternational,
      this.priceTermId,
      this.avalibilityId});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'spc_user_idfk': spcUserIdfk!.trim(),
      'category_id': categoryId!.trim(),
      'is_offering': isOffering!.trim(),
      'locality': localInternational!.trim(),
      'stocklot_category_id': stocklotCategoryId,
      'stocklot_sub_category_id': stocklotSubCategoryId,
      'price_term_id': priceTermId,
      'avability_id': avalibilityId,
    };

    return map;
  }
}
