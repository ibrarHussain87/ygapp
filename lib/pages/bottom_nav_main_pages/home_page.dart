import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:getwidget/components/carousel/gf_carousel.dart';
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
  final List<String> imgList = [
    'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
    'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
    'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
    'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
  ];


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade200,
        // appBar: AppBar(
        //   backgroundColor: Colors.white,
        //   centerTitle: false,
        //   leading: Padding(
        //       padding: EdgeInsets.all(8.w),
        //       child: Row(
        //         children: [
        //           Container(
        //             decoration: BoxDecoration(
        //               color: AppColors.btnColorLogin,
        //               shape: BoxShape.circle,
        //             ),
        //             child: Icon(
        //               Icons.person,
        //               color: Colors.white,
        //               size: 32.w,
        //             ),
        //           ),
        //           Container(
        //             decoration: BoxDecoration(
        //                 color: Colors.deepOrange,
        //                 borderRadius: BorderRadius.only(
        //                     topLeft: Radius.circular(8.0),
        //                     topRight: Radius.circular(8.0))),
        //             child: Text('Upgrade',
        //                 style: TextStyle(
        //                     fontSize: 16.0.w,
        //                     color: AppColors.appBarTextColor,
        //                     fontWeight: FontWeight.w400)),
        //           )
        //         ],
        //       )),
        //   // title: Text('Welcome to yurn Guru',
        //   //     style: TextStyle(
        //   //         fontSize: 16.0.w,
        //   //         color: AppColors.appBarTextColor,
        //   //         fontWeight: FontWeight.w400)),
        // ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 1.0), //(x,y)
                        blurRadius: 6.0,
                      ),
                    ],
                    color: Colors.white
                  ),
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
                            padding: EdgeInsets.only(top:8.w,bottom: 8.w,left: 12.w,right: 12.w),
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
                Padding(
                  padding: EdgeInsets.only(top: 16.w),
                  child: BannersWidget(),
                ),
                // DotsIndicator(
                //   dotsCount: imgList.length,
                //   position: double.tryParse(currentImageBanner.toString())!,
                //   decorator: DotsDecorator(
                //     size: Size.square(6.w),
                //     spacing: const EdgeInsets.all(4.0),
                //   ),
                // )
              ],
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
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40.0),
                      topRight: Radius.circular(40.0),
                    )),
                child: Column(
                  children: [
                    HomeFilterWidget(),
                    HomePremiumWidget(),
                    SizedBox(
                      height: 8.w,
                    ),
                    MarketStockWidget(),
                    Expanded(
                        child: Padding(
                            padding: EdgeInsets.only(
                                top: 8.0.w, left: 16.w, right: 16.w),
                            child: MarketTrendWidget()))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
