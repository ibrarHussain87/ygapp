

import 'package:flutter/cupertino.dart';
import 'package:yg_app/api_services/api_service_class.dart';
import 'package:yg_app/model/response/get_banner_response.dart';

import '../app_database/app_database_instance.dart';
import '../model/response/common_response_models/unit_of_count.dart';
import '../model/response/family_data.dart';
import '../model/response/sync/sync_response.dart';

class StocklotProvider extends ChangeNotifier{

  List<StocklotCategories>? stocklotAllCategories = [];
  List<StocklotCategories>? stocklots = [];
  List<StocklotCategories>? stocklotCategories = [];
  List<Stocklots>? stocklotAllSubcategories = [];
  List<StocklotCategories>? stocklotSubcategories = [];
  List<Units>? unitsList = [];
  bool loading = false;
  int startIndex = 0;

  getStocklotData() async{
    loading = true;
    stocklotAllCategories!.clear();
    stocklots!.clear();
    stocklotAllSubcategories!.clear();
    unitsList!.clear();
    var dbInstance = await AppDbInstance.getDbInstance();
    stocklotAllCategories = await dbInstance.stocklotCategoriesDao.findAllStocklotCategories();
    stocklots = stocklotAllCategories!.where((element) => element.parentId == null).toList();
    stocklotAllSubcategories = await dbInstance.stocklotDao.findAllStocklots();
    unitsList = await dbInstance.unitDao.findAllUnit();
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
    stocklotSubcategories = stocklotAllCategories!.where((element) => element.parentId == id).toList();
    notifyListeners();
  }

}