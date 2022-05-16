import 'package:flutter/material.dart';
import 'package:yg_app/app_database/app_database_instance.dart';
import 'package:yg_app/elements/list_widgets/cat_with_image_listview_widget.dart';
import 'package:yg_app/helper_utils/app_constants.dart';
import 'package:yg_app/model/request/post_ad_request/create_request_model.dart';
import 'package:yg_app/model/response/common_response_models/brands_response.dart';
import 'package:yg_app/model/response/common_response_models/certification_response.dart';
import 'package:yg_app/model/response/common_response_models/city_state_response.dart';
import 'package:yg_app/model/response/common_response_models/countries_response.dart';
import 'package:yg_app/model/response/common_response_models/grade.dart';
import 'package:yg_app/model/response/fiber_response/sync/fiber_apperance.dart';
import 'package:yg_app/model/response/fiber_response/sync/sync_fiber_response.dart';

class PostFiberProvider extends ChangeNotifier {
  CreateRequestModel createRequestModel = CreateRequestModel();
  late List<FiberBlends> fiberBlendsList;
  late List<FiberFamily> fiberFamilyList;
  bool isLoading = true;
  bool isSettingLoaded = false;
  late String selectedFamilyId;

  final GlobalKey<BlendsWithImageListWidgetState> blendWidgetKey = GlobalKey();
  final GlobalKey<BlendsWithImageListWidgetState> blendListWidgetKey = GlobalKey();

  List<FiberAppearance> fiberAppearanceList= [];
  List<Grades> fiberGradesList = [];
  List<Brands> brandsList = [];
  List<Countries> countries = [];
  List<CityState> citySateList = [];
  List<Certification> certificationList = [];

  late FiberSettings fiberSettings;

  String? _selectedBlendId;
  String get selectedBlendId => _selectedBlendId!;
  set selectedBlendId(String value){
    _selectedBlendId = value;
  }



  getFiberSyncedData() {
    isLoading = true;
    AppDbInstance().getDbInstance().then((value) async {
      await value.fiberFamilyDao
          .findAllFiberNatures()
          .then((family) => fiberFamilyList = family);
      selectedFamilyId = fiberFamilyList.first.fiberFamilyId.toString();
      await value.fiberBlendsDao
          .findFiberBlend(fiberFamilyList.first.fiberFamilyId)
          .then((blends) => fiberBlendsList = blends);
      selectedBlendId = fiberBlendsList.first.blnId.toString();

      isLoading = false;
      notifyListeners();
    });
  }

  getFiberBlends(int id) {
    isLoading = true;
    selectedFamilyId = id.toString();
    AppDbInstance().getDbInstance().then((value) {
      value.fiberBlendsDao.findFiberBlend(id).then((value) {
        fiberBlendsList = value;
        isLoading = false;
        notifyListeners();
      });
    });
  }

  getFiberAllSyncedData() {
    isLoading = true;
    AppDbInstance().getDbInstance().then((value) async {
      await value.fiberBlendsDao
          .findFiberBlend(int.parse(selectedFamilyId))
          .then((value) {
        fiberBlendsList = value;
      });
      selectedBlendId = fiberBlendsList.first.blnId.toString();
      await value.fiberAppearanceDoa.findAllFiberAppearance().then((value) {
        fiberAppearanceList = value;
      });

      await value.gradesDao.findAllGrades().then((value) {
        fiberGradesList = value;
      });

      await value.brandsDao.findAllBrands().then((value) {
        brandsList = value;
      });

      await value.countriesDao.findAllCountries().then((value) {
        countries = value;
      });

      await value.cityStateDao.findAllCityState().then((value) {
        citySateList = value;
      });
      await value.certificationDao.findAllCertifications().then((value) {
        certificationList = value;
      });
      isLoading = false;
      notifyListeners();
    });

  }

  fiberSettingSelectedBlend(){
    isLoading = true;
    AppDbInstance().getDbInstance().then((value) async{
      fiberSettings = (await value.fiberSettingDao.findFiberSettings(int.parse(selectedBlendId)))!;
      isLoading = false;
      notifyListeners();
    });
  }
}
