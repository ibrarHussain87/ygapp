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
import 'package:provider/provider.dart';
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

              ],
            ),
            ),

    )
    );
  }


}


