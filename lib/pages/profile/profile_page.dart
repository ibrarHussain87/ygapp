import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stylish_dialog/stylish_dialog.dart';
import 'package:yg_app/api_services/api_service_class.dart';
import 'package:yg_app/app_database/app_database_instance.dart';
import 'package:yg_app/elements/elevated_button_widget.dart';
import 'package:yg_app/elements/profile_elements/profile_tile_widget.dart';
import 'package:yg_app/elements/text_widgets.dart';
import 'package:yg_app/helper_utils/app_colors.dart';
import 'package:yg_app/helper_utils/app_constants.dart';
import 'package:yg_app/helper_utils/connection_status_singleton.dart';
import 'package:yg_app/helper_utils/dialog_builder.dart';
import 'package:yg_app/helper_utils/navigation_utils.dart';
import 'package:yg_app/helper_utils/progress_dialog_util.dart';
import 'package:yg_app/helper_utils/shared_pref_util.dart';
import 'package:yg_app/helper_utils/ui_utils.dart';
import 'package:yg_app/locators.dart';
import 'package:yg_app/model/response/login/login_response.dart';
import 'package:yg_app/pages/auth_pages/login/signin_page.dart';
import 'package:yg_app/providers/profile_providers/profile_info_provider.dart';

import '../../elements/custom_header.dart';
import '../../elements/profile_elements/add_profile_picture_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _profileInfoProvider = locator<ProfileInfoProvider>();

  @override
  void initState() {
    super.initState();
    _profileInfoProvider.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder<User?>(
        future: AppDbInstance()
            .getDbInstance()
            .then((value) => value.userDao.getUser()),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            return Scaffold(
              appBar: /*AppBar(
                backgroundColor: Colors.white,
                centerTitle: true,
                */ /*leading: GestureDetector(
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
                ),*/ /*
                title: Text('Profile',
                    style: TextStyle(
                        fontSize: 16.0.w,
                        color: appBarTextColor,
                        fontWeight: FontWeight.w400)),
              )*/
                  appBar(context, "Profile & Settings", isBackVisible: true),
              key: scaffoldKey,
              backgroundColor: Colors.white,
              body: Column(
                children: [
                  Expanded(
                    flex: 8,
                    child: Container(
                      padding: EdgeInsets.only(top: 14.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 18),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    AddProfilePictureWidget(
                                      imageCount: 1,
                                      callbackImages: (PickedFile value) {
                                        ProgressDialogUtil.showDialog(
                                            context, "Uploading...");
                                        ApiService()
                                            .uploadProfilePic(value.path)
                                            .then((value) {
                                          ProgressDialogUtil.hideDialog();
                                          if (value.success!) {
                                            _profileInfoProvider
                                                .updateProfileData(value);
                                            // Ui.showSnackBar(context, value.message.toString());
                                            showGenericDialog(
                                                'Success',
                                                value.message.toString(),
                                                context,
                                                StylishDialogType.SUCCESS,
                                                'Ok',
                                                () {});
                                          } else {
                                            showGenericDialog(
                                                'Alert',
                                                value.message.toString(),
                                                context,
                                                StylishDialogType.ERROR,
                                                'Ok',
                                                () {});
                                          }
                                        }, onError: (error) {
                                          ProgressDialogUtil.hideDialog();
                                          showGenericDialog(
                                              'Alert',
                                              error.toString(),
                                              context,
                                              StylishDialogType.ERROR,
                                              'Ok',
                                              () {});
                                        });
                                        // imageFile = value;
                                      },
                                    ),
                                    // ClipRRect(
                                    //   borderRadius: BorderRadius.circular(18.0),
                                    //   child: Container(
                                    //     child: Image.asset('images/img_dummy_profile.png',
                                    //         height: 55.w,
                                    //         width: 55.w,
                                    //         fit: BoxFit.fill,
                                    //     ),
                                    //   ),
                                    // ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.only(
                                                top: 16.w, bottom: 1.w),
                                            child: TitleTextWidget(
                                              title: snapshot.data!.username,
                                              fontSize: 15.sp,
                                            ),
                                          ),
                                          Container(
                                            padding:
                                                EdgeInsets.only(bottom: 8.w),
                                            child: TitleSmallTextWidget(
                                              title: "Lahore, Pakistan",
                                              color: Colors.grey.shade600,
                                              size: 12.sp,
                                            ),
                                          ),
                                          /*Container(
                                            child: TitleSmallTextWidget(title: "Seller Type",
                                              color: Colors.grey.shade600,
                                              padding: 4,),
                                          ),
                                          TitleTextWidget(
                                            title: snapshot.data!.company,
                                            color: Colors.grey.shade700,),*/
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 18,
                              ),
                              child: Divider()),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Align(
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 18, top: 15),
                                    child: TitleTextWidget(title: 'Settings'),
                                  )),
                              Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 0.w, vertical: 8.w),
                                decoration: BoxDecoration(
                                    /*border: Border.all(
                                        color: Colors.grey.shade300),*/
                                    borderRadius: BorderRadius.circular(8.w),
                                    color: Colors.white),
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
                                          const Padding(
                                            padding: EdgeInsets.only(top: 5.0),
                                            child: ProfileTileWidget(
                                                title: "Account Details",
                                                image:
                                                    'images/svg/ic_profile_reloaded.svg'),
                                          ),
                                          /*const Divider()*/
                                          SizedBox(
                                            height: 5.0.h,
                                          )
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
                                          const ProfileTileWidget(
                                              title: "My Products",
                                              image:
                                                  'images/svg/ic_offering_reloaded.svg'),
                                          /*const Divider()*/
                                          SizedBox(
                                            height: 5.0.h,
                                          )
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
                                          const ProfileTileWidget(
                                              title: "My Bids",
                                              image:
                                                  'images/svg/ic_requirements_reloaded.svg'),
                                          /*const Divider()*/
                                          SizedBox(
                                            height: 5.0.h,
                                          )
                                        ],
                                      ),
                                    ),

                                    GestureDetector(
                                      behavior: HitTestBehavior.opaque,
                                      onTap: () {
                                        openMyServicesScreen(context);
                                      },
                                      child: Column(
                                        children: [
                                          const ProfileTileWidget(
                                              title: "My Services",
                                              image:
                                                  'images/svg/ic_services_reloaded.svg'),
                                          /*const Divider()*/
                                          SizedBox(
                                            height: 5.0.h,
                                          )
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
                                          const ProfileTileWidget(
                                              title: "Membership",
                                              image:
                                                  'images/svg/ic_membership_reloaded.svg'),
                                          /*const Divider()*/
                                          SizedBox(
                                            height: 5.0.h,
                                          )
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
                                          const ProfileTileWidget(
                                              title: "Customer Support",
                                              image:
                                                  'images/svg/ic_customer_support_reloaded.svg'),
                                          // const Divider()
                                          SizedBox(
                                            height: 10.0.h,
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                            /*border: Border.all(color: Colors.grey.shade200),*/
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(16.w),
                                topLeft: Radius.circular(16.w)),
                            color: Colors.white),
                        padding: const EdgeInsets.only(
                            left: 16, right: 16, top: 13, bottom: 13),
                        child: ElevatedButtonWithIcon(
                          callback: () {
                            showLogoutDialog(
                                "Alert",
                                "Are you sure you want to logout?",
                                context, () async {
                              Navigator.pop(context);
                              DialogBuilder(context, title: "Please wait ...")
                                  .showLoadingDialog();
                              await SharedPreferenceUtil.addBoolToSF(
                                  SYNCED_KEY, false);
                              await SharedPreferenceUtil.addBoolToSF(
                                  IS_LOGIN, false);
                              await SharedPreferenceUtil.addStringToSF(
                                  USER_TOKEN_KEY, "");
                              await SharedPreferenceUtil.addStringToSF(
                                  USER_ID_KEY, "");
                              // await SharedPreferenceUtil.addBoolToSF(PRE_SYNCED_KEY,false);
                              var dbInstance =
                                  await AppDbInstance().getDbInstance();
                              await dbInstance.userDao.deleteUserData();
                              await dbInstance.userCategoriesDao.deleteAll();
                              await dbInstance.businessInfoDao
                                  .deleteBusinessInfoData();
                              await dbInstance.brandsDao.updateAllBrands(false);
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
                              // await dbInstance.brandsDao.deleteAll();
                              //  await dbInstance.cityStateDao.deleteAll();
                              // await dbInstance.companiesDao.deleteAll();
//                          await dbInstanceue.countriesDao.deleteAll();
                              // await dbInstance.portsDao.deleteAll();
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
                              await dbInstance.fabricLoomDao
                                  .deleteFabricLooms();
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
                              await dbInstance.stocklotCategoriesDao
                                  .deleteAll();
                              DialogBuilder(context).hideDialog();

                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SignInPage()),
                                (route) => false,
                              );
//                              MaterialPageRoute(builder: (context) => const LoginPage()),(route) => false,);
                            });
                          },
                          color: redColorLight,
                          btnText: "Logout",
                          icons: Icons.logout,
                        ),
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
