import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:yg_app/elements/text_widgets.dart';
import 'package:yg_app/helper_utils/app_images.dart';
import '../../helper_utils/app_colors.dart';
import '../../helper_utils/app_constants.dart';
import '../../helper_utils/shared_pref_util.dart';
import '../auth_pages/login/signin_page.dart';
import '../main_page.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();
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

  Widget _buildFullscreenImage() {
    return Image.asset(
      'images/fullscreen.jpg',
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.center,
    );
  }

  Widget _buildImage(String bg,String circle,String image, [double width = 250]) {
    return Stack(
      children: [
        Image.asset(bg, width: MediaQuery.of(context).size.width,fit: BoxFit.fill,),
        Center(child: Image.asset(circle,width: MediaQuery.of(context).size.width/1.4,)),
        Center(child: Image.asset(image,scale: 1.5,)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var bodyStyle = TextStyle(fontSize: 12.sp);
    var pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      titlePadding: const EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 5.0),
      bodyPadding: const EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 5.0),
      pageColor: Colors.white,
      imagePadding: const EdgeInsets.all(0.0),
    );

    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Colors.white,
      // globalHeader: Align(
      //   alignment: Alignment.topLeft,
      //   child: SafeArea(
      //     child: Padding(
      //       padding: const EdgeInsets.only(top: 16, left: 16),
      //       child: _buildImage('logo.png', 30),
      //     ),
      //   ),
      // ),
      // globalFooter: SizedBox(
      //   width: double.infinity,
      //   height: 60,
      //   child: ElevatedButton(
      //     child: const Text(
      //       'Let\'s go right away!',
      //       style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
      //     ),
      //     onPressed: () => _onIntroEnd(context),
      //   ),
      // ),
      pages: [
        PageViewModel(

          titleWidget: const TitleTextWidget(title:"Grow your business with Yarn Guru"),
          bodyWidget:const NormalTitleTextWidget(title:   "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.",
          ),
         image: _buildImage(first_bg,first_circle,first),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Discover wide range of Products",
          body:
          "It is a long established fact that a reader will be distracted by the readable content of a page.",
          image: _buildImage(second_bg,second_circle,second),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Trade Anywhere Anytime",
          body:
          "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.",
          image: _buildImage(third_bg,third_circle,third),
          decoration: pageDecoration,
          footer: SizedBox(
              height: 50.w,
              width: double.infinity,
              child: TextButton(
                  child: Row(
                    children: [
                      Expanded(
                        child: Center(
                          child: Text("Get Started",
                              style: TextStyle(
                                fontSize: 14.sp,
                                /**/
                              )),
                        ),
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

                  }
              )
          )
        ),
        // PageViewModel(
        //   title: "Full Screen Page",
        //   body:
        //   "Pages can be full screen as well.\n\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc id euismod lectus, non tempor felis. Nam rutrum rhoncus est ac venenatis.",
        //   image: _buildFullscreenImage(),
        //   decoration: pageDecoration.copyWith(
        //     contentMargin: const EdgeInsets.symmetric(horizontal: 16),
        //     fullScreen: true,
        //     bodyFlex: 2,
        //     imageFlex: 3,
        //   ),
        // ),
        // PageViewModel(
        //   title: "Another title page",
        //   body: "Another beautiful body text for this example on-boarding",
        //   image: _buildImage('img2.jpg'),
        //   // footer: ElevatedButton(
        //   //   onPressed: () {
        //   //     introKey.currentState?.animateScroll(0);
        //   //   },
        //   //   child: const Text(
        //   //     'FooButton',
        //   //     style: TextStyle(color: Colors.white),
        //   //   ),
        //   //   style: ElevatedButton.styleFrom(
        //   //     primary: Colors.lightBlue,
        //   //     shape: RoundedRectangleBorder(
        //   //       borderRadius: BorderRadius.circular(8.0),
        //   //     ),
        //   //   ),
        //   // ),
        //   decoration: pageDecoration,
        //   reverse: true
        // ),
        // PageViewModel(
        //   title: "Title of last page - reversed",
        //   bodyWidget: Row(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: const [
        //       Text("Click on ", style: bodyStyle),
        //       Icon(Icons.edit),
        //       Text(" to edit a post", style: bodyStyle),
        //     ],
        //   ),
        //   decoration: pageDecoration.copyWith(
        //     bodyFlex: 2,
        //     imageFlex: 4,
        //     bodyAlignment: Alignment.bottomCenter,
        //     imageAlignment: Alignment.topCenter,
        //   ),
        //   image: _buildImage('img1.jpg'),
        //   reverse: true,
        // ),
      ],
      onDone: () => _onIntroEnd(context),
      onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      showDoneButton: false,
      skipOrBackFlex: 0,
      nextFlex: 0,
      showBackButton: false,
      //rtl: true, // Display as right-to-left
      back:  const Icon(Icons.arrow_back,
          color: Colors.green,),
      skip:   Text('Skip', style: TextStyle(fontWeight: FontWeight.w600,color:HexColor.fromHex("#444649"),)),
      next:   Icon(Icons.arrow_forward_sharp, color: HexColor.fromHex("#444649"),),
      isProgress: false,
      curve: Curves.bounceInOut,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: kIsWeb
          ? const EdgeInsets.all(12.0)
          : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator:   DotsDecorator(
        size:  const Size(10.0, 10.0),
        color:  const Color(0xFFBDBDBD),
        activeSize:  const Size(10.0, 10.0),
        activeColor: appBarColor2,
        activeShape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
      ),
      dotsContainerDecorator: const ShapeDecoration(
        // color: Colors.black87,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
    );
  }
}
