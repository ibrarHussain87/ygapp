import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stylish_dialog/stylish_dialog.dart';
import 'package:yg_app/api_services/api_service_class.dart';
import 'package:yg_app/elements/list_widgets/blend_with_image_listview_widget.dart';
import 'package:yg_app/elements/list_widgets/single_select_tile_renewed_widget.dart';
import 'package:yg_app/helper_utils/dialog_builder.dart';
import 'package:yg_app/helper_utils/progress_dialog_util.dart';
import 'package:yg_app/model/request/stocklot_request/get_stock_lot_spec_request.dart';
import 'package:yg_app/model/response/common_response_models/countries_response.dart';
import 'package:yg_app/model/response/common_response_models/price_term.dart';
import 'package:yg_app/model/response/stocklot_repose/stocklot_specification_response.dart';
import 'package:yg_app/model/response/stocklot_repose/stocklot_sync/stocklot_sync_response.dart';

import '../../app_database/app_database_instance.dart';
import '../../elements/list_widgets/single_select_tile_widget.dart';
import '../../helper_utils/ui_utils.dart';
import '../../model/request/stocklot_request/stocklot_request.dart';
import '../../model/response/common_response_models/ports_response.dart';
import '../../model/response/common_response_models/unit_of_count.dart';
import '../../model/stocklot_waste_model.dart';

class StockLotSpecificationProvider extends ChangeNotifier {
  //Keys
  final GlobalKey<SingleSelectTileWidgetState> stocklotKey =
      GlobalKey<SingleSelectTileWidgetState>();
  final GlobalKey<SingleSelectTileWidgetState> categoryKey =
      GlobalKey<SingleSelectTileWidgetState>();

  final GlobalKey<BlendWithImageListWidgetState> familyKey =
      GlobalKey<BlendWithImageListWidgetState>();
  GlobalKey<SingleSelectTileRenewedWidgetState> subFamilyKey =
      GlobalKey<SingleSelectTileRenewedWidgetState>();

  List<StockLotFamily>? stockLots = [];
  List<StockLotFamily>? stockLotCategories = [];
  List<Countries> countries = [];
  List<FPriceTerms> priceTermsList = [];


  bool isLoading = false;
  GetStockLotSpecRequestModel getStockLotSpecRequestModel =
      GetStockLotSpecRequestModel();

  searchData(GetStockLotSpecRequestModel value) {
    getStockLotSpecRequestModel = value;
    notifyListeners();
  }

  getStockLotData() async {
    isLoading = true;
    var dbInstance = await AppDbInstance().getDbInstance();
    stockLots = await dbInstance.stocklotCategoriesDao.findParentStocklot();
    priceTermsList = await dbInstance.priceTermsDao.findYarnFPriceTermsWithCatIdLocality(5, 'LOCAL');
    isLoading = false;
    notifyListeners();
  }

  getStockLotCategoriesData(int id) async {
    var dbInstance = await AppDbInstance().getDbInstance();
    stockLotCategories =
        await dbInstance.stocklotCategoriesDao.findStocklotCategories(id);
    notifyListeners();
  }

  getCountriesData() async {
    var dbInstance = await AppDbInstance().getDbInstance();
    countries = await dbInstance.countriesDao.findAllCountries();
    notifyListeners();
  }

  void resetValue() {
    stockLotCategories = [];
    notifyListeners();
  }

  void notifyUI() {
    notifyListeners();
  }
}
