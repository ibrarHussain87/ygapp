import 'package:flutter/material.dart';
import 'package:yg_app/api_services/api_service_class.dart';
import 'package:yg_app/app_database/app_database_instance.dart';
import 'package:yg_app/helper_utils/ui_utils.dart';
import 'package:yg_app/helper_utils/util.dart';
import 'package:yg_app/model/request/filter_request/filter_request.dart';
import 'package:yg_app/model/response/common_response_models/certification_response.dart';
import 'package:yg_app/model/response/common_response_models/countries_response.dart';
import 'package:yg_app/model/response/common_response_models/grade.dart';
import 'package:yg_app/model/response/common_response_models/packing_response.dart';
import 'package:yg_app/model/response/fiber_response/fiber_specification.dart';
import 'package:yg_app/model/response/fiber_response/sync/fiber_apperance.dart';
import 'package:yg_app/model/response/fiber_response/sync/sync_fiber_response.dart';

import '../../elements/list_widgets/cat_with_image_listview_widget.dart';

class FiberSpecificationProvider extends ChangeNotifier {
  bool isLoading = true;
  bool isFilterPageLoading = true;
  FiberSpecificationResponse? fiberSpecificationResponse;

  List<FiberBlends> fiberBlends = [];
  List<FiberFamily> fiberFamily = [];
  List<Countries> countries = [];
  List<FiberAppearance>? fiberAppearances;
  List<Grades>? fiberGrades;
  List<Certification>? fiberCertifications;
  List<Packing>? fiberPacking;
  List<FiberSettings>? listOfSettings;
  List<int> listOfMaterials = [];
  List<int> listOfGrades = [];
  List<double> listOfMic = [];
  List<double> listOfMos = [];
  List<double> listOfRd = [];
  List<double> listOfGpt = [];
  List<int> listOfAppearance = [];
  List<int> listOfCertification = [];
  List<int> listOfPacking = [];

  String? locality;

  final GlobalKey<BlendsWithImageListWidgetState> blendWidgetKey =
      GlobalKey<BlendsWithImageListWidgetState>();

  final GlobalKey<BlendsWithImageListWidgetState> filterBlendWidgetKey =
  GlobalKey<BlendsWithImageListWidgetState>();


  GetSpecificationRequestModel _specificationRequestModel =
      GetSpecificationRequestModel();

  GetSpecificationRequestModel get specificationRequestModel =>
      _specificationRequestModel;

  set specificationRequestModel(value) {
    _specificationRequestModel = value;
    notifyListeners();
  }

  //Filter page configrations Variables
  bool? showLength;
  bool? showGrade;
  bool? showMicronaire;
  bool? showMoisture;
  bool? showTrash;
  bool? showRd;
  bool? showGpt;
  bool? showAppearance;
  bool? showBrand;
  bool? showOrigin;
  bool? showCertification;
  bool? showCountUnit;
  bool? showDeliveryPeriod;
  bool? showAvailableForMarket;
  bool? showPriceTerms;
  bool? showLotNumber;

  double? micValue;
  double? moisValue;
  double? rdValue;
  double? gptValue;
  double minMois = 0.0;
  double minRd = 0.0;
  double minTrash = 0.0;
  double minMic = 0.0;
  double minGpt = 0.0;
  double maxMois = 0.0;
  double maxRd = 0.0;
  double maxTrash = 0.0;
  double maxMic = 0.0;
  double maxGpt = 0.0;

  bool isListClear = false;

  querySetting(int id) async {
    var appDbInstance = await AppDbInstance().getDbInstance();
    var fiberSetting =
        await appDbInstance.fiberSettingDao.findFiberSettings(id);

    late bool isSettingInList;
    late FiberSettings _fiberSettings;

    if (!isListClear) {
      listOfSettings!.clear();
      isListClear = false;
    }
    if (listOfSettings!.isNotEmpty) {
      for (var element in listOfSettings!) {
        _fiberSettings = fiberSetting!;

        if (element.fbsFiberFamilyIdfk == _fiberSettings.fbsFiberFamilyIdfk) {
          isSettingInList = true;
          break;
        } else {
          isSettingInList = false;
        }
      }

      isSettingInList
          ? listOfSettings!.removeWhere((element) =>
              element.fbsFiberFamilyIdfk == _fiberSettings.fbsFiberFamilyIdfk)
          // ? listOfSettings.toSet().toList()
          : listOfSettings!.add(_fiberSettings);
    } else {
      listOfSettings!.add(fiberSetting!);
    }
    _minMaxConfiguration();
    _showHideConfiguration();
  }

  _minMaxConfiguration() {
    for (var element in listOfSettings!) {
      _setMinMaxConfiguration(element);
    }
  }

  _setMinMaxConfiguration(FiberSettings element) {

    //Mic Min Max
    if(element.micMinMax != null) {
      if (Utils.splitMin(element.micMinMax) > minMic) {
        minMic = Utils.splitMin(element.micMinMax);
      }
      if (Utils.splitMax(element.micMinMax) > maxMic) {
        maxMic = Utils.splitMax(element.micMinMax);
      }
    }

    // Moisture min max
    if(element.moiMinMax != null) {
      if (Utils.splitMin(element.moiMinMax) > minMois) {
        minMois = Utils.splitMin(element.moiMinMax);
      }
      if (Utils.splitMax(element.moiMinMax) > maxMois) {
        maxMois = Utils.splitMax(element.moiMinMax);
      }
    }

    //RD min max
    if(element.rdMinMax != null) {
      if (Utils.splitMin(element.rdMinMax) > minRd) {
        minRd = Utils.splitMin(element.rdMinMax);
      }
      if (Utils.splitMax(element.rdMinMax) > maxRd) {
        maxRd = Utils.splitMax(element.rdMinMax);
      }
    }

    //GPT min max
    if(element.gptMinMax != null) {
      if (Utils.splitMin(element.gptMinMax) > minGpt) {
        minGpt = Utils.splitMin(element.gptMinMax);
      }
      if (Utils.splitMax(element.gptMinMax) > maxGpt) {
        maxGpt = Utils.splitMax(element.gptMinMax);
      }
    }

    //TRASH min max
    if(element.trashMinMax != null) {
      if (Utils.splitMin(element.trashMinMax) > minTrash) {
        minTrash = Utils.splitMin(element.trashMinMax);
      }
      if (Utils.splitMax(element.trashMinMax) > maxTrash) {
        maxTrash = Utils.splitMax(element.trashMinMax);
      }
    }
  }

  _showHideConfiguration() {
    bool? tempShowGrade;
    bool? tempShowMic;
    bool? tempShowMos;
    bool? tempShowRd;
    bool? tempShowAppearance;
    bool? tempShowOrigin;
    bool? tempShowCertification;

    if (listOfSettings!.isNotEmpty) {
      for (var element in listOfSettings!) {
        // setState(() {
        tempShowGrade = tempShowGrade == null
            ? Ui.showHide(element.showGrade)
            : (showGrade! && Ui.showHide(element.showGrade) && tempShowGrade)
                ? true
                : false;

        tempShowMic = tempShowMic == null
            ? Ui.showHide(element.showMicronaire)
            : (showMicronaire! &&
                    Ui.showHide(element.showMicronaire) &&
                    tempShowMic)
                ? true
                : false;

        tempShowMos = tempShowMos == null
            ? Ui.showHide(element.showMoisture)
            : (showMoisture! &&
                    Ui.showHide(element.showMoisture) &&
                    tempShowMos)
                ? true
                : false;

        tempShowRd = tempShowRd == null
            ? Ui.showHide(element.showRd)
            : (showRd! && Ui.showHide(element.showRd) && tempShowRd)
                ? true
                : false;

        tempShowAppearance = tempShowAppearance == null
            ? Ui.showHide(element.showAppearance)
            : (showAppearance! &&
                    Ui.showHide(element.showAppearance) &&
                    tempShowAppearance)
                ? true
                : false;

        tempShowOrigin = tempShowOrigin == null
            ? Ui.showHide(element.showOrigin)
            : (showOrigin! && Ui.showHide(element.showOrigin) && tempShowOrigin)
                ? true
                : false;

        tempShowCertification = tempShowCertification == null
            ? Ui.showHide(element.showCertification)
            : (showCertification! &&
                    Ui.showHide(element.showCertification) &&
                    tempShowCertification)
                ? true
                : false;

        // });
      }

      showGrade = tempShowGrade;
      showMicronaire = tempShowMic;
      showMoisture = tempShowMos;
      showCertification = tempShowCertification;
      showAppearance = tempShowAppearance;
      showOrigin = tempShowOrigin;
      showRd = tempShowRd;
    } else {
      showGrade = null;
      showMicronaire = null;
      showLength = null;
      showMoisture = null;
      showTrash = null;
      showRd = null;
      showGpt = null;
      showAppearance = null;
      showBrand = null;
      showOrigin = null;
      showCertification = null;
      showCountUnit = null;
      showDeliveryPeriod = null;
      showAvailableForMarket = null;
      showPriceTerms = null;
      showLotNumber = null;
    }
    notifyListeners();
  }

  getFiberSyncDataForFilter() async {
    isFilterPageLoading = true;
    var dbInstance = await AppDbInstance().getDbInstance();
    List<FiberFamily> fiberFamily = await dbInstance.fiberFamilyDao.findAllFiberNatures();
    List<FiberBlends> fiberBlends =
        await dbInstance.fiberBlendsDao.findFiberBlendWithNature(fiberFamily.first.fiberFamilyId);
    var fiberGrades = await dbInstance.gradesDao.findGradeWithCatId(1);
    var countries = await dbInstance.countriesDao.findAllCountries();
    var fiberAppearance =
        await dbInstance.fiberAppearanceDoa.findAllFiberAppearance();
    var fiberCertifications =
        await dbInstance.certificationDao.findAllCertifications();
    var fiberPacking = await dbInstance.packingDao.findYarnPackingWithCatId(1);
    var fiberSettings = await dbInstance.fiberSettingDao.findFiberSettings(fiberBlends.first.blnId!);
    this.fiberFamily = fiberFamily;
    fiberBlends = fiberBlends;
    this.fiberGrades = fiberGrades;
    this.countries = countries;
    this.fiberAppearances = fiberAppearance;
    this.fiberCertifications = fiberCertifications;
    this.fiberPacking = fiberPacking;
    this.listOfSettings = [fiberSettings!];
    isFilterPageLoading = false;
    _minMaxConfiguration();
    _showHideConfiguration();
  }

  fiberSyncDataForMarketPage() async {
    isLoading = true;
    notifyListeners();
    var dbInstance = await AppDbInstance().getDbInstance();
    var fiberFamily = await dbInstance.fiberFamilyDao.findAllFiberNatures();
    this.fiberFamily = fiberFamily;
    var fiberBlends = await dbInstance.fiberBlendsDao
        .findFiberBlend(fiberFamily.first.fiberFamilyId);
    this.fiberBlends = fiberBlends;
    var countries = await dbInstance.countriesDao.findAllCountries();
    this.countries = countries;
    isLoading = false;
    notifyListeners();
  }

  getFiberBlends(int id) async {
    isLoading = true;
    notifyListeners();
    var dbInstance = await AppDbInstance().getDbInstance();
    var fiberBlends = await dbInstance.fiberBlendsDao.findFiberBlend(id);
    this.fiberBlends = fiberBlends;
    isLoading = false;
    notifyListeners();
  }

  getUpdatedFiberSpecificationsData() async {
    var response = await ApiService.getFiberSpecifications(
        _specificationRequestModel, locality);
    fiberSpecificationResponse = response;
    notifyListeners();
  }

  Future<FiberSpecificationResponse> getFibers(String locality) async {
    _specificationRequestModel.locality = locality;
    specificationRequestModel.categoryId = "1";
    var response = await ApiService.getFiberSpecifications(
        _specificationRequestModel, locality);
    fiberSpecificationResponse = response;
    return response;
  }

  onClickFamily(FiberFamily value) {
    specificationRequestModel.spcFiberFamilyIdfk =
        value.fiberFamilyId.toString();
    specificationRequestModel.ysBlendIdFk = null;
    getFiberBlends(value.fiberFamilyId);
  }

  notifyUI() {
    notifyListeners();
  }
}
