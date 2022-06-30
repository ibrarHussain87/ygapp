import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:yg_app/helper_utils/app_colors.dart';
import 'package:yg_app/helper_utils/app_constants.dart';
import 'package:yg_app/helper_utils/app_images.dart';
import 'package:yg_app/pages/dashboard_pages/home_new/dashboard_page.dart';
import 'package:yg_app/pages/profile/profile_page.dart';
import 'package:yg_app/providers/home_providers/sync_provider.dart';

import '../locators.dart';
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
  final _syncProvider = locator<SyncProvider>();
  List<Widget>? _screens;
  int _selectedIndex = 0;

  void _onItemTapped(int selectedIndex) {
    setState(() {
      _selectedIndex = selectedIndex;
    });
  }

  @override
  void initState() {
    super.initState();
    _screens = [
     // HomePage(
     //   key: homePageState,
     //   callback: (value) {
     //     setState(() {
     //       _onItemTapped(value);
     //     });
     //   },
     // ),
      ShowCaseWidget(
        builder: Builder(builder: (_) =>   DashboardPage(
          key: homePageState,
          callback: (value) {
            setState(() {
              _onItemTapped(value);
            });
          },
        ),),
        onStart: (index, key) => print('On started $index'),
        onComplete: (index, key) => print('On completed $index'),
        onFinish: () => print('Finished completely'),
        // autoPlay: true,
        // autoPlayDelay: const Duration(seconds: 3),
      ),

      MarketPage(
        locality: local,
      ),
      MarketPage(
        locality: international,
      ),
      const YGServices(),
      const ProfilePage(),
      // const PastAdPage()
    ];
    _syncProvider.addListener(() {
      if(mounted) {
        updateUI();
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _syncProvider.syncAppData(context);
    });
  }

  updateUI() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: _screens![_selectedIndex],
          // bottomNavigationBar: _generateBottomBar()
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
        BottomNavigationBarItem(
            icon: _selectedIndex == 4
                ? Padding(
                    padding: EdgeInsets.all(2.w),
                    child: const Icon(
                      Icons.segment,
                      size: 28,
                      color: Colors.green,
                    ),
                  )
                : Padding(
                    padding: EdgeInsets.all(2.0.w),
                    child: const Icon(
                      Icons.segment,
                      size: 28,
                      color: Colors.grey,
                    ),
                  ),
            label: "Profile"),
      ],
    );
  }
}
