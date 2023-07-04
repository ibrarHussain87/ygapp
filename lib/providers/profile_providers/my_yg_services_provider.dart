
import 'package:flutter/material.dart';
import 'package:yg_app/api_services/api_service_class.dart';
import 'package:yg_app/model/response/yg_services/my_yg_services_response.dart';

import '../../helper_utils/connection_status_singleton.dart';
import '../../helper_utils/progress_dialog_util.dart';

class YgServicesProvider extends ChangeNotifier {
  List<MyYgServices>? myServices = [];
  bool loading = false;

  getServicesData(BuildContext context) async {
    check().then((value) {
      if (value) {
        loading = true;
        ProgressDialogUtil.showDialog(context, 'Please wait...');
        // Logger().e(_csRequestModel?.toJson());
        ApiService().myYgServices().then((value) {
          ProgressDialogUtil.hideDialog();
          if (value.status!) {
            myServices = value.data?.myYgServices;
            loading = false;
            notifyListeners();
          } else {
            loading = false;
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(value.message ?? "")));
          }
        }).onError((error, stackTrace) {
          loading = false;
          ProgressDialogUtil.hideDialog();
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(error.toString())));
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("No internet available.".toString())));
      }
    });
  }
}
