import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/elements/elevated_button_widget_2.dart';
import 'package:yg_app/elements/profile_elements/profile_tile_widget.dart';
import 'package:yg_app/elements/title_text_widget.dart';
import 'package:yg_app/helper_utils/app_colors.dart';
import 'package:yg_app/helper_utils/app_images.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
                padding: EdgeInsets.all(12.w),
                child: Card(
                  child: Padding(
                      padding: EdgeInsets.only(left: 4.w),
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.black,
                        size: 12.w,
                      )),
                )),
          ),
          title: Text('Profile',
              style: TextStyle(
                  fontSize: 16.0.w,
                  color: appBarTextColor,
                  fontWeight: FontWeight.w400)),
        ),
        key: scaffoldKey,
        backgroundColor: Colors.grey.shade200,
        body: Column(
          children: [
            Expanded(
              flex: 8,
              child: Container(
                padding: EdgeInsets.only(top: 24.w),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 48,
                        backgroundColor: Color(0xff132D5A),
                        child: Stack(
                            children: const [
                              Align(
                                alignment: Alignment.center,
                                child: CircleAvatar(
                                  radius: 38,
                                  backgroundColor: Colors.transparent,
                                  child: Icon(Icons.person, color: Colors.white,
                                    size: 74,),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: CircleAvatar(
                                  radius: 18,
                                  backgroundColor: Colors.grey,
                                  child: Icon(CupertinoIcons.camera,
                                    color: Colors.white,),
                                ),
                              ),
                            ]
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 16.w, bottom: 2.w),
                        child: TitleTextWidget(title: "Inverted Traders"),
                      ),
                      Container(
                        padding: EdgeInsets.only(bottom: 8.w),
                        child: TitleSmallTextWidget(title: "Lahore, Pakistan",
                          color: Colors.grey.shade600,),
                      ),
                      Container(
                        child: TitleSmallTextWidget(title: "Seller Type",
                          color: Colors.grey.shade600,
                          padding: 4,),
                      ),
                      Container(
                        child: TitleTextWidget(
                          title: "Mills", color: Colors.grey.shade700,),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 8.w,vertical: 8.w),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(8.w),
                              color: Colors.white

                          ),
                          child: ListView(
                            children: [
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top:5.0),
                                    child: ProfileTileWidget(title: "My Ads",
                                        image: PROFILE_DETAILS_IMAGE),
                                  ),
                                  Divider()
                                ],
                              ),
                              Column(
                                children: [
                                  ProfileTileWidget(title: "My Ads",
                                      image: PROFILE_DETAILS_IMAGE),
                                  Divider()
                                ],
                              ),
                              Column(
                                children: [
                                  ProfileTileWidget(title: "My Ads",
                                      image: PROFILE_DETAILS_IMAGE),
                                  Divider()
                                ],
                              ),
                              Column(
                                children: [
                                  ProfileTileWidget(title: "My Ads",
                                      image: PROFILE_DETAILS_IMAGE),
                                  Divider()
                                ],
                              ),
                              Column(
                                children: [
                                  ProfileTileWidget(title: "My Ads",
                                      image: PROFILE_DETAILS_IMAGE),
                                  Divider()
                                ],
                              ),
                              Column(
                                children: [
                                  ProfileTileWidget(title: "My Ads",
                                      image: PROFILE_DETAILS_IMAGE),
                                  Divider()
                                ],
                              ),
                              Column(
                                children: [
                                  ProfileTileWidget(title: "My Ads",
                                      image: PROFILE_DETAILS_IMAGE),
                                  Divider()
                                ],
                              ),
                              Column(
                                children: [
                                  ProfileTileWidget(title: "My Ads",
                                      image: PROFILE_DETAILS_IMAGE),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(flex: 1, child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade200),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(16.w),
                      topLeft: Radius.circular(16.w)),
                  color: Colors.white
              ),
              padding: EdgeInsets.all(16.w),
              child: ElevatedButtonWithoutIcon(
                  callback: () {}, color: Colors.green, btnText: "Logout"),
            ))
          ],
        ),
      ),
    );
  }
}
