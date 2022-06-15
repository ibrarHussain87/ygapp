


import 'package:flutter/material.dart';
import 'package:yg_app/api_services/api_service_class.dart';
import 'package:yg_app/model/response/fabric_response/fabric_specification_response.dart';

import '../../model/request/filter_request/fabric_filter_request.dart';

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
      var response = await ApiService().getFabricSpecifications(requestModel!, locality);
      fabricSpecificationResponse = response;
      notifyListeners();
    }
  }

  Future<FabricSpecificationResponse> getFabrics() async{
    var response = await ApiService().getFabricSpecifications(requestModel!, locality);
    fabricSpecificationResponse = response;
    return response;
  }

}