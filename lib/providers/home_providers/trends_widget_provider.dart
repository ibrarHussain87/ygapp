import 'package:flutter/material.dart';
import 'package:yg_app/app_database/app_database_instance.dart';
import 'package:yg_app/model/pre_login_response.dart';

class TrendsWidgetProvider extends ChangeNotifier {
  List<AlertBars> alertBarsList = [];

  getAlertBars() async {
    var dbInstance = await AppDbInstance().getDbInstance();
    alertBarsList = await dbInstance.alertBarDao.findAllAlertBars();
    notifyListeners();
  }
}
