

import 'package:flutter/cupertino.dart';
import 'package:yg_app/api_services/api_service_class.dart';
import 'package:yg_app/elements/list_widgets/single_select_tile_renewed_widget.dart';
import 'package:yg_app/model/request/filter_request/filter_request.dart';
import 'package:yg_app/model/response/get_banner_response.dart';

import '../model/response/yarn_response/yarn_specification_response.dart';

class YarnSpecificationsProvider extends ChangeNotifier{

  GetYarnSpecificationResponse? yarnSpecificationResponse;
  GetSpecificationRequestModel? requestModel;
  String? locality;

  setRequestParams(GetSpecificationRequestModel getRequestModel, String loclity){
    requestModel = getRequestModel;
    locality = loclity;
  }


  getUpdatedYarnSpecificationsData() async{
    if(requestModel != null && locality != null){
      var response = await ApiService.getYarnSpecifications(requestModel!, locality);
      yarnSpecificationResponse = response;
      notifyListeners();
    }
  }

  Future<GetYarnSpecificationResponse> getYarns() async{
    var response = await ApiService.getYarnSpecifications(requestModel!, locality);
    yarnSpecificationResponse = response;
    return response;
  }

}