import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stylish_dialog/stylish_dialog.dart';
import 'package:yg_app/api_services/api_service_class.dart';
import 'package:yg_app/app_database/app_database_instance.dart';
import 'package:yg_app/elements/list_widgets/single_select_tile_widget.dart';
import 'package:yg_app/helper_utils/dialog_builder.dart';
import 'package:yg_app/helper_utils/progress_dialog_util.dart';
import 'package:yg_app/helper_utils/ui_utils.dart';
import 'package:yg_app/model/request/stocklot_request/stocklot_request.dart';
import 'package:yg_app/model/response/common_response_models/countries_response.dart';
import 'package:yg_app/model/response/common_response_models/ports_response.dart';
import 'package:yg_app/model/response/common_response_models/price_term.dart';
import 'package:yg_app/model/response/common_response_models/unit_of_count.dart';
import 'package:yg_app/model/response/stocklot_repose/stocklot_specification_response.dart';
import 'package:yg_app/model/response/stocklot_repose/stocklot_sync/stocklot_sync_response.dart';
import 'package:yg_app/model/stocklot_waste_model.dart';

class PostStockLotProvider extends ChangeNotifier {
  final GlobalKey<SingleSelectTileWidgetState> stocklotKey =
      GlobalKey<SingleSelectTileWidgetState>();
  final GlobalKey<SingleSelectTileWidgetState> categoryKey =
      GlobalKey<SingleSelectTileWidgetState>();
  final GlobalKey<SingleSelectTileWidgetState> fabricSubCatKey =
      GlobalKey<SingleSelectTileWidgetState>();
  final GlobalKey<SingleSelectTileWidgetState> subCategoryKey =
      GlobalKey<SingleSelectTileWidgetState>();

  bool isLoading = false;
  bool ignoreClick = false;
  bool expandStockLostWast = true;
  int selectedSubCategoryId = -1;
  int subcategoryId = -1;
  List<PickedFile> imageFiles = [];
  var stocklotRequestModel = StocklotRequestModel();

  List<StocklotWasteModel>? stocklotWasteList = [];
  List<StocklotWasteModel>? filteredStocklotWasteList = [];
  List<StockLotSpecification> listStockLotSpec = [];
  List<StockLotSpecification> localSpecList = [];
  List<StockLotSpecification> internationSpecList = [];

  List<StockLotFamily> stockLotFamily = [];
  List<StockLotFamily> stockLotCategories = [];
  List<StockLotFamily> stockLotSubCategories = [];
  List<StockLotFamily> fabricLeftOverSubCategories = [];

  List<Units>? unitsList = [];
  List<FPriceTerms> priceTermsList = [];
  List<Countries>? countryList = [];
  List<Ports>? portsList = [];

  getStockLotSyncData(String locality) async {
    isLoading = true;
    stocklotWasteList!.clear();
    var dbInstance = await AppDbInstance().getDbInstance();
    stockLotFamily =
        await dbInstance.stocklotCategoriesDao.findParentStocklot();
    unitsList = await dbInstance.unitDao.findAllUnit();
    priceTermsList = await dbInstance.priceTermsDao
        .findYarnFPriceTermsWithCatIdLocality(5, locality);
    countryList = await dbInstance.countriesDao.findAllCountries();
    isLoading = false;
    notifyListeners();
  }

  getStockLotFamilyData() async {
    var dbInstance = await AppDbInstance().getDbInstance();
    stockLotFamily =
        await dbInstance.stocklotCategoriesDao.findParentStocklot();
    notifyListeners();
  }

  getStockLotCategoryData(int id) async {
    var dbInstance = await AppDbInstance().getDbInstance();
    stockLotCategories =
        await dbInstance.stocklotCategoriesDao.findStocklotCategories(id);
    notifyListeners();
  }

  getStockLotSubCategoryData(int id) async {
    var dbInstance = await AppDbInstance().getDbInstance();
    stockLotSubCategories =
        await dbInstance.stocklotCategoriesDao.findStocklotCategories(id);
    notifyListeners();
  }

  getFabricLeftOverData(int id) async {
    var dbInstance = await AppDbInstance().getDbInstance();
    fabricLeftOverSubCategories =
        await dbInstance.stocklotCategoriesDao.findStocklotCategories(id);
    if (fabricLeftOverSubCategories.isEmpty) {
      stocklotRequestModel.stocklot_fabric_leftover_idfk = null;
    }
    notifyListeners();
  }

  getSelectCountryPortList(int conId) async {
    var dbInstance = await AppDbInstance().getDbInstance();
  }

  createStockLot(context, Function pop) async {
    isLoading = true;
    notifyListeners();
    if (isLoading) {
      ProgressDialogUtil.showDialog(context, "Please wait...");
    }
    ApiService()
        .createStockLot(stocklotRequestModel,
            imageFiles.isNotEmpty ? imageFiles[0].path : "")
        .then((value) {
      if (value != null && value.status!) {
        isLoading = false;
        ProgressDialogUtil.hideDialog();

        showGenericDialogCancel("Success", value.message.toString(), context,
            StylishDialogType.SUCCESS, "Close", () {}, () {
          resetValues();
          notifyListeners();
          pop();
        });

        // Ui.showSnackBar(context, value.message.toString());

      }
    }, onError: (error) {
      isLoading = false;
      Ui.showSnackBar(context, error.toString());
      ProgressDialogUtil.hideDialog();
      notifyListeners();
    });
  }

  changeExpandStockLostWast() {
    if (expandStockLostWast) {
      expandStockLostWast = false;
      notifyListeners();
    } else {
      expandStockLostWast = true;
      notifyListeners();
    }
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

  //created by asad_m
  resetValues() {
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
    stockLotCategories = [];
    stockLotSubCategories = [];
    isLoading = false;
    ignoreClick = false;
    selectedSubCategoryId = -1;
    subcategoryId = -1;
    expandStockLostWast = true;
    imageFiles = [];
    stocklotRequestModel.subcategoryId = null;
    stocklotRequestModel = StocklotRequestModel();
  }

  disableClick() {
    ignoreClick = true;
    notifyListeners();
  }
}
