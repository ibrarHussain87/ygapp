import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yg_app/app_database/app_database_instance.dart';
import 'package:yg_app/elements/list_widgets/cat_with_image_listview_widget.dart';
import 'package:yg_app/elements/list_widgets/single_select_tile_widget.dart';
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
  late PageController pageController;
  late List<Widget> samplePages;
  int selectedValue = 0;

  final GlobalKey<BlendsWithImageListWidgetState> blendWidgetKey = GlobalKey();
  final GlobalKey<BlendsWithImageListWidgetState> blendListWidgetKey = GlobalKey();
  final GlobalKey<SingleSelectTileWidgetState> gradeWidgetKey = GlobalKey();
  final GlobalKey<SingleSelectTileWidgetState> appearanceWidgetKey = GlobalKey();
  final GlobalKey<SingleSelectTileWidgetState> certificationWidgetKey = GlobalKey();
  final TextEditingController textEditingController = TextEditingController();
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

  resetData() {
    if(gradeWidgetKey.currentState!=null)gradeWidgetKey.currentState!.checkedTile = -1;
    if(appearanceWidgetKey.currentState!=null)appearanceWidgetKey.currentState!.checkedTile = -1;
    if(certificationWidgetKey.currentState!=null)certificationWidgetKey.currentState!.checkedTile = -1;
    createRequestModel.spc_grade_idfk = null;
    createRequestModel.spc_appearance_idfk = null;
    createRequestModel.spc_certificate_idfk = null;
    createRequestModel.spc_lot_number = null;
    createRequestModel.spc_brand_idfk = null;
    createRequestModel.spc_gpt_idfk = null;
    createRequestModel.spc_rd_idfk = null;
    createRequestModel.spc_trash_idfk = null;
    createRequestModel.spc_micronaire_idfk = null;
    createRequestModel.spc_moisture_idfk = null;
    createRequestModel.spc_production_year = null;
    createRequestModel.spc_nature_idfk = null;
    createRequestModel.spc_fiber_family_idfk = null;
    createRequestModel.spc_origin_idfk = null;
    textEditingController.text = "";
  }
}
