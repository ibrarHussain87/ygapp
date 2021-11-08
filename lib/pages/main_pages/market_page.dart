import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/pages/local_market_pages/converstion_leasing.dart';
import 'package:yg_app/pages/local_market_pages/fiber_page.dart';
import 'package:yg_app/pages/local_market_pages/product_weaving.dart';
import 'package:yg_app/pages/local_market_pages/spinning_page.dart';
import 'package:yg_app/pages/local_market_pages/stock_lot.dart';
import 'package:yg_app/utils/colors.dart';

class MarketPage extends StatefulWidget {
  const MarketPage({Key? key}) : super(key: key);

  @override
  _MarketPageState createState() => _MarketPageState();
}

class _MarketPageState extends State<MarketPage> {
  List<String> tabsList = [
    'Fiber',
    'Spinning',
    'Product Weaving',
    'Converstion (Leasing)',
    'Stock Lot'
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: DefaultTabController(
                length: tabsList.length,
                child: Scaffold(
                  backgroundColor: Colors.white,
                  appBar: PreferredSize(
                    preferredSize: Size(double.infinity, kToolbarHeight),
                    child:TabBar(
                      padding: EdgeInsets.only(left: 8.w, right: 8.w),
                      isScrollable: true,
                      unselectedLabelColor: AppColors.textColorGreyLight,
                      labelColor: AppColors.lightBlueTabs,
                      indicatorColor: AppColors.lightBlueTabs,
                      indicatorSize: TabBarIndicatorSize.label,
                      indicator: UnderlineTabIndicator(
                          borderSide:
                              BorderSide(color: AppColors.lightBlueTabs),
                          insets: EdgeInsets.only(bottom: 12.w)),
                      tabs: tabMaker(),
                    ),
                  ),
                  body: TabBarView(children: [
                    FiberPage(),
                    SpinningPage(),
                    ProductWeavingPage(),
                    ConverstionLeasingPage(),
                    StockLotPage()
                  ]),
                ))));
  }

  List<Tab> tabMaker() {
    List<Tab> tabs = []; //create an empty list of Tab
    for (var i = 0; i < tabsList.length; i++) {
      tabs.add(Tab(
        child: Container(
          // decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(16),
          //     border: Border.all(color: Colors.grey, width: 1)),
          child: Align(
            alignment: Alignment.center,
            child: Padding(
                padding: EdgeInsets.all(0),
                child: Text(
                  tabsList[i],
                  style: TextStyle(fontSize: 12.sp),
                )),
          ),
        ),
      ));
    }
    return tabs;
  }
}
