import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/pages/profile/profile_segment_component.dart';

import '../../../elements/custom_header.dart';
import '../../../locators.dart';
import '../../../providers/profile_providers/profile_info_provider.dart';


class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  int selectedValue = 1;
  final _profileInfoProvider = locator<ProfileInfoProvider>();
  @override
  void initState() {

    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _profileInfoProvider.resetData();
      _profileInfoProvider.getSyncedData();

    });
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


