import 'dart:convert';

import 'package:yg_app/model/stocklot_waste_model.dart';

class StocklotRequestModel {
  String? user_id;
  String? spc_category_idfk;
  String? subcategoryId;
  String? priceTermsId;
  String? countryId;
  String? currency;
  String? availability;
  String? isOffering;
  String? locality;
  List<StocklotWasteModel>? stocklotWasteModelList;

  StocklotRequestModel({this.user_id,this.spc_category_idfk,
    this.subcategoryId, this.priceTermsId,this.countryId, this.currency,this.availability,this.isOffering,this.locality,this.stocklotWasteModelList,});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'user_id': user_id!.trim(),
      'spc_category_idfk': spc_category_idfk!.trim(),
      'sub_category_id': subcategoryId!.trim(),
      'price_term_id': priceTermsId!.trim(),
      'country_id': countryId!.trim(),
      'avability_id': availability!.trim(),
      'locality': locality,
      'is_offering': isOffering,
      'stocklot_specification_details': stocklotWasteModelList!.map((e) => e.toJson()).toList(),
    };

    return map;
  }

}
