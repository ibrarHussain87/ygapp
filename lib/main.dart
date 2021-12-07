import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yg_app/pages/auth_pages/login_page.dart';
import 'package:yg_app/pages/main_page.dart';
import 'package:yg_app/utils/app_images.dart';
import 'package:yg_app/utils/shared_pref_util.dart';
import 'package:yg_app/utils/strings.dart';

void main() {
  runApp(YgApp());
}

class YgApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MaterialApp(
      title: 'Splash Screen',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        fontFamily: 'Metropolis'
      ),
      home: YgAppPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class YgAppPage extends StatefulWidget {
  @override
  _YgAppPageState createState() => _YgAppPageState();
}

class _YgAppPageState extends State<YgAppPage> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () async {
      bool userLogin = await SharedPreferenceUtil.getBoolValuesSF(AppStrings.IS_LOGIN);

      if(userLogin){
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const MainPage()));
      }else{
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const LoginPage()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    //Set the fit size (fill in the screen size of the device in the design) If the design is based on the size of the 360*690(dp)
    ScreenUtil.init(
        BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            maxHeight: MediaQuery.of(context).size.height),
        designSize: Size(360, 690),
        orientation: Orientation.portrait);
    return Container(
      child: Image.asset(AppImages.splashImage, fit: BoxFit.fill),
    );
  }
}
