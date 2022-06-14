import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/pages/profile/profile_segment_component.dart';

import '../../../elements/custom_header.dart';


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
                padding: EdgeInsets.only(left: 10.w, right: 10.w),
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


