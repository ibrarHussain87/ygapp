import 'package:yg_app/model/stocklot_waste_model.dart';

class StocklotRequestModel {

  String? stocklotId;
  String? stocklotName;
  String? categoryId;
  String? categoryName;
  String? subcategoryId;
  String? subcategoryName;
  String? priceTermsId;
  String? priceTermsName;
  String? countryId;
  String? currency;
  String? availability;
  List<StocklotWasteModel>? stocklotWasteModelList;

  StocklotRequestModel({this.stocklotId, this.stocklotName,this.categoryId, this.categoryName,
    this.subcategoryId,this.subcategoryName, this.priceTermsId,
    this.priceTermsName,this.countryId, this.currency,this.availability,this.stocklotWasteModelList,});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'stocklot_id': stocklotId!.trim(),
      'stocklot_name': stocklotName!.trim(),
      'category_id': categoryId!.trim(),
      'category_name': categoryName!.trim(),
      'subcategory_id': subcategoryId!.trim(),
      'subcategory_name': subcategoryName!.trim(),
      'priceTerms_id': priceTermsId!.trim(),
      'priceTerms_name': priceTermsName!.trim(),
      'country_id': countryId!.trim(),
      'currency': currency!.trim(),
      'availability': availability!.trim(),
      'stocklot_waste_model_list': stocklotWasteModelList!.map((e) => e.toJson()).toList(),
    };

    return map;
  }
}
