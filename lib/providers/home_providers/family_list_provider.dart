import 'package:flutter/material.dart';

import '../../app_database/app_database_instance.dart';
import '../../model/response/family_data.dart';

class FamilyListProvider extends ChangeNotifier {
  List<FamilyData>? familyList = [];
  bool loading = false;

  getFamilyListData() async {
    loading = true;
    familyList!.clear();
    var dbInstance = await AppDbInstance().getDbInstance();
    var fiberList = await dbInstance.fiberBlendsDao.findAllFiberBlends();
    var yarnList = await dbInstance.yarnBlendDao.allYarnBlends();
    if (fiberList.isNotEmpty && fiberList.length >= 4) {
      fiberList = fiberList.take(4).toList();
      for (var element in fiberList) {
        familyList!.add(FamilyData(element.blnId!, element.iconSelected ?? "",
            element.iconUnselected!, element.blnName ?? ""));
      }
    }

    if (yarnList.isNotEmpty && yarnList.length >= 4) {
      yarnList = yarnList.take(4).toList()..shuffle();
      for (var element in yarnList) {
        familyList!.add(FamilyData(
            element.blnId!,
            element.iconSelected ?? "",
            element.iconUnselected ?? "",
            element.blnName ?? element.bln_abrv2 ?? ""));
      }
    }
    loading = false;
    notifyListeners();
  }
}
