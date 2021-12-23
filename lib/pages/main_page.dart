import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/utils/app_images.dart';
import 'package:yg_app/utils/colors.dart';
import 'package:yg_app/utils/strings.dart';

import 'bottom_nav_main_pages/home_page.dart';
import 'bottom_nav_main_pages/market_page.dart';
import 'bottom_nav_main_pages/post_ad.dart';
import 'bottom_nav_main_pages/yg_services.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final List<Widget> _screens = [
    const HomePage(),
    MarketPage(
      locality: AppStrings.local,
    ),
    MarketPage(
      locality: AppStrings.international,
    ),
    const YGServices(),
    const PastAdPage()
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
      selectedItemColor: AppColors.textColorBlue,
      unselectedItemColor: AppColors.textColorGrey,
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
                      AppImages.homeIcon,
                      width: 20.w,
                      height: 20.h,
                    ))
                : Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Image.asset(
                      AppImages.homeGreyIcon,
                      width: 20.w,
                      height: 20.h,
                    ),
                  ),
            label: AppStrings.home),
        BottomNavigationBarItem(
            icon: _selectedIndex == 1
                ? Padding(
                    padding: EdgeInsets.all(5.w),
                    child: Image.asset(
                      AppImages.marketIcon,
                      width: 20.w,
                      height: 20.h,
                    ))
                : Padding(
                    padding: EdgeInsets.all(5.0.w),
                    child: Image.asset(
                      AppImages.marketGreyIcon,
                      width: 20.w,
                      height: 20.h,
                    ),
                  ),
            label: AppStrings.localMarket),
        BottomNavigationBarItem(
            icon: _selectedIndex == 2
                ? Padding(
                    padding: EdgeInsets.all(5.w),
                    child: Image.asset(
                      AppImages.marketIcon,
                      width: 20.w,
                      height: 20.h,
                    ),
                  )
                : Padding(
                    padding: EdgeInsets.all(5.0.w),
                    child: Image.asset(
                      AppImages.marketGreyIcon,
                      width: 20.w,
                      height: 20.h,
                    ),
                  ),
            label: AppStrings.internationalMarket),
        BottomNavigationBarItem(
            icon: _selectedIndex == 3
                ? Padding(
                    padding: EdgeInsets.all(5.w),
                    child: Image.asset(
                      AppImages.ygServicesIcon,
                      width: 20.w,
                      height: 20.h,
                    ),
                  )
                : Padding(
                    padding: EdgeInsets.all(5.0.w),
                    child: Image.asset(
                      AppImages.ygServicesGreyIcon,
                      width: 20.w,
                      height: 20.h,
                    ),
                  ),
            label: AppStrings.ygService),
        BottomNavigationBarItem(
            icon: _selectedIndex == 4
                ? Padding(
                    padding: EdgeInsets.all(5.w),
                    child: Image.asset(
                      AppImages.postAdIcon,
                      width: 20.w,
                      height: 20.h,
                    ),
                  )
                : Padding(
                    padding: EdgeInsets.all(5.0.w),
                    child: Image.asset(
                      AppImages.postAdGreyIcon,
                      width: 20.w,
                      height: 20.h,
                    ),
                  ),
            label: AppStrings.auction),
      ],
    );
  }
}
