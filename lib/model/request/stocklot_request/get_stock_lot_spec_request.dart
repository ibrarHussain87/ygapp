class GetStockLotSpecRequestModel{
  String? spcUserIdfk;
  String? categoryId;
  String? isOffering;
  String? localInternational;

  GetStockLotSpecRequestModel({this.spcUserIdfk, this.categoryId,this.isOffering,this.localInternational});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'spc_user_idfk': spcUserIdfk!.trim(),
      'category_id': categoryId!.trim(),
      'is_offering': isOffering!.trim(),
      'local_international': localInternational!.trim(),
    };

    return map;
  }

}
