import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:yg_app/helper_utils/app_colors.dart';
import 'package:yg_app/helper_utils/app_images.dart';
import 'package:yg_app/helper_utils/navigation_utils.dart';
import 'package:yg_app/pages/dashboard_pages/home_new/trends_widget.dart';
import 'package:yg_app/pages/dashboard_pages/market_page.dart';

import '../../../elements/custom_showcase_widget.dart';
import '../../../helper_utils/app_constants.dart';
import '../../../model/home_model.dart';
import '../../../providers/home_providers/banners_provider.dart';
import '../../profile/profile_page.dart';
import '../home_widgets/alert_widget.dart';
import '../home_widgets/banner_body.dart';
import '../notifications/notification_page.dart';

class DashboardPage4 extends StatefulWidget {
  final Function callback;
  const DashboardPage4({Key? key,required this.callback}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage4> {
  List<HomeModel> homeList=
  [
    HomeModel(id: "1", title: 'Fiber',subTitle: 'over 255 ads',image:fiberImage,isDisable: true),
    HomeModel(id: "2", title: 'Yarn',subTitle: 'over 410 ads',image:yarnImage,isDisable: false),
    HomeModel(id: "3", title: 'Fabrics',subTitle: 'over 115 ads',image: fabricsImage,isDisable: false),
    HomeModel(id: "4", title: 'StockLots',subTitle: 'over 40 ads',image: stockLotsImage,isDisable: false),
    HomeModel(id: "5", title: 'YG Services',subTitle: 'over 5 services',image: servicesImage,isDisable: false),
  ];
  final keyOne = GlobalKey();
  final keyTwo = GlobalKey();
  List<SingleChildWidget> providers = [
    ChangeNotifierProvider<BannersProvider>(create: (_) => BannersProvider()),
    // ChangeNotifierProvider<FamilyListProvider>(create: (_) => FamilyListProvider())
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      appBar: PreferredSize(
        preferredSize: AppBar().preferredSize,
        child: SafeArea(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: AppBar().preferredSize.height * 1,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[appBarColor2, appBarColor1]),
                borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(16.0),
                    bottomLeft: Radius.circular(16.0))),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
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
                        padding: EdgeInsets.only(left: 4.w,right: 4.w),
                        child: SvgPicture.asset(navImage,
                          color: Colors.white,
                          height: 17,
                          width: 17,
                        ),
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
                          color: Colors.white,
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
                          padding: EdgeInsets.only(left: 4.w,right: 4.w,),
                          child: SvgPicture.asset(
                            bellImage,
                            color: Colors.white,
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
      ),
      body: SafeArea(
        child: MultiProvider(
          providers:providers,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 8.h,
              ),
              Padding(
                padding:EdgeInsets.only(left: 5.w,right:5.w),
                child: const BannerBody(),
              ),
              Container(margin:EdgeInsets.only(bottom: 4.h,top: 4.h,left:10.w,right:10.w),
                  child: const SlidingAlertWidget()),

              Expanded(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                   child: ListView(
                      children: [
                        // const SizedBox(
                        //   height: 5,
                        // ),
                        const HomeTrendsWidget(),
                        Container(
                          padding: EdgeInsets.only(left:20.w,right: 20.w,bottom: 3.h,top: 3.h),
                          child: Text(
                            "Services",
                            overflow: TextOverflow.fade,
                            maxLines: 1,
                            softWrap: false,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15.sp,

                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left:15.w,right: 15.w,bottom: 5.h),
                          // margin: EdgeInsets.only(top: 2.h),
                          child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: homeList.length,
                            shrinkWrap: true,
                            primary: true,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: (){
                                  switch(index){
                                    case 0:
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
                                    case 1:
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
                                    case 2:
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
                                    case 3:
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
                                    case 4:
                                      openYGServiceScreen(context);
                                      break;
                                  }
                                  // if (index==4) {
                                  // }
                                },
                                child: Stack(
                                  children: <Widget>[
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(15.0),
                                      child: Container(
                                          width: MediaQuery.of(context).size.width,
                                          padding: const EdgeInsets.all(5),
                                          child: Image.asset(
                                              homeList[index].image.toString(),
                                              fit: BoxFit.fill,
                                              height: 90.h,
                                          )
                                      ),
                                    ),
                                    Positioned(
                                        left: 25,
                                        bottom: 20,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(homeList[index].title.toString(), style: TextStyle(fontSize: 18.sp, color: Colors.white,fontWeight: FontWeight.bold)),
                                                Text(homeList[index].subTitle.toString() , style: TextStyle(fontSize: 10.sp, color: Colors.white))
                                              ],
                                            ),
                                          ],
                                        )
                                    )
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    )

                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


