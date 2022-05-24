

import 'package:flutter/cupertino.dart';
import 'package:yg_app/api_services/api_service_class.dart';
import 'package:yg_app/model/request/post_fabric_request/create_fabric_request_model.dart';
import 'package:yg_app/model/response/fabric_response/sync/fabric_sync_response.dart';
import 'package:yg_app/model/response/get_banner_response.dart';

import '../../app_database/app_database_instance.dart';

class PostFabricProvider extends ChangeNotifier{

  List<FabricFamily> fabricFamilyList = [];
  List<FabricBlends> fabricBlendsList = [];
  List<dynamic> selectedBlends = [];
  set addSelectedBlend(value){
    selectedBlends.add(value);
    notifyListeners();
  }

  set removeSelectedBlend(value){
    selectedBlends.remove(value);
    notifyListeners();
  }
  int? blendId;
  int? firstFamilyId;
  bool dataSynced = false;
  bool updateSegments = true;
  List<FabricSetting>? fabricSetting = [];
  FabricCreateRequestModel? fabricCreateRequestModel = FabricCreateRequestModel();
  List<TextEditingController> textFieldControllers = [];
  List<TextEditingController> textFieldControllersPopular = [];
  // Lists
  FabricFamily? _selectedFabricFamily;
  FabricFamily get selectedFabricFamily => _selectedFabricFamily??FabricFamily();
  set selectedFabricFamily(value){
    _selectedFabricFamily = value;
    notifyListeners();
  }

  bool? _isBlendSelected;
  bool get isBlendSelected => _isBlendSelected??false;
  set isBlendSelected(value){
    _isBlendSelected = value;
    notifyListeners();
  }

  bool? _familyDisabled;
  bool get familyDisabled => _familyDisabled??false;
  set familyDisabled(value){
    _familyDisabled = value;
    notifyListeners();
  }

  List<FabricBlends> _blendsList = [];
  List<FabricBlends> get blendList => _blendsList;
  set setBlendList(value){
    _blendsList.clear();
    _blendsList = value;
    notifyListeners();
  }

  void setBlendRatio(index,ratio){
    _blendsList[index].blendRatio = ratio;
    notifyListeners();
  }

  getFamilyData() async {
    var dbInstance = await AppDbInstance().getDbInstance();
    fabricFamilyList = await dbInstance.fabricFamilyDao.findAllFabricFamily();
    notifyUI();
  }

  getFabricBlendData(famId) async {
    var dbInstance = await AppDbInstance().getDbInstance();
    _blendsList = await dbInstance.fabricBlendsDao.findFabricBlend(famId);
    notifyUI();
  }

  queryFamilySettings(int id) async {
    var dbInstance = await AppDbInstance().getDbInstance();
    List<FabricSetting> fabricSettings =
    await dbInstance.fabricSettingDao.findFamilyFabricSettings(id);
    if (fabricSettings.isNotEmpty) {
      fabricSetting = fabricSettings;
      notifyUI();
    }
  }


  Future<void> getSyncData() async{
    //fabricCreateRequestModel = FabricCreateRequestModel();
    var dbInstance = await AppDbInstance().getDbInstance();
    fabricFamilyList = await dbInstance.fabricFamilyDao.findAllFabricFamily();
    fabricBlendsList = await dbInstance.fabricBlendsDao.findAllFabricBlends();
    firstFamilyId = fabricFamilyList.first.fabricFamilyId;
    blendId = fabricBlendsList.where((element) => element.familyIdfk == fabricFamilyList.first.fabricFamilyId.toString())
        .toList().first
        .blnId;

    setBlendList = fabricBlendsList;
    dataSynced = true;
    notifyListeners();
  }

  Future<List<FabricSetting>> getFabricSettingsData(String familyId) async{
    var dbInstance = await AppDbInstance().getDbInstance();
    fabricSetting = await dbInstance.fabricSettingDao.findFamilyFabricSettings(int.parse(familyId));
    return fabricSetting!;
  }

  setBlendId(int? value){
    blendId = value;
    notifyListeners();
  }

  updateFabricSegments(){
    updateSegments = true;
   // notifyListeners();
  }



  getDbLists(){

  }


  void setRequestModel(FabricCreateRequestModel createRequestModel) {
    fabricCreateRequestModel = createRequestModel;
  }

  void resetData(){
    for (var element in _blendsList) {
      element.blendRatio = "";
      element.isSelected = false;
    }
    textFieldControllers.clear();
    selectedBlends.clear();
    notifyListeners();

  }

  notifyUI() {
    notifyListeners();
  }

}