

import 'package:flutter/cupertino.dart';
import 'package:yg_app/api_services/api_service_class.dart';
import 'package:yg_app/model/response/common_response_models/brands_response.dart';
import 'package:yg_app/model/response/get_banner_response.dart';

import '../../../app_database/app_database_instance.dart';
import '../../../model/response/family_data.dart';

class UserBrandsProvider extends ChangeNotifier{

  List<UserBrands>? brandsList = [];
  bool loading = false;

  getUserBrandsData() async{
    loading = true;
    brandsList!.clear();
    var dbInstance = await AppDbInstance().getDbInstance();
    brandsList = await dbInstance.userBrandsDao.findAllUserBrands();
    loading = false;
    notifyListeners();
  }

}