import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';
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
import 'package:yg_app/pages/auth_pages/signup/signup_page_new.dart';
import 'package:yg_app/pages/main_page.dart';

import '../../../elements/circle_icon_widget.dart';
import '../../../helper_utils/navigation_utils.dart';
import '../../../model/response/common_response_models/countries_response.dart';
import '../signup/country_search_page.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool _showPassword = false;
  late LoginRequestModel _loginRequestModel;
  bool? isOnline;
  String? code;

  void _togglevisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  @override
  void initState() {
    _loginRequestModel = LoginRequestModel();
    AppDbInstance().getDbInstance().then((value) => {
      value.countriesDao.findAllCountries().then((value) {
        setState(() {
          _loginRequestModel?.country=value.first;
         code=value.first.countryPhoneCode;
        });
      })
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                flex: 1,
                fit: FlexFit.loose,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 40.w, bottom: 40.w),
                      child: Image.asset(
                        newLogoImage,
                        width: 90.w,
                        height: 90.h,
                      ),
                    ),
                    Text(
                      signIn,
                      style: TextStyle(
                          color: signInColor,
                          fontSize: 28.sp,
                          fontFamily: 'Metropolis',
                          fontWeight: FontWeight.w700),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.w),
                      child: Text(
                        loginDescription,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: textColorGrey,
                          fontSize: 10.sp,
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    top: 14.w, bottom: 6.w, left: 8.w, right: 8.w),
                                child: Text(
                                  mobileNumber,
                                  textAlign: TextAlign.left,

                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    bottom: 8.w, left: 8.w, right: 8.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    TextFormField(
                                      keyboardType: TextInputType.phone,
                                      cursorColor: Colors.black,
                                      onSaved: (input) => _loginRequestModel.username = "+$code"+input!,
                                    inputFormatters: <TextInputFormatter>[
                                      /*FilteringTextInputFormatter.allow(RegExp(r'([a-zA-Z0-9@.])')),*/
                                      LengthLimitingTextInputFormatter(
                                          15),
                                    ],
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
                                                  setState(() {
                                                    _loginRequestModel?.country=country;
                                                    code=_loginRequestModel?.country?.countryPhoneCode;

                                                  })
                                                },
                                                ),
                                              ),
                                            )
                                          },
                                          child:  Container(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                const SizedBox(width: 2.0,),
                                                CircleImageIconWidget(
                                                    imageUrl:
                                                    _loginRequestModel?.country?.medium.toString() ?? ""),
                                                const SizedBox(width: 8.0,),
                                                Text(
                                                  _loginRequestModel?.country?.countryPhoneCode.toString() ?? "",textAlign: TextAlign.start,),
                                                const SizedBox(width: 2.0,),
                                                const Icon(Icons.arrow_drop_down,color: Colors.grey,),
                                                const Text("|",textAlign: TextAlign.start,style:TextStyle(color:Colors.grey, ),),
                                                const SizedBox(width: 2.0,),

                                              ],
                                            ),
                                          ),
                                        ),

                                      ),
                                    )
                                  ],
                                ),
                              ),
//                              Padding(
//                                padding: EdgeInsets.only(
//                                    top: 14.w, bottom: 6.w, left: 8.w, right: 8.w),
//                                child: Text(
//                                  userName,
//                                  textAlign: TextAlign.left,
//
//                                ),
//                              ),
//                              Padding(
//                                padding: EdgeInsets.only(
//                                     bottom: 8.w, left: 8.w, right: 8.w),
//                                child: TextFormField(
//                                    keyboardType: TextInputType.text,
//                                    textInputAction: TextInputAction.next,
//                                    inputFormatters: <TextInputFormatter>[
//                                      /*FilteringTextInputFormatter.allow(RegExp(r'([a-zA-Z0-9@.])')),*/
//                                      LengthLimitingTextInputFormatter(
//                                          25),
//                                    ],
//                                    cursorColor: Colors.black,
//                                    onSaved: (input) =>
//                                    _loginRequestModel.username = input!,
//                                    validator: (input) {
//                                      if (input == null || input.isEmpty) {
//                                        return "Please enter username";
//                                      }
//                                      return null;
//                                    },
//                                    decoration: InputDecoration(
//                                      contentPadding:const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
//
//                                      hintStyle: TextStyle(fontSize: 10.sp,fontWeight: FontWeight.w500,color:hintColorGrey),
//                                      border: OutlineInputBorder(
//                                          borderRadius:const BorderRadius.all(
//                                            Radius.circular(5.0),
//                                          ),
//                                          borderSide: BorderSide(color: signInBorderColor)
//                                      ),
////                                    hintText: "Enter Here",
//
//                                    ),
//                                ),
//                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: 14.w, bottom: 6.w, left: 8.w, right: 8.w),
                                child: Text(
                                  password,
                                  textAlign: TextAlign.left,

                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                     bottom: 8.w, left: 8.w, right: 8.w),
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
                                    contentPadding:const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
//                                    label: Row(
//                                      mainAxisSize: MainAxisSize.min,
//                                      mainAxisAlignment: MainAxisAlignment.start,
//                                      children: [
//                                        Text("Password",style: TextStyle(color: formFieldLabel),),
////                                    const Text("*", style: TextStyle(color: Colors.red)),
//                                      ],
//                                    ),
//                                    floatingLabelBehavior:FloatingLabelBehavior.always ,
                                    hintStyle: TextStyle(fontSize: 10.sp,fontWeight: FontWeight.w500,color:hintColorGrey),
                                    border: OutlineInputBorder(
                                        borderRadius:const BorderRadius.all(
                                          Radius.circular(5.0),
                                        ),
                                        borderSide: BorderSide(color: signInBorderColor)
                                    ),
//                                    hintText: "Enter Here",
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
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      top: 0, bottom: 8.w, left: 8.w, right: 8.w),
                                  child: GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    onTap: ()=>{
                                      openForgotPasswordScreen(context)
                                    },
                                    child: Text(
                                      forgetPassword,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: forgotPasswordColor,
                                        fontSize: 12.sp,
                                        /*fontFamily: 'Metropolis',*/
                                        fontWeight: FontWeight.w500,
                                        height: 1.5.h,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 30.h,
                              ),
                              SizedBox(
                                height: 50.w,
                                  width: double.infinity,
                                  child: ElevatedButton(
                                      child:Row(
                                        children: [
                                          Expanded(child: Center(child:
                                          Text("Sign in",
                                              style: TextStyle(
                                                fontSize: 14.sp,
                                                /*fontFamily: 'Metropolis',*/
                                              )),),flex: 9,),
                                          const Icon(
                                            Icons.arrow_forward_sharp,
                                            color: Colors.white,
                                          ),
                                        ],
                                      ),

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
                                          _loginCall();
                                        }
                                      })),
                            ],
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height/10,),
              Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0,bottom: 8.0,),
                      child: Text(
                        signUp,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          /*fontFamily: 'Metropolis',*/
                          color: textColorGrey,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          height: 1.5.h,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0,bottom: 8.0,left: 2.0),
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignUpPage(),
                            ),
                          );
                        },
                        child: Text(
                          register,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            /*fontFamily: 'Metropolis',*/
                            color: signInColor,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            height: 1.5.h,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],

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
            AppDbInstance().getDbInstance().then((db) async {
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
extension PhoneValidator on String {
  bool isValidNumber() {
    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    return RegExp(pattern).hasMatch(this);
  }
}
