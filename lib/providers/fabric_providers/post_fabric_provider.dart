

import 'package:flutter/cupertino.dart';
import 'package:yg_app/api_services/api_service_class.dart';
import 'package:yg_app/model/request/post_fabric_request/create_fabric_request_model.dart';
import 'package:yg_app/model/response/fabric_response/sync/fabric_sync_response.dart';
import 'package:yg_app/model/response/get_banner_response.dart';

import '../../app_database/app_database_instance.dart';

class PostFabricProvider extends ChangeNotifier{

  List<FabricFamily> fabricFamilyList = [];
  List<FabricBlends> fabricBlendsList = [];
  int? blendId;
  int? firstFamilyId;
  bool dataSynced = false;
  bool updateSegments = true;
  List<FabricSetting>? fabricSetting = [];
  late FabricCreateRequestModel fabricCreateRequestModel;
  // Lists


  Future<void> getSyncData() async{
    fabricCreateRequestModel = FabricCreateRequestModel();
    var dbInstance = await AppDbInstance().getDbInstance();
    fabricFamilyList = await dbInstance.fabricFamilyDao.findAllFabricFamily();
    fabricBlendsList = await dbInstance.fabricBlendsDao.findAllFabricBlends();
    firstFamilyId = fabricFamilyList.first.fabricFamilyId;
    blendId = fabricBlendsList.where((element) => element.familyIdfk == fabricFamilyList.first.fabricFamilyId.toString())
        .toList().first
        .blnId;
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

}