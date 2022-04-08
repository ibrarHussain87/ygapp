

import 'package:flutter/cupertino.dart';
import 'package:yg_app/api_services/api_service_class.dart';
import 'package:yg_app/model/request/filter_request/filter_request.dart';
import 'package:yg_app/model/response/get_banner_response.dart';

import '../model/response/fiber_response/fiber_specification.dart';

class FiberSpecificationsProvider extends ChangeNotifier{

  FiberSpecificationResponse? fiberSpecificationResponse;
  GetSpecificationRequestModel? requestModel;
  String? locality;

  setRequestParams(GetSpecificationRequestModel getRequestModel, String loclity){
    requestModel = getRequestModel;
    locality = loclity;
  }


  getUpdatedFiberSpecificationsData() async{
    if(requestModel != null && locality != null){
      var response = await ApiService.getFiberSpecifications(requestModel!, locality);
      fiberSpecificationResponse = response;
      notifyListeners();
    }
  }

  Future<FiberSpecificationResponse> getFibers() async{
    var response = await ApiService.getFiberSpecifications(requestModel!, locality);
    fiberSpecificationResponse = response;
    return response;
  }

}