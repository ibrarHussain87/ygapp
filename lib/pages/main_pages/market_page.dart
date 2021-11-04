import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yg_app/pages/local_market_pages/fiber_page.dart';
import 'package:yg_app/utils/colors.dart';

class MarketPage extends StatefulWidget {
  const MarketPage({Key? key}) : super(key: key);

  @override
  _MarketPageState createState() => _MarketPageState();
}

class _MarketPageState extends State<MarketPage> {
  List<String> tabsList = [
    'Fibers',
    'Yarn',
    'Fabrics',
    'Dyning',
    'Fibers',
    'Yarn',
    'Fabrics'
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: DefaultTabController(
            length: tabsList.length,
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                flexibleSpace: SafeArea(
                  child: Padding(
                    padding: EdgeInsets.only(top: 16, left: 24, right: 24),
                    child: TabBar(
                      isScrollable: true,
                      unselectedLabelColor: AppColors.textColorGreyLight,
                      labelColor: AppColors.lightBlueTabs,
                      indicatorColor: AppColors.lightBlueTabs,
                      indicatorSize: TabBarIndicatorSize.tab,
                      // indicator: BubbleTabIndicator(
                      //   indicatorHeight: 24.0,
                      //   indicatorColor: Colors.blueAccent,
                      //   tabBarIndicatorSize: TabBarIndicatorSize.tab,
                      //   // Other flags
                      //   indicatorRadius: 16,
                      //   insets: EdgeInsets.all(1),
                      //   padding: EdgeInsets.all(10),
                      // ),
                      indicator: UnderlineTabIndicator(
                          borderSide: BorderSide(width: 1.0,color: AppColors.lightBlueTabs),
                          insets: EdgeInsets.symmetric(horizontal:16.0),
                      ),
                      tabs: tabMaker(),
                    ),
                  ),
                ),
              ),
              body: TabBarView(children: [
                FiberPage(),
                Icon(Icons.movie),
                Icon(Icons.games),
                Icon(Icons.label),
                Icon(Icons.label),
                Icon(Icons.label),
                Icon(Icons.label),
              ]),
            )));
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
                  style: TextStyle(fontSize: 12),
                )),
          ),
        ),
      ));
    }
    return tabs;
  }
}
