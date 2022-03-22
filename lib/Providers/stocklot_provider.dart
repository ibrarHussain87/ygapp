

import 'package:flutter/cupertino.dart';
import 'package:yg_app/api_services/api_service_class.dart';
import 'package:yg_app/model/response/common_response_models/countries_response.dart';
import 'package:yg_app/model/response/common_response_models/price_term.dart';
import 'package:yg_app/model/response/get_banner_response.dart';

import '../app_database/app_database_instance.dart';
import '../model/response/common_response_models/unit_of_count.dart';
import '../model/response/family_data.dart';
import '../model/response/sync/sync_response.dart';
import '../model/stocklot_waste_model.dart';

class StocklotProvider extends ChangeNotifier{

  List<StocklotCategories>? stocklotAllCategories = [];
  List<StocklotCategories>? stocklots = [];
  List<StocklotCategories>? stocklotCategories = [];
  List<Stocklots>? stocklotAllSubcategories = [];
  List<StocklotCategories>? stocklotSubcategories = [];
  List<Units>? unitsList = [];
  List<FPriceTerms>? priceTermsList = [];
  List<Countries>? countryList = [];
  List<StocklotWasteModel>? stocklotWasteList = [];
  List<StocklotWasteModel>? filteredStocklotWasteList = [];
  bool loading = false;
  bool ignoreClick = false;
  int selectedSubCategoryId = -1;

  getStocklotData() async{
    loading = true;
    stocklotAllCategories!.clear();
    stocklots!.clear();
    stocklotAllSubcategories!.clear();
    unitsList!.clear();
    priceTermsList!.clear();
    countryList!.clear();
    stocklotWasteList!.clear();
    ignoreClick = false;
    var dbInstance = await AppDbInstance.getDbInstance();
    stocklotAllCategories = await dbInstance.stocklotCategoriesDao.findAllStocklotCategories();
    stocklots = stocklotAllCategories!.where((element) => element.parentId == null).toList();
    stocklotAllSubcategories = await dbInstance.stocklotDao.findAllStocklots();
    unitsList = await dbInstance.unitDao.findAllUnit();
    priceTermsList = await dbInstance.priceTermsDao.findAllFPriceTerms();
    countryList = await dbInstance.countriesDao.findAllCountries();
    if(stocklots != null){
      getCategories(stocklots!.first.id.toString());
    }
    loading = false;
    notifyListeners();
  }

  getCategories(String id)async{
    stocklotCategories!.clear();
    stocklotCategories = stocklotAllCategories!.where((element) => element.parentId == id).toList();
    if(stocklotCategories != null){
      getSubcategories(stocklotCategories!.first.id.toString());
    }
    notifyListeners();
  }

  getSubcategories(String id)async{
    stocklotSubcategories!.clear();
    stocklotWasteList!.clear();
    selectedSubCategoryId = -1;
    stocklotSubcategories = stocklotAllCategories!.where((element) => element.parentId == id).toList();
    notifyListeners();
  }

  addStocklotWaste(StocklotWasteModel stocklotWasteModel){
    if(stocklotWasteList!.isNotEmpty){
      var index = stocklotWasteList!.indexWhere((element) => element.id == stocklotWasteModel.id);
      if(index >-1){
        stocklotWasteList![index] = stocklotWasteModel;
      }else{
        stocklotWasteList!.add(stocklotWasteModel);
      }
    }else{
      stocklotWasteList!.add(stocklotWasteModel);
    }
    if(selectedSubCategoryId != -1){
      filteredStocklotWasteList!.clear();
     // filteredStocklotWasteList = stocklotWasteList!.where((element) => element.id == selectedSubCategoryId.toString()).toList();
      filteredStocklotWasteList = stocklotWasteList!.toList();
    }
    notifyListeners();
  }

  removeStockWaste(StocklotWasteModel stocklotWasteModel){
    stocklotWasteList!.remove(stocklotWasteModel);
    filteredStocklotWasteList = stocklotWasteList!.toList();
    if(filteredStocklotWasteList!.isEmpty){
      ignoreClick = false;
    }
    notifyListeners();
  }

  getFilteredStocklotWaste(int id){
    selectedSubCategoryId = id;
    filteredStocklotWasteList!.clear();
   // filteredStocklotWasteList = stocklotWasteList!.where((element) => element.id == selectedSubCategoryId.toString()).toList();
    filteredStocklotWasteList = stocklotWasteList!.toList();
    notifyListeners();
  }

  disableClick(){
    ignoreClick = true;
    notifyListeners();
  }

}