import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:yg_app/api_services/api_service_class.dart';
import 'package:yg_app/app_database/app_database_instance.dart';
import 'package:yg_app/elements/decoration_widgets.dart';
import 'package:yg_app/helper_utils/app_colors.dart';
import 'package:yg_app/helper_utils/app_constants.dart';
import 'package:yg_app/helper_utils/app_images.dart';
import 'package:yg_app/helper_utils/connection_status_singleton.dart';
import 'package:yg_app/helper_utils/progress_dialog_util.dart';
import 'package:yg_app/helper_utils/shared_pref_util.dart';
import 'package:yg_app/model/request/login_request/login_request.dart';
import 'signup/signup_page_new.dart';
import 'package:yg_app/pages/main_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool _showPassword = false;
  late LoginRequestModel _loginRequestModel;
  bool? isOnline;

  void _togglevisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  @override
  void initState() {
    _loginRequestModel = LoginRequestModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 40.w, bottom: 40.w),
                  child: Image.asset(
                    logoImage,
                    width: 60.w,
                    height: 60.h,
                  ),
                ),
                Text(
                  letsGetStarted,
                  style: TextStyle(
                      color: textColorBlue,
                      fontSize: 24.sp,
                      /*fontFamily: 'Metropolis',*/
                      fontWeight: FontWeight.w400),
                ),
                Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Text(
                    loginDescription,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: textColorGrey,
                      fontSize: 9.sp,
                      /*fontFamily: 'Metropolis',*/
                      fontWeight: FontWeight.w400,
                      height: 1.5.h,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Center(
                    child: Form(
                      key: globalFormKey,
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                top: 8.w, bottom: 8.w, left: 8.w, right: 8.w),
                            child: TextFormField(
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.allow(RegExp(r'([a-zA-Z0-9@.])')),
                                  LengthLimitingTextInputFormatter(
                                      25),
                                ],
                                cursorColor: Colors.black,
                                onSaved: (input) =>
                                    _loginRequestModel.email = input!,
                                validator: (input) {
                                  if (input == null || input.isEmpty) {
                                    return "Please enter username";
                                  }
                                  return null;
                                },
                                decoration: textFormFieldDec(userName)),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: 8.w, bottom: 8.w, left: 8.w, right: 8.w),
                            child: TextFormField(
                              obscureText: !_showPassword,
                              keyboardType: TextInputType.text,
                              cursorColor: Colors.black,
                              onSaved: (input) =>
                                  _loginRequestModel.password = input!,
                              validator: (input) {
                                if (input == null ||
                                    input.isEmpty ||
                                    input.length < 8) {
                                  return "Password must be at least 8 characters long";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                labelText: password,
                                labelStyle: TextStyle(
                                  fontSize: 12.sp,
                                  /*fontFamily: 'Metropolis',*/
                                ),
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(color: textColorGrey),
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
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: 0, bottom: 8.w, left: 8.w, right: 8.w),
                              child: Text(
                                forgetPassword,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: btnColorLogin,
                                  fontSize: 12.sp,
                                  /*fontFamily: 'Metropolis',*/
                                  fontWeight: FontWeight.w500,
                                  height: 1.5.h,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                          SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                  child: Text("Sign in".toUpperCase(),
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
                                                  Radius.circular(8)),
                                              side: BorderSide(
                                                  color: Colors.transparent)))),
                                  onPressed: () {
                                    FocusScope.of(context).unfocus();
                                    if (validateAndSave()) {
                                      _loginCall();
                                    }
                                  })),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  child: Text(
                    signUpStr,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      /*fontFamily: 'Metropolis',*/
                      color: textColorGrey,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      height: 1.5.h,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignUpPage(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
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

  void _loginCall() {
    check().then((value) {
      if(value){
        ProgressDialogUtil.showDialog(context, 'Please wait...');
        ApiService.login(_loginRequestModel).then((value) {
          ProgressDialogUtil.hideDialog();
          if (value.success!) {
            AppDbInstance.getDbInstance().then((db) async {
              await db.userDao.insertUser(value.data!.user!);
            });

            SharedPreferenceUtil.addStringToSF(
                USER_ID_KEY, value.data!.user!.id.toString());
            SharedPreferenceUtil.addStringToSF(USER_TOKEN_KEY, value.data!.token!);
            SharedPreferenceUtil.addBoolToSF(IS_LOGIN, true);

            Fluttertoast.showToast(
                msg: value.message!,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1);
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => MainPage()),
                    (Route<dynamic> route) => false);
          } else {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(value.message!)));
          }
        }).onError((error, stackTrace) {
          ProgressDialogUtil.hideDialog();
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(error.toString())));
        });
      }
      else{
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("No internet available.".toString())));
      }
    });
  }
}
