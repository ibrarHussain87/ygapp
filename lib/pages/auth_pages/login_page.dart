import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yg_app/utils/colors.dart';
import 'package:yg_app/utils/images.dart';
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
  void _togglevisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 40, bottom: 40),
              child: Image.asset(
                AppImages.logoImage,
                width: 60,
                height: 60,
              ),
            ),
            Text(
              AppStrings.letsGetStarted,
              style: TextStyle(
                  color: AppColors.textColorBlue,
                  fontSize: 24,
                  fontWeight: FontWeight.w400),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                AppStrings.loginDescription,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.textColorGrey,
                  fontSize: 9,
                  fontWeight: FontWeight.w400,
                  height: 1.5,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Center(
                child: Form(
                  key: globalFormKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 8, bottom: 8, left: 8, right: 8),
                        child: TextFormField(
                            keyboardType: TextInputType.text,
                            cursorColor: Colors.black,
                            decoration: textFormFieldDec(AppStrings.userName)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 8, bottom: 8, left: 8, right: 8),
                        child: TextFormField(
                          obscureText: !_showPassword,
                          keyboardType: TextInputType.text,
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            labelText: AppStrings.password,
                            // hintText: AppStrings.password,
                            // hintStyle: TextStyle(
                            //     fontSize: 12.0, color: AppColors.textColorGrey),
                            border: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: AppColors.textColorGrey),
                            ),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                _togglevisibility();
                              },
                              child: Icon(
                                _showPassword ? Icons.visibility : Icons
                                    .visibility_off, color: AppColors.textColorGrey,),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 0, bottom: 8, left: 8, right: 8),
                          child: Text(
                            AppStrings.forgetPassword,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppColors.textColorFBlue,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              height: 1.5,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16,),
                      Padding(
                        padding: EdgeInsets.only(top: 30),
                        child: SizedBox(width: double.infinity,
                            child:ElevatedButton(
                                child: Text(
                                    "Sign in".toUpperCase(),
                                    style: TextStyle(fontSize: 14)
                                ),
                                style: ButtonStyle(
                                    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                                    backgroundColor: MaterialStateProperty.all<Color>(AppColors.btnColorLogin),
                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                        const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(8)),
                                            side: BorderSide(color: Colors.transparent)
                                        )
                                    )
                                ),
                                onPressed: () => null
                            )),
                      ),

                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 30,),
            Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                AppStrings.signUpStr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.textColorGrey,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  height: 1.5,
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
