import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:yg_app/api_services/api_service_class.dart';
import 'package:yg_app/app_database/app_database_instance.dart';
import 'package:yg_app/elements/title_text_widget.dart';
import 'package:yg_app/helper_utils/app_colors.dart';
import 'package:yg_app/helper_utils/app_constants.dart';
import 'package:yg_app/helper_utils/app_images.dart';
import 'package:yg_app/helper_utils/navigation_utils.dart';
import 'package:yg_app/helper_utils/progress_dialog_util.dart';

import 'dashboard_pages/home_page.dart';
import 'dashboard_pages/market_page.dart';
import 'dashboard_pages/yg_services.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  GlobalKey<HomePageState> homePageState = GlobalKey<HomePageState>();

  List<Widget>? _screens;
  int _selectedIndex = 0;
  bool isSynced = false;

  void _onItemTapped(int selectedIndex) {
    setState(() {
      _selectedIndex = selectedIndex;
    });
  }

  @override
  void initState() {
    super.initState();
    _screens = [
      HomePage(
        key: homePageState,
        callback: (value) {
          setState(() {
            _onItemTapped(1);
          });
        },
      ),
      MarketPage(
        locality: local,
      ),
      MarketPage(
        locality: international,
      ),
      const YGServices(),
      // const PastAdPage()
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: isSynced ? Scaffold(
          body: /*buildPageView()*/ IndexedStack( index: _selectedIndex,children: _screens!),
          bottomNavigationBar: _generateBottomBar()) : FutureBuilder<bool>(
        future: _synData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.data != null) {
            isSynced = true;
            return Scaffold(
                body: /*buildPageView()*/ IndexedStack( index: _selectedIndex,children: _screens!),
                bottomNavigationBar: _generateBottomBar());
          } else {
            return Scaffold(
                extendBodyBehindAppBar: true,
                backgroundColor: Colors.white,
                resizeToAvoidBottomInset: true,
                appBar: PreferredSize(
                  preferredSize: const Size.fromHeight(50),
                  child: Container(
                    decoration: BoxDecoration(/*boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0.0, 1.0.w), //(x,y)
                  blurRadius: 2.0.w,
                ),
              ],*/
                        color: Colors.white.withOpacity(0.7)),
                    child: Container(
                        padding: EdgeInsets.all(8.w),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                openProfileScreen(context);
                              },
                              child: const CircleAvatar(
                                radius: 24,
                                backgroundColor: Colors.green,
                                child: Icon(Icons.person, color: Colors.white,
                                  size: 24,),
                              ),
                            ),
                            SizedBox(
                              width: 3.w,
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                  top: 8.w,
                                  bottom: 8.w,
                                  left: 12.w,
                                  right: 12.w),
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.deepOrange.shade400,
                                      Colors.deepOrange.shade600,
                                    ],
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(12.w),
                                  )),
                              child: Text('Upgrade',
                                  style: TextStyle(
                                      fontSize: 9.0.w,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400)),
                            )
                          ],
                        )),
                  ),
                ),
                body: Container(
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SpinKitWave(
                        color: Colors.green,
                        size: 24.0,
                      ),
                      SizedBox(height: 6.w,),
                      const TitleSmallTextWidget(
                        title: "Syncing data please wait...",),
                    ],
                  ),

                ),
                bottomNavigationBar: _generateBottomBar());
          }
        },
      ),
    );
  }

  BottomNavigationBar _generateBottomBar() {
    return BottomNavigationBar(
      selectedItemColor: textColorBlue,
      unselectedItemColor: textColorGrey,
      selectedFontSize: 9.5.sp,
      unselectedFontSize: 9.5.sp,
      elevation: 24,
      backgroundColor: Colors.white,
      type: BottomNavigationBarType.fixed,
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      items: [
        BottomNavigationBarItem(
            icon: _selectedIndex == 0
                ? Padding(
                padding: EdgeInsets.all(5.w),
                child: Image.asset(
                  homeIcon,
                  width: 20.w,
                  height: 20.h,
                ))
                : Padding(
              padding: const EdgeInsets.all(5.0),
              child: Image.asset(
                homeGreyIcon,
                width: 20.w,
                height: 20.h,
              ),
            ),
            label: home),
        BottomNavigationBarItem(
            icon: _selectedIndex == 1
                ? Padding(
                padding: EdgeInsets.all(5.w),
                child: Image.asset(
                  marketIcon,
                  width: 20.w,
                  height: 20.h,
                ))
                : Padding(
              padding: EdgeInsets.all(5.0.w),
              child: Image.asset(
                marketGreyIcon,
                width: 20.w,
                height: 20.h,
              ),
            ),
            label: localMarket),
        BottomNavigationBarItem(
            icon: _selectedIndex == 2
                ? Padding(
              padding: EdgeInsets.all(5.w),
              child: Image.asset(
                marketIcon,
                width: 20.w,
                height: 20.h,
              ),
            )
                : Padding(
              padding: EdgeInsets.all(5.0.w),
              child: Image.asset(
                marketGreyIcon,
                width: 20.w,
                height: 20.h,
              ),
            ),
            label: internationalMarket),
        BottomNavigationBarItem(
            icon: _selectedIndex == 3
                ? Padding(
              padding: EdgeInsets.all(5.w),
              child: Image.asset(
                ygServicesIcon,
                width: 20.w,
                height: 20.h,
              ),
            )
                : Padding(
              padding: EdgeInsets.all(5.0.w),
              child: Image.asset(
                ygServicesGreyIcon,
                width: 20.w,
                height: 20.h,
              ),
            ),
            label: ygService),
        // BottomNavigationBarItem(
        //     icon: _selectedIndex == 4
        //         ? Padding(
        //             padding: EdgeInsets.all(5.w),
        //             child: Image.asset(
        //               postAdIcon,
        //               width: 20.w,
        //               height: 20.h,
        //             ),
        //           )
        //         : Padding(
        //             padding: EdgeInsets.all(5.0.w),
        //             child: Image.asset(
        //               postAdGreyIcon,
        //               width: 20.w,
        //               height: 20.h,
        //             ),
        //           ),
        //     label: auction),
      ],
    );
  }

  Future<bool> _synData() async {
    var syncFiberResponse = await ApiService.syncFiber();
    var syncYarnResponse = await ApiService.syncYarn();
    AppDbInstance.getDbInstance().then((value) async {
      await value.fiberMaterialDao
          .insertAllFiberMaterials(syncFiberResponse.data.fiber.material);

      await value.yarnFamilyDao
          .insertAllYarnFamily(syncYarnResponse.data.yarn.family!);

      await value.fiberSettingDao
          .insertAllFiberSettings(syncFiberResponse.data.fiber.settings);
      await value.gradesDao
          .insertAllGrades(syncFiberResponse.data.fiber.grades);
      await value.fiberNatureDao
          .insertAllFiberNatures(syncFiberResponse.data.fiber.natures);


      //insert Common objects for fiber
      await value.brandsDao
          .insertAllBrands(syncFiberResponse.data.fiber.brands);
      await value.certificationDao
          .insertAllCertification(syncFiberResponse.data.fiber.certification);
      await value.cityStateDao
          .insertAllCityState(syncFiberResponse.data.fiber.cityState);
      await value.companiesDao
          .insertAllCompanies(syncFiberResponse.data.fiber.companies);
      await value.countriesDao
          .insertAllCountry(syncFiberResponse.data.fiber.countries);
      await value.deliveryPeriodDao.insertAllDeliveryPeriods(
          syncFiberResponse.data.fiber.deliveryPeriod);
      await value.lcTypeDao
          .insertAllLcType(syncFiberResponse.data.fiber.lcType);
      await value.paymentTypeDao
          .insertAllPaymentType(syncFiberResponse.data.fiber.paymentType);
      await value.portsDao.insertAllPorts(syncFiberResponse.data.fiber.ports);
      await value.priceTermsDao
          .insertAllFPriceTerms(syncFiberResponse.data.fiber.priceTerms);
      await value.unitDao.insertAllUnit(syncFiberResponse.data.fiber.units);
      await value.fiberAppearanceDoa
          .insertAllFiberAppearance(syncFiberResponse.data.fiber.apperance);

      //Yarn
      await value.yarnSettingsDao
          .insertAllYarnSettings(syncYarnResponse.data.yarn.setting!);
      await value.yarnBlendDao
          .insertAllYarnBlend(syncYarnResponse.data.yarn.blends!);

      await value.gradesDao.insertAllGrades(syncYarnResponse.data.yarn.grades!);

      //Insert All Common Objects for yarn
      await value.brandsDao.insertAllBrands(syncYarnResponse.data.yarn.brands!);
      await value.certificationDao
          .insertAllCertification(syncYarnResponse.data.yarn.certification!);
      await value.cityStateDao
          .insertAllCityState(syncYarnResponse.data.yarn.cityState!);
      await value.companiesDao
          .insertAllCompanies(syncYarnResponse.data.yarn.companies!);
      await value.countriesDao
          .insertAllCountry(syncYarnResponse.data.yarn.countries!);
      await value.deliveryPeriodDao
          .insertAllDeliveryPeriods(syncYarnResponse.data.yarn.deliveryPeriod!);
      await value.lcTypeDao
          .insertAllLcType(syncYarnResponse.data.yarn.lcTypes!);
      await value.paymentTypeDao
          .insertAllPaymentType(syncYarnResponse.data.yarn.paymentTypes!);
      await value.portsDao.insertAllPorts(syncYarnResponse.data.yarn.ports!);
      await value.priceTermsDao
          .insertAllFPriceTerms(syncYarnResponse.data.yarn.priceTerms!);
      await value.unitDao.insertAllUnit(syncYarnResponse.data.yarn.units!);
      await value.colorTreatmentMethodDao.insertAllColorTreatmentMethod(
          syncYarnResponse.data.yarn.colorTreatmentMethod!);
      await value.coneTypeDao
          .insertAllConeType(syncYarnResponse.data.yarn.coneType!);
      await value.colorMethodDao
          .insertAllDyingMethod(syncYarnResponse.data.yarn.dyingMethod!);
      await value.orientationDao
          .insertAllOrientation(syncYarnResponse.data.yarn.orientation!);
      await value.patternCharDao.insertAllPatternCharacteristics(
          syncYarnResponse.data.yarn.patternCharectristic!);
      await value.patternDao
          .insertAllPattern(syncYarnResponse.data.yarn.pattern!);
      await value.plyDao.insertAllPly(syncYarnResponse.data.yarn.ply!);
      await value.qualityDao
          .insertAllQuality(syncYarnResponse.data.yarn.quality!);
      await value.twistDirectionDao
          .insertAllTwistDirection(syncYarnResponse.data.yarn.twistDirection!);
      await value.usageDao.insertAllUsage(syncYarnResponse.data.yarn.usage!);
      await value.yarnTypesDao
          .insertAllYarnTypes(syncYarnResponse.data.yarn.yarnTypes!);

      await value.yarnAppearanceDao
          .insertAllYarnAppearance(syncYarnResponse.data.yarn.apperance!);
    });

    return true;
    // await AppDbInstance.getDbInstance().then((value) async {});
  }
}
