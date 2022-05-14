
import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_picker_cupertino.dart';
import 'package:country_pickers/country_picker_dropdown.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:provider/provider.dart';
import 'package:yg_app/app_database/app_database_instance.dart';
import 'package:yg_app/elements/elevated_button_widget.dart';
import 'package:yg_app/elements/elevated_button_widget_2.dart';
import 'package:yg_app/elements/network_icon_widget.dart';
import 'package:yg_app/helper_utils/app_colors.dart';
import 'package:yg_app/helper_utils/app_constants.dart';
import 'package:yg_app/helper_utils/ui_utils.dart';
import 'package:yg_app/model/response/common_response_models/city_state_response.dart';
import 'package:yg_app/model/response/common_response_models/countries_response.dart';

import '../../../elements/decoration_widgets.dart';
import '../../../helper_utils/app_images.dart';
import '../../../model/request/signup_request/signup_request.dart';

class CountryComponent extends StatefulWidget {
  final Function? callback;

  final String? selectedTab;

  const CountryComponent(
      {Key? key,
        // required this.syncFiberResponse,
        required this.callback,
        required this.selectedTab})
      : super(key: key);

  @override
  CountryComponentState createState() => CountryComponentState();
}

class CountryComponentState
    extends State<CountryComponent>
    with AutomaticKeepAliveClientMixin {

  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  SignUpRequestModel? _signupRequestModel;

  String countryString="";
  List<Countries> _countryList=[];

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {

    _resetData();
//    _countryList.addAll(
//        [
//          Countries(id: "1", title: 'Pakistan',countryFlag:pk,countryCode: "PK"),
//          Countries(id: "2", title: 'USA',countryFlag:us,countryCode:"US"),
//          Countries(id: "3", title: 'Afghanistan',countryFlag:af,countryCode:"AF"),
//          Countries(id: "4", title: 'Australia',countryFlag:au,countryCode:"AU"),
//          Countries(id: "5", title: 'Bangladesh',countryFlag:bd,countryCode:"BD"),
//          Countries(id: "6", title: 'Argentina',countryFlag:ar,countryCode:"AR"),
//
//        ]);
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
//    _signupRequestModel?.countryId="AF";
    return  SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
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
            SingleChildScrollView(
              child: Column(

                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: 50.w, left: 18.w, right: 18.w),
                    child: Text(
                      letsGetStarted,
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
                      countryText,
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
                          height: 8.w,
                        ),


                        Padding(
                          padding: EdgeInsets.only(
                              top: 20.w, bottom: 8.w, left: 18.w, right: 18.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              FutureBuilder<List<Countries>?>(
                                  future: AppDbInstance().getDbInstance()
                                      .then((value) =>  value.countriesDao.findAllCountries()),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData && snapshot.data != null) {
                                      return DropdownButtonFormField<String>(

                                        decoration: dropDownProfile(
                                            'Select', "Country") ,
                                        isDense: true,
                                        hint:Text("Select",style: TextStyle(fontSize: 10.sp,fontWeight: FontWeight.w400,color: Colors.black87),),
                                        isExpanded: true,
                                        iconSize: 21,
                                        items:snapshot.data?.map((location) {
                                          return DropdownMenuItem<String>(
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: <Widget>[

                                                const SizedBox(width: 8.0),
                                                NetworkImageIconWidget(
                                                    imageUrl:location.medium.toString()
                                                ),
//                                                Image.network(
//                                                  location.medium.toString(),
//                                                  height: 30.0,
//                                                  width: 30.0,
//                                                ),
                                                const SizedBox(width: 8.0),
                                                Expanded(child: Text(location.conName.toString())),

                                              ],
                                            ),
                                            value: location.conId.toString(),

                                          );}).toList(),

                                        onChanged: (newValue) {
                                          _signupRequestModel?.countryId=newValue;
                                        },
                                        validator: (input) {
                                          if (input == null ||
                                              input.isEmpty) {
                                            return "Please select country";
                                          }
                                          return null;
                                        },

                                      );
                                    }
                                    else {
                                      return DropdownButtonFormField<String>(

                                        decoration: dropDownProfile(
                                            'Select', "Country") ,
                                        isDense: true,
                                        hint:Text("Select",style: TextStyle(fontSize: 10.sp,fontWeight: FontWeight.w400,color: Colors.black87),),
                                        isExpanded: true,
                                        iconSize: 20,
                                        items: const [

                                        ],

                                        onChanged: (newValue) {

                                        },


                                        validator: (value) => value == null ? 'Please select country name' : null,

                                      );
                                    }
                                  }),



                            ],
                          ),
                        ),

//                        Padding(
//                          padding: EdgeInsets.only(
//                              top: 20.w, bottom: 8.w, left: 18.w, right: 18.w),
//                          child: CountryPickerDropdown(
//
//                            underline: InputDecorator(
//                              decoration: dropDownProfile("Select Country", "Country"),
//                            ),
//                            onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
//                            onValuePicked: (Country country) {
//                              print("${country.isoCode}");
//
//                              print("${_signupRequestModel?.countryId}");
//
//
//                              _signupRequestModel?.countryId=country.isoCode;
//                              print("${_signupRequestModel?.countryId}");
//                            },
//                            itemBuilder: (Country country) {
//                              return Row(
//                                children: <Widget>[
//                                  const SizedBox(width: 8.0),
//                                  CountryPickerUtils.getDefaultFlagImage(country),
//                                  const SizedBox(width: 8.0),
//                                  Expanded(child: Text(country.name)),
//                                ],
//                              );
//                            },
//                            itemHeight: null,
//                            isExpanded: true,
//                            //initialValue: 'TR',
//                            icon: const Icon(Icons.arrow_drop_down_outlined),
//                          ),
//                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: 40.w, bottom: 8.w, left: 18.w, right: 18.w),
                          child: SizedBox(
                              height: 50.w,
                              width: double.infinity,
                              child: ElevatedButton(
                                  child:  Text("Proceed",
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
//                                  if (validateAndSave()) {
                                      handleNextClick();
//                                  }
                                  })),
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            ),

          ],
        ),
      ),
    );
  }

  void _openCupertinoCountryPicker() => showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) {
        return CountryPickerCupertino(
          pickerSheetHeight: 300.0,
          onValuePicked: (Country country) =>
              setState(() => _signupRequestModel?.countryId = country.isoCode),
          itemFilter: (c) => ['AR', 'DE', 'GB', 'CN'].contains(c.isoCode),
          priorityList: [
            CountryPickerUtils.getCountryByIsoCode('TR'),
            CountryPickerUtils.getCountryByIsoCode('US'),
          ],
        );
      });

  void handleNextClick() {
if (validationAllPage()) {

      widget.callback!(1);
    }
  }

  _resetData() {
    _signupRequestModel?.countryId=null;

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
    _signupRequestModel?.countryId ??= "AF";
    if (validateAndSave()) {
      if (_signupRequestModel?.countryId == null &&
          Ui.showHide("1")) {
        Ui.showSnackBar(context, 'Please select country');
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

//class Countries {
//  String? id;
//  String? title;
//  String? countryFlag;
//  String? countryCode;
//
//  Countries({
//    @required this.id,
//    @required this.title,
//    @required this.countryFlag,
//    @required this.countryCode,
//  });
//}



