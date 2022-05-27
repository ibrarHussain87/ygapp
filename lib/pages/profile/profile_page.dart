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
import 'package:yg_app/helper_utils/dialog_builder.dart';
import 'package:yg_app/helper_utils/progress_dialog_util.dart';
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
        future: AppDbInstance().getDbInstance().then((value) =>
            value.userDao.getUser()),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
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
                                        child: Icon(
                                          Icons.person, color: Colors.white,
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
                              child: TitleTextWidget(
                                  title: snapshot.data!.username),
                            ),
                            Container(
                              padding: EdgeInsets.only(bottom: 8.w),
                              child: TitleSmallTextWidget(
                                title: "Lahore, Pakistan",
                                color: Colors.grey.shade600,),
                            ),
                            Container(
                              child: TitleSmallTextWidget(title: "Seller Type",
                                color: Colors.grey.shade600,
                                padding: 4,),
                            ),
                            TitleTextWidget(
                              title: snapshot.data!.company,
                              color: Colors.grey.shade700,),
                            Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 8.w, vertical: 8.w),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.grey.shade300),
                                  borderRadius: BorderRadius.circular(8.w),
                                  color: Colors.white

                              ),
                              child: ListView(
                                shrinkWrap: true,
                                children: [
                                  GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    onTap: () {
                                      openPersonalDetailsScreen(context);
                                    },
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 5.0),
                                          child: ProfileTileWidget(
                                              title: "Personal Details",
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
                                    onTap: () {
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
                                    onTap: () {
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
                                    onTap: () {
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
                                    onTap: () {
                                      openCustomerSupportScreen(context);
                                    },
                                    child: Column(
                                      children: [
                                        ProfileTileWidget(
                                            title: "Customer Support",
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
                          showLogoutDialog(
                              "Alert", "Are you sure you want to logout?",
                              context, () async {
                            Navigator.pop(context);
                            DialogBuilder(context, title: "Please wait ...").showLoadingDialog();
                            await SharedPreferenceUtil.addBoolToSF(SYNCED_KEY, false);
                            await SharedPreferenceUtil.addBoolToSF(IS_LOGIN, false);
                            await SharedPreferenceUtil.addStringToSF(USER_TOKEN_KEY, "");
                            await SharedPreferenceUtil.addStringToSF(USER_ID_KEY, "");
                            await SharedPreferenceUtil.addBoolToSF(PRE_SYNCED_KEY,false);
                            var dbInstance = await AppDbInstance().getDbInstance();
                            await
                            dbInstance.userDao.deleteUserData();
                            await dbInstance.categoriesDao.deleteAll();
                            await dbInstance.fabricGradesDao
                                .deleteFabricGrades();
                            await dbInstance.knittingTypesDao
                                .deleteKnittingTypes();
                            await dbInstance.priceTermsDao.deleteAll();
                            await dbInstance.qualityDao.deleteAll();
                            await dbInstance.spunTechDao.deleteAll();
                            await dbInstance.yarnFamilyDao.deleteAll();
                            await dbInstance.doublingMethodDao.deleteAll();
                            await dbInstance.yarnSettingsDao
                                .deleteYarnSettings();
                            await dbInstance.fiberSettingDao.deleteAll();
                            await dbInstance.fiberBlendsDao.deleteAll();
                            await dbInstance.fiberSettingDao.deleteAll();
                            await dbInstance.gradesDao.deleteAll();
                            await dbInstance.fiberFamilyDao.deleteAll();
                            await dbInstance.patternDao.deleteAll();
                            await dbInstance.patternCharDao.deleteAll();
                            await dbInstance.paymentTypeDao.deleteAll();
                            await dbInstance.deliveryPeriodDao.deleteAll();
                            await dbInstance.yarnGradesDao.deleteAll();
                            await dbInstance.fiberAppearanceDoa.deleteAll();
                            await dbInstance.yarnAppearanceDao.deleteAll();
                            await dbInstance.certificationDao.deleteAll();
                            await dbInstance.yarnBlendDao.deleteAll();
                            await dbInstance.coneTypeDao.deleteAll();
                            await dbInstance.yarnTypesDao.deleteAll();
                            await dbInstance.colorTreatmentMethodDao
                                .deleteAll();
                            await dbInstance.dyingMethodDao.deleteAll();
                            await dbInstance.usageDao.deleteAll();
                            await dbInstance.unitDao.deleteAll();
                            await dbInstance.orientationDao.deleteAll();
                            await dbInstance.plyDao.deleteAll();
                            await dbInstance.qualityDao.deleteAll();
                            await dbInstance.brandsDao.deleteAll();
                            await dbInstance.cityStateDao.deleteAll();
                            await dbInstance.companiesDao.deleteAll();
//                          await dbInstanceue.countriesDao.deleteAll();
                            await dbInstance.portsDao.deleteAll();
                            await dbInstance.fabricBlendsDao
                                .deleteFabricBlends();
                            await dbInstance.fabricFamilyDao
                                .deleteFabricFamilies();
                            await dbInstance.fabricSettingDao
                                .deleteFabricSettings();
                            await dbInstance.fabricAppearanceDao
                                .deleteFabricAppearances();
                            await dbInstance.fabricDenimTypesDao
                                .deleteFabricDenimTypes();
                            await dbInstance.fabricColorTreatmentMethodDao
                                .deleteFabricFiberColorTreatmentMethods();
                            await dbInstance.fabricDyingTechniqueDao
                                .deleteFabricDyingTechniques();
                            await dbInstance.fabricLoomDao.deleteFabricLooms();
                            await dbInstance.fabricPlyDao.deleteFabricPlys();
                            await dbInstance.fabricQualityDao
                                .deleteFabricQualities();
                            await dbInstance.fabricLayyerDao
                                .deleteFabricLayyers();
                            await dbInstance.fabricQualityDao
                                .deleteFabricQualities();
                            await dbInstance.fabricSalvedgeDao
                                .deleteFabricSalvedges();
                            await dbInstance.fabricWeaveDao
                                .deleteFabricWeaves();
                            await dbInstance.stocklotCategoriesDao.deleteAll();
                            DialogBuilder(context).hideDialog();


                            Navigator.pushAndRemoveUntil(context,
                              MaterialPageRoute(
                                  builder: (context) => const SignInPage()), (
                                  route) => false,);
//                              MaterialPageRoute(builder: (context) => const LoginPage()),(route) => false,);
                          });
                        }, color: Colors.green, btnText: "Logout"),
                  ))
                ],
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

}
