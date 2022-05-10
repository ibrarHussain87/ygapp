
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:provider/provider.dart';
import 'package:yg_app/elements/elevated_button_widget.dart';
import 'package:yg_app/helper_utils/app_colors.dart';
import 'package:yg_app/helper_utils/app_constants.dart';
import 'package:yg_app/helper_utils/ui_utils.dart';

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
  List<String> businessAreaList = ["Islamabad","Lahore","Karachi","Quetta","Peshwar"];
  List<String> suggestionList = ["Uber","Careem","Foodpanda","Director","CEO"];
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  SignUpRequestModel? _signupRequestModel;

  var _typeAheadController=TextEditingController();

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
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[appBarColor2,appBarColor1])),
        ),

        /*leading: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Padding(
                        padding: EdgeInsets.all(12.w),
                        child: Card(
                          child: Padding(
                              padding: EdgeInsets.only(left: 4.w),
                              child: Icon(
                                Icons.arrow_back_ios,
                                color: Colors.black,
                                size: 12.w,
                              )),
                        )),
                  ),*/
        title: Text('Registration',
            style: TextStyle(
                fontSize: 16.0.w,
                color: Colors.white,
                fontWeight: FontWeight.w400)),
      ),
//      key: scaffoldKey,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: 50.w, left: 18.w, right: 18.w),
                    child: Text(
                      businessDetail,
                      style: TextStyle(
                          color: signInColor,
                          fontSize: 28.sp,
                          fontFamily: 'Metropolis',
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: 4.w, bottom: 8.w, left: 18.w, right: 18.w),
                    child: Text(
                      businessText,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: textColorGrey,
                        fontSize: 12.sp,
                        /*fontFamily: 'Metropolis',*/
                        fontWeight: FontWeight.w400,
                        height: 1.5.h,
                      ),
                    ),
                  ),
                  Form(
                    key: globalFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 15.w,
                        ),
                        buildBusinessDataColumn(context),
                        Padding(
                          padding: EdgeInsets.only(
                              top: 40.w, bottom: 8.w, left: 18.w, right: 18.w),
                          child: SizedBox(
                              height: 50.w,
                              width: double.infinity,
                              child: ElevatedButton(
                                  child:  Text("Save & Continue",
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        /*fontFamily: 'Metropolis',*/
                                      )),

                                  style: ButtonStyle(

                                      foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.white),
                                      backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          btnColorLogin),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                          const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                              side: BorderSide(
                                                  color: Colors.transparent)))),
                                  onPressed: () {
                                    FocusScope.of(context).unfocus();
                                    handleNextClick();
                                  })),

                        ),
                      ],
                    ),
                  )
                ],
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
          padding: EdgeInsets.only(
              top: 20.w, bottom: 8.w, left: 18.w, right: 18.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              TypeAheadFormField(
                textFieldConfiguration: TextFieldConfiguration(
                    controller: _typeAheadController,
                    decoration: textFieldProfile(
                   'Enter Company Name', "Company Name")
                    ),
                    suggestionsCallback: (pattern) {
                  print("Suggestion"+pattern);
                    return suggestionList.where(
                            (x) => x.toLowerCase().contains(pattern)
                    ).toList();
                   },
                itemBuilder: (context, suggestion) {
                  return ListTile(
                    title: Text(suggestion.toString()),
                  );
                },
                transitionBuilder: (context, suggestionsBox, controller) {
                  return suggestionsBox;
                },
                hideSuggestionsOnKeyboardHide: true,
                onSuggestionSelected: (suggestion) {
                  _typeAheadController.text = suggestion.toString();
                },
                errorBuilder:(BuildContext context, Object? error) =>
                    Text(
                        '$error',
                        style: TextStyle(
                            color: Theme.of(context).errorColor
                        )
                    ),
                validator: (input) {
                  if (input == null || input.isEmpty) {
                    return 'Please enter company name';
                  }
                  return null;
                },
                onSaved: (value) =>
                _signupRequestModel?.company = value,

              ),
            ],
          ),
        ),

//        Padding(
//          padding: EdgeInsets.only(
//              top: 20.w, bottom: 8.w, left: 18.w, right: 18.w),
//          child: Column(
//            crossAxisAlignment: CrossAxisAlignment.start,
//            children: [
//
//              TextFormField(
//                  keyboardType: TextInputType.text,
//                  cursorColor: Colors.black,
//                  onSaved: (input) =>
//                  _signupRequestModel?.company = input!,
//                  validator: (input) {
//                    if (input == null || input.isEmpty) {
//                      return "Please enter company name";
//                    }
//                    return null;
//                  },
//                  decoration: textFieldProfile(
//                      'Enter Company Name', "Company Name")),
//            ],
//          ),
//        ),

        Padding(
          padding: EdgeInsets.only(
              top: 20.w, bottom: 8.w, left: 18.w, right: 18.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              DropdownButtonFormField<String>(

                decoration: dropDownProfile(
                    'Select', "Business Area") ,
                isDense: true,
                hint:Text("Select",style: TextStyle(fontSize: 10.sp,fontWeight: FontWeight.w400,color: Colors.black87),),
                isExpanded: true,
                iconSize: 21,
                items:businessAreaList.map((location) {
                  return DropdownMenuItem<String>(
                    child: Text(location),
                    value: location,

                  );
                }).toList(),

                onChanged: (newValue) {
                  _signupRequestModel?.cityStateId=newValue;
                },
                validator: (input) {
                  if (input == null ||
                      input.isEmpty) {
                    return "Please select business area";
                  }
                  return null;
                },

              ),

            ],
          ),
        ),

//        Padding(
//          padding: EdgeInsets.only(
//              top: 20.w, bottom: 8.w, left: 18.w, right: 18.w),
//          child: Column(
//            crossAxisAlignment: CrossAxisAlignment.start,
//            children: [
//
//              TextFormField(
//                  keyboardType: TextInputType.text,
//                  cursorColor: Colors.black,
//                  initialValue: '',
//                  onSaved: (input) =>
//                  _signupRequestModel?.cityStateId = input!,
//                  validator: (input) {
//                    if (input == null ||
//                        input.isEmpty) {
//                      return "Please enter business area";
//                    }
//                    return null;
//                  },
//                  decoration: textFieldProfile(
//                      'Enter Business Area', "Business Area")),
//            ],
//          ),
//        ),

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
        Ui.showSnackBar(context, 'Please enter company name');
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


