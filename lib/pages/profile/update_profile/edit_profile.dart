import 'dart:convert';


import 'package:flutter/foundation.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import '../../../elements/custom_header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:yg_app/api_services/api_service_class.dart';
import 'package:yg_app/app_database/app_database_instance.dart';
import 'package:yg_app/elements/decoration_widgets.dart';
import 'package:yg_app/helper_utils/app_colors.dart';
import 'package:yg_app/helper_utils/connection_status_singleton.dart';
import 'package:yg_app/helper_utils/progress_dialog_util.dart';
import 'package:yg_app/model/pre_login_response.dart';
import 'package:yg_app/model/request/update_profile/brands_request_model.dart';
import 'package:yg_app/model/request/update_profile/update_profile_request.dart';
import 'package:yg_app/model/response/common_response_models/brands_response.dart';
import 'package:yg_app/model/response/login/login_response.dart';
import 'package:yg_app/pages/profile/profile_segment_component.dart';
import 'package:yg_app/pages/profile/update_profile/user_notifier.dart';

import '../../../helper_utils/ui_utils.dart';
import '../../../helper_utils/util.dart';
import '../../../model/request/update_profile/update_business_request.dart';
import '../../../model/response/common_response_models/companies_reponse.dart';
import '../../../model/response/common_response_models/countries_response.dart';
import '../../auth_pages/signup/country_search_page.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  int selectedValue = 1;
  @override
  void initState() {

    super.initState();
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
        appBar: appBar(context,"Update Profile"),
//        AppBar(
//          backgroundColor: Colors.white,
//          centerTitle: true,
//          leading: GestureDetector(
//            behavior: HitTestBehavior.opaque,
//            onTap: () {
//              Navigator.pop(context);
//            },
//            child: Padding(
//                padding: EdgeInsets.all(12.w),
//                child: Card(
//                  child: Padding(
//                      padding: EdgeInsets.only(left: 4.w),
//                      child: Icon(
//                        Icons.arrow_back_ios,
//                        color: Colors.black,
//                        size: 12.w,
//                      )),
//                )),
//          ),
//          title: Text('Update Profile',
//              style: TextStyle(
//                  fontSize: 16.0.w,
//                  color: appBarTextColor,
//                  fontWeight: FontWeight.w400)),
//        ),
        body: Column(
          children: [
            const SizedBox(height: 14.0,),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 18.w, right: 18.w),
                child: ProfileSegmentComponent(
                  selectedTab: "1",
                  stepsCallback: (value) {
                    if (value is int) {
                      selectedValue = value;
                    }
                  },
                ),
              ),
            ),


          ],
        ),
      ),
    );
  }



}


