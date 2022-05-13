import 'package:flutter/material.dart';
import 'package:yg_app/api_services/api_service_class.dart';
import 'package:yg_app/app_database/app_database_instance.dart';
import 'package:yg_app/helper_utils/app_constants.dart';
import 'package:yg_app/model/request/filter_request/filter_request.dart';
import 'package:yg_app/model/response/common_response_models/countries_response.dart';
import 'package:yg_app/model/response/fiber_response/fiber_specification.dart';
import 'package:yg_app/model/response/fiber_response/sync/sync_fiber_response.dart';

class FiberSpecificationProvider extends ChangeNotifier {
  List<FiberBlends> fiberBlends = [];
  List<FiberFamily> fiberFamily = [];
  bool isLoading = true;
  bool isSpecsLoaded = true;
  FiberSpecificationResponse? fiberSpecificationResponse;
  List<Countries> countries = [];
  String? locality;
  GetSpecificationRequestModel _getSpecificationRequestModel =
      GetSpecificationRequestModel();

  GetSpecificationRequestModel get getSpecificationRequestModel =>
      _getSpecificationRequestModel;

  set getSpecificationRequestModel(value) {
    _getSpecificationRequestModel = value;
    notifyListeners();
  }


  getCountries() async {
    isLoading = true;
    notifyListeners();
    AppDbInstance().getOriginsData().then((value) {
      countries = value;
      notifyListeners();
    });
  }

  getFiberDataFromDb() async {
    isLoading = true;
    notifyListeners();
    AppDbInstance().getDbInstance().then((value) async {
      await value.fiberFamilyDao.findAllFiberNatures().then((value) {
        fiberFamily = value;
      });
      await value.fiberBlendsDao
          .findFiberBlend(fiberFamily.first.fiberFamilyId)
          .then((value) {
        fiberBlends = value;
      });
      isLoading = false;
      notifyListeners();
    });
  }

  getFiberBlends(int id) async {
    isLoading = true;
    notifyListeners();
    AppDbInstance().getDbInstance().then((value) {
      value.fiberBlendsDao.findFiberBlend(id).then((value) {
        fiberBlends = value;
        isLoading = false;
        notifyListeners();
      });
    });
  }

  getUpdatedFiberSpecificationsData() async {
    var response = await ApiService.getFiberSpecifications(
        _getSpecificationRequestModel, locality);
    fiberSpecificationResponse = response;
    notifyListeners();
  }

  getFibers(String locality) async {
    _getSpecificationRequestModel.locality = locality;
    isSpecsLoaded = true;
    notifyListeners();
    var response = await ApiService.getFiberSpecifications(
        _getSpecificationRequestModel, locality);
    fiberSpecificationResponse = response;
    isSpecsLoaded = false;
    notifyListeners();
  }

}
