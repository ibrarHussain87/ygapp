import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/pages/bottom_nav_main_pages/home_widgets/banner_widgets/banner_home_widget.dart';
import 'package:yg_app/pages/bottom_nav_main_pages/home_widgets/home_premium_widget.dart';
import 'package:yg_app/pages/bottom_nav_main_pages/home_widgets/market_stock_widget.dart';
import 'package:yg_app/pages/bottom_nav_main_pages/home_widgets/market_trend_widget.dart';
import 'package:yg_app/utils/colors.dart';

import 'home_widgets/home_filter_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: Colors.grey.shade200,
          resizeToAvoidBottomInset: true,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: Container(
              decoration:  BoxDecoration(boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0.0, 1.0.w), //(x,y)
                  blurRadius: 2.0.w,
                ),
              ], color: Colors.white),
              child: Padding(
                  padding: EdgeInsets.all(8.w),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.btnColorLogin,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 32.w,
                        ),
                      ),
                      SizedBox(
                        width: 3.w,
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            top: 8.w, bottom: 8.w, left: 12.w, right: 12.w),
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
          body: ListView(
            shrinkWrap: true,
            primary: true,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 16.w),
                child: BannersWidget(),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: 16.w, right: 16.w, top: 8.w, bottom: 8.w),
                child: CarouselSlider(
                  options: CarouselOptions(
                      aspectRatio: 32 / 2,
                      scrollDirection: Axis.vertical,
                      autoPlay: true,
                      reverse: false,
                      viewportFraction: 1,
                      enlargeCenterPage: true,
                      pageSnapping: true,
                      disableCenter: false),
                  items: [1, 2, 3, 4, 5].map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Icon(
                              Icons.speaker,
                              color: Colors.red,
                              size: 12,
                            ),
                            Flexible(
                              child: RichText(
                                overflow: TextOverflow.ellipsis,
                                strutStyle: StrutStyle(fontSize: 9.0.sp),
                                text: TextSpan(
                                    text:
                                        'Alert text with animation with alert text that get from server $i',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 9.sp)),
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                const Icon(
                                  Icons.arrow_downward_outlined,
                                  color: Colors.red,
                                  size: 9,
                                ),
                                RichText(
                                  overflow: TextOverflow.ellipsis,
                                  strutStyle: StrutStyle(fontSize: 9.0.sp),
                                  text: TextSpan(
                                      text: '+21.20%',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 8.sp)),
                                ),
                              ],
                            )
                          ],
                        );
                      },
                    );
                  }).toList(),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40.0),
                      topRight: Radius.circular(40.0),
                    )),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    HomeFilterWidget(),
                    HomePremiumWidget(),
                    SizedBox(
                      height: 8.w,
                    ),
                    MarketStockWidget(),
                  ],
                ),
              ),
              AbsorbPointer(
                child: Container(
                  color: Colors.white,
                  height: 0.9 * MediaQuery.of(context).size.height,
                  child: Padding(
                      padding:
                          EdgeInsets.only(top: 8.0.w, left: 16.w, right: 16.w),
                      child: MarketTrendWidget()),
                ),
              )
            ],
          )),
    );
  }
}
