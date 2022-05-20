import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stylish_dialog/stylish_dialog.dart';
import 'package:yg_app/api_services/api_service_class.dart';
import 'package:yg_app/elements/list_widgets/single_select_tile_renewed_widget.dart';
import 'package:yg_app/helper_utils/dialog_builder.dart';
import 'package:yg_app/helper_utils/progress_dialog_util.dart';
import 'package:yg_app/locators.dart';
import 'package:yg_app/model/request/post_ad_request/create_request_model.dart';
import 'package:yg_app/model/request/stocklot_request/get_stock_lot_spec_request.dart';
import 'package:yg_app/model/response/common_response_models/countries_response.dart';
import 'package:yg_app/model/response/common_response_models/price_term.dart';
import 'package:yg_app/model/response/get_banner_response.dart';
import 'package:yg_app/model/response/stocklot_repose/stocklot_specification_response.dart';
import 'package:yg_app/model/response/stocklot_repose/stocklot_sync/stocklot_sync_response.dart';

import '../../app_database/app_database_instance.dart';
import '../../elements/list_widgets/single_select_tile_widget.dart';
import '../../helper_utils/ui_utils.dart';
import '../../model/request/stocklot_request/stocklot_request.dart';
import '../../model/response/common_response_models/unit_of_count.dart';
import '../../model/response/family_data.dart';
import '../../model/stocklot_waste_model.dart';

class StocklotProvider extends ChangeNotifier {
  //Keys
  final GlobalKey<SingleSelectTileWidgetState> stocklotKey =
      GlobalKey<SingleSelectTileWidgetState>();
  final GlobalKey<SingleSelectTileWidgetState> categoryKey =
      GlobalKey<SingleSelectTileWidgetState>();
  final GlobalKey<SingleSelectTileWidgetState> subCategoryKey =
      GlobalKey<SingleSelectTileWidgetState>();

  final GlobalKey<SingleSelectTileRenewedWidgetState> categoryListLocalKey =
  GlobalKey<SingleSelectTileRenewedWidgetState>();
  GlobalKey<SingleSelectTileRenewedWidgetState> subFamilyKey =
  GlobalKey<SingleSelectTileRenewedWidgetState>();

  List<StockLotFamily> stocklotAllCategories = [];
  List<StockLotFamily>? stocklots = [];
  List<StockLotFamily>? stocklotCategories = [];
  List<StockLotFamily>? stocklotAllSubcategories = [];
  List<StockLotFamily>? stocklotSubcategories = [];
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
  int? categoryId = -1;
  int? subcategoryId = -1;
  int? selectedIndex = -1;
  bool expandStockLostWast = true;
  String apiError = "";
  List<PickedFile> imageFiles = [];
  var stocklotRequestModel = StocklotRequestModel();
  String? isOffering = "1";
  int selectedSubCategoryIndex = -1;
  bool showSubCategory = false;
  bool showCategory = false;
  String? unitName;
  GetStockLotSpecRequestModel getStockLotSpecRequestModel = GetStockLotSpecRequestModel();

  setUnitName(String name){
    unitName = name;
    notifyListeners();
  }


  setSubCatIndex(int value) {
    if (subCategoryKey.currentState != null) {
      subCategoryKey.currentState!.checkedTile = value;
    }
  }

  setCatIndex(int value) {
    if (categoryKey.currentState != null) {
      categoryKey.currentState!.checkedTile = value;
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

  Future<StockLotSpecificationResponse> getStockLots(requestModel) async{
    loading = true;
    notifyListeners();
    var response = await ApiService.getStockLotSpecifications(requestModel);
    StockLotSpecificationResponse specificationResponse = response;
    return specificationResponse;
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
    var dbInstance = await AppDbInstance().getDbInstance();
    stocklotAllCategories =
        await dbInstance.stocklotCategoriesDao.findAllStocklotCategories();
    stocklots = stocklotAllCategories
        .where((element) => element.stocklotFamilyParentId == null)
        .toList();
    stocklotAllSubcategories = await dbInstance.stocklotCategoriesDao.findAllStocklotCategories();
    unitsList = await dbInstance.unitDao.findAllUnit();
    priceTermsList =
        await dbInstance.priceTermsDao.findYarnFPriceTermsWithCatId(5);
    countryList = await dbInstance.countriesDao.findAllCountries();
    availabilityList = await dbInstance.availabilityDao.findAllAvailability();
    if (stocklots != null) {
      getCategories(stocklots!.first.stocklotFamilyId.toString());
    }
    loading = false;
    notifyListeners();
  }

  createStockLot(context,Function pop) async {
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

        showGenericDialogCancel("Success", value.message.toString(), context,
            StylishDialogType.SUCCESS, "Close", () {

            },(){
              resetData();
              notifyListeners();
              pop();
            });

        // Ui.showSnackBar(context, value.message.toString());


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
        .where((element) => element.stocklotFamilyParentId == id)
        .toList();
    if (stocklotCategories != null) {
      getSubcategories(stocklotCategories!.first.stocklotFamilyId.toString());
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
        .where((element) => element.stocklotFamilyParentId == id)
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
    categoryId = -1;
    subcategoryId = -1;
    expandStockLostWast = true;
    imageFiles = [];
    setShowCategory(true);
    setShowSubCategory(true);
    setSubCatIndex(-1);
    setCatIndex(-1);
    stocklotRequestModel.subcategoryId = null;
    setCatIndex(-1);
    setSubCatIndex(-1);
    stocklotRequestModel = StocklotRequestModel();
  }
}
