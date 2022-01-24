import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:yg_app/api_services/api_service_class.dart';
import 'package:yg_app/app_database/app_database_instance.dart';
import 'package:yg_app/helper_utils/app_colors.dart';
import 'package:yg_app/helper_utils/app_constants.dart';
import 'package:yg_app/helper_utils/app_constants.dart';
import 'package:yg_app/elements/decoration_widgets.dart';
import 'package:yg_app/helper_utils/connection_status_singleton.dart';
import 'package:yg_app/helper_utils/progress_dialog_util.dart';
import 'package:yg_app/helper_utils/shared_pref_util.dart';
import 'package:yg_app/model/request/signup_request/signup_request.dart';

import '../main_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  late SignUpRequestModel _signupRequestModel;
  bool _showPassword = false;
  bool _termsChecked = false;
  String userName = "";
  String email = "";
  String telephoneNumber = "";
  String operatorName = "";
  String password = "";
  String confirmPassword = "";
  String businsessArea = "";

  void _togglevisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  @override
  void initState() {
    _signupRequestModel = SignUpRequestModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery
        .of(context)
        .size
        .width;
    double height = MediaQuery
        .of(context)
        .size
        .height;

    return SafeArea(
        child: Scaffold(
            key: scaffoldKey,
            resizeToAvoidBottomInset: true,
            backgroundColor: Colors.white,
            body: Stack(
              children: [
                /*Image.asset(
                  "images/splash.png",
                  width: width,
                  height: height,
                  fit: BoxFit.fill,
                ),*/
                Container(
                  color: skyBlueColor,
                  width: width,
                  height: height,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 35.w, bottom: 16.0.w),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Text(
                          'Sign up',
                          style: TextStyle(
                              fontFamily: 'Metropolis',
                              fontSize: 28.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        'Delivery options and fees may vary based\non your country selection',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Metropolis',
                          color: Colors.white,
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w400,
                          height: 1.5.h,
                        ),
                      ),
                    ),
                    SizedBox(height: 10.w,),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(topRight: Radius.circular(15.w),topLeft: Radius.circular(15.w)),
                            gradient: const LinearGradient(
                                colors: [Colors.white, Colors.white],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter)),
                        child: Column(
                          children: [
                            Form(
                              key: globalFormKey,
                              child: Expanded(
                                child: SingleChildScrollView(
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 16.w, right: 16.w),
                                    child: Center(
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(top: 16.w,
                                                bottom: 8.w, left: 8.w, right: 8.w),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(telephoneNumberLabel,
                                                    style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w500,color: Colors.black)),
                                                TextFormField(
                                                    keyboardType: TextInputType.number,
                                                    cursorColor: Colors.black,
                                                    inputFormatters: [
                                                      LengthLimitingTextInputFormatter(
                                                          11),
                                                    ],
                                                    onSaved: (input) =>
                                                    _signupRequestModel.telephoneNumber =
                                                    input!,
                                                    validator: (input) {
                                                      if (input == null ||
                                                          input.isEmpty ||
                                                          input.length > 11) {
                                                        return "Please enter valid telephone number";
                                                      }
                                                      return null;
                                                    },
                                                    decoration: textFormFieldDecSignup(
                                                        telephoneNumberLabel,"assets/ic_call.svg")),
                                              ],
                                            )
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                bottom: 8.w, left: 8.w, right: 8.w),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(operator,
                                                    style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w500,color: Colors.black)),
                                                TextFormField(
                                                    keyboardType: TextInputType.text,
                                                    cursorColor: Colors.black,
                                                    onSaved: (input) =>
                                                    _signupRequestModel.operator = input!,
                                                    validator: (input) {
                                                      if (input == null ||
                                                          input.isEmpty) {
                                                        return "Please enter operator";
                                                      }
                                                      return null;
                                                    },
                                                    decoration: textFormFieldDecSignup(
                                                    operator,"assets/ic_operator.svg")
                                                ),
                                              ],
                                            ),

                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top: 8.w,
                                                bottom: 8.w, left: 8.w, right: 8.w),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(userNameLabel,
                                                    style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w500,color: Colors.black)),
                                                TextFormField(
                                                    keyboardType: TextInputType.text,
                                                    cursorColor: Colors.black,
                                                    onSaved: (input) =>
                                                    _signupRequestModel.name = input!,
                                                    validator: (input) {
                                                      if (input == null ||
                                                          input.isEmpty) {
                                                        return "Please enter username";
                                                      }
                                                      return null;
                                                    },
                                                    decoration: textFormFieldDecSignup(
                                                    userNameLabel,"assets/ic_profile.svg")
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top: 8.w,
                                                bottom: 8.w, left: 8.w, right: 8.w),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(emailLabel,
                                                    style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w500,color: Colors.black)),
                                                TextFormField(
                                                  keyboardType: TextInputType
                                                      .emailAddress,
                                                  cursorColor: Colors.black,
                                                  onSaved: (input) =>
                                                  _signupRequestModel.email = input!,
                                                  validator: (input) {
                                                    if (input == null || input.isEmpty ||
                                                        !input.isValidEmail()) {
                                                      return "Please check your email";
                                                    }
                                                    return null;
                                                  },
                                                    decoration: textFormFieldDecSignup(
                                                        emailLabel,"assets/ic_email.svg")
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top: 8.w,
                                                bottom: 8.w, left: 8.w, right: 8.w),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(passwordLabel,
                                                    style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w500,color: Colors.black)),
                                                TextFormField(
                                                  obscureText: !_showPassword,
                                                  keyboardType: TextInputType.text,
                                                  cursorColor: Colors.black,
                                                  onSaved: (input) => password = input!,
                                                  validator: (input) {
                                                    if (input == null ||
                                                        input.isEmpty ||
                                                        input.length < 8) {
                                                      return "Password must be greater then 8 characters";
                                                    }
                                                    password = input;
                                                    return null;
                                                  },
                                                  decoration: InputDecoration(
                                                    hintText: "Enter Here",
                                                    hintStyle: TextStyle(fontSize: 10.sp,fontWeight: FontWeight.w400,color: Colors.black87),
                                                    prefixIcon: IconButton(
                                                      onPressed: (){

                                                      },
                                                      icon: SvgPicture.asset(
                                                        'assets/ic_password.svg',
                                                        color: iconColor,
                                                        fit: BoxFit.scaleDown,
                                                        height: 16,
                                                        width: 16,
                                                      ),
                                                    ),
                                                    border: UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: textColorGrey),
                                                    ),
                                                    suffixIcon: GestureDetector(
                                                      behavior: HitTestBehavior.opaque,
                                                      onTap: () {
                                                        _togglevisibility();
                                                      },
                                                      child: Icon(
                                                        _showPassword
                                                            ? Icons.visibility
                                                            : Icons.visibility_off,
                                                        color: textColorGrey,
                                                        size: 18,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top: 8.w,
                                                bottom: 8.w, left: 8.w, right: 8.w),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text('Confirm Password',
                                                    style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w500,color: Colors.black)),
                                                TextFormField(
                                                  obscureText: !_showPassword,
                                                  keyboardType: TextInputType.text,
                                                  cursorColor: Colors.black,
                                                  onSaved: (input) =>
                                                  _signupRequestModel.password = input!,
                                                  validator: (input) {
                                                    if (input == null ||
                                                        input.isEmpty ||
                                                        input.length < 8) {
                                                      return "Password not matched";
                                                    } else if (input != password) {
                                                      return "Password not matched";
                                                    }
                                                    return null;
                                                  },
                                                  decoration: InputDecoration(
                                                    hintText: "Enter Here",
                                                    hintStyle: TextStyle(fontSize: 10.sp,fontWeight: FontWeight.w400,color: Colors.black87),
                                                    prefixIcon: IconButton(
                                                      onPressed: (){

                                                      },
                                                      icon: SvgPicture.asset(
                                                        'assets/ic_confirm_password.svg',
                                                        color: iconColor,
                                                        fit: BoxFit.scaleDown,
                                                        height: 16,
                                                        width: 16,
                                                      ),
                                                    ),
                                                    border: UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: textColorGrey),
                                                    ),
                                                    suffixIcon: GestureDetector(
                                                      behavior: HitTestBehavior.opaque,
                                                      onTap: () {
                                                        _togglevisibility();
                                                      },
                                                      child: Icon(
                                                        _showPassword
                                                            ? Icons.visibility
                                                            : Icons.visibility_off,
                                                        color: textColorGrey,
                                                        size: 18,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top: 8.w,
                                                bottom: 8.w, left: 8.w, right: 8.w),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(businessArea,
                                                    style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w500,color: Colors.black)),
                                                TextFormField(
                                                  keyboardType: TextInputType.text,
                                                  cursorColor: Colors.black,
                                                  onSaved: (input) =>
                                                  _signupRequestModel.cityStateId =
                                                  input!,
                                                  validator: (input) {
                                                    if (input == null || input.isEmpty) {
                                                      return "Please enter business area";
                                                    }
                                                    return null;
                                                  },
                                                  decoration: textFormFieldDecSignup(
                                                      businessArea,'assets/ic_business_area.svg'),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top: 8.w,
                                                bottom: 8.w, left: 8.w, right: 8.w),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(company,
                                                    style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w500,color: Colors.black)),
                                                TextFormField(
                                                  keyboardType: TextInputType.text,
                                                  cursorColor: Colors.black,
                                                  onSaved: (input) =>
                                                  _signupRequestModel.company =
                                                  input!,
                                                  validator: (input) {
                                                    if (input == null || input.isEmpty) {
                                                      return "Please enter company name";
                                                    }
                                                    return null;
                                                  },
                                                  decoration: textFormFieldDecSignup(
                                                      company,'assets/ic_business_area.svg'),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Checkbox(
                                                  value: _termsChecked,
                                                  onChanged: (val) {
                                                    setState(() {
                                                      _termsChecked = val!;
                                                    });
                                                  }),
                                              RichText(
                                                text: TextSpan(
                                                  // Note: Styles for TextSpans must be explicitly defined.
                                                  // Child text spans will inherit styles from parent
                                                  style: TextStyle(
                                                    fontFamily: 'Metropolis',
                                                    fontSize: 14.0.sp,
                                                    color: Colors.black,
                                                  ),
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                        text: 'I Agree to ',
                                                        style: TextStyle(
                                                            fontFamily: 'Metropolis',
                                                            fontSize: 12.sp,
                                                            color:
                                                            textColorGrey)),
                                                    TextSpan(
                                                        text: 'Terms & Conditions',
                                                        style: TextStyle(
                                                            fontFamily: 'Metropolis',
                                                            fontSize: 12.sp,
                                                            fontWeight: FontWeight
                                                                .bold,
                                                            color: Colors.black87)),
                                                  ],
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(16.w),
                              child: SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                      child: Text("Sign Up",
                                          style: TextStyle(fontFamily: 'Metropolis',
                                              fontSize: 14.sp)),
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
                                                      Radius.circular(8)),
                                                  side: BorderSide(
                                                      color: Colors.transparent)))),
                                      onPressed: () {
                                        if (validateAndSave()) {
                                          /*Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => MainPage()),
                                  (Route<dynamic> route) => false);*/
                                          _signUpCall();
                                        }
                                      })),
                            ),
                          ],
                        ),
                      )
                    )
                  ],
                )
              ],
            )
        )
    );
  }

  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form!.validate() && _termsChecked) {
      form.save();
      return true;
    } else if (!_termsChecked) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please accept Terms & Conditions')));
    }
    return false;
  }

  void _signUpCall() {
    check().then((value) {
      if (value) {
        ProgressDialogUtil.showDialog(context, 'Please wait...');
        _signupRequestModel.countryId = '1';
        ApiService.signup(_signupRequestModel).then((value) {
          ProgressDialogUtil.hideDialog();
          if (value.success) {
            AppDbInstance.getDbInstance().then((db) async {
              await db.userDao.insertUser(value.data.user);
            });

            SharedPreferenceUtil.addStringToSF(
                USER_ID_KEY, value.data.user.id.toString());
            SharedPreferenceUtil.addStringToSF(
                USER_TOKEN_KEY, value.data.token);
            SharedPreferenceUtil.addBoolToSF(IS_LOGIN, true);

            Fluttertoast.showToast(
                msg: value.message,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1);
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const MainPage()),
                    (Route<dynamic> route) => false);
          } else {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(value.message)));
          }
        }).onError((error, stackTrace) {
          ProgressDialogUtil.hideDialog();
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(error.toString())));
        });
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(
            SnackBar(content: Text("No internet available.".toString())));
      }
    });
  }
}

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}
