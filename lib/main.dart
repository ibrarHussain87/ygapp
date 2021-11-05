import 'dart:async';

import 'package:flutter/material.dart';
import 'package:yg_app/pages/auth_pages/login_page.dart';
import 'package:yg_app/pages/auth_pages/sign_up_page.dart';
import 'package:yg_app/pages/main_page.dart';
import 'package:yg_app/utils/images.dart';
void main() {
  runApp(YgApp());
}

class YgApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Splash Screen',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
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
    Timer(Duration(seconds: 5),
            ()=>Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) =>
                const LoginPage()
            )
        )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.asset(AppImages.splashImage,fit: BoxFit.fill),
    );
  }
}