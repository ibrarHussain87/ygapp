
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:yg_app/helper_utils/dialog_builder.dart';

import '../../api_services/api_service_class.dart';
import '../../app_database/app_database_instance.dart';
import '../../helper_utils/app_constants.dart';
import '../../helper_utils/shared_pref_util.dart';

class PreLoginSyncProvider extends ChangeNotifier {

  bool isDataSynced = false;
  bool loading = false;

  syncAppData(context) async {
      DialogBuilder(context,title: "Syncing Please wait ...").showLoadingDialog();
      loading = true;
      isDataSynced = await synData();
      loading = false;
      DialogBuilder(context).hideDialog();
      notifyListeners();
  }

  Future<bool> synData() async {
    bool dataSynced = await SharedPreferenceUtil.getBoolValuesSF(PRE_LOGIN_SYNCED_KEY);
    Logger().e(dataSynced.toString());
    if (!dataSynced) {
      await Future.wait([
        ApiService().preLoginSyncCall().then((
            syncResponse) {
          if(syncResponse.success != null){
            if (syncResponse.success!) {
              AppDbInstance().getDbInstance().then((value) async {
                await Future.wait([
                  value.genericCategoriesDao.insertAllGenericCategories(syncResponse.data!.categories!),
                  value.brandsDao.insertAllBrands(syncResponse.data!.brands!),
                  value.countriesDao.insertAllCountry(syncResponse.data!.countries!),
                  value.statesDao.insertAllStates(syncResponse.data!.states!),
                  value.citiesDao.insertAllCities(syncResponse.data!.cities!),
                  value.companiesDao.insertAllCompanies(syncResponse.data!.companies!),
                  value.designationsDao.insertAllDesignations(syncResponse.data!.designations!),
                  value.portsDao.insertAllPorts(syncResponse.data!.ports!),
                  value.paymentTypeDao.insertAllPaymentType(syncResponse.data!.paymentTypes!),
                  value.subscriptionPlansDao.insertAllSubscriptionPlans(syncResponse.data!.subscriptionPlans!),
                  value.serviceTypesDao.insertAllServiceTypes(syncResponse.data!.serviceTypes!),
                  value.customerSupportTypesDao.insertAllCustomerSupportTypes(syncResponse.data!.customerSupportTypes!),
                ]
                );
              });
            }
          }else{
            if(syncResponse.message != null){
              toast(syncResponse.message!);
            }else{
              toast('Something went wrong. Please try again later');
            }
          }
        }),

      ]);
      SharedPreferenceUtil.addBoolToSF(PRE_LOGIN_SYNCED_KEY, true);
    }
    return true;
  }

}