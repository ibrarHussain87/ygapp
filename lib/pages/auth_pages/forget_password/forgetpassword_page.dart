import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:timer_button/timer_button.dart';
import 'package:yg_app/helper_utils/app_colors.dart';
import 'package:yg_app/helper_utils/app_constants.dart';
import 'package:yg_app/helper_utils/progress_dialog_util.dart';
import 'package:yg_app/helper_utils/ui_utils.dart';

import '../../../elements/decoration_widgets.dart';
import '../../../helper_utils/app_images.dart';
import '../../../helper_utils/navigation_utils.dart';
import '../../../helper_utils/util.dart';
import '../../../model/request/signup_request/signup_request.dart';

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

  CountdownTimerController? controller;
  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 30;

  var isResend=false;

  bool showTimer=true;


  @override
  void initState() {
    controller = CountdownTimerController(endTime: endTime, onEnd: onEnd);
    _signupRequestModel=SignUpRequestModel();
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
          backgroundColor: Colors.white,
          centerTitle: true,
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[appBarColor2,appBarColor1])),
          ),

          title: Text('Forget Password',
              style: TextStyle(
                  fontSize: 16.0.w,
                  color: Colors.white,
                  fontWeight: FontWeight.w400)),
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
                        top: 50.w, left: 18.w, right: 18.w),
                    child: Text(
                      forgetPasswordText,
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
                        Padding(
                          padding: EdgeInsets.only(
                              top: 20.w, bottom: 8.w, left: 18.w, right: 18.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              IntlPhoneField(
                                decoration: textFieldProfile(
                                    '',telephoneNumberLabel),
                                initialCountryCode:'PK',
                                disableLengthCheck: false,
                                onChanged: (phone){
                                  Utils.validateMobile(phone.number);
                                },
                                onSaved: (input) =>
                                _signupRequestModel?.telephoneNumber = input?.completeNumber,
                                validator: (input) {
                                  if (input == null) {
                                    return "Please enter number";
                                  }
                                  return null;
                                },
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
                                  child:  Text("Send",
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
                                          print("Signup Model"+_signupRequestModel!.telephoneNumber.toString());
                                        }
                                        loginWithPhone();
                                      }
                                    }
                                  }
                                  )
                          ),
                        ),
//                        Center(
//                          child: CountdownTimer(
//                            endTime: endTime,
//                            controller: controller,
//                            onEnd: onEnd,
//                            widgetBuilder: (_, CurrentRemainingTime? time) {
//                              if (time == null) {
//                                return  Visibility(
//                                  visible:!isResend,
//                                  child: Container(
//                                    margin: const EdgeInsets.symmetric(
//                                        vertical: 16.0, horizontal: 16),
//                                    child: ButtonTheme(
//                                      height: 50,
//                                      child: TextButton(
//                                        onPressed: () {
//                                          setState(() {
//                                            if(!controller!.isRunning) {
//
//                                              setState(() {
//                                                ///start
//                                               isResend=true;
//                                               showTimer=true;
//                                              });
//                                            }
//
//                                          });
//                                        },
//                                        child: Center(
//                                            child: Text(
//                                              "Resend".toUpperCase(),
//                                              style: const TextStyle(
//                                                  color: Colors.white,
//                                                  fontSize: 18,
//                                                  fontWeight: FontWeight.bold),
//                                            )),
//                                      ),
//                                    ),
//                                    decoration: BoxDecoration(
//                                        color: Colors.green.shade300,
//                                        borderRadius: BorderRadius.circular(5),
//                                        boxShadow: [
//                                          BoxShadow(
//                                              color: Colors.green.shade200,
//                                              offset: Offset(1, -2),
//                                              blurRadius: 5),
//                                          BoxShadow(
//                                              color: Colors.green.shade200,
//                                              offset: Offset(-1, 2),
//                                              blurRadius: 5)
//                                        ]),
//                                  ),
//                                );
//                              }
//                              return Visibility(
//                                visible:showTimer,
//                                child: Text(
//                                    '${time.sec}'),
//                              );
//                            },
//                          ),
//                        ),

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


  void onEnd() {
    print('onEnd');
    setState(() {
      isResend=false;
      showTimer=false;
    });
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
      phoneNumber:_signupRequestModel!.telephoneNumber!,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential).then((value) {

          openUpdatePasswordScreen(context,_signupRequestModel!);

        });
      },
      verificationFailed: (FirebaseAuthException e) {
        print(e.message);
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

    ProgressDialogUtil.showDialog(context, 'Please wait...');
    auth.verifyPhoneNumber(
      phoneNumber:_signupRequestModel!.telephoneNumber!,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential).then((value) {

          openUpdatePasswordScreen(context,_signupRequestModel!);

        });
      },
      verificationFailed: (FirebaseAuthException e) {
        ProgressDialogUtil.hideDialog();
        print(e.message);
        Fluttertoast.showToast(
            msg: e.message.toString(),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1);
      },

      codeSent: (String verificationId, int? resendToken) {
        ProgressDialogUtil.hideDialog();
        verificationID = verificationId;
        Fluttertoast.showToast(
            msg: "Otp sent successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1);
        setState(() {});
        otpDialogBox(context);
      },

      codeAutoRetrievalTimeout: (String verificationId) {

        Ui.showSnackBar(context, "SMS retrieval timeout");
      },
    );
  }

  otpDialogBox(BuildContext buildContext) {
    // TextEditingController textEditingController = TextEditingController();
    // StreamController<ErrorAnimationType>? errorController = StreamController<ErrorAnimationType>();

    return showModalBottomSheet(
        context: buildContext,
        isDismissible: false,
        isScrollControlled: true,
        enableDrag: false,
        builder: (BuildContext buildContext) {
          return Container(
              color: Colors.white,
              padding: MediaQuery.of(buildContext).viewInsets,
              height: 420,
              width: MediaQuery.of(buildContext).size.width,
              child: ListView(children: <Widget>[
                const SizedBox(height: 10),
                SizedBox(
                  height: 64,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.asset(
                      logoImage,
                      height: 64,
                      width: 64,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    'Phone Number Verification',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 8),
                  child: RichText(
                    text: TextSpan(
                        text: "Enter the code sent to ",
                        children: [
                          TextSpan(
                              text: _signupRequestModel!.telephoneNumber ??
                                  "Enter your number",
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15)),
                        ],
                        style: const TextStyle(
                            color: Colors.black54, fontSize: 12)),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 30),
                    child: PinCodeTextField(
                      appContext: buildContext,
                      pastedTextStyle: TextStyle(
                        color: Colors.green.shade600,
                        fontWeight: FontWeight.bold,
                      ),
                      length: 6,
                      backgroundColor: Colors.white,
                      obscureText: true,
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
                          activeFillColor: Colors.white,
                          inactiveFillColor: Colors.white),
                      cursorColor: Colors.black,
                      animationDuration: Duration(milliseconds: 300),
                      enableActiveFill: true,
                      // errorAnimationController: errorController,
                      // controller: textEditingController,
                      keyboardType: TextInputType.number,
                      boxShadows: const [
                        BoxShadow(
                          offset: Offset(0, 1),
                          color: Colors.black12,
                          blurRadius: 10,
                        )
                      ],
                      onCompleted: (v) {
                        otp = v;
                      },
                      // onTap: () {
                      //   print("Pressed");
                      // },
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

                const SizedBox(
                  height: 8,
                ),

                Container(
                  margin: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 16),
                  child: ButtonTheme(
                    height: 50,
                    child: TextButton(
                      onPressed: () {
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

                          verifyOTP(otp, buildContext);
                        }
                      },
                      child: Center(
                          child: Text(
                            "VERIFY".toUpperCase(),
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          )),
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: Colors.green.shade300,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.green.shade200,
                            offset: Offset(1, -2),
                            blurRadius: 5),
                        BoxShadow(
                            color: Colors.green.shade200,
                            offset: Offset(-1, 2),
                            blurRadius: 5)
                      ]),
                ),
                const SizedBox(
                  height: 4,
                ),
                Center(
                  child: TimerButton(
                    label: "Send OTP Again",
                    timeOutInSeconds: 60,

                    onPressed: () {
                            resendOTP();
                    },
                    disabledColor: Colors.white,
                    color: Colors.white,
//                    color: Colors.green.shade300,
                    buttonType:ButtonType.TextButton,

                    disabledTextStyle: const TextStyle(fontSize: 12.0,color: Colors.black38),
                    activeTextStyle: TextStyle(
                        color: Colors.green.shade600,
                        fontSize: 12,

                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 8,
                )
              ]));
        });

  }


  void verifyOTP(
      String otp,
      BuildContext buildContext,
      ) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationID, smsCode: otp);

    await auth.signInWithCredential(credential).then((value) {
      Navigator.pop(buildContext);
      openUpdatePasswordScreen(context,_signupRequestModel!);

    },onError: (error){
      Fluttertoast.showToast(
          msg: error.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1);
    });
  }
}



