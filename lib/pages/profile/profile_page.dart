import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/app_database/app_database_instance.dart';
import 'package:yg_app/elements/elevated_button_widget_2.dart';
import 'package:yg_app/elements/profile_elements/profile_tile_widget.dart';
import 'package:yg_app/elements/title_text_widget.dart';
import 'package:yg_app/helper_utils/app_colors.dart';
import 'package:yg_app/helper_utils/app_constants.dart';
import 'package:yg_app/helper_utils/app_images.dart';
import 'package:yg_app/helper_utils/connection_status_singleton.dart';
import 'package:yg_app/helper_utils/shared_pref_util.dart';
import 'package:yg_app/model/response/login/login_response.dart';
import 'package:yg_app/helper_utils/navigation_utils.dart';
import 'package:yg_app/pages/auth_pages/login/signin_page.dart';
import 'package:yg_app/pages/auth_pages/login_page.dart';
class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder<User?>(
        future: AppDbInstance().getDbInstance().then((value) => value.userDao.getUser()),
        builder: (context,snapshot){
          if(snapshot.hasData && snapshot.data != null){
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                centerTitle: true,
                /*leading: GestureDetector(
                  behavior: HitTestBehavior.opaque,
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
                ),*/
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
                              child: TitleTextWidget(title: snapshot.data!.username),
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
                            TitleTextWidget(
                              title: snapshot.data!.company, color: Colors.grey.shade700,),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 8.w,vertical: 8.w),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey.shade300),
                                  borderRadius: BorderRadius.circular(8.w),
                                  color: Colors.white

                              ),
                              child: ListView(
                                shrinkWrap: true,
                                children: [
                                  GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    onTap: (){
                                      openPersonalDetailsScreen(context);
                                    },
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(top:5.0),
                                          child: ProfileTileWidget(title: "Personal Details",
                                              image: PROFILE_DETAILS_IMAGE),
                                        ),
                                        const Divider()
                                      ],
                                    ),
                                  ),

                                  // Column(
                                  //   children: [
                                  //     ProfileTileWidget(title: "My Offerings",
                                  //         image: ic_tag),
                                  //     const Divider()
                                  //   ],
                                  // ),
                                  // GestureDetector(
                                  //   behavior: HitTestBehavior.opaque,
                                  //   onTap: (){},
                                  //   child: Column(
                                  //     children: [
                                  //       ProfileTileWidget(title: "My Requirements",
                                  //           image: ic_requirments),
                                  //       const Divider()
                                  //     ],
                                  //   ),
                                  // ),
                                  GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    onTap: (){
                                      openMyAdsScreen(context);
                                    },
                                    child: Column(
                                      children: [
                                        ProfileTileWidget(title: "My Product",
                                            image: ic_products),
                                        const Divider()
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    onTap: (){
                                      openMyBidsScreen(context);
                                    },
                                    child: Column(
                                      children: [
                                        ProfileTileWidget(title: "My Bids",
                                            image: ic_universe),
                                        const Divider()
                                      ],
                                    ),
                                  ),
                                  //
                                  // Column(
                                  //   children: [
                                  //     ProfileTileWidget(title: "Auctions",
                                  //         image: AUCTION_IMAGE),
                                  //     const Divider()
                                  //   ],
                                  // ),

                                  // Column(
                                  //   children: [
                                  //     ProfileTileWidget(title: "Inquiries",
                                  //         image: ic_inquiries),
                                  //     const Divider()
                                  //   ],
                                  // ),
                                  GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    onTap: (){
                                      openMembershipScreen(context);
                                    },
                                    child: Column(
                                      children: [
                                        ProfileTileWidget(title: "Membership",
                                            image: ic_membership),
                                        const Divider()
                                      ],
                                    ),
                                  ),
                                  // Column(
                                  //   children: [
                                  //     ProfileTileWidget(title: "Customer & Supplier",
                                  //         image: ic_suppliers),
                                  //     const Divider()
                                  //   ],
                                  // ),

                                  // Column(
                                  //   children: [
                                  //     ProfileTileWidget(title: "FAQs",
                                  //         image: ic_faq),
                                  //     const Divider()
                                  //   ],
                                  // ),
                                  // Column(
                                  //   children: [
                                  //     ProfileTileWidget(title: "Activity Log",
                                  //         image: ic_log),
                                  //     const Divider()
                                  //   ],
                                  // ),

                                  GestureDetector(
                                    onTap:(){
                                      openCustomerSupportScreen(context);
                                    },
                                    child: Column(
                                      children: [
                                        ProfileTileWidget(title: "Customer Support",
                                            image: ic_support),
                                        // const Divider()
                                        SizedBox(height: 10.0.h,)
                                      ],
                                    ),
                                  ),
                                ],
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
                        callback: () {
                          showLogoutDialog("Alert", "Are you sure you want to logout?", context, (){
                            AppDbInstance().getDbInstance().then((value) {
                              value.userDao.deleteUserData();
                              value.yarnSettingsDao.deleteYarnSettings();
                              value.fiberSettingDao.deleteAll();
                              value.fiberBlendsDao.deleteAll();
                              value.fiberSettingDao.deleteAll();
                              value.gradesDao.deleteAll();
                              value.fiberFamilyDao.deleteAll();
                              value.packingDao.deleteAll();
                              value.patternDao.deleteAll();
                              value.patternCharDao.deleteAll();
                              value.paymentTypeDao.deleteAll();
                              value.deliveryPeriodDao.deleteAll();
                              value.lcTypeDao.deleteAll();
                              value.yarnGradesDao.deleteAll();
                              value.fiberAppearanceDoa.deleteAll();
                              value.yarnAppearanceDao.deleteAll();
                              value.certificationDao.deleteAll();
                              value.yarnBlendDao.deleteAll();
                              value.coneTypeDao.deleteAll();
                              value.yarnTypesDao.deleteAll();
                              value.colorTreatmentMethodDao.deleteAll();
                              value.dyingMethodDao.deleteAll();
                              value.usageDao.deleteAll();
                              value.unitDao.deleteAll();
                              value.orientationDao.deleteAll();
                              value.plyDao.deleteAll();
                              value.qualityDao.deleteAll();
                              value.brandsDao.deleteAll();
                              value.cityStateDao.deleteAll();
                              value.companiesDao.deleteAll();
//                              value.countriesDao.deleteAll();
                              value.portsDao.deleteAll();
                              value.fabricBlendsDao.deleteFabricBlends();
                              value.fabricFamilyDao.deleteFabricFamilies();
                              value.fabricSettingDao.deleteFabricSettings();
                              value.fabricAppearanceDao.deleteFabricAppearances();
                              value.fabricDenimTypesDao.deleteFabricDenimTypes();
                              value.fabricColorTreatmentMethodDao.deleteFabricFiberColorTreatmentMethods();
                              value.fabricDyingTechniqueDao.deleteFabricDyingTechniques();
                              value.fabricLoomDao.deleteFabricLooms();
                              value.fabricPlyDao.deleteFabricPlys();
                              value.fabricQualityDao.deleteFabricQualities();
                              value.fabricLayyerDao.deleteFabricLayyers();
                              value.fabricQualityDao.deleteFabricQualities();
                              value.fabricSalvedgeDao.deleteFabricSalvedges();
                              value.fabricWeaveDao.deleteFabricWeaves();
                              value.stocklotCategoriesDao.deleteAll();

                            });
                            SharedPreferenceUtil.addBoolToSF(SYNCED_KEY, false);
                            SharedPreferenceUtil.addBoolToSF(IS_LOGIN, false);
                            SharedPreferenceUtil.addStringToSF(USER_TOKEN_KEY, "");
                            SharedPreferenceUtil.addStringToSF(USER_ID_KEY, "");

                            Navigator.pushAndRemoveUntil(context,
                              MaterialPageRoute(builder: (context) => const SignInPage()),(route) => false,);
//                              MaterialPageRoute(builder: (context) => const LoginPage()),(route) => false,);
                          });
                        }, color: Colors.green, btnText: "Logout"),
                  ))
                ],
              ),
            );
          }else {
            return Container();
          }
        },
      ),
    );
  }

}
