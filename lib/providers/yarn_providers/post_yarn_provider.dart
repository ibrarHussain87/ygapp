import 'package:flutter/material.dart';
import 'package:yg_app/app_database/app_database_instance.dart';
import 'package:yg_app/helper_utils/ui_utils.dart';
import 'package:yg_app/model/request/post_ad_request/create_request_model.dart';
import 'package:yg_app/model/response/common_response_models/certification_response.dart';
import 'package:yg_app/model/response/yarn_response/sync/yarn_grades.dart';
import 'package:yg_app/model/response/yarn_response/sync/yarn_sync_response.dart';

class PostYarnProvider extends ChangeNotifier {
  List<Usage>? usageList = [];
  List<ColorTreatmentMethod>? colorTreatmentMethodList = [];
  List<Ply>? plyList = [];
  List<DoublingMethod>? doublingMethodList = [];
  List<DyingMethod>? dyingMethodList = [];
  List<OrientationTable>? orientationList = [];
  // List<TwistDirection>? twistDirectionList = [];
  List<SpunTechnique>? spunTechList = [];
  List<Quality>? qualityList = [];
  List<PatternModel>? patternList = [];
  List<PatternCharectristic>? patternCharList = [];
  List<YarnGrades>? gradesList = [];
  List<YarnAppearance>? appearanceList = [];
  List<Certification>? certificationList = [];
  List<YarnTypes>? yarnTypesList = [];

  CreateRequestModel? createRequestModel = CreateRequestModel();
  List<dynamic> selectedBlends = [];
  List<TextEditingController> textFieldControllers = [];
  List<TextEditingController> textFieldControllersPopular = [];
  bool isYarnSettingLoaded = false;
  YarnSetting? yarnSetting;

  bool? _familyDisabled;

  bool get familyDisabled => _familyDisabled ?? false;

  set familyDisabled(value) {
    _familyDisabled = value;
    notifyListeners();
  }

  Family? _selectedYarnFamily;

  Family get selectedYarnFamily => _selectedYarnFamily ?? Family();

  set selectedYarnFamily(value) {
    _selectedYarnFamily = value;
    notifyListeners();
  }

  bool? _isBlendSelected;

  bool get isBlendSelected => _isBlendSelected ?? false;

  set isBlendSelected(value) {
    _isBlendSelected = value;
    notifyListeners();
  }

  List<Blends> _blendsList = [];

  List<Blends> get blendList => _blendsList;

  set setBlendList(value) {
    _blendsList.clear();
    _blendsList = value;
    notifyListeners();
  }

  List<Family> yarnFamilyList = [];

  set addSelectedBlend(value) {
    selectedBlends.add(value);
  }

  set removeSelectedBlend(value) {
    selectedBlends.remove(value);
  }

  void setBlendRatio(index, ratio) {
    _blendsList[index].blendRatio = ratio;
    notifyListeners();
  }

  void resetData() {
    for (var element in _blendsList) {
      element.blendRatio = "";
      element.isSelected = false;
    }
    textFieldControllers.clear();
    selectedBlends.clear();
    notifyListeners();
  }

  getSyncedData() async {
    var dbInstance = await AppDbInstance().getDbInstance();
    usageList = await dbInstance.usageDao
        .findYarnUsageWithFamilyId(_selectedYarnFamily!.famId!);
    appearanceList = await dbInstance.yarnAppearanceDao
        .findYarnAppearanceWithFamilyId(_selectedYarnFamily!.famId!);
    yarnTypesList = await dbInstance.yarnTypesDao.findAllYarnTypes();
    colorTreatmentMethodList = await dbInstance.colorTreatmentMethodDao
        .findYarnColorTreatmentMethodWithFamilyId(_selectedYarnFamily!.famId!);
    dyingMethodList = await dbInstance.dyingMethodDao.findAllDyingMethod();
    plyList = await dbInstance.plyDao
        .findYarnPlyWithFamilyId(_selectedYarnFamily!.famId!);
    doublingMethodList =
        await dbInstance.doublingMethodDao.findAllDoublingMethod();
    orientationList = await dbInstance.orientationDao
        .findYarnOrientationWithFamilyId(_selectedYarnFamily!.famId!);
    spunTechList = await dbInstance.spunTechDao
        .findYarnSpunTechniqueWithFamilyId(_selectedYarnFamily!.famId!);
    qualityList = await dbInstance.qualityDao
        .findYarnQualityWithFamilyId(_selectedYarnFamily!.famId!);
    patternList = await dbInstance.patternDao
        .findAllPatternWithFamily(_selectedYarnFamily!.famId!);
    // twistDirectionList = await dbInstance.twistDirectionDao
    //     .findYarnTwistDirectionWithFamilyId(_selectedYarnFamily!.famId!);
    gradesList = await dbInstance.yarnGradesDao
        .findGradeWithFamilyId(_selectedYarnFamily!.famId!);
    patternCharList =
        await dbInstance.patternCharDao.findAllPatternCharacteristics();
    certificationList = await dbInstance.certificationDao.findCertificationWithCatId(2);
    // certificationList = await dbInstance.certificationDao.findAllCertifications();
    notifyUI();
  }

  getQualityWithSpunId(int spunId) async {
    var dbInstance = await AppDbInstance().getDbInstance();
    qualityList = await dbInstance.qualityDao
        .findYarnQualityWithSpunTechId(spunId, selectedYarnFamily.famId!);
    notifyUI();
  }

  getQuality() async {
    var dbInstance = await AppDbInstance().getDbInstance();
    qualityList = await dbInstance.qualityDao
        .findYarnQualityWithFamilyId(selectedYarnFamily.famId!);
    notifyUI();
  }

  getPatternWithSpunId(int id) async {
    var dbInstance = await AppDbInstance().getDbInstance();
    patternList = await dbInstance.patternDao
        .findAllPatternWithSpunTechId(id, selectedYarnFamily.famId!);
    notifyUI();
  }
  getPatternList() async {
    var dbInstance = await AppDbInstance().getDbInstance();
    patternList = await dbInstance.patternDao
        .findAllPatternWithFamily(selectedYarnFamily.famId!);
    notifyUI();
  }
  getDyingMethodListWithAprId(int aprId) async {
    var dbInstance = await AppDbInstance().getDbInstance();
    dyingMethodList = await dbInstance.dyingMethodDao
        .findAllDyingMethodWithAppearanceId(aprId);
    notifyUI();
  }

  getPatternCharcIdWithPtrId(int id) async{
    var dbInstance = await AppDbInstance().getDbInstance();
    patternCharList = await dbInstance.patternCharDao.findYarnPatternCharacteristicsWithPtrId(id);
    notifyUI();
  }

  getDyingMethodListWithCTMId(int ctmId) async {
    var dbInstance = await AppDbInstance().getDbInstance();
    dyingMethodList = await dbInstance.dyingMethodDao
        .findAllDyingMethodWithCTMId(ctmId);
    // notifyUI();
  }

  getFamilyData() async {
    var dbInstance = await AppDbInstance().getDbInstance();
    yarnFamilyList = await dbInstance.yarnFamilyDao.findAllYarnFamily();
    notifyUI();
  }

  getYarnBlendData(famId, catId) async {
    var dbInstance = await AppDbInstance().getDbInstance();
    _blendsList = await dbInstance.yarnBlendDao.findAllYarnBlends(famId, catId);
    notifyUI();
  }

  queryFamilySettings(int id) async {
    var dbInstance = await AppDbInstance().getDbInstance();
    List<YarnSetting> yarnSettings =
        await dbInstance.yarnSettingsDao.findFamilyYarnSettings(id);
    if (yarnSettings.isNotEmpty) {
      yarnSetting = yarnSettings.first;
      notifyUI();
    }
  }

  notifyUI() {
    notifyListeners();
  }
}
