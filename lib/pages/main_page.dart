import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:yg_app/Providers/sync_provider.dart';
import 'package:yg_app/api_services/api_service_class.dart';
import 'package:yg_app/app_database/app_database_instance.dart';
import 'package:yg_app/elements/title_text_widget.dart';
import 'package:yg_app/helper_utils/app_colors.dart';
import 'package:yg_app/helper_utils/app_constants.dart';
import 'package:yg_app/helper_utils/app_images.dart';
import 'package:yg_app/helper_utils/navigation_utils.dart';
import 'package:yg_app/helper_utils/shared_pref_util.dart';
import 'package:yg_app/pages/profile/profile_page.dart';
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
  List<SingleChildWidget> providers = [
    ChangeNotifierProvider<SyncProvider>(create: (_) => SyncProvider()),
  ];

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
            _onItemTapped(value);
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
      const ProfilePage(),
      // const PastAdPage()
    ];
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: SafeArea(
        child: isSynced
            ? Scaffold(
                body: /*buildPageView()*/ IndexedStack(
                    index: _selectedIndex, children: _screens!),
                bottomNavigationBar: _generateBottomBar())
            : buildMainWidget(),
      ),
    );
  }

  Widget buildMainWidget() {

    return Builder(
      builder: (BuildContext context) {
        final syncProvider = Provider.of<SyncProvider>(context);
        syncProvider.syncAppData();
        return syncProvider.isDataSynced ?
        Scaffold(
            body: /*buildPageView()*/ IndexedStack(
                index: _selectedIndex, children: _screens!),
            bottomNavigationBar: _generateBottomBar())
        :
        Scaffold(
            extendBodyBehindAppBar: true,
            backgroundColor: Colors.white,
            resizeToAvoidBottomInset: true,
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(50),
              child: Container(
                decoration: BoxDecoration(
                  /*boxShadow: [
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
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            openProfileScreen(context);
                          },
                          child: const CircleAvatar(
                            radius: 24,
                            backgroundColor: Colors.green,
                            child: Icon(
                              Icons.person,
                              color: Colors.white,
                              size: 24,
                            ),
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
                  SizedBox(
                    height: 6.w,
                  ),
                  const TitleSmallTextWidget(
                    title: "Syncing data please wait...",
                  ),
                ],
              ),
            ),
            bottomNavigationBar: _generateBottomBar());
      },
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

  CurvedNavigationBar _generateBottomBarCurved() {
    return CurvedNavigationBar(
      backgroundColor: Colors.blueAccent,
      index: _selectedIndex,
      onTap: _onItemTapped,
      height: 50,
      animationCurve: Curves.easeInOut,
      animationDuration: Duration(milliseconds: 600),
      items: [
        _selectedIndex == 0
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
        _selectedIndex == 1
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
        _selectedIndex == 2
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
        _selectedIndex == 3
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
        _selectedIndex == 4
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
      ],
    );
  }


}
