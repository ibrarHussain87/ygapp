import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:stylish_dialog/stylish_dialog.dart';
import 'package:yg_app/api_services/api_service_class.dart';
import 'package:yg_app/helper_utils/app_colors.dart';
import 'package:yg_app/helper_utils/app_constants.dart';
import 'package:yg_app/helper_utils/dialog_builder.dart';
import 'package:yg_app/model/server_response.dart';
import 'package:yg_app/pages/auth_pages/signup/country_search_page.dart';

import '../../../app_database/app_database_instance.dart';
import '../../../elements/circle_icon_widget.dart';
import '../../../helper_utils/navigation_utils.dart';
import '../../../model/request/signup_request/signup_request.dart';
import '../../../model/response/common_response_models/countries_response.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({Key? key}) : super(key: key);

  @override
  ForgetPasswordPageState createState() => ForgetPasswordPageState();
}

class ForgetPasswordPageState extends State<ForgetPasswordPage> {
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  String otp = "";
  SignUpRequestModel? _signupRequestModel;
  FirebaseAuth auth = FirebaseAuth.instance;
  String verificationID = "";
  var phoneController = TextEditingController();
  var emailController = TextEditingController();
  bool isEmail = true;
  bool hasError = false;
  String currentText = "";
  String? telNumber = "";
  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 30;

  var isResend = false;

  bool showTimer = true;
  ValueNotifier<Countries?>? _notifierCountry;
  List<Countries> countriesList = [];
  String? code;

  @override
  void initState() {
    _signupRequestModel = SignUpRequestModel();
    AppDbInstance().getDbInstance().then((value) => {
          value.countriesDao.findAllCountries().then((value) {
            setState(() {
              countriesList = value;
              code = countriesList.first.countryPhoneCode;
              _signupRequestModel?.countryId =
                  countriesList.first.conId.toString();
              _signupRequestModel?.country = countriesList.first;
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
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: appbarIconColor),
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
                    padding:
                        EdgeInsets.only(top: 20.w, left: 18.w, right: 18.w),
                    child: Text(
                      forgetPasswordText,
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 28.sp,
                          //
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
                        /**/
                        fontWeight: FontWeight.w400,
                        height: 1.5.h,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 18.w, top: 10.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isEmail = true;
                              _resetData();
                            });
                          },
                          child: Container(
                              height: 40.w,
                              width: MediaQuery.of(context).size.width/3.0,
                              decoration: BoxDecoration(
                                  color:
                                  isEmail ? Colors.green : Colors.white,
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(2.0),
                                  )),
                              child: Center(
                                child: Text("Email",
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        color: isEmail
                                            ? Colors.white
                                            : Colors.black54
                                      /**/
                                    )),
                              )),
                        ),
                        SizedBox(
                          width: 20.w,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isEmail = false;
                              _resetData();
                            });
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  color:
                                  isEmail ? Colors.white : Colors.green,
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(2.0),
                                  )),
                              height: 40.w,
                              width: MediaQuery.of(context).size.width/3.0,
                              child: Center(
                                child: Text("Phone Number",
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        color: isEmail
                                            ? Colors.black54
                                            : Colors.white
                                      /**/
                                    )),
                              )),
                        ),
                      ],
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

                        //For Email
                        Visibility(
                          visible: isEmail ? true : false,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    top: 14.w, bottom: 6.w, left: 18.w, right: 18.w),
                                child: const Text(
                                  "Email",
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    bottom: 8.w, left: 18.w, right: 18.w),
                                child:  TextFormField(
                                    keyboardType:
                                    TextInputType.emailAddress,
                                    textInputAction: TextInputAction.next,
                                    cursorColor: Colors.black,
                                    onSaved: (input) =>
                                    _signupRequestModel?.email = input!,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'([a-zA-Z0-9@._])')),
                                      LengthLimitingTextInputFormatter(
                                          30),
                                    ],
                                    validator: (input) {
                                      if (input == null ||
                                          input.isEmpty ||
                                          !input.isValidEmail()) {
                                        return "Please check your email";
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                        contentPadding:
                                        const EdgeInsets.symmetric(
                                            vertical: 8.0,
                                            horizontal: 8.0),
                                        hintStyle: TextStyle(
                                            fontSize: 10.sp,
                                            fontWeight: FontWeight.w500,
                                            color: hintColorGrey),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                            const BorderRadius.all(
                                              Radius.circular(5.0),
                                            ),
                                            borderSide: BorderSide(
                                                color: newColorGrey)
                                        )
                                    )
                                ),
                              ),
                            ],
                          ),
                        ),

                        // For Phone Number
                        Visibility(
                          visible: isEmail ? false : true,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    top: 14.w, bottom: 6.w, left: 18.w, right: 18.w),
                                child: Text(
                                  mobileNumber,
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    bottom: 8.w, left: 18.w, right: 18.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextFormField(
                                      keyboardType: TextInputType.phone,
                                      cursorColor: Colors.black,
                                      onSaved: (input) => _signupRequestModel!
                                          .telephoneNumber = "+$code" + input!,
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
                                      decoration: InputDecoration(
                                        contentPadding: const EdgeInsets.symmetric(
                                            vertical: 8.0, horizontal: 8.0),
//                                  label: Row(
//                                    mainAxisSize: MainAxisSize.min,
//                                    mainAxisAlignment: MainAxisAlignment.start,
//                                    children: [
//                                      Text("Mobile Number",style: TextStyle(color: formFieldLabel),),
//                                      const Text("*", style: TextStyle(color: Colors.red)),
//                                    ],
//                                  ),
//                                  floatingLabelBehavior:FloatingLabelBehavior.always ,
//                                  floatingLabelAlignment: FloatingLabelAlignment.start,
                                        hintStyle: TextStyle(
                                            fontSize: 10.sp,
                                            fontWeight: FontWeight.w500,
                                            color: hintColorGrey),
                                        border: OutlineInputBorder(
                                            borderRadius: const BorderRadius.all(
                                              Radius.circular(5.0),
                                            ),
                                            borderSide:
                                                BorderSide(color: newColorGrey)),

                                        prefixIcon: GestureDetector(
                                          onTap: () async {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    SelectCountryPage(
                                                  title: "Country Code",
                                                  isCodeVisible: true,
                                                  callback: (Countries country) => {
                                                    setState(() {
                                                      _signupRequestModel?.country =
                                                          country;
                                                      code = _signupRequestModel
                                                          ?.country?.countryPhoneCode;
//                                            _notifierCountry?.value=_signupRequestModel?.country;
                                                    })
                                                  },
                                                ),
                                              ),
                                            );
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                const SizedBox(
                                                  width: 2.0,
                                                ),
                                                CircleImageIconWidget(
                                                    imageUrl: _signupRequestModel
                                                            ?.country?.medium
                                                            .toString() ??
                                                        ""),
                                                const SizedBox(
                                                  width: 8.0,
                                                ),
                                                Text(
                                                  _signupRequestModel
                                                          ?.country?.countryPhoneCode
                                                          .toString() ??
                                                      "",
                                                  textAlign: TextAlign.start,
                                                ),
                                                const SizedBox(
                                                  width: 2.0,
                                                ),
                                                const Icon(
                                                  Icons.arrow_drop_down,
                                                  color: Colors.grey,
                                                ),
                                                const Text(
                                                  "|",
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 2.0,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
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
                              child: TextButton(
                                  child: Text("Send Code",
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        /**/
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
                                  onPressed: () async{
                                    FocusScope.of(context).unfocus();
                                    if (validateAndSave()) {
                                      if (_signupRequestModel
                                              ?.telephoneNumber !=
                                          null || _signupRequestModel
                                              ?.email !=
                                          null) {

                                        DialogBuilder(context,title:"please wait...").showLoadingDialog();

                                        // if user enter email
                                        if(_signupRequestModel?.email!=null) {
                                          if (kDebugMode) {
                                            print("SignUp Model" +
                                                _signupRequestModel!
                                                    .email
                                                    .toString());
                                          }
                                         var response = await ApiService()
                                                .checkUserExist('email',
                                                email: _signupRequestModel!
                                                    .email);
                                          DialogBuilder(context).hideDialog();
                                          if (response.success!) {
                                            Fluttertoast.showToast(msg: response.message.toString());
                                            // openVerifyCodeScreen(context,
                                            //     _signupRequestModel!, false);
                                          } else {
                                            showGenericDialog(
                                                'Alert',
                                                response.message.toString(),
                                                context,
                                                StylishDialogType.ERROR,
                                                'Ok',
                                                    () {});
                                          }
                                        }
                                        // if user not enter email
                                        else {
                                          if (kDebugMode) {
                                            print("SignUp Model" +
                                                _signupRequestModel!
                                                    .telephoneNumber
                                                    .toString());
                                          }
                                           var response = await ApiService()
                                            .checkUserExist('phone',
                                                number: _signupRequestModel!
                                                    .telephoneNumber);
                                          DialogBuilder(context).hideDialog();
                                          if (response.success!) {
                                            Fluttertoast.showToast(msg: response.message.toString());
                                            openVerifyCodeScreen(context,
                                                _signupRequestModel!, false);
                                          } else {
                                            showGenericDialog(
                                                'Alert',
                                                response.message.toString(),
                                                context,
                                                StylishDialogType.ERROR,
                                                'Ok',
                                                    () {});
                                          }
                                        }



                                      }
                                    }
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

  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  _resetData() {
    _signupRequestModel?.telephoneNumber = null;
    _signupRequestModel?.email = null;
    emailController.clear();
    phoneController.clear();
  }
}
extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}
extension PhoneValidator on String {
  bool isValidNumber() {
    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    return RegExp(pattern).hasMatch(this);
  }
}
