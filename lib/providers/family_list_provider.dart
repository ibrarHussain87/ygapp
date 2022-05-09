

import 'package:flutter/cupertino.dart';
import 'package:yg_app/api_services/api_service_class.dart';
import 'package:yg_app/model/response/get_banner_response.dart';

import '../app_database/app_database_instance.dart';
import '../model/response/family_data.dart';

class FamilyListProvider extends ChangeNotifier{

  List<FamilyData>? familyList = [];
  bool loading = false;

  getFamilyListData() async{
    loading = true;
    familyList!.clear();
    var dbInstance = await AppDbInstance.getDbInstance();
    var fiberList = await dbInstance.fiberMaterialDao.findAllFiberMaterials();
    var yarnList = await dbInstance.yarnFamilyDao.findAllYarnFamily();
    if(fiberList.isNotEmpty  && fiberList.length >= 4){
      fiberList = fiberList.take(4).toList();
      for (var element in fiberList) {
        familyList!.add(FamilyData(element.fbmId, element.icon_selected??"", element.icon_unselected!, element.fbmName!));
      }

    }

    if(yarnList.isNotEmpty && yarnList.length >= 4){
      yarnList = yarnList.take(4).toList()..shuffle();
      for (var element in yarnList) {
        familyList!.add(FamilyData(element.famId!, element.iconSelected!, element.iconUnSelected!, element.famName!));
      }
    }
    loading = false;
    notifyListeners();
  }

}