import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/helper_utils/app_images.dart';
import 'package:yg_app/pages/onboarding_pages/each_page.dart';
import 'package:yg_app/pages/onboarding_pages/indicator.dart';
import 'package:yg_app/pages/onboarding_pages/intro_1.dart';
import 'package:yg_app/pages/onboarding_pages/intro_2.dart';
import 'package:yg_app/pages/onboarding_pages/intro_3.dart';

import '../../helper_utils/app_colors.dart';
import '../../helper_utils/app_constants.dart';
import '../../helper_utils/shared_pref_util.dart';
import '../auth_pages/login/signin_page.dart';
import '../main_page.dart';


class StartingScreen extends StatefulWidget {
  const StartingScreen({Key? key}) : super(key: key);


  @override
  State<StatefulWidget> createState() {
    return StartingScreenState();
  }
}

class StartingScreenState extends State{
  final controller = PageController();
  bool showSkip = true;
  final messages = ["First Screen", "Second Screen", "Third Screen"];
  final images = [
    'assets/images/slider1.jpg',
    'assets/images/slider2.jpg',
    'assets/images/slider3.jpg'
  ];
  int currentPage=0;
  final _samplePages = [
  FirstIntro(
      "Grow your business with Yarn Guru","It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.",first_bg,first_circle,first
      ),
    SecondIntro(
      "Discover wide range of Products","It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.",second_bg,second_circle,second
      ),
    ThirdIntro(
      "Trade Anywhere Anytime","It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.",third_bg,third_circle,third
      ),

  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: <Widget>[
        PageView.builder(
          controller: controller,
          onPageChanged: (index){
            setState(() {
              currentPage=index;
            });
          },
          itemCount: _samplePages.length,
          itemBuilder: (BuildContext context, int index) {

            if (index == 2) showSkip = false;
            if (index == 1) showSkip = true;
            if (index == 0) showSkip = true;
            return _samplePages[index];
          },
        ),
        Visibility(
          visible: showSkip,
          child: Padding(
            padding: EdgeInsets.only(top: 10.h,bottom: 10.h),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    // Flexible(child: Container()),
                    Flexible(
                      flex: 1,
                      child: GestureDetector(
                          onTap: (){
                            _onIntroEnd(context);
                          },
                          child: Center(child: Text("Skip",style: TextStyle(fontWeight: FontWeight.normal,color: HexColor.fromHex("#444649")),))),
                    ),
                    Flexible(
                      flex: 1,
                      child:   DotsIndicator(
                        dotsCount: _samplePages.length,
                        position: double.tryParse(currentPage.toString())!,
                        decorator: DotsDecorator(
                          activeColor: btnTextColor,
                          shape:  RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                          activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                          size: Size.fromRadius(4.w),
                          spacing: const EdgeInsets.all(4.0),
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: GestureDetector(
                          onTap: (){
                            if (currentPage == 2) showSkip = false;
                            if (currentPage == 1) showSkip = true;
                            if (currentPage == 0) showSkip = true;
                            controller.jumpToPage(currentPage++);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(child: Text("Next",style: TextStyle(fontWeight: FontWeight.normal,color: HexColor.fromHex("#444649")),)),
                              Icon(Icons.arrow_forward_sharp, color: HexColor.fromHex("#444649"),)
                            ],
                          )),
                    )
                  ],),
              ),
            ),
          ),
        ),
        Visibility(
          visible: !showSkip,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child:GestureDetector(
                onTap: (){
                  _onIntroEnd(context);
                },
                child: Container(
                  width: double.infinity,
                  height: 50.w,
                  padding: const EdgeInsets.all(7),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.bottomRight,
                          colors: <Color>[appBarColor2, appBarColor1]),
                      borderRadius: const BorderRadius.all( Radius.circular(10.0),)),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Text("Get Started",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.white,)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
  Future<void> _onIntroEnd(context) async {
    bool userLogin = await SharedPreferenceUtil.getBoolValuesSF(IS_LOGIN);
    if (userLogin) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const MainPage()));
    } else {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const SignInPage()));
      //                MaterialPageRoute(builder: (context) => const LoginPage()));
    }

  }
}