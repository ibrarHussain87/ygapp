

import 'package:flutter/cupertino.dart';
import 'package:yg_app/api_services/api_service_class.dart';
import 'package:yg_app/model/response/common_response_models/brands_response.dart';
import 'package:yg_app/model/response/get_banner_response.dart';

import '../../../app_database/app_database_instance.dart';
import '../../../model/response/family_data.dart';

class UserBrandsProvider extends ChangeNotifier{

  List<UserBrands> userBrandsList = [];
  List<Brands> allBrandsList = [];
  bool loading = false;

  getUserBrandsData() async{
    loading = true;
    notifyListeners();
    userBrandsList.clear();
    allBrandsList.clear();
    var dbInstance = await AppDbInstance().getDbInstance();
    userBrandsList = await dbInstance.userBrandsDao.findAllUserBrands();
    allBrandsList = await dbInstance.brandsDao.findAllBrands();
    _removeSelectedBrands(userBrandsList);
    loading = false;
    notifyListeners();
  }

  _removeSelectedBrands(List<UserBrands> tagModel)  {
    if (tagModel!=null && tagModel.isNotEmpty) {

      for(int i=0;i<tagModel.length;i++) {
        allBrandsList.removeWhere((item) => item.brdName.toString() == tagModel[i].brdName.toString());
      }

    }
  }

}