import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/pages/bottom_nav_main_pages/home_widgets/alert_widget.dart';
import 'package:yg_app/pages/bottom_nav_main_pages/home_widgets/banner_body.dart';
import 'package:yg_app/pages/bottom_nav_main_pages/home_widgets/home_premium_widget.dart';
import 'package:yg_app/pages/bottom_nav_main_pages/home_widgets/market_stock_widget.dart';
import 'package:yg_app/pages/bottom_nav_main_pages/home_widgets/market_trend_widget.dart';
import 'package:yg_app/helper_utils/app_colors.dart';

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
          backgroundColor: Colors.white,
          resizeToAvoidBottomInset: true,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: Container(
              decoration:  BoxDecoration(/*boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0.0, 1.0.w), //(x,y)
                  blurRadius: 2.0.w,
                ),
              ],*/ color: Colors.white.withOpacity(0.7)),
              child: Container(
                  padding: EdgeInsets.all(8.w),
                  child: Row(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: btnColorLogin,
                          shape: BoxShape.circle,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.person,
                            color: Colors.white,
                            size: 22.w,
                          ),
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
              const BannerBody(),
              const SlidingAlertWidget(),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(24.0),
                      topRight: Radius.circular(24.0),
                    )),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    const HomeFilterWidget(),
                    HomePremiumWidget(),
                    MarketStockWidget(),
                  ],
                ),
              ),
              AbsorbPointer(
                child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  height: 0.9 * MediaQuery.of(context).size.height,
                  child: MarketTrendWidget(),
                ),
              )
            ],
          )),
    );
  }
}
