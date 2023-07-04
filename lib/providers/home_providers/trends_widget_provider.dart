import 'package:flutter/material.dart';
import 'package:yg_app/app_database/app_database_instance.dart';
import 'package:yg_app/model/pre_login_response.dart';

import '../../model/response/common_response_models/commodity_rates_response.dart';

class TrendsWidgetProvider extends ChangeNotifier {
  List<AlertBars> alertBarsList = [];
  List<CommodityRates> commodityRatesList = [];

  getAlertBars() async {
    var dbInstance = await AppDbInstance().getDbInstance();
    alertBarsList = await dbInstance.alertBarDao.findAllAlertBars();
    notifyListeners();
  }

  getCommodityRates() async {
    var dbInstance = await AppDbInstance().getDbInstance();
    commodityRatesList = await dbInstance.commodityRatesDao.findAllCommodityRates();
    notifyListeners();
  }
}
