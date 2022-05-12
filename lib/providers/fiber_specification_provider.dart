import 'package:flutter/material.dart';
import 'package:yg_app/app_database/app_database.dart';
import 'package:yg_app/app_database/app_database_instance.dart';
import 'package:yg_app/model/response/fiber_response/sync/sync_fiber_response.dart';

class FiberSpecificationProvider extends ChangeNotifier {
  List<FiberBlends> fiberBlends = [];
  List<FiberFamily> fiberFamily = [];
  bool isLoading = true;

  getFiberDataFromDb() {
    AppDbInstance().getDbInstance().then((value) async {
      isLoading = true;
      await value.fiberFamilyDao.findAllFiberNatures().then((value) {
        fiberFamily = value;
      });
      await value.fiberBlendsDao.findFiberBlend(fiberFamily.first.fiberFamilyId).then((value) {
        fiberBlends = value;
      });
      isLoading = false;
      notifyListeners();
    });
  }

  getFiberBlends(int id){
    isLoading = true;
    AppDbInstance().getDbInstance().then((value) {
      value.fiberBlendsDao.findFiberBlend(id).then((value) {
        fiberBlends = value;
        isLoading = false;
        notifyListeners();
      });
    });
  }

}
