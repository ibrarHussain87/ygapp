import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:yg_app/helper_utils/app_colors.dart';
import 'package:yg_app/helper_utils/app_constants.dart';
import 'package:yg_app/helper_utils/app_images.dart';
import 'package:yg_app/model/home_model.dart';
import 'package:yg_app/pages/dashboard_pages/home_new/dashboard_card_items.dart';
import 'package:yg_app/pages/dashboard_pages/home_new/trends_widget.dart';
import 'package:yg_app/pages/dashboard_pages/market_page.dart';
import 'package:yg_app/providers/home_providers/banners_provider.dart';
import 'package:yg_app/pages/dashboard_pages/home_widgets/alert_widget.dart';
import 'package:yg_app/pages/dashboard_pages/home_widgets/banner_body.dart';
import 'package:yg_app/pages/dashboard_pages/home_widgets/home_premium_widget.dart';

import '../../../elements/title_text_widget.dart';
import '../../../helper_utils/navigation_utils.dart';
import '../../../helper_utils/util.dart';

class DashboardPage extends StatefulWidget {
  final Function callback;

  const DashboardPage({Key? key, required this.callback}) : super(key: key);

  @override
  DashboardPageState createState() => DashboardPageState();
}

class DashboardPageState extends State<DashboardPage> {
  List<HomeModel> homeList = [
    HomeModel(
        id: "1", title: 'Fiber', subTitle: 'over 255 ads', image: fiberIcon),
    HomeModel(
        id: "2", title: 'Yarn', subTitle: 'over 410 ads', image: yarnIcon),
    HomeModel(
        id: "3",
        title: 'Fabrics',
        subTitle: 'over 115 ads',
        image: fabricsIcon),
    HomeModel(
        id: "4",
        title: 'Stocklots',
        subTitle: 'over 40 ads',
        image: stockLotsIcon),
    HomeModel(
        id: "5",
        title: 'YG Services',
        subTitle: 'over 5 services',
        image: serviceIcon),
  ];
  List<SingleChildWidget> providers = [
    ChangeNotifierProvider<BannersProvider>(create: (_) => BannersProvider()),
    // ChangeNotifierProvider<FamilyListProvider>(create: (_) => FamilyListProvider())
  ];

  @override
  void initState() {
    super.initState();
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
        child: SafeArea(
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
                    widget.callback(4);
                  },
                  child: Padding(
                      padding: EdgeInsets.only(left: 4.w, top: 8.w),
                      child: Image.asset(
                        navImage,
                        scale: 1.3,
                      )),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text("Yarn Guru",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 18.0.w,
                          fontFamily: 'Metropolis',
                          color: Colors.black,
                          fontWeight: FontWeight.w700)),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {},
                    child: Padding(
                        padding: EdgeInsets.only(left: 10.w, top: 6.w),
                        child: Image.asset(
                          bellImage,
                          scale: 1.3,
                        )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: MultiProvider(
          providers: providers,
          child: ListView(
            shrinkWrap: true,
            primary: true,
            children: [
              // const SizedBox(
              //   height: 5,
              // ),
              const BannerBody(),
              const SlidingAlertWidget(),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                    )),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                    //         fontFamily: 'Metropolis',
                    //         fontWeight: FontWeight.w700),
                    //   ),
                    // ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
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
            ],
          )),
    ));
  }
}
