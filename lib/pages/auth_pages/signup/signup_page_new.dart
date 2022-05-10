import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_picker_dropdown.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yg_app/model/request/signup_request/signup_request.dart';
import 'package:yg_app/pages/auth_pages/signup/signup_segment_component.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  SignUpRequestModel? _signupRequestModel;


  int selectedValue = 1;


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
            body:Provider(
                create: (_) => _signupRequestModel,
              child: Column(
              children: [
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

              ],
            ),
            ),

    )
    );
  }


}


