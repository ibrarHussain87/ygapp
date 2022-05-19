

import 'package:flutter/cupertino.dart';
import 'package:yg_app/api_services/api_service_class.dart';
import 'package:yg_app/model/response/get_banner_response.dart';

class BannersProvider extends ChangeNotifier{

  BannerData bannerData = BannerData();
  bool loading = false;

  getBannerData() async{
    loading = true;
    var response = await ApiService.getBanners();
    bannerData = response.data;
    loading = false;
    notifyListeners();
  }

}