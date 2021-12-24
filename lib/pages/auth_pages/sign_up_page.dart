import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/helper_utils/app_colors.dart';
import 'package:yg_app/helper_utils/app_constants.dart';
import 'package:yg_app/helper_utils/app_constants.dart';
import 'package:yg_app/elements/decoration_widgets.dart';

import '../main_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
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
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            key: scaffoldKey,
            resizeToAvoidBottomInset: true,
            backgroundColor: Colors.white,
            body: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 40.w, bottom: 16.0.w),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        'Sign up',
                        style: TextStyle(
                            fontFamily: 'Metropolis',
                            fontSize: 28.sp,
                            fontWeight: FontWeight.w500,
                            color: textColorBlue),
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
                        color: textColorGrey,
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w400,
                        height: 1.5.h,
                      ),
                    ),
                  ),
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
                                  padding: EdgeInsets.only(
                                      bottom: 8.w, left: 8.w, right: 8.w),
                                  child: TextFormField(
                                      keyboardType: TextInputType.text,
                                      cursorColor: Colors.black,
                                      onSaved: (input) => userName = input!,
                                      validator: (input) {
                                        if (input == null || input.isEmpty) {
                                          return "Please enter username";
                                        }
                                        return null;
                                      },
                                      decoration: textFormFieldDec(
                                          userName)),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      bottom: 8.w, left: 8.w, right: 8.w),
                                  child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      cursorColor: Colors.black,
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(11),
                                      ],
                                      onSaved: (input) =>
                                          telephoneNumber = input!,
                                      validator: (input) {
                                        if (input == null || input.isEmpty || input.length > 11) {
                                          return "Please enter valid telephone number";
                                        }
                                        return null;
                                      },
                                      decoration: textFormFieldDec(
                                          telephoneNumber)),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      bottom: 8.w, left: 8.w, right: 8.w),
                                  child: TextFormField(
                                      keyboardType: TextInputType.text,
                                      cursorColor: Colors.black,
                                      onSaved: (input) => operatorName = input!,
                                      validator: (input) {
                                        if (input == null || input.isEmpty) {
                                          return "Please enter operator";
                                        }
                                        return null;
                                      },
                                      decoration: textFormFieldDec(
                                          operator)),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      bottom: 8.w, left: 8.w, right: 8.w),
                                  child: TextFormField(
                                    keyboardType: TextInputType.emailAddress,
                                    cursorColor: Colors.black,
                                    onSaved: (input) => email = input!,
                                    validator: (input) {
                                      if (input == null || input.isEmpty || !input.isValidEmail()) {
                                        return "Please check your email";
                                      }
                                      return null;
                                    },
                                    decoration:
                                        textFormFieldDec(email),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      bottom: 8.w, left: 8.w, right: 8.w),
                                  child: TextFormField(
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
                                      labelText: password,
                                      labelStyle: TextStyle(fontFamily: 'Metropolis',fontSize: 12.sp),
                                      border: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: textColorGrey),
                                      ),
                                      suffixIcon: GestureDetector(
                                        onTap: () {
                                          _togglevisibility();
                                        },
                                        child: Icon(
                                          _showPassword
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          color: textColorGrey,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      bottom: 8.w, left: 8.w, right: 8.w),
                                  child: TextFormField(
                                    obscureText: !_showPassword,
                                    keyboardType: TextInputType.text,
                                    cursorColor: Colors.black,
                                    onSaved: (input) => confirmPassword = input!,
                                    validator: (input) {
                                      if (input == null ||
                                          input.isEmpty ||
                                          input.length < 8) {
                                        return "Password not matched";
                                      }else if(input != password){
                                        return "Password not matched";
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      labelText: 'Confirm Password',
                                      labelStyle: TextStyle(fontFamily: 'Metropolis',fontSize: 12.sp),
                                      border: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: textColorGrey),
                                      ),
                                      suffixIcon: GestureDetector(
                                        onTap: () {
                                          _togglevisibility();
                                        },
                                        child: Icon(
                                          _showPassword
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          color: textColorGrey,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      bottom: 8.w, left: 8.w, right: 8.w),
                                  child: TextFormField(
                                    keyboardType: TextInputType.text,
                                    cursorColor: Colors.black,
                                    onSaved: (input) => businsessArea = input!,
                                    validator: (input) {
                                      if (input == null || input.isEmpty) {
                                        return "Please enter business area";
                                      }
                                      return null;
                                    },
                                    decoration: textFormFieldDec(
                                        businessArea),
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
                                                  fontWeight: FontWeight.bold,
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
                            child: Text("Sign Up".toUpperCase(),
                                style: TextStyle(fontFamily: 'Metropolis',fontSize: 14.sp)),
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
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) => MainPage()),
                                    (Route<dynamic> route) => false);
                              }
                            })),
                  ),
                ],
              ),
            )));
  }

  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form!.validate() && _termsChecked) {
      form.save();
      return true;
    }else if(!_termsChecked){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please accept Terms & Conditions')));
    }
    return false;
  }
}

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}
