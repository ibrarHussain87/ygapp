import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:timer_button/timer_button.dart';
import 'package:yg_app/helper_utils/app_colors.dart';
import 'package:yg_app/helper_utils/app_constants.dart';
import 'package:yg_app/helper_utils/progress_dialog_util.dart';
import 'package:yg_app/helper_utils/ui_utils.dart';
import 'package:yg_app/pages/auth_pages/signup/country_search_page.dart';
import '../../../app_database/app_database_instance.dart';
import '../../../elements/circle_icon_widget.dart';
import '../../../elements/decoration_widgets.dart';
import '../../../helper_utils/app_images.dart';
import '../../../helper_utils/navigation_utils.dart';
import '../../../helper_utils/util.dart';
import '../../../model/request/signup_request/signup_request.dart';
import '../../../model/response/common_response_models/countries_response.dart';

class ForgetPasswordPage extends StatefulWidget {


  const ForgetPasswordPage(
      {Key? key})
      : super(key: key);

  @override
  ForgetPasswordPageState createState() => ForgetPasswordPageState();
}

class ForgetPasswordPageState
    extends State<ForgetPasswordPage> {

  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  String otp = "";
  SignUpRequestModel? _signupRequestModel;
  FirebaseAuth auth = FirebaseAuth.instance;
  String verificationID = "";

  bool hasError = false;
  String currentText = "";
  String? telNumber = "";
  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 30;

  var isResend=false;

  bool showTimer=true;
  ValueNotifier<Countries?>? _notifierCountry;
  List<Countries> countriesList = [];
  String? code;

  @override
  void initState() {
    _signupRequestModel=SignUpRequestModel();
    AppDbInstance().getDbInstance().then((value) => {
      value.countriesDao.findAllCountries().then((value) {
        setState(() {
          countriesList = value;
          _notifierCountry=ValueNotifier(countriesList.first);
          code=countriesList.first.countryPhoneCode;
          _signupRequestModel?.countryId=countriesList.first.conId.toString();
          _signupRequestModel?.country=countriesList.first;
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
    return  SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color:appbarIconColor),
            onPressed: () => Navigator.of(context).pop(),
          ),

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
                        top: 20.w, left: 18.w, right: 18.w),
                    child: Text(
                      forgetPasswordText,
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 28.sp,
                          fontFamily: 'Metropolis',
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: 4.w, bottom: 8.w, left: 18.w, right: 18.w),
                    child: Text(
                      forgetPasswordDetails,
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
//                        Padding(
//                          padding: EdgeInsets.only(
//                              top: 20.w, bottom: 8.w, left: 18.w, right: 18.w),
//                          child: Column(
//                            crossAxisAlignment: CrossAxisAlignment.start,
//                            children: [
//                              IntlPhoneField(
//                                decoration: textFieldProfile(
//                                    '',telephoneNumberLabel),
//                                initialCountryCode:'PK',
//                                disableLengthCheck: false,
//                                onChanged: (phone){
//                                  Utils.validateMobile(phone.number);
//                                },
//                                onSaved: (input) =>
//                                _signupRequestModel?.telephoneNumber = input?.completeNumber,
//                                validator: (input) {
//                                  if (input == null) {
//                                    return "Please enter number";
//                                  }
//                                  return null;
//                                },
//                              ),
//
//                            ],
//                          ),
//                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: 20.w, bottom: 8.w, left: 18.w, right: 18.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              TextFormField(
                                keyboardType: TextInputType.phone,
                                cursorColor: Colors.black,
                                onSaved: (input) => _signupRequestModel!.telephoneNumber = "+$code"+input!,
//                  onChanged: (phone){
//                    Utils.validateMobile(phone);
//                  },
                                validator: (input) {
                                  if (input == null ||
                                      input.isEmpty ||
                                      !input.isValidNumber()) {
                                    return "Please check your phone number";
                                  }
                                  return null;
                                },
                                decoration:InputDecoration(
                                  contentPadding:const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                                  label: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text("Mobile Number",style: TextStyle(color: formFieldLabel),),
                                      const Text("*", style: TextStyle(color: Colors.red)),
                                    ],
                                  ),
                                  floatingLabelBehavior:FloatingLabelBehavior.always ,
                                  floatingLabelAlignment: FloatingLabelAlignment.start,
                                  hintStyle: TextStyle(fontSize: 10.sp,fontWeight: FontWeight.w500,color:hintColorGrey),
                                  border: OutlineInputBorder(
                                      borderRadius:const BorderRadius.all(
                                        Radius.circular(5.0),
                                      ),
                                      borderSide: BorderSide(color: newColorGrey)
                                  ),

                                  prefixIcon:  GestureDetector(
                                    onTap:()=>{
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>  SelectCountryPage(title:"Country Code",isCodeVisible: true,callback:(Countries country)=>{
                                            _signupRequestModel?.country=country,
                                            code=_signupRequestModel?.country?.countryPhoneCode,
                                            _notifierCountry?.value=_signupRequestModel?.country,
                                          },
                                          ),
                                        ),
                                      )
                                    },
                                    child: ValueListenableBuilder(
                                      valueListenable: _notifierCountry!,
                                      builder: (context, Countries? value, child){
                                        return  Container(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              const Icon(Icons.arrow_drop_down,color: Colors.black87,),
                                              CircleImageIconWidget(
                                                  imageUrl:
                                                  _notifierCountry?.value?.medium.toString() ?? ""),
                                              const SizedBox(width: 8.0,),
                                              Text(
                                                _notifierCountry?.value?.countryPhoneCode.toString() ?? "",textAlign: TextAlign.start,),

                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),

                                ),
                              )
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
                                  child:  Text("Send Code",
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
                                    if (validateAndSave()) {
                                      if (_signupRequestModel
                                          ?.telephoneNumber !=
                                          null) {
                                        if (kDebugMode) {
                                          print("SignUp Model"+_signupRequestModel!.telephoneNumber.toString());
                                        }
                                       openVerifyCodeScreen(context, _signupRequestModel!,false);
                                      }
                                    }
                                  }
                                  )
                          ),
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



  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }


}

extension PhoneValidator on String {
  bool isValidNumber() {
    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    return RegExp(pattern).hasMatch(this);
  }
}




