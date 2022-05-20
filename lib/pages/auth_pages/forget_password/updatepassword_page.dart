

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:logger/logger.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:yg_app/elements/elevated_button_widget.dart';
import 'package:yg_app/helper_utils/app_colors.dart';

import '../../../api_services/api_service_class.dart';
import '../../../app_database/app_database_instance.dart';
import '../../../elements/decoration_widgets.dart';
import '../../../helper_utils/app_constants.dart';
import '../../../helper_utils/app_images.dart';
import '../../../helper_utils/connection_status_singleton.dart';
import '../../../helper_utils/progress_dialog_util.dart';
import '../../../helper_utils/shared_pref_util.dart';
import '../../../helper_utils/ui_utils.dart';
import '../../../helper_utils/util.dart';
import '../../../model/request/signup_request/signup_request.dart';
import '../../main_page.dart';

class UpdatePasswordPage extends StatefulWidget {

   final SignUpRequestModel signUpRequestModel;

   const UpdatePasswordPage(
      {Key? key,required this.signUpRequestModel})
      : super(key: key);

  @override
  UpdatePasswordPageState createState() => UpdatePasswordPageState();
}

class UpdatePasswordPageState
    extends State<UpdatePasswordPage>{
  final passwordFocus = FocusNode();
  final confirmPasswordFocus = FocusNode();
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  SignUpRequestModel? _signupRequestModel;
  bool _showPassword = false;
  String password = "";
  String confirmPassword = "";
  String otp = "";

  FirebaseAuth auth = FirebaseAuth.instance;
  String verificationID = "";

  bool hasError = false;
  String currentText = "";


  int selectedValue = 1;
  void _togglevisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }
  @override
  void initState() {
    print("Number\t"+widget.signUpRequestModel.telephoneNumber.toString());
    super.initState();
  }

  @override
  void dispose() {

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return  Scaffold(
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
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: 20.w, left: 18.w, right: 18.w),
                    child: Text(
                      updatePasswordText,
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
                      updatePasswordDetails,
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
                        buildUserDataColumn(context),
                        Padding(
                          padding: EdgeInsets.only(
                              top: 40.w, bottom: 8.w, left: 18.w, right: 18.w),
                          child: SizedBox(
                              height: 50.w,
                              width: double.infinity,
                              child: ElevatedButton(
                                  child:  Text("Reset Password",
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
                                      if (widget.signUpRequestModel.telephoneNumber!=null) {
                                          if (kDebugMode) {
                                            print("Tel#"+widget.signUpRequestModel.telephoneNumber.toString());
                                            print("Password"+widget.signUpRequestModel.password.toString());
                                          }
                                      }
                                    }
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


  Column buildUserDataColumn(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [



        Padding(
          padding: EdgeInsets.only(
              top: 20.w, bottom: 8.w, left: 18.w, right: 18.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:EdgeInsets.only(
                   bottom: 6.w,),
                child: Text(
                  passwordString,
                  textAlign: TextAlign.left,

                ),
              ),
              TextFormField(
                focusNode: passwordFocus,
                obscureText: !_showPassword,
                keyboardType:
                TextInputType.text,
                textInputAction: TextInputAction.next,
                onEditingComplete: () => FocusScope.of(context).requestFocus(confirmPasswordFocus),
                cursorColor: Colors.black,
                onSaved: (input) =>
                password = input!,
                validator: (input) {
                  if (input == null ||
                      input.isEmpty ||
                      input.length < 8) {
                    return "Password must be at least 8 characters long";
                  }
                  password = input;
                  return null;
                },
                decoration: InputDecoration(
                  contentPadding:const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
//                  label: Row(
//                    mainAxisSize: MainAxisSize.min,
//                    mainAxisAlignment: MainAxisAlignment.start,
//                    children: [
//                      Text("New Password",style: TextStyle(color: formFieldLabel),),
//                      const Text("*", style: TextStyle(color: Colors.red)),
//                    ],
//                  ),
//                  floatingLabelBehavior:FloatingLabelBehavior.always ,
                  hintStyle: TextStyle(fontSize: 10.sp,fontWeight: FontWeight.w500,color:hintColorGrey),
                  border: OutlineInputBorder(
                      borderRadius:const BorderRadius.all(
                        Radius.circular(5.0),
                      ),
                      borderSide: BorderSide(color: newColorGrey)
                  ),
//                  hintText: "Enter Here",
//                  prefixIcon: IconButton(
//                    onPressed: () {},
//                    icon: SvgPicture.asset(
//                      'assets/ic_password.svg',
//                      color: iconColor,
//                      fit: BoxFit.scaleDown,
//                      height: 16,
//                      width: 16,
//                    ),
//                  ),
                  suffixIcon: GestureDetector(
                    behavior:
                    HitTestBehavior.opaque,
                    onTap: () {
                      _togglevisibility();
                    },
                    child: Icon(
                      _showPassword
                          ? Icons.visibility
                          : Icons
                          .visibility_off,
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
          padding: EdgeInsets.only(
              top: 20.w, bottom: 8.w, left: 18.w, right: 18.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:EdgeInsets.only(
                   bottom: 6.w,),
                child: Text(
                  confirmPasswordString,
                  textAlign: TextAlign.left,

                ),
              ),
              TextFormField(
                focusNode: confirmPasswordFocus,
                obscureText: !_showPassword,
                keyboardType:
                TextInputType.text,
                textInputAction: TextInputAction.next,
                cursorColor: Colors.black,
                onSaved: (input) =>
                widget.signUpRequestModel
                    .password = input!,
                validator: (input) {
                  if (input == null ||
                      input.isEmpty ||
                      input.length < 8) {
                    return "Password must be at least 8 characters long";
                  } else if (input !=
                      password) {
                    return "Password not matched";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  contentPadding:const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
//                  label: Row(
//                    mainAxisSize: MainAxisSize.min,
//                    mainAxisAlignment: MainAxisAlignment.start,
//                    children: [
//                      Text("Confirm Password",style: TextStyle(color: formFieldLabel),),
//                      const Text("*", style: TextStyle(color: Colors.red)),
//                    ],
//                  ),
//                  floatingLabelBehavior:FloatingLabelBehavior.always ,
                  hintStyle: TextStyle(fontSize: 10.sp,fontWeight: FontWeight.w500,color:hintColorGrey),
                  border: OutlineInputBorder(
                      borderRadius:const BorderRadius.all(
                        Radius.circular(5.0),
                      ),
                      borderSide: BorderSide(color: newColorGrey)
                  ),
//                  hintText: "Enter Here",

                  suffixIcon: GestureDetector(
                    behavior:
                    HitTestBehavior.opaque,
                    onTap: () {
                      _togglevisibility();
                    },
                    child: Icon(
                      _showPassword
                          ? Icons.visibility
                          : Icons
                          .visibility_off,
                      color: textColorGrey,
                      size: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),


      ],
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



  void _signUpCall() {
    check().then((value) {
      if (value) {
        ProgressDialogUtil.showDialog(context, 'Please wait...');
        /*remove operator and added static data for parameter*/
        _signupRequestModel?.operator = '1';
        _signupRequestModel?.countryId = '1';
        _signupRequestModel?.email = 'anonymous@gmail.com';
        _signupRequestModel?.name = 'Anonymous';
        Logger().e(_signupRequestModel?.toJson());
        ApiService.signup(_signupRequestModel!).then((value) {
          Logger().e(value.toJson());
          ProgressDialogUtil.hideDialog();
          if (value.errors != null) {
            value.errors!.forEach((key, error) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(error.toString())));
            });
          } else if (value.success!) {
            AppDbInstance().getDbInstance().then((db) async {
              await db.userDao.insertUser(value.data!.user!);
            });
            SharedPreferenceUtil.addStringToSF(
                USER_ID_KEY, value.data!.user!.id.toString());
            SharedPreferenceUtil.addStringToSF(
                USER_TOKEN_KEY, value.data!.token!);
            SharedPreferenceUtil.addBoolToSF(IS_LOGIN, true);

            Fluttertoast.showToast(
                msg: value.message ?? "",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1);
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const MainPage()),
                    (Route<dynamic> route) => false);
          } else {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(value.message ?? "")));
          }
        }).onError((error, stackTrace) {
          ProgressDialogUtil.hideDialog();
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(error.toString())));
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("No internet available.".toString())));
      }
    });
  }

}





