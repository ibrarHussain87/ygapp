import 'package:flutter/material.dart';
import 'package:yg_app/app_database/app_database_instance.dart';
import 'package:yg_app/elements/list_widgets/single_select_tile_widget.dart';
import 'package:yg_app/model/request/post_ad_request/create_request_model.dart';
import 'package:yg_app/model/response/common_response_models/certification_response.dart';
import 'package:yg_app/model/response/common_response_models/countries_response.dart';
import 'package:yg_app/model/response/yarn_response/sync/yarn_grades.dart';
import 'package:yg_app/model/response/yarn_response/sync/yarn_sync_response.dart';

class PostYarnProvider extends ChangeNotifier {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<SingleSelectTileWidgetState> usageKey =
      GlobalKey<SingleSelectTileWidgetState>();
  final GlobalKey<SingleSelectTileWidgetState> yarnTypeKey =
      GlobalKey<SingleSelectTileWidgetState>();
  final GlobalKey<SingleSelectTileWidgetState> colorTreatmentMethodKey =
      GlobalKey<SingleSelectTileWidgetState>();
  final GlobalKey<SingleSelectTileWidgetState> dyingMethodKey =
      GlobalKey<SingleSelectTileWidgetState>();
  final GlobalKey<SingleSelectTileWidgetState> certificateKey =
      GlobalKey<SingleSelectTileWidgetState>();
  final GlobalKey<SingleSelectTileWidgetState> plyKey =
      GlobalKey<SingleSelectTileWidgetState>();
  final GlobalKey<SingleSelectTileWidgetState> doublingMethodKey =
      GlobalKey<SingleSelectTileWidgetState>();
  final GlobalKey<SingleSelectTileWidgetState> orientationKey =
      GlobalKey<SingleSelectTileWidgetState>();
  final GlobalKey<SingleSelectTileWidgetState> qualityKey =
      GlobalKey<SingleSelectTileWidgetState>();
  final GlobalKey<SingleSelectTileWidgetState> patternKey =
      GlobalKey<SingleSelectTileWidgetState>();
  final GlobalKey<SingleSelectTileWidgetState> patternCharKey =
      GlobalKey<SingleSelectTileWidgetState>();
  final GlobalKey<SingleSelectTileWidgetState> spunTechKey =
      GlobalKey<SingleSelectTileWidgetState>();
  final GlobalKey<SingleSelectTileWidgetState> twistDirectionKey =
      GlobalKey<SingleSelectTileWidgetState>();
  final GlobalKey<SingleSelectTileWidgetState> gradeKey =
      GlobalKey<SingleSelectTileWidgetState>();
  final GlobalKey<SingleSelectTileWidgetState> appearanceKey =
      GlobalKey<SingleSelectTileWidgetState>();

  //Show Hide on dependency
  bool showDyingMethod = false;
  bool showDoublingMethod = false;
  bool showPatternChar = false;

  Usage? selectedUsage;
  String? selectedPlyId;
  String? selectedDoublingMethodId;
  String? selectedOrientationId;

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
  List<Countries> countries = [];

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

  //RESET ALL DATA
  resetSpecFormData() {
    if (yarnTypeKey.currentState != null) {
      yarnTypeKey.currentState!.resetWidget();
    }
    if (usageKey.currentState != null) {
      usageKey.currentState!.resetWidget();
    }
    if (appearanceKey.currentState != null) {
      appearanceKey.currentState!.resetWidget();
    }
    if (plyKey.currentState != null) plyKey.currentState!.resetWidget();
    if (patternKey.currentState != null) {
      patternKey.currentState!.resetWidget();
    }
    if (patternCharKey.currentState != null) {
      patternCharKey.currentState!.resetWidget();
    }
    if (orientationKey.currentState != null) {
      orientationKey.currentState!.resetWidget();
    }
    if (spunTechKey.currentState != null) {
      spunTechKey.currentState!.resetWidget();
    }
    if (qualityKey.currentState != null) {
      qualityKey.currentState!.resetWidget();
    }
    if (certificateKey.currentState != null) {
      certificateKey.currentState!.resetWidget();
    }
    if (gradeKey.currentState != null) {
      gradeKey.currentState!.resetWidget();
    }
    if (twistDirectionKey.currentState != null) {
      twistDirectionKey.currentState!.resetWidget();
    }
    if (doublingMethodKey.currentState != null) {
      doublingMethodKey.currentState!.resetWidget();
    }
    if (dyingMethodKey.currentState != null) {
      dyingMethodKey.currentState!.resetWidget();
    }
    if (colorTreatmentMethodKey.currentState != null) {
      colorTreatmentMethodKey.currentState!.resetWidget();
    }
    selectedUsage = null;
    showDyingMethod = false;
    showDoublingMethod = false;
    showPatternChar = false;

    selectedPlyId = null;
    selectedDoublingMethodId = null;
    selectedOrientationId = null;
    if (createRequestModel != null) {
      createRequestModel!.ys_usage_idfk = null;
      createRequestModel!.ys_ratio = null;
      createRequestModel!.ys_twist_direction_idfk = null;
      createRequestModel!.ys_grade_idfk = null;
      createRequestModel!.ys_fdy_filament = null;
      createRequestModel!.ys_dty_filament = null;
      createRequestModel!.ys_apperance_idfk = null;
      createRequestModel!.ys_color_treatment_method_idfk = null;
      createRequestModel!.ys_dying_method_idfk = null;
      createRequestModel!.ys_color_code = null;
      createRequestModel!.ys_count = null;
      createRequestModel!.ys_ply_idfk = null;
      createRequestModel!.ys_doubling_method_idFk = null;
      createRequestModel!.ys_orientation_idfk = null;
      createRequestModel!.ys_quality_idfk = null;
      createRequestModel!.ys_pattern_idfk = null;
      createRequestModel!.ys_pattern_charectristic_idfk = null;
      createRequestModel!.ys_certification_idfk = null;
      createRequestModel!.ys_yarn_type_idfk = null;
    }
    // selectedPatternId = null;
    notifyUI();
  }

  void resetData() {
    resetSpecFormData();
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
    certificationList =
        await dbInstance.certificationDao.findCertificationWithCatId(2);
    // certificationList = await dbInstance.certificationDao.findAllCertifications();
    notifyUI();
  }

  getBlendsData() async{
    var dbInstance = await AppDbInstance().getDbInstance();
    setBlendList = await dbInstance.yarnBlendDao.allYarnBlends();
    notifyListeners();

  }

  getCountries() async {
    var dbInstance = await AppDbInstance().getDbInstance();
    countries = await dbInstance.countriesDao.findAllCountries();
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

  getPatternCharcIdWithPtrId(int id) async {
    var dbInstance = await AppDbInstance().getDbInstance();
    patternCharList = await dbInstance.patternCharDao
        .findYarnPatternCharacteristicsWithPtrId(id);
    notifyUI();
  }

  getDyingMethodListWithCTMId(int ctmId) async {
    var dbInstance = await AppDbInstance().getDbInstance();
    dyingMethodList =
        await dbInstance.dyingMethodDao.findAllDyingMethodWithCTMId(ctmId);
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
