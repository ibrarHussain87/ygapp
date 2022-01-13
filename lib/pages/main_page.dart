import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/api_services/api_service_class.dart';
import 'package:yg_app/app_database/app_database_instance.dart';
import 'package:yg_app/helper_utils/app_colors.dart';
import 'package:yg_app/helper_utils/app_constants.dart';
import 'package:yg_app/helper_utils/app_images.dart';

import 'dashboard_pages/home_page.dart';
import 'dashboard_pages/market_page.dart';
import 'dashboard_pages/yg_services.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final List<Widget> _screens = [
    const HomePage(),
    MarketPage(
      locality: local,
    ),
    MarketPage(
      locality: international,
    ),
    const YGServices(),
    // const PastAdPage()
  ];
  int _selectedIndex = 0;

  void _onItemTapped(int selectedIndex) {
    setState(() {
      _selectedIndex = selectedIndex;
    });
  }

  @override
  void initState() {
    super.initState();
    _synData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: /*buildPageView()*/ _screens[_selectedIndex],
          bottomNavigationBar: _generateBottomBar()),
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

  _synData() async {
    var syncFiberResponse = await ApiService.syncFiber();
    var syncYarnResponse = await ApiService.syncYarn();
    AppDbInstance.getDbInstance().then((value) async {
      await value.fiberSettingDao
          .insertAllFiberSettings(syncFiberResponse.data.fiber.settings);
      await value.gradesDao
          .insertAllGrades(syncFiberResponse.data.fiber.grades);
      await value.fiberNatureDao
          .insertAllFiberNatures(syncFiberResponse.data.fiber.natures);
      await value.fiberMaterialDao
          .insertAllFiberMaterials(syncFiberResponse.data.fiber.material);

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
      await value.yarnFamilyDao
          .insertAllYarnFamily(syncYarnResponse.data.yarn.family!);
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

    // await AppDbInstance.getDbInstance().then((value) async {});
  }
}
