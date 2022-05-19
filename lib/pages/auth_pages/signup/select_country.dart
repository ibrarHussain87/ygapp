import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:yg_app/app_database/app_database_instance.dart';
import 'package:yg_app/helper_utils/app_colors.dart';
import 'package:yg_app/helper_utils/app_constants.dart';
import 'package:yg_app/helper_utils/ui_utils.dart';
import 'package:yg_app/model/response/common_response_models/countries_response.dart';
import 'package:yg_app/pages/auth_pages/signup/country_search_page.dart';

import '../../../api_services/api_service_class.dart';
import '../../../elements/circle_icon_widget.dart';
import '../../../elements/custom_header.dart';
import '../../../helper_utils/progress_dialog_util.dart';
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

class CountryComponentState extends State<CountryComponent>
    with AutomaticKeepAliveClientMixin {
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  SignUpRequestModel? _signupRequestModel;

  String countryString = "";

  List<Countries> countriesList = [];


  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    _resetData();
    AppDbInstance().getDbInstance().then((value) => {
          value.countriesDao.findAllCountries().then((value) {
            setState(() {
              countriesList = value;
              _signupRequestModel?.countryId=countriesList.first.conId.toString();
              _signupRequestModel?.country=countriesList.first;
//              _preConfigCall(countriesList.first.conId.toString());
            });
          })
        });
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
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        appBar: appBar(context, "Registration"),
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
                    padding:
                        EdgeInsets.only(top: 50.w, left: 18.w, right: 18.w),
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 8.w,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 8.w, bottom: 8.w, left: 18.w, right: 18.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            GestureDetector(
                              onTap: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>  SelectCountryPage(title:"Country",isCodeVisible: false, callback:(Countries country)=>{
                                      setState(() {
//                                        _notifierCountry?.value=country,
                                        _signupRequestModel?.countryId=country.conId.toString();
                                        _signupRequestModel?.country=country;
//                                        _preConfigCall(country.conId.toString());

                                      }
                                      )


                                    },
                                    ),
                                  ),
                                );
                              },
                              child:Container(
                                padding: const EdgeInsets.all(4.0),
                                child: InputDecorator(
                                  decoration: InputDecoration(
                                      contentPadding:const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                                      label: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Text("Country",style: TextStyle(color: formFieldLabel,fontSize: 12.w),),
                                          const Text("*", style: TextStyle(color: Colors.red)),
                                        ],
                                      ),
                                      suffixIcon:const Icon(Icons.arrow_drop_down,color: Colors.black87,),
                                      floatingLabelBehavior:FloatingLabelBehavior.always ,
                                      hintText: "Select",
                                      hintStyle:  TextStyle(fontSize: 12.sp,fontWeight: FontWeight.w500,color:hintColorGrey),
                                      border: OutlineInputBorder(
                                          borderRadius:const BorderRadius.all(
                                            Radius.circular(5.0),
                                          ),
                                          borderSide: BorderSide(color: newColorGrey)
                                      )
                                  ),
                                  child: Row(
                                    children: [
                                      CircleImageIconWidget(
                                          imageUrl:
                                          _signupRequestModel?.country?.medium.toString() ?? ""),
                                      const SizedBox(width: 8.0,),
                                      Expanded(
                                          flex:8,
                                          child: Text(
                                            _signupRequestModel?.country?.conName.toString() ?? "Select",textAlign: TextAlign.start,)),

                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 40.w, bottom: 8.w, left: 18.w, right: 18.w),
                        child: SizedBox(
                            height: 50.w,
                            width: double.infinity,
                            child: ElevatedButton(
                                child: Text("Proceed",
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void handleNextClick() {
    if (validationAllPage()) {
      _preConfigCall(_signupRequestModel?.countryId.toString());
      widget.callback!(1);
    }
  }

  _resetData() {
    _signupRequestModel?.countryId = null;
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
//    if (validateAndSave()) {
      if (_signupRequestModel?.countryId == null) {
        Ui.showSnackBar(context, 'Please select country');
        return false;
      } else {
        return true;
      }
//    }
//    return false;
    //  return true;
  }

  void _preConfigCall(String? countryId) {
    ProgressDialogUtil.showDialog(context, 'Please wait...');
    ApiService.preConfig(countryId!).then((value) {
      ProgressDialogUtil.hideDialog();
      if (value.success!) {
        _signupRequestModel?.config = value.data!.config.toString();
        if (kDebugMode) {
          print("Data Config:" + value.data!.config.toString());
        }
      } else {
        if (kDebugMode) {
          print("Error" + value.message.toString());
        }
      }
    }).onError((error, stackTrace) {
      ProgressDialogUtil.hideDialog();
      if (kDebugMode) {
        print("Error" + error.toString());
      }
    });
  }
}
