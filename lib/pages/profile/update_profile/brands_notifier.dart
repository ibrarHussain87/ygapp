import 'package:flutter/cupertino.dart';
import 'package:yg_app/model/response/common_response_models/brands_response.dart';


class UserBrandsNotifier extends ChangeNotifier{

  late List<UserBrands> userBrands;

  UserBrandsNotifier(this.userBrands);

  updateBrands(List<UserBrands> userBrandsNew){
    userBrands = userBrandsNew;
    notifyListeners();
  }

  getBrands(){
    return userBrands;
  }

}