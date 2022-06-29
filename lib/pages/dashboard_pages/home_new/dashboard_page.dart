
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:yg_app/elements/custom_showcase_widget.dart';
import 'package:yg_app/helper_utils/app_colors.dart';
import 'package:yg_app/helper_utils/app_constants.dart';
import 'package:yg_app/helper_utils/app_images.dart';
import 'package:yg_app/model/home_model.dart';
import 'package:yg_app/pages/dashboard_pages/home_new/dashboard_card_items.dart';
import 'package:yg_app/pages/dashboard_pages/home_new/trends_widget.dart';
import 'package:yg_app/pages/dashboard_pages/home_widgets/alert_widget.dart';
import 'package:yg_app/pages/dashboard_pages/home_widgets/banner_body.dart';
import 'package:yg_app/pages/dashboard_pages/market_page.dart';
import 'package:yg_app/pages/dashboard_pages/notifications/notification_page.dart';
import 'package:yg_app/pages/profile/profile_page.dart';
import 'package:yg_app/providers/home_providers/banners_provider.dart';

import '../../../helper_utils/navigation_utils.dart';

class DashboardPage extends StatefulWidget {
  final Function callback;

  const DashboardPage({Key? key, required this.callback}) : super(key: key);

  @override
  DashboardPageState createState() => DashboardPageState();
}

class DashboardPageState extends State<DashboardPage> {
  List<HomeModel> homeList = [
    HomeModel(
        id: "1", title: 'Fiber', subTitle: 'over 255 ads', image: fiberIcon,isDisable: true),
    HomeModel(
        id: "2", title: 'Yarn', subTitle: 'over 410 ads', image: yarnIcon,isDisable: true),
    HomeModel(
        id: "3",
        title: 'Fabrics',
        subTitle: 'over 115 ads',
        image: fabricsIcon,
        isDisable: true),
    HomeModel(
        id: "4",
        title: 'Stocklots',
        subTitle: 'over 40 ads',
        image: stockLotsIcon
        ,isDisable: true),
    HomeModel(
        id: "5",
        title: 'YG Services',
        subTitle: 'over 5 services',
        image: serviceIcon,
    isDisable: false),
  ];
  List<SingleChildWidget> providers = [
    ChangeNotifierProvider<BannersProvider>(create: (_) => BannersProvider()),
    // ChangeNotifierProvider<FamilyListProvider>(create: (_) => FamilyListProvider())
  ];
  int selectedIndex = 0;
  final keyOne = GlobalKey();
  final keyTwo = GlobalKey();
  final keyThree = GlobalKey();
  final keyFour = GlobalKey();
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final sharedPreferences = await SharedPreferences.getInstance();
      bool isFirstLaunch = sharedPreferences.getBool(IS_FIRST_LAUNCH) ?? true;

      if(isFirstLaunch) {
        sharedPreferences.setBool(IS_FIRST_LAUNCH, false);
        ShowCaseWidget.of(context).startShowCase([
          keyOne,
          keyTwo
        ]);
      }

    });



  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: homeBgColor,
      resizeToAvoidBottomInset: true,
      appBar: PreferredSize(
        preferredSize: AppBar().preferredSize,
        child: Container(
          color: homeBgColor,
          width: MediaQuery.of(context).size.width,
          height: AppBar().preferredSize.height,
          padding: const EdgeInsets.all(10),
          child: Stack(
            children: [
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  // widget.callback(4);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>  const ProfilePage(),
                    ),
                  );
                },
                child: CustomShowcaseWidget(
                  globalKey: keyOne,
                  title: "Navigation",
                  description: 'Explore More Options By Navigation',
                  child: Padding(
                    padding: EdgeInsets.only(left: 4.w,right: 4.w, top: 8.h,bottom: 8.h),
                    child:    SvgPicture.asset(navImage,
                      // color: Colors.transparent,
                      height: 17,
                      width: 17,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Text("Yarn Guru",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 18.0.w,
                        color: Colors.black,
                        fontWeight: FontWeight.w800)),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>  const NotificationPage(),
                      ),
                    );
                  },
                  child:   CustomShowcaseWidget(
                    globalKey: keyTwo,
                    title: "Notifications",
                    description: 'Search For Notifications',
                    child: Padding(
                        padding: EdgeInsets.only(top: 6.h,bottom: 6.h),
                        child: SvgPicture.asset(
                          bellImage,
                          width: 24,
                          height: 24,
                        )),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: MultiProvider(
            providers: providers,
            child: Column(
              children: [
                // const SizedBox(
                //   height: 5,
                // ),
                const BannerBody(),
                Container(margin:EdgeInsets.only(bottom: 4.h,top: 4.h,left: 5.w,right:5.w),child: const SlidingAlertWidget()),
                Expanded(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0),
                        )),
                    child: ListView(
                      children: [
                        // const SizedBox(
                        //   height: 5,
                        // ),
                        const HomeTrendsWidget(),
                        // Container(
                        //   padding:
                        //       const EdgeInsets.only(left: 17, top: 5, bottom: 5),
                        //   child: Text(
                        //     "Services",
                        //     overflow: TextOverflow.fade,
                        //     maxLines: 1,
                        //     softWrap: false,
                        //     style: TextStyle(
                        //         color: Colors.black,
                        //         fontSize: 15.sp,
                        //
                        //         fontWeight: FontWeight.w700),
                        //   ),
                        // ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          margin: EdgeInsets.only(top: 2.h),
                          // height: 0.6 * MediaQuery.of(context).size.height,
                          child: HomeCardWidget(
                            spanCount: 2,
                            listOfItems: homeList,
                            callback: (HomeModel value) {
                              switch (value.id) {
                                case '1':
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MarketPage(
                                        locality: local,
                                        pageIndex: 0,
                                      ),
                                    ),
                                  );
                                  break;
                                case '2':
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MarketPage(
                                        locality: local,
                                        pageIndex: 1,
                                      ),
                                    ),
                                  );
                                  break;
                                case '3':
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MarketPage(
                                        locality: local,
                                        pageIndex: 2,
                                      ),
                                    ),
                                  );
                                  break;
                                case '4':
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MarketPage(
                                        locality: local,
                                        pageIndex: 3,
                                      ),
                                    ),
                                  );
                                  break;
                                case '5':
                                  openYGServiceScreen(context);
                                  break;
                              }

                              // if(value.id=="5")
                              //   {
                              //
                              //     openYGServiceScreen(context);
                              //   }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )),
      ),
    ));
  }
}
