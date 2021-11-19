import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/model/response/fiber_response/fiber_specification.dart';
import 'package:yg_app/pages/detail_pages/detail_page/bider_list_page.dart';
import 'package:yg_app/pages/local_market_pages/converstion_leasing.dart';
import 'package:yg_app/pages/local_market_pages/product_weaving.dart';
import 'package:yg_app/pages/local_market_pages/stock_lot.dart';
import 'package:yg_app/utils/colors.dart';
import 'package:yg_app/widgets/list_widgets/brand_text.dart';
import 'package:yg_app/widgets/title_text_widget.dart';

import 'detail_page/detail_tab_page.dart';

class FiberDetailPage extends StatefulWidget {
  Specification specification;

  FiberDetailPage({Key? key, required this.specification}) : super(key: key);

  @override
  _FiberDetailPageState createState() => _FiberDetailPageState();
}

class _FiberDetailPageState extends State<FiberDetailPage> {

  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<String> tabsList = [
    'Details',
    'Description',
    'Bidder List'
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      BrandWidget(title: widget.specification.brand),
                      RatingBarIndicator(
                        rating: 2.75,
                        itemBuilder: (context, index) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        itemCount: 5,
                        itemSize: 14.0.w,
                        direction: Axis.horizontal,
                      ),
                    ],
                  ),
                  SizedBox(height: 2.w,),
                  TitleTextWidget(
                    title:
                        '${widget.specification.material},${widget.specification.apperance != null ? "${widget.specification.apperance}/" : ""}${widget.specification.productYear!.substring(0, 4)}',
                  ),
                  SizedBox(height: 4.w),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                            text: 'Time Left',
                            style: TextStyle(
                                color: AppColors.textColorGrey,
                                fontWeight: FontWeight.bold,
                                fontSize: 11.sp)),
                        TextSpan(
                          text: '      0 DAYS. 8 HOURS,29 MINS',
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: AppColors.lightBlueTabs,
                              fontSize: 11.sp),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 6.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BrandWidget(title: 'Starting Bid'),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          TitleTextWidget(
                              title: 'PKR.${widget.specification.priceUnit}'),
                          SizedBox(
                            width: 12.w,
                          ),
                          Text(
                            '(CLOSES 09/20/2021 | 09:35 AM EST)',
                            style: TextStyle(
                                fontSize: 7.sp,
                                color: AppColors.textColorGreyLight),
                          )
                        ],
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(height: 16.w,),
              Expanded(child: Center(
                child: DefaultTabController(
                    length: tabsList.length,
                    child: Scaffold(
                      backgroundColor: Colors.white,
                      appBar: PreferredSize(
                        preferredSize: Size(double.infinity, 32.w),
                        child:TabBar(
                          // padding: EdgeInsets.only(left: 8.w, right: 8.w),
                          isScrollable: false,
                          unselectedLabelColor: AppColors.textColorGrey,
                          labelColor: Colors.white,
                          indicatorColor: AppColors.lightBlueTabs,
                          indicatorSize: TabBarIndicatorSize.tab,
                          indicator: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [AppColors.lightBlueTabs, AppColors.lightBlueTabs]),
                              borderRadius: BorderRadius.circular(8.w),),
                          tabs: tabMaker(),
                        ),
                      ),
                      body: TabBarView(children: [
                        DetailTabPage(specification: widget.specification,),
                        ConverstionLeasingPage(),
                        BidderListPage()
                      ]),
                    )),
              )),
            ],
          ),
        ),
      ),
    );
  }
  List<Tab> tabMaker() {
    List<Tab> tabs = []; //create an empty list of Tab
    for (var i = 0; i < tabsList.length; i++) {
      tabs.add(Tab(
        child: Align(
          alignment: Alignment.center,
          child: Padding(
              padding: EdgeInsets.all(0),
              child: Text(
                tabsList[i],
                style: TextStyle(fontSize: 11.sp,fontWeight: FontWeight.w400),
              )),
        ),
      ));
    }
    return tabs;
  }
}
