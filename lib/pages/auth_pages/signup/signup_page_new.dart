import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_picker_dropdown.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:yg_app/api_services/api_service_class.dart';
import 'package:yg_app/app_database/app_database_instance.dart';
import 'package:yg_app/helper_utils/app_colors.dart';
import 'package:yg_app/helper_utils/app_constants.dart';
import 'package:yg_app/elements/decoration_widgets.dart';
import 'package:yg_app/helper_utils/connection_status_singleton.dart';
import 'package:yg_app/helper_utils/progress_dialog_util.dart';
import 'package:yg_app/helper_utils/shared_pref_util.dart';
import 'package:yg_app/helper_utils/util.dart';
import 'package:yg_app/model/request/signup_request/signup_request.dart';
import 'package:yg_app/pages/auth_pages/signup/signup_segment_component.dart';
import '../../../helper_utils/app_images.dart';
import '../../../helper_utils/ui_utils.dart';
import '../../../model/response/common_response_models/countries_response.dart';
import '../../main_page.dart';
import '../../profile/profile_segment_component.dart';

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
  String otp = "";

  FirebaseAuth auth = FirebaseAuth.instance;
  String verificationID = "";

  // ..text = "123456";

  // ignore: close_sinks

  bool hasError = false;
  String currentText = "";

  final usernameFocus = FocusNode();
  final emailFocus = FocusNode();
  final passwordFocus = FocusNode();
  final confirmPasswordFocus = FocusNode();
  final businessAreaFocus = FocusNode();
  final companyFocus = FocusNode();

  String countryValue="";
  int selectedValue = 1;
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
  void dispose() {
    // errorController!.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return SafeArea(
        child: Scaffold(
            key: scaffoldKey,
            resizeToAvoidBottomInset: true,
            backgroundColor: Colors.white,
            body: Column(
              children: [
                const SizedBox(height: 14.0,),
                Expanded(
                  child: SignUpStepsSegments(
                    // syncFiberResponse: data,
                    selectedTab: "1",
                    stepsCallback: (value) {
                      if (value is int) {
                        selectedValue = value;
                        /*BroadcastReceiver().publish<int>(segmentIndexBroadcast,
                      arguments: selectedSegment);*/
                      }
                    },
                  ),
                ),
//                Padding(
//                  padding: EdgeInsets.only(left: 18.w, right: 18.w),
//                  child: ProfileSegmentComponent(
//                    callback: (value) {
//                      setState(() {
//                              selectedValue=value;
//                      });
//                    },
//                      tab1:"Select Country",
//                      tab2:"Business Info",
//                      tab3:'Personal Info'
//                  ),
//
//                ),
//
//                const SizedBox(height: 14.0,),
//                if(selectedValue==1)
//                  Form(
//                    key: globalFormKey,
//                    child: Expanded(
//                      child: SingleChildScrollView(
//                        child: Padding(
//                          padding: EdgeInsets.only(left: 16.w, right: 16.w),
//                          child: Center(
//                            child: Builder(builder: (BuildContext context2) {
//                              return buildCountryPickerDropdownSoloExpanded(context2);
//                            }),
//                          ),
//                        ),
//                      ),
//                    ),
//                  )
//                else if(selectedValue==2)
//                  Form(
////                          key: bussinessFormKey,
//                    child: Expanded(
//                      child: SingleChildScrollView(
//                        child: Padding(
//                          padding: EdgeInsets.only(left: 16.w, right: 16.w),
//                          child: Center(
//                            child: Builder(builder: (BuildContext context2) {
//                              return buildBusinessDataColumn(context2);
//                            }),
//                          ),
//                        ),
//                      ),
//                    ),
//                  )
//                else
//                  Expanded(
//                    child: SingleChildScrollView(
//                      child: Padding(
//                        padding: EdgeInsets.only(left: 16.w, right: 16.w),
//                        child: Center(
//                          child: Builder(builder: (BuildContext context2) {
//                            return buildUserDataColumn(context2);
//                          }),
//                        ),
//                      ),
//                    ),
//                  ),
              ],
            )));
  }


  buildCountryPickerDropdownSoloExpanded(BuildContext context2) {
    return Center(
      child: Column(
        children: [
          CountryPickerDropdown(
            underline: InputDecorator(
              decoration: dropDownProfile("Select Country", "Country"),
            ),
            onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
            onValuePicked: (Country country) {
              print("${country.name}");
            },
            itemBuilder: (Country country) {
              return Row(
                children: <Widget>[
                  SizedBox(width: 8.0),
                  CountryPickerUtils.getDefaultFlagImage(country),
                  SizedBox(width: 8.0),
                  Expanded(child: Text(country.name)),
                ],
              );
            },
            itemHeight: null,
            isExpanded: true,
            //initialValue: 'TR',
            icon: Icon(Icons.arrow_drop_down_outlined),
          ),
          Padding(
            padding: EdgeInsets.all(16.w),
            child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    child: Text("Next",
                        style: TextStyle(
                            fontFamily: 'Metropolis',
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
                                side: BorderSide(color: Colors.transparent)))),
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      if (validateAndSave()) {
                        if (_signupRequestModel
                            .countryId !=
                            null) {
                          loginWithPhone();
                        }
                      }
                    })),
          ),
        ],

      ),
    );
  }

  Column buildBusinessDataColumn(BuildContext context2)
  {

    return Column(
      children: [

        Padding(
          padding:
          EdgeInsets.only(top: 8.w, bottom: 8.w, left: 8.w, right: 8.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              TextFormField(
                  keyboardType: TextInputType.text,
                  cursorColor: Colors.black,
                  onSaved: (input) =>
                  _signupRequestModel.company = input!,
                  validator: (input) {
                    if (input == null || input.isEmpty) {
                      return "Please enter company name";
                    }
                    return null;
                  },
                  decoration: textFieldProfile(
                      'Enter Company Name', "Company Name")),
            ],
          ),
        ),

        Padding(
          padding:
          EdgeInsets.only(top: 8.w, bottom: 8.w, left: 8.w, right: 8.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              TextFormField(
                  keyboardType: TextInputType.text,
                  cursorColor: Colors.black,
                  initialValue: '',
                  onSaved: (input) =>
                                          _signupRequestModel.cityStateId = input!,
                  validator: (input) {
                  if (input == null ||
                      input.isEmpty) {
                    return "Please enter business area";
                                     }
                    return null;
                  },
                  decoration: textFieldProfile(
                      'Enter Business Area', "Business Area")),
            ],
          ),
        ),

//        Padding(
//          padding:
//          EdgeInsets.only(top: 8.w, bottom: 8.w, left: 8.w, right: 8.w),
//          child: Column(
//            crossAxisAlignment: CrossAxisAlignment.start,
//            children: [
//
//
//              DropdownButtonFormField<String>(
//
//                decoration: dropDownProfile(
//                    'Select', "Designation") ,
//                isDense: true,
//                hint:Text("Select",style: TextStyle(fontSize: 10.sp,fontWeight: FontWeight.w400,color: Colors.black87),),
//                isExpanded: true,
//                iconSize: 21,
//                items:roleList.map((location) {
//                  return DropdownMenuItem<String>(
//                    child: Text(location),
//                    value: location,
//
//                  );
//                }).toList(),
//
//                onChanged: (newValue) {
//
//                },
//
//
//                validator: (value) => value == null ? '*' : null,
//
//              ),
//
//            ],
//          ),
//        ),

        Padding(
          padding: EdgeInsets.all(16.w),
          child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  child: Text("Next",
                      style: TextStyle(
                          fontFamily: 'Metropolis',
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
                              side: BorderSide(color: Colors.transparent)))),
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    if (validateAndSave()) {
                      if (_signupRequestModel
                          .telephoneNumber !=
                          null) {
                        loginWithPhone();
                      }
                    }
                  })),
        ),

      ],
    );
  }



  Column buildUserDataColumn(BuildContext context2) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding:
          EdgeInsets.only(top: 8.w, bottom: 8.w, left: 8.w, right: 8.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
//              IntlPhoneField(
//                decoration: InputDecoration(
//                  labelText: 'Phone Number',
//                  border: OutlineInputBorder(
//                    borderSide: BorderSide(),
//                  ),
//                ),
//                initialCountryCode: 'IN',
//                onChanged: (phone) {
//                  print(phone.completeNumber);
//                },
//              ),
              TextFormField(
                  keyboardType: TextInputType.text,
                  cursorColor: Colors.black,
                  onChanged: (input){
                    Utils.validateMobile(input);
                  },
                  onSaved: (input) =>
                  _signupRequestModel.telephoneNumber = input!,
                  validator: (input) {
                    if (input == null || input.isEmpty) {
                      return "Please enter number";
                    }
                    return null;
                  },
                  decoration: textFieldProfile(
                      '',telephoneNumberLabel)),
            ],
          ),
        ),

        Padding(
          padding:
          EdgeInsets.only(top: 8.w, bottom: 8.w, left: 8.w, right: 8.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              TextFormField(
                  readOnly: true,
                  keyboardType: TextInputType.emailAddress,
                  cursorColor: Colors.black,
                  onSaved: (input) => _signupRequestModel.email = input!,
                  validator: (input) {
                    if (input == null ||
                        input.isEmpty ||
                        !input.isValidEmail()) {
                      return "Please check your email";
                    }
                    return null;
                  },
                  decoration: textFieldProfile(
                      '',emailLabel)),
            ],
          ),
        ),


        Padding(
          padding:
          EdgeInsets.only(top: 8.w, bottom: 8.w, left: 8.w, right: 8.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

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
                  label: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Password",style: TextStyle(color: formFieldLabel),),
                      const Text("*", style: TextStyle(color: Colors.red)),
                    ],
                  ),
                  floatingLabelBehavior:FloatingLabelBehavior.always ,
                  hintStyle: TextStyle(fontSize: 10.sp,fontWeight: FontWeight.w500,color:hintColorGrey),
                  border: OutlineInputBorder(
                      borderRadius:const BorderRadius.all(
                        Radius.circular(5.0),
                      ),
                      borderSide: BorderSide(color: newColorGrey)
                  ),
                  hintText: "Enter Here",
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
          padding:
          EdgeInsets.only(top: 8.w, bottom: 8.w, left: 8.w, right: 8.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              TextFormField(
                focusNode: confirmPasswordFocus,
                obscureText: !_showPassword,
                keyboardType:
                TextInputType.text,
                textInputAction: TextInputAction.next,
                onEditingComplete: () => FocusScope.of(context).requestFocus(businessAreaFocus),
                cursorColor: Colors.black,
                onSaved: (input) =>
                _signupRequestModel
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
                  label: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Confirm Password",style: TextStyle(color: formFieldLabel),),
                      const Text("*", style: TextStyle(color: Colors.red)),
                    ],
                  ),
                  floatingLabelBehavior:FloatingLabelBehavior.always ,
                  hintStyle: TextStyle(fontSize: 10.sp,fontWeight: FontWeight.w500,color:hintColorGrey),
                  border: OutlineInputBorder(
                      borderRadius:const BorderRadius.all(
                        Radius.circular(5.0),
                      ),
                      borderSide: BorderSide(color: newColorGrey)
                  ),
                  hintText: "Enter Here",
//                  prefixIcon: IconButton(
//                    onPressed: () {},
//                    icon: SvgPicture.asset(
//                      'assets/ic_confirm_password.svg',
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
                          fontFamily:
                          'Metropolis',
                          fontSize: 12.sp,
                          color:
                          textColorGrey)),
                  TextSpan(
                      text:
                      'Terms & Conditions',
                      style: TextStyle(
                          fontFamily:
                          'Metropolis',
                          fontSize: 12.sp,
                          fontWeight:
                          FontWeight.bold,
                          color:
                          Colors.black87)),
                ],
              ),
            )
          ],
        ),

        Padding(
          padding: EdgeInsets.all(16.w),
          child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  child: Text("Sign Up",
                      style: TextStyle(
                          fontFamily: 'Metropolis',
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
                              side: BorderSide(color: Colors.transparent)))),
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    if (validateAndSave()) {
                      if (_signupRequestModel
                          .telephoneNumber !=
                          null) {
                        loginWithPhone();
                      }
                    }
                  })),
        ),
      ],
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


  bool validationAllPage() {
    if (validateAndSave()) {

    }
    return false;
    //  return true;
  }

  void loginWithPhone() async {
    auth.verifyPhoneNumber(
      phoneNumber: _signupRequestModel.telephoneNumber!,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential).then((value) {
          _signUpCall();
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
              height: 350,
              width: MediaQuery.of(buildContext).size.width,
              child: ListView(children: <Widget>[
                const SizedBox(height: 30),
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
                              text: _signupRequestModel.telephoneNumber ??
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
                        print(value);
                        setState(() {
                          currentText = value;
                        });
                        otp = value;
                      },
                      beforeTextPaste: (text) {
                        print("Allowing to paste $text");
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
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     const Text(
                //       "Didn't receive the code? ",
                //       style: TextStyle(color: Colors.black54, fontSize: 15),
                //     ),
                //     TextButton(
                //         onPressed: () => loginWithPhone,
                //         child: const Text(
                //           "RESEND",
                //           style: TextStyle(
                //               color: Color(0xFF91D3B3),
                //               fontWeight: FontWeight.bold,
                //               fontSize: 16),
                //         ))
                //   ],
                // ),
                // const SizedBox(
                //   height: 8,
                // ),
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
                  height: 8,
                )
              ]));
        });

    // return showDialog(
    //     context: context,
    //     barrierDismissible: false,
    //     builder: (BuildContext context) {
    //       return AlertDialog(
    //         title: Text('Enter your OTP'),
    //         content: Padding(
    //           padding: const EdgeInsets.all(8.0),
    //           child: TextFormField(
    //             decoration: const InputDecoration(
    //               border:  OutlineInputBorder(
    //                 borderRadius: BorderRadius.all(
    //                   Radius.circular(30),
    //                 ),
    //               ),
    //             ),
    //             onChanged: (value) {
    //               otp = value;
    //             },
    //           ),
    //         ),
    //         contentPadding: EdgeInsets.all(10.0),
    //         actions: <Widget>[
    //           FlatButton(
    //             onPressed: () {
    //               verifyOTP(otp);
    //             },
    //             child: Text(
    //               'Submit',
    //             ),
    //           ),
    //         ],
    //       );
    //     });
  }

  void verifyOTP(
      String otp,
      BuildContext buildContext,
      ) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationID, smsCode: otp);

    await auth.signInWithCredential(credential).then((value) {
      Navigator.pop(buildContext);
      _signUpCall();
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
        _signupRequestModel.operator = '1';
        _signupRequestModel.countryId = '1';
        Logger().e(_signupRequestModel.toJson());
        ApiService.signup(_signupRequestModel).then((value) {
          Logger().e(value.toJson());
          ProgressDialogUtil.hideDialog();
          if (value.errors != null) {
            value.errors!.forEach((key, error) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(error.toString())));
            });
          } else if (value.success!) {
            AppDbInstance.getDbInstance().then((db) async {
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

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}
