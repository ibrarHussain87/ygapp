
import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_picker_dropdown.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:yg_app/api_services/api_service_class.dart';
import 'package:yg_app/app_database/app_database_instance.dart';
import 'package:yg_app/elements/elevated_button_widget.dart';
import 'package:yg_app/elements/list_widgets/single_select_tile_widget.dart';
import 'package:yg_app/elements/title_text_widget.dart';
import 'package:yg_app/elements/yg_text_form_field.dart';
import 'package:yg_app/helper_utils/app_colors.dart';
import 'package:yg_app/helper_utils/app_constants.dart';
import 'package:yg_app/helper_utils/blended_single_tile.dart';
import 'package:yg_app/helper_utils/ui_utils.dart';
import 'package:yg_app/model/response/common_response_models/brands_response.dart';
import 'package:yg_app/model/response/common_response_models/certification_response.dart';
import 'package:yg_app/model/response/common_response_models/city_state_response.dart';
import 'package:yg_app/model/response/common_response_models/countries_response.dart';

import '../../../../Providers/post_fabric_provider.dart';
import '../../../../helper_utils/fabric_bottom_sheet.dart';
import '../../../../helper_utils/pure_single_tile.dart';
import '../../../../model/blend_model.dart';
import '../../../../model/request/post_fabric_request/create_fabric_request_model.dart';
import '../../../../model/response/fabric_response/sync/fabric_sync_response.dart';
import '../../../elements/decoration_widgets.dart';
import '../../../model/request/signup_request/signup_request.dart';

class BusinessInfoComponent extends StatefulWidget {
  final Function? callback;

  final String? selectedTab;

  const BusinessInfoComponent(
      {Key? key,
        // required this.syncFiberResponse,
        required this.callback,
        required this.selectedTab})
      : super(key: key);

  @override
  BusinessInfoComponentState createState() => BusinessInfoComponentState();
}

class BusinessInfoComponentState
    extends State<BusinessInfoComponent>
    with AutomaticKeepAliveClientMixin {
  final usernameFocus = FocusNode();
  final emailFocus = FocusNode();
  final passwordFocus = FocusNode();
  final confirmPasswordFocus = FocusNode();
  final businessAreaFocus = FocusNode();
  final companyFocus = FocusNode();
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  SignUpRequestModel? _signupRequestModel;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
//    _signupRequestModel = SignUpRequestModel();
    _resetData();
    super.initState();
  }

  @override
  void dispose() {

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    _signupRequestModel = Provider.of<SignUpRequestModel?>(context);
    if (kDebugMode) {
      print("COuntry"+_signupRequestModel!.countryId.toString());
    }
    return  Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
//      key: scaffoldKey,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
              padding:
              EdgeInsets.only(top: 16.w, left: 16.w, right: 16.w),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Form(
                      key: globalFormKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 8.w,
                          ),
                          buildBusinessDataColumn(context)
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.w),
            child: SizedBox(
              width: double.maxFinite,
              child: ElevatedButtonWithIcon(
                callback: () async {
                  handleNextClick();
                },
                color: btnColorLogin,
                btnText: "Next",
              ),
            ),
          ),
        ],
      ),
    );
  }


  Column buildBusinessDataColumn(BuildContext context2)
  {

    return Column(
      children: [

        Padding(
          padding:
          EdgeInsets.only(top: 8.w, bottom: 8.w, left: 8.w, right: 8.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              TextFormField(
                  keyboardType: TextInputType.text,
                  cursorColor: Colors.black,
                  onSaved: (input) =>
                  _signupRequestModel?.company = input!,
                  validator: (input) {
                    if (input == null || input.isEmpty) {
                      return "Please enter company name";
                    }
                    return null;
                  },
                  decoration: textFieldProfile(
                      'Enter Company Name', "Company Name")),
            ],
          ),
        ),

        Padding(
          padding:
          EdgeInsets.only(top: 8.w, bottom: 8.w, left: 8.w, right: 8.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              TextFormField(
                  keyboardType: TextInputType.text,
                  cursorColor: Colors.black,
                  initialValue: '',
                  onSaved: (input) =>
                  _signupRequestModel?.cityStateId = input!,
                  validator: (input) {
                    if (input == null ||
                        input.isEmpty) {
                      return "Please enter business area";
                    }
                    return null;
                  },
                  decoration: textFieldProfile(
                      'Enter Business Area', "Business Area")),
            ],
          ),
        ),

//        Padding(
//          padding:
//          EdgeInsets.only(top: 8.w, bottom: 8.w, left: 8.w, right: 8.w),
//          child: Column(
//            crossAxisAlignment: CrossAxisAlignment.start,
//            children: [
//
//
//              DropdownButtonFormField<String>(
//
//                decoration: dropDownProfile(
//                    'Select', "Designation") ,
//                isDense: true,
//                hint:Text("Select",style: TextStyle(fontSize: 10.sp,fontWeight: FontWeight.w400,color: Colors.black87),),
//                isExpanded: true,
//                iconSize: 21,
//                items:roleList.map((location) {
//                  return DropdownMenuItem<String>(
//                    child: Text(location),
//                    value: location,
//
//                  );
//                }).toList(),
//
//                onChanged: (newValue) {
//
//                },
//
//
//                validator: (value) => value == null ? '*' : null,
//
//              ),
//
//            ],
//          ),
//        ),


      ],
    );
  }

  void handleNextClick() {
//    _createRequestModel!.spc_category_idfk = "3";
//    _createRequestModel!.fs_blend_idfk = _selectedMaterial != null ? _selectedMaterial.toString():'';
    if (validationAllPage()) {

//      postFabricProvider.setRequestModel(_createRequestModel!);
      widget.callback!(2);
    }
  }

  _resetData() {

  }

  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }



  bool validationAllPage() {
    if (validateAndSave()) {
      if (_signupRequestModel?.company == null &&
          Ui.showHide("1")) {
        Ui.showSnackBar(context, 'Please enter phone number');
        return false;
      } else if (_signupRequestModel?.cityStateId == null &&
          Ui.showHide("1")) {
        Ui.showSnackBar(context, 'Please enter business area');
        return false;
      }
      else {
        return true;
      }
    }
    return false;
    //  return true;
  }



}


