
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';
import 'package:otp_timer_button/otp_timer_button.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:yg_app/helper_utils/app_colors.dart';
import 'package:yg_app/helper_utils/app_constants.dart';
import 'package:yg_app/helper_utils/progress_dialog_util.dart';
import 'package:yg_app/helper_utils/ui_utils.dart';

import '../../../api_services/api_service_class.dart';
import '../../../app_database/app_database_instance.dart';
import '../../../helper_utils/connection_status_singleton.dart';
import '../../../helper_utils/navigation_utils.dart';
import '../../../helper_utils/shared_pref_util.dart';
import '../../../model/request/signup_request/signup_request.dart';
import '../../main_page.dart';

class VerifyCodePage extends StatefulWidget {
  final SignUpRequestModel signUpRequestModel;
  final bool fromSignUp;

  const VerifyCodePage(
      {Key? key,required this.signUpRequestModel,required this.fromSignUp})
      : super(key: key);

  @override
  VerifyCodePageState createState() => VerifyCodePageState();
}

class VerifyCodePageState
    extends State<VerifyCodePage> {

  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  String otp = "";
  FirebaseAuth auth = FirebaseAuth.instance;
  String verificationID = "";

  bool hasError = false;
  String currentText = "";
  String? telNumber = "";
  OtpTimerButtonController controller = OtpTimerButtonController();
  bool isLoading=true;


  @override
  void initState() {
    if (kDebugMode) {
      print("SignUp Model"+widget.signUpRequestModel.telephoneNumber.toString());
    }
    loginWithPhone();
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
        body:  isLoading ? Center(child: CircularProgressIndicator(color:lightBlueTabs,)) : Column(
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
                      verifyCodeText,
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 28.sp,
                          // 
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: 10.w, bottom: 8.w, left: 20.w, right: 18.w),
                    child: Text(
                      verifyCodeDetails,
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
                  Form(
                    key: globalFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 15.w,
                        ),

                        Padding(
                          padding: EdgeInsets.only(
                              top: 20.w, bottom: 8.w, left: 18.w, right: 18.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      top: 4.w, bottom: 8.w, left: 18.w, right: 18.w),
                                  child: Text(
                                    verifyCodeLabel,
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
                              ),
                              Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8.0, horizontal: 30),
                                  child: PinCodeTextField(
                                    appContext: context,
                                    pastedTextStyle: TextStyle(
                                      color: Colors.green.shade600,
                                      fontWeight: FontWeight.bold,
                                    ),

                                    length: 6,
                                    backgroundColor: Colors.white,
                                    obscureText: false,
                                    obscuringCharacter: '*',
                                    // obscuringWidget: FlutterLogo(
                                    //   size: 24,
                                    // ),
                                    blinkWhenObscuring: true,
                                    animationType: AnimationType.fade,
                                    validator: (v) {
                                      if (v!.length < 6) {
                                        return "Please enter OTP";
                                      } else {
                                        return null;
                                      }
                                    },
                                    pinTheme: PinTheme(
                                        shape: PinCodeFieldShape.box,
                                        borderRadius: BorderRadius.circular(5),
                                        fieldHeight: 50,
                                        fieldWidth: 40,
                                        inactiveColor: Colors.grey.shade300,
                                        activeFillColor: Colors.white,
                                        inactiveFillColor: Colors.white),
                                    cursorColor: Colors.black,
                                    animationDuration: const Duration(milliseconds: 300),
                                    enableActiveFill: true,
                                    // errorAnimationController: errorController,
                                    // controller: textEditingController,
                                    keyboardType: TextInputType.number,
                                    boxShadows: const [
                                      BoxShadow(
                                        offset: Offset(0, 1),
                                        color: Colors.black12,
                                        blurRadius: 0,
                                      )
                                    ],
                                    onCompleted: (v) {
                                      otp = v;
                                    },

                                    onChanged: (value) {
                                      if (kDebugMode) {
                                        print(value);
                                      }
                                      setState(() {
                                        currentText = value;
                                      });
                                      otp = value;
                                    },
                                    beforeTextPaste: (text) {
                                      if (kDebugMode) {
                                        print("Allowing to paste $text");
                                      }
                                      //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                                      //but you can show anything you want here, like your pop up saying wrong paste format or etc
                                      return true;
                                    },
                                  )),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                                child: Text(
                                  hasError ? "*Please fill up all the cells properly" : "",
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),



                            ],
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.only(
                              top: 40.w, bottom: 4.w, left: 18.w, right: 18.w),
                          child: SizedBox(
                              height: 50.w,
                              width: double.infinity,
                              child: TextButton(
                                  child:  Text("Verify",
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
                                                  color: Colors.transparent)))
                                  ),
                                  onPressed: () {
                                    FocusScope.of(context).unfocus();
                                    if (validateAndSave()) {
                                      if (widget.signUpRequestModel
                                          .telephoneNumber !=
                                          null) {
                                        if (kDebugMode) {
                                          print("SignUp Model"+widget.signUpRequestModel.telephoneNumber.toString());
                                        }
                                        // conditions for validating
                                        if (currentText.length != 6) {
                                          // errorController!.add(ErrorAnimationType
                                          //     .shake); // Triggering error shake animation
                                          setState(() => hasError = true);
                                        } else {
                                          setState(
                                                () {
                                              hasError = false;
                                            },
                                          );

                                          verifyOTP(otp, context);
                                        }

                                      }
                                    }
                                  }
                              )
                          ),
                        ),

                        Center(
                          child: OtpTimerButton(
                            controller: controller,
                            height: 60,
                            text: const Text(
                              "Resend code",
                              style: TextStyle(color: Colors.black54),
                            ),
                            duration: 60,
                            radius: 8,
                            textColor: Colors.white,
                            buttonType: ButtonType.text_button, // or ButtonType.outlined_button
                            loadingIndicator: const CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.red,
                            ),
                            loadingIndicatorColor: Colors.red,
                            onPressed: () {
                              resendOTP();
                            },
                          ), /*TimerButton(
                            label: "Resend code",
                            timeOutInSeconds: 60,
                            onPressed: () {

                            },
                            disabledColor: Colors.white,
                            color: Colors.white,
                            buttonType:ButtonType.TextButton,

                            disabledTextStyle: const TextStyle(fontSize: 12.0,color: Colors.black38),
                            activeTextStyle: const TextStyle(
                                color: Colors.black87,
                                decoration: TextDecoration.underline,
                                fontSize: 12,
                                fontWeight: FontWeight.normal),
                          )*/
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



  void resendOTP() async {

    auth.verifyPhoneNumber(
      phoneNumber:widget.signUpRequestModel.telephoneNumber!,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential).then((value) {

          if(widget.fromSignUp)
          {

          }
          else {
            openUpdatePasswordScreen(context, widget.signUpRequestModel);
          }

        });
      },
      verificationFailed: (FirebaseAuthException e) {
        if (kDebugMode) {
          print(e.message);
        }
        Fluttertoast.showToast(
            msg: e.message.toString(),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1);
      },


      codeSent: (String verificationId, int? resendToken) {
//        ProgressDialogUtil.hideDialog();
        verificationID = verificationId;
        Fluttertoast.showToast(
            msg: "Otp sent successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1);
//        setState(() {});
//        otpDialogBox(context);
      },

      codeAutoRetrievalTimeout: (String verificationId) {

        Ui.showSnackBar(context, "SMS retrieval timeout");
      },
    );
  }
  void loginWithPhone() async {

//    ProgressDialogUtil.showDialog(context, 'Please wait...');
    auth.verifyPhoneNumber(
      phoneNumber:widget.signUpRequestModel.telephoneNumber.toString(),
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential).then((value) {

          if(widget.fromSignUp)
          {
            _signUpCall();
          }
          else {
            openUpdatePasswordScreen(context, widget.signUpRequestModel);
          }

        });
      },
      verificationFailed: (FirebaseAuthException e) {
//        ProgressDialogUtil.hideDialog();
        if (kDebugMode) {
          print(e.message);
        }
        Fluttertoast.showToast(
            msg: e.message.toString(),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1);
        setState(() {
          isLoading=false;
        });
      },

      codeSent: (String verificationId, int? resendToken) {
//        ProgressDialogUtil.hideDialog();
        verificationID = verificationId;
        Fluttertoast.showToast(
            msg: "Otp sent successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1);
        setState(() {
          isLoading=false;
        });
//        otpDialogBox(context);
      },

      codeAutoRetrievalTimeout: (String verificationId) {

        Ui.showSnackBar(context, "SMS retrieval timeout");
      },
    );
  }



  void verifyOTP(
      String otp,
      BuildContext buildContext,
      ) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationID, smsCode: otp);

    await auth.signInWithCredential(credential).then((value) {

      if(widget.fromSignUp)
        {
          _signUpCall();
        }
      else {
        Navigator.pop(buildContext);
        openUpdatePasswordScreen(context, widget.signUpRequestModel);
      }

    },onError: (error){
      Fluttertoast.showToast(
          msg: error.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1);
    });
  }

  void _signUpCall() {
    check().then((value) {
      if (value) {
        ProgressDialogUtil.showDialog(context, 'Please wait...');
        /*remove operator and added static data for parameter*/
//        widget.signUpRequestModel.operator = code;
//        _signupRequestModel?.countryId =_signupRequestModel?.countryId;
//        _signupRequestModel?.email =_signupRequestModel?.email;
//        _signupRequestModel?.name = _signupRequestModel?.name;
        Logger().e(widget.signUpRequestModel.toJson());
        ApiService().signup(widget.signUpRequestModel).then((value) {
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
              await db.userCategoriesDao.insertAllCategories(value.data!.user!.categories!);

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




