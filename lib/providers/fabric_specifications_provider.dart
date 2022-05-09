

import 'package:flutter/cupertino.dart';
import 'package:yg_app/api_services/api_service_class.dart';
import 'package:yg_app/model/request/filter_request/filter_request.dart';
import 'package:yg_app/model/response/fabric_response/fabric_specification_response.dart';
import 'package:yg_app/model/response/get_banner_response.dart';

import '../model/request/filter_request/fabric_filter_request.dart';
import '../model/response/yarn_response/yarn_specification_response.dart';

class FabricSpecificationsProvider extends ChangeNotifier{

  FabricSpecificationResponse? fabricSpecificationResponse;
  FabricSpecificationRequestModel? requestModel;
  String? locality;

  setRequestParams(FabricSpecificationRequestModel getRequestModel, String loclity){
    requestModel = getRequestModel;
    locality = loclity;
  }


  getUpdatedFabricSpecificationsData() async{
    if(requestModel != null && locality != null){
      var response = await ApiService.getFabricSpecifications(requestModel!, locality);
      fabricSpecificationResponse = response;
      notifyListeners();
    }
  }

  Future<FabricSpecificationResponse> getFabrics() async{
    var response = await ApiService.getFabricSpecifications(requestModel!, locality);
    fabricSpecificationResponse = response;
    return response;
  }

}