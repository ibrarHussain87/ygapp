import 'package:flutter/material.dart';
import 'package:yg_app/app_database/app_database_instance.dart';
import 'package:yg_app/helper_utils/ui_utils.dart';
import 'package:yg_app/helper_utils/util.dart';
import 'package:yg_app/model/request/filter_request/filter_request.dart';
import 'package:yg_app/model/response/common_response_models/certification_response.dart';
import 'package:yg_app/model/response/yarn_response/sync/yarn_grades.dart';
import 'package:yg_app/model/response/yarn_response/sync/yarn_sync_response.dart';

class YarnFilterProvider extends ChangeNotifier{

  bool isGetSyncedData = false;
  Family selectedYarnFamily = Family(
    famId: -1
  );

  List<Family>? familyList = [];
  List<Blends>? blendsList = [];
  List<Usage>? usageList = [];
  List<ColorTreatmentMethod>? colorTreatmentMethodList  = [];
  List<Ply>? plyList  = [];
  List<DoublingMethod>? doublingMethodList  = [];
  List<DyingMethod>? dyingMethodList  = [];
  List<OrientationTable>? orientationList  = [];
  // List<TwistDirection>? twistDirectionList;
  List<SpunTechnique>? spunTechList  = [];
  List<Quality>? qualityList  = [];
  List<PatternModel>? patternList  = [];
  List<PatternCharectristic>? patternCharList  = [];
  List<YarnGrades>? gradesList  = [];
  List<YarnAppearance>? appearanceList  = [];
  List<Certification>? certificationList  = [];
  List<YarnTypes>? yarnTypesList  = [];
  List<YarnSetting>? yarnSettingsList  = [];

  List<YarnSetting> listOfSettings = [];
  List<int> listOfMaterials = [];
  List<int> listOfYarnType = [];
  List<int> listOfPattern = [];
  List<int> listOfOrientation = [];
  List<int> listOfUsageId = [];
  List<int> listOfPlyId = [];
  List<int> listOfColorTreatmentId = [];
  List<int> listOfTwistDirectionId = [];
  List<int> listOfSpunTechId = [];
  List<int> listOfQualityId = [];
  List<int> listAppearanceId = [];
  List<int> listOfDyingMethod = [];
  List<int> listOfPatternChar = [];
  List<int> listOfDoublingMethod = [];


  bool? showTexturized;
  bool? showBlend;
  bool? showDannier;
  bool? showFilament;
  bool? showUsage;
  bool? showAppearance;
  bool? showColorDyingMethod;
  bool? showColorCode;
  bool? showRatio;
  bool? showCount;
  bool? showPly;
  bool? showColorTreatmentMethod;
  bool? showOrientation;
  bool? showTwistDirection;
  bool? showSpunTechnique;
  bool? showQuality;
  bool? showPattern;
  bool? showDyingMethod;
  bool? showPatternCharc;
  bool? showDoublingMethod;
  bool? showGrade;
  bool? showCertification;

  double minDannier = 0.0;
  double minFilament = 0.0;
  double minCount = 0.0;
  double minRatio = 0.0;
  double maxDannier = 0.0;
  double maxFilament = 0.0;
  double maxCount = 0.0;
  double maxRatio = 100.0;

  double? minValueDannierParam;
  double? maxValueDannierParam;
  double? minValueFilamentParam;
  double? maxValueFilamentParam;
  double? minValueCountParam;
  double? maxValueCountParam;
  double? minValueRatioParam;
  double? maxValueRatioParam;

  bool isListClear = false;

  final TextEditingController textEditingController = TextEditingController();

  Color pickerColor = const Color(0xffffffff);
  GetSpecificationRequestModel getSpecificationRequestModel = GetSpecificationRequestModel();


  getFamilyData() async{
    isGetSyncedData = false;
    var dbInstance = await AppDbInstance().getDbInstance();
    familyList = await dbInstance.yarnFamilyDao.findAllYarnFamily();
    selectedYarnFamily = familyList!.first;
    getSpecificationRequestModel.ysFamilyIdFk = [familyList!.first.famId!];
    getSyncedData(familyList!.first.famId!);
    isGetSyncedData = true;
    notifyListeners();

  }

  getSyncedData(int famId) async {
    isGetSyncedData = false;
    getSpecificationRequestModel.categoryId = "2";
    var dbInstance = await AppDbInstance().getDbInstance();
    blendsList =
    await dbInstance.yarnBlendDao.findAllYarnBlends(famId, 2);
    appearanceList = await dbInstance.yarnAppearanceDao
        .findYarnAppearanceWithFamilyId(famId);
    yarnTypesList = await dbInstance.yarnTypesDao.findAllYarnTypes();
    usageList =
    await dbInstance.usageDao.findYarnUsageWithFamilyId(famId);
    colorTreatmentMethodList = await dbInstance.colorTreatmentMethodDao
        .findYarnColorTreatmentMethodWithFamilyId(famId);
    dyingMethodList = await dbInstance.dyingMethodDao.findAllDyingMethod();
    plyList =
    await dbInstance.plyDao.findYarnPlyWithFamilyId(famId);
    doublingMethodList =
    await dbInstance.doublingMethodDao.findAllDoublingMethod();
    orientationList = await dbInstance.orientationDao
        .findYarnOrientationWithFamilyId(famId);
    spunTechList = await dbInstance.spunTechDao
        .findYarnSpunTechniqueWithFamilyId(famId);
    patternList =
    await dbInstance.patternDao.findAllPatternWithFamily(famId);
    qualityList = await dbInstance.qualityDao
        .findYarnQualityWithFamilyId(famId);
    // _twistDirectionList = await dbInstance.twistDirectionDao
    //     .findYarnTwistDirectionWithFamilyId(famId);
    patternCharList =
    await dbInstance.patternCharDao.findAllPatternCharacteristics();
    certificationList =
    await dbInstance.certificationDao.findCertificationWithCatId(2);
    gradesList =
    await dbInstance.yarnGradesDao.findGradeWithFamilyId(famId);
    await AppDbInstance().getYarnSettings().then((value) {
      yarnSettingsList = value;
      querySetting(famId);
      /*added this to fix bug*/
      getSpecificationRequestModel.ysFamilyIdFk = [famId];
        isGetSyncedData = true;
        minMaxConfiguration();
    });
  }



  querySetting(int id) async{

    var dbInstance = await AppDbInstance().getDbInstance();

    List<YarnSetting> yarnSetting = await dbInstance.yarnSettingsDao.findFamilyYarnSettings(id);

    late bool isSettingInList;

    if (!isListClear) {
      listOfSettings.clear();
      isListClear = false;
    }


    if (listOfSettings.isNotEmpty) {
      for (var element in listOfSettings) {

        if (element.ysFamilyIdfk == yarnSetting[0].ysFamilyIdfk) {
          isSettingInList = true;
          break;
        } else {
          isSettingInList = false;
        }
      }

      isSettingInList
          ? listOfSettings.removeWhere((element) =>
      element.ysFamilyIdfk == yarnSetting[0].ysFamilyIdfk)
      // ? listOfSettings.toSet().toList()
          : listOfSettings.add(yarnSetting[0]);
    } else {
      listOfSettings.add(yarnSetting[0]);
    }
    minMaxConfiguration();
    showHideConfiguration();


  }

  querySettingWithBlend(int id, int blend) {
    AppDbInstance().getDbInstance().then((db) => db.yarnSettingsDao
        .findFamilyAndBlendYarnSettings(blend, id)
        .then((value) {
      if (value.isNotEmpty) {
        late bool isSettingInList;
        late YarnSetting _yarnSetting;

        if (!isListClear) {
          listOfSettings.clear();
          isListClear = false;
        }
        if (listOfSettings.isNotEmpty) {
          for (var element in listOfSettings) {
            _yarnSetting = value[0];

            if (element.ysFamilyIdfk == _yarnSetting.ysFamilyIdfk) {
              isSettingInList = true;
              break;
            } else {
              isSettingInList = false;
            }
          }

          isSettingInList
              ? listOfSettings.removeWhere((element) =>
          element.ysFamilyIdfk == _yarnSetting.ysFamilyIdfk)
          // ? listOfSettings.toSet().toList()
              : listOfSettings.add(_yarnSetting);
        } else {
          listOfSettings.add(value[0]);
        }
        minMaxConfiguration();
        showHideConfiguration();
      }
    }));
  }

  minMaxConfiguration() {
    for (var element in listOfSettings.isEmpty ? yarnSettingsList! : listOfSettings) {
      setMinMaxConfiguration(element);
    }
  }

  setMinMaxConfiguration(YarnSetting element) {
      if (Utils.splitMin(element.countMinMax) > minCount) {
        minCount = Utils.splitMin(element.countMinMax);
      }
      if (Utils.splitMax(element.countMinMax) > maxCount) {
        maxCount = Utils.splitMax(element.countMinMax);
      }
      if (Utils.splitMin(element.filamentMinMax) > minFilament) {
        minFilament = Utils.splitMin(element.filamentMinMax);
      }
      if (Utils.splitMax(element.filamentMinMax) > maxFilament) {
        maxFilament = Utils.splitMax(element.filamentMinMax);
      }
      if (Utils.splitMin(element.dannierMinMax) > minDannier) {
        minDannier = Utils.splitMin(element.dannierMinMax);
      }
      if (Utils.splitMax(element.dannierMinMax) > maxDannier) {
        maxDannier = Utils.splitMax(element.dannierMinMax);
      }

      notifyListeners();
  }

  showHideConfiguration() {
    bool? tempShowTexturized;
    bool? tempShowBlend;
    bool? tempShowDannier;
    bool? tempShowFilament;
    bool? tempShowUsage;
    bool? tempShowAppearance;
    bool? tempShowColorDyingMethod;
    bool? tempShowColorCode;
    bool? tempShowRatio;
    bool? tempShowCount;
    bool? tempShowPly;
    bool? tempShowDoublingMethod;
    bool? tempShowColorTreatmentMethod;
    bool? tempShowOrientation;
    bool? tempShowTwistDirection;
    bool? tempShowSpunTechnique;
    bool? tempShowQuality;
    bool? tempShowPattern;
    bool? tempShowPatternCharc;
    bool? tempShowGrade;
    bool? tempShowCertification;

    if (listOfSettings.isNotEmpty) {
      for (var element in listOfSettings) {
        // setState(() {

        tempShowBlend = tempShowBlend == null
            ? Ui.showHide(element.showBlend)
            : (showBlend! && Ui.showHide(element.showBlend) && tempShowBlend)
            ? true
            : false;

        tempShowUsage = tempShowUsage == null
            ? Ui.showHide(element.showUsage)
            : (showUsage! && Ui.showHide(element.showUsage) && tempShowUsage)
            ? true
            : false;

        tempShowGrade = tempShowGrade == null
            ? Ui.showHide(element.showGrade)
            : (showGrade! && Ui.showHide(element.showGrade) && tempShowGrade)
            ? true
            : false;

        tempShowTexturized = tempShowTexturized == null
            ? Ui.showHide(element.showTexturized)
            : (showTexturized! &&
            Ui.showHide(element.showTexturized) &&
            tempShowTexturized)
            ? true
            : false;

        tempShowFilament = tempShowFilament == null
            ? Ui.showHide(element.showFilament)
            : (showFilament! &&
            Ui.showHide(element.showFilament) &&
            tempShowFilament)
            ? true
            : false;

        tempShowDannier = tempShowDannier == null
            ? Ui.showHide(element.showDannier)
            : (showDannier! &&
            Ui.showHide(element.showDannier) &&
            tempShowDannier)
            ? true
            : false;

        tempShowAppearance = tempShowAppearance == null
            ? Ui.showHide(element.showAppearance)
            : (showAppearance! &&
            Ui.showHide(element.showAppearance) &&
            tempShowAppearance)
            ? true
            : false;

        tempShowCount = tempShowCount == null
            ? Ui.showHide(element.showCount)
            : (showCount! && Ui.showHide(element.showCount) && tempShowCount)
            ? true
            : false;

        tempShowRatio = tempShowRatio == null
            ? Ui.showHide(element.showRatio)
            : (showRatio! && Ui.showHide(element.showRatio) && tempShowRatio)
            ? true
            : false;

        tempShowCertification = tempShowCertification == null
            ? Ui.showHide(element.showCertification)
            : (showCertification! &&
            Ui.showHide(element.showCertification) &&
            tempShowCertification)
            ? true
            : false;

        tempShowColorDyingMethod = tempShowColorDyingMethod == null
            ? Ui.showHide(element.showDyingMethod)
            : (showColorDyingMethod! &&
            Ui.showHide(element.showDyingMethod) &&
            tempShowColorDyingMethod)
            ? true
            : false;

        tempShowColorTreatmentMethod = tempShowColorTreatmentMethod == null
            ? Ui.showHide(element.showColorTreatmentMethod)
            : (showColorTreatmentMethod! &&
            Ui.showHide(element.showColorTreatmentMethod) &&
            tempShowColorTreatmentMethod)
            ? true
            : false;

        tempShowPly = tempShowPly == null
            ? Ui.showHide(element.showPly)
            : (showPly! && Ui.showHide(element.showPly) && tempShowPly)
            ? true
            : false;

        tempShowPattern = tempShowPattern == null
            ? Ui.showHide(element.showPattern)
            : (showPattern! &&
            Ui.showHide(element.showPattern) &&
            tempShowPattern)
            ? true
            : false;

        // tempShowPatternCharc = tempShowPatternCharc == null
        //     ? Ui.showHide(element.showPatternCharectristic)
        //     : (showPatternCharc! &&
        //             Ui.showHide(element.showPatternCharectristic) &&
        //             tempShowPatternCharc)
        //         ? true
        //         : false;

        tempShowOrientation = tempShowOrientation == null
            ? Ui.showHide(element.showOrientation)
            : (showOrientation! &&
            Ui.showHide(element.showOrientation) &&
            tempShowOrientation)
            ? true
            : false;

        tempShowSpunTechnique = tempShowSpunTechnique == null
            ? Ui.showHide(element.showSpunTechnique)
            : (showSpunTechnique! &&
            Ui.showHide(element.showSpunTechnique) &&
            tempShowSpunTechnique)
            ? true
            : false;

        tempShowTwistDirection = tempShowTwistDirection == null
            ? Ui.showHide(element.showTwistDirection)
            : (showTwistDirection! &&
            Ui.showHide(element.showTwistDirection) &&
            tempShowTwistDirection)
            ? true
            : false;

        // tempShowDoublingMethod = tempShowDoublingMethod == null
        //     ? Ui.showHide(element.showDoublingMethod)
        //     : (showDoublingMethod! &&
        //             Ui.showHide(element.showDoublingMethod) &&
        //             tempShowDoublingMethod)
        //         ? true
        //         : false;

        tempShowQuality = tempShowQuality == null
            ? Ui.showHide(element.showQuality)
            : (showQuality! &&
            Ui.showHide(element.showQuality) &&
            tempShowQuality)
            ? true
            : false;

        // });
      }

        showGrade = tempShowGrade;
        showBlend = tempShowBlend;
        showCount = tempShowCount;
        showRatio = tempShowRatio;
        showCertification = tempShowCertification;
        showAppearance = tempShowAppearance;
        showFilament = tempShowFilament;
        showDannier = tempShowDannier;
        showUsage = tempShowUsage;
        showTexturized = tempShowTexturized;

        showColorDyingMethod = tempShowColorDyingMethod;
        showColorCode = tempShowColorCode;
        showPly = tempShowPly;
        showDoublingMethod = tempShowDoublingMethod;
        showColorTreatmentMethod = tempShowColorTreatmentMethod;
        showOrientation = tempShowOrientation;
        showTwistDirection = tempShowTwistDirection;
        showSpunTechnique = tempShowSpunTechnique;
        showQuality = tempShowQuality;
        showPattern = tempShowPattern;
        // showPatternCharc = tempShowPatternCharc;
        showGrade = tempShowGrade;

    } else {
      // _resetData();
    }

    notifyListeners();
  }



  void pickColor(Color color) {
      pickerColor = color;
      textEditingController.text = '#${pickerColor.value.toRadixString(16)}';
      notifyListeners();
  }

  setPickedColor(){
    pickerColor = pickerColor;
    notifyListeners();
  }

  spunSelection(SpunTechnique value) async {
    getSpecificationRequestModel.spunTechId = [value.ystId!];
    await getPatternWithSpunId(value.ystId!);
    await getQualityWithSpunId(value.ystId!);
    if (qualityList!.isEmpty) {
      await getQuality();
    }
    if (patternList!.isEmpty) {
      await getPatternList();
    }

    notifyListeners();
  }

  patternSelection(PatternModel value) async {
    await getPatternCharcIdWithPtrId(value.ypId!);
    if (patternCharList!.isNotEmpty) {
      showPatternCharc = true;
    } else {
      showPatternCharc = false;
      getSpecificationRequestModel.patternCharId =
      null;
    }
    getSpecificationRequestModel.patternId = [value.ypId!];
  }

  getQualityWithSpunId(int spunId) async {
    var dbInstance = await AppDbInstance().getDbInstance();
    qualityList = await dbInstance.qualityDao
        .findYarnQualityWithSpunTechId(spunId, selectedYarnFamily.famId!);
    notifyListeners();
  }
  getQuality() async {
    var dbInstance = await AppDbInstance().getDbInstance();
    qualityList = await dbInstance.qualityDao
        .findYarnQualityWithFamilyId(selectedYarnFamily.famId!);
    notifyListeners();
  }

  getPatternWithSpunId(int id) async {
    var dbInstance = await AppDbInstance().getDbInstance();
    patternList = await dbInstance.patternDao
        .findAllPatternWithSpunTechId(id, selectedYarnFamily.famId!);
    notifyListeners();
  }
  getPatternList() async {
    var dbInstance = await AppDbInstance().getDbInstance();
    patternList = await dbInstance.patternDao
        .findAllPatternWithFamily(selectedYarnFamily.famId!);
    notifyListeners();
  }
  getDyingMethodListWithAprId(int aprId) async {
    var dbInstance = await AppDbInstance().getDbInstance();
    dyingMethodList = await dbInstance.dyingMethodDao
        .findAllDyingMethodWithAppearanceId(aprId);
    notifyListeners();
  }

  getPatternCharcIdWithPtrId(int id) async{
    var dbInstance = await AppDbInstance().getDbInstance();
    patternCharList = await dbInstance.patternCharDao.findYarnPatternCharacteristicsWithPtrId(id);
    notifyListeners();
  }

  getDyingMethodListWithCTMId(int ctmId) async {
    var dbInstance = await AppDbInstance().getDbInstance();
    dyingMethodList = await dbInstance.dyingMethodDao
        .findAllDyingMethodWithCTMId(ctmId);
    // notifyUI();
  }

  void plySelection(Ply ply) async{
    var dbInstance= await AppDbInstance().getDbInstance();
    doublingMethodList = await dbInstance.doublingMethodDao.findYarnDoublingMethodWithPlyId(ply.plyId??-1);
    if(doublingMethodList!.isEmpty){
      showDoublingMethod = false;
    }else{
      showDoublingMethod = true;
    }
    notifyListeners();
  }
}