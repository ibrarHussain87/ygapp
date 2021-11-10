import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:yg_app/api_services/api_service_class.dart';
import 'package:yg_app/model/request/login_request/login_request.dart';
import 'package:yg_app/pages/auth_pages/sign_up_page.dart';
import 'package:yg_app/pages/main_page.dart';
import 'package:yg_app/utils/colors.dart';
import 'package:yg_app/utils/images.dart';
import 'package:yg_app/utils/progress_dialog_util.dart';
import 'package:yg_app/utils/shared_pref_util.dart';
import 'package:yg_app/utils/strings.dart';
import 'package:yg_app/widgets/decoration_widgets.dart';

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
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 40.w, bottom: 40.w),
                  child: Image.asset(
                    AppImages.logoImage,
                    width: 60.w,
                    height: 60.h,
                  ),
                ),
                Text(
                  AppStrings.letsGetStarted,
                  style: TextStyle(
                      color: AppColors.textColorBlue,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w400),
                ),
                Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Text(
                    AppStrings.loginDescription,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.textColorGrey,
                      fontSize: 9.sp,
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
                                cursorColor: Colors.black,
                                onSaved: (input) =>
                                    _loginRequestModel.email = input!,
                                validator: (input) {
                                  if (input == null || input.isEmpty) {
                                    return "Please enter username";
                                  }
                                  return null;
                                },
                                decoration:
                                    textFormFieldDec(AppStrings.userName)),
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
                                  return "Password must be greater then 8 characters";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                labelText: AppStrings.password,
                                labelStyle: TextStyle(fontSize: 12.sp),
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppColors.textColorGrey),
                                ),
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    _togglevisibility();
                                  },
                                  child: Icon(
                                    _showPassword
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: AppColors.textColorGrey,
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
                                AppStrings.forgetPassword,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: AppColors.textColorFBlue,
                                  fontSize: 12.sp,
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
                                      style: TextStyle(fontSize: 14.sp)),
                                  style: ButtonStyle(
                                      foregroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.white),
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              AppColors.btnColorLogin),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(8)),
                                              side: BorderSide(color: Colors.transparent)))),
                                  onPressed: () {
                                    if (validateAndSave()) {
                                      ProgressDialogUtil.showDialog(
                                          context, 'Please wait...');

                                      ApiService.login(_loginRequestModel)
                                          .then((value) {
                                        ProgressDialogUtil.hideDialog();
                                        if (value.success) {

                                          SharedPreferenceUtil.addStringToSF(AppStrings.USER_TOKEN_KEY, value.data.token);

                                          Fluttertoast.showToast(
                                              msg: value.message,
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.BOTTOM,
                                              timeInSecForIosWeb: 1
                                          );
                                          Navigator.of(context)
                                              .pushAndRemoveUntil(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          MainPage()),
                                                  (Route<dynamic> route) =>
                                                      false);
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content:
                                                      Text(value.message)));
                                        }
                                      }).onError((error, stackTrace) {
                                        ProgressDialogUtil.hideDialog();
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content:
                                                    Text(error.toString())));
                                      });
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
                  child: Text(
                    AppStrings.signUpStr,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.textColorGrey,
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
}
