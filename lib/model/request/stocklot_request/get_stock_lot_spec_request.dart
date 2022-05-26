class GetStockLotSpecRequestModel {
  String? spcUserIdfk;
  String? categoryId;
  String? isOffering;
  String? localInternational;
  String? stocklotFamilyId;
  String? stocklotParentFamilyId;
  String? priceTermId;
  String? avalibilityId;

  GetStockLotSpecRequestModel(
      {this.spcUserIdfk,
      this.categoryId,
      this.isOffering,
      this.stocklotFamilyId,
      this.stocklotParentFamilyId,
      this.localInternational,
      this.priceTermId,
      this.avalibilityId});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'spc_user_idfk': spcUserIdfk??'',
      'category_id': categoryId??'',
      'is_offering': isOffering??'',
      'locality': localInternational??'',
      'stocklot_family_idfk[]': stocklotFamilyId??'',
      'stocklot_family_parent_idfk[]': stocklotParentFamilyId??'',
      'price_term_id': priceTermId??'',
      'avability_id': avalibilityId??'',
    };

    return map;
  }
}
