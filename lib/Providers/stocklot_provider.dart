import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stylish_dialog/stylish_dialog.dart';
import 'package:yg_app/api_services/api_service_class.dart';
import 'package:yg_app/elements/list_widgets/single_select_tile_renewed_widget.dart';
import 'package:yg_app/helper_utils/alert_dialog.dart';
import 'package:yg_app/helper_utils/progress_dialog_util.dart';
import 'package:yg_app/model/request/post_ad_request/create_request_model.dart';
import 'package:yg_app/model/request/stocklot_request/get_stock_lot_spec_request.dart';
import 'package:yg_app/model/response/common_response_models/countries_response.dart';
import 'package:yg_app/model/response/common_response_models/price_term.dart';
import 'package:yg_app/model/response/get_banner_response.dart';
import 'package:yg_app/model/response/stocklot_repose/stocklot_specification_response.dart';
import 'package:yg_app/model/response/stocklot_repose/stocklot_sync/stocklot_sync_response.dart';

import '../app_database/app_database_instance.dart';
import '../helper_utils/ui_utils.dart';
import '../model/request/stocklot_request/stocklot_request.dart';
import '../model/response/common_response_models/unit_of_count.dart';
import '../model/response/family_data.dart';
import '../model/stocklot_waste_model.dart';

class StocklotProvider extends ChangeNotifier {
  //Keys
  final GlobalKey<SingleSelectTileWidgetState> stocklotKey =
      GlobalKey<SingleSelectTileWidgetState>();
  final GlobalKey<SingleSelectTileWidgetState> categoryKey =
      GlobalKey<SingleSelectTileWidgetState>();
  final GlobalKey<SingleSelectTileWidgetState> subCategoryKey =
      GlobalKey<SingleSelectTileWidgetState>();

  List<StocklotCategories> stocklotAllCategories = [];
  List<StocklotCategories>? stocklots = [];
  List<StocklotCategories>? stocklotCategories = [];
  List<Stocklots>? stocklotAllSubcategories = [];
  List<StocklotCategories>? stocklotSubcategories = [];
  List<Units>? unitsList = [];
  List<FPriceTerms> priceTermsList = [];
  List<Countries>? countryList = [];
  List<AvailabilityModel>? availabilityList = [];
  List<StocklotWasteModel>? stocklotWasteList = [];
  List<StocklotWasteModel>? filteredStocklotWasteList = [];
  List<StockLotSpecification> listStockLotSpec = [];
  List<StockLotSpecification> localSpecList = [];
  List<StockLotSpecification> internationSpecList = [];
  bool loading = false;
  bool ignoreClick = false;
  int selectedSubCategoryId = -1;
  int? stocklotId = -1;
  int? categoryId = -1;
  int? subcategoryId = -1;
  bool expandStockLostWast = true;
  String apiError = "";
  List<PickedFile> imageFiles = [];
  var stocklotRequestModel = StocklotRequestModel();
  String? isOffering = "1";
  int selectedSubCategoryIndex = -1;
  bool showSubCategory = false;
  bool showCategory = false;
  GetStockLotSpecRequestModel getStockLotSpecRequestModel = GetStockLotSpecRequestModel();

  setSubCatIndex(int value) {
    if (subCategoryKey.currentState != null) {
      subCategoryKey.currentState!.checkedTile = value;
    }
  }

  setIsOffering(String value) {
    isOffering = value;
    notifyListeners();
  }

  setShowCategory(bool value) {
    showCategory = value;
    notifyListeners();
  }

  setShowSubCategory(bool value) {
    showSubCategory = value;
    notifyListeners();
  }

   searchData(GetStockLotSpecRequestModel value){
    getStockLotSpecRequestModel = value;
    notifyListeners();
  }

  getStocklotData() async {
    loading = true;
    stocklotAllCategories.clear();
    stocklots!.clear();
    stocklotAllSubcategories!.clear();
    unitsList!.clear();
    priceTermsList.clear();
    countryList!.clear();
    stocklotWasteList!.clear();
    ignoreClick = false;
    var dbInstance = await AppDbInstance.getDbInstance();
    stocklotAllCategories =
        await dbInstance.stocklotCategoriesDao.findAllStocklotCategories();
    stocklots = stocklotAllCategories
        .where((element) => element.parentId == null)
        .toList();
    stocklotAllSubcategories = await dbInstance.stocklotDao.findAllStocklots();
    unitsList = await dbInstance.unitDao.findAllUnit();
    priceTermsList =
        await dbInstance.priceTermsDao.findYarnFPriceTermsWithCatId(5);
    countryList = await dbInstance.countriesDao.findAllCountries();
    availabilityList = await dbInstance.availabilityDao.findAllAvailability();
    if (stocklots != null) {
      getCategories(stocklots!.first.id.toString());
    }
    loading = false;
    notifyListeners();
  }

  createStockLot(context) async {
    loading = true;
    notifyListeners();
    if (loading) {
      ProgressDialogUtil.showDialog(context, "Please wait...");
    }
    ApiService.createStockLot(stocklotRequestModel, imageFiles.first).then(
        (value) {
      if (value != null && value.status!) {
        loading = false;
        ProgressDialogUtil.hideDialog();

        showGenericDialog("Success", value.message.toString(), context,
            StylishDialogType.SUCCESS, "Close", () {});

        // Ui.showSnackBar(context, value.message.toString());
        resetData();
        notifyListeners();
      }
    }, onError: (error) {
      loading = false;
      Ui.showSnackBar(context, error.toString());
      ProgressDialogUtil.hideDialog();
      notifyListeners();
    });
  }

  void changeExpandStockLostWast() {
    if (expandStockLostWast) {
      expandStockLostWast = false;
      notifyListeners();
    } else {
      expandStockLostWast = true;
      notifyListeners();
    }
  }

  getCategories(String id) async {
    // stocklotId = int.parse(id);
    stocklotCategories!.clear();
    stocklotCategories = stocklotAllCategories
        .where((element) => element.parentId == id)
        .toList();
    if (stocklotCategories != null) {
      getSubcategories(stocklotCategories!.first.id.toString());
    }
    notifyListeners();
  }

  getSubcategories(String id) async {
    // categoryId = int.parse(id);
    stocklotSubcategories!.clear();
    stocklotWasteList!.clear();
    subcategoryId = -1;
    selectedSubCategoryId = -1;
    stocklotSubcategories = stocklotAllCategories
        .where((element) => element.parentId == id)
        .toList();
    notifyListeners();
  }

  addStocklotWaste(StocklotWasteModel stocklotWasteModel) {
    if (stocklotWasteList!.isNotEmpty) {
      var index = stocklotWasteList!
          .indexWhere((element) => element.id == stocklotWasteModel.id);
      if (index > -1) {
        stocklotWasteList![index] = stocklotWasteModel;
      } else {
        stocklotWasteList!.add(stocklotWasteModel);
      }
    } else {
      stocklotWasteList!.add(stocklotWasteModel);
    }
    if (selectedSubCategoryId != -1) {
      filteredStocklotWasteList!.clear();
      // filteredStocklotWasteList = stocklotWasteList!.where((element) => element.id == selectedSubCategoryId.toString()).toList();
      filteredStocklotWasteList = stocklotWasteList!.toList();
    }
    notifyListeners();
  }

  removeStockWaste(StocklotWasteModel stocklotWasteModel) {
    stocklotWasteList!.remove(stocklotWasteModel);
    filteredStocklotWasteList = stocklotWasteList!.toList();
    if (filteredStocklotWasteList!.isEmpty) {
      ignoreClick = false;
    }
    notifyListeners();
  }

  getFilteredStocklotWaste(int id) {
    selectedSubCategoryId = id;
    subcategoryId = id;
    filteredStocklotWasteList!.clear();
    // filteredStocklotWasteList = stocklotWasteList!.where((element) => element.id == selectedSubCategoryId.toString()).toList();
    filteredStocklotWasteList = stocklotWasteList!.toList();
    notifyListeners();
  }

  disableClick() {
    ignoreClick = true;
    notifyListeners();
  }

  resetData() {
    if (stocklotKey.currentState != null) {
      stocklotKey.currentState!.checkedTile = 0;
    }
    if (categoryKey.currentState != null) {
      categoryKey.currentState!.checkedTile = -1;
    }

    if (subCategoryKey.currentState != null) {
      subCategoryKey.currentState!.checkedTile = -1;
    }
    stocklotWasteList = [];
    filteredStocklotWasteList = [];
    getStocklotData();
    loading = false;
    ignoreClick = false;
    selectedSubCategoryId = -1;
    stocklotId = -1;
    categoryId = -1;
    subcategoryId = -1;
    expandStockLostWast = true;
    imageFiles = [];
    stocklotRequestModel = StocklotRequestModel();
  }
}
