import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:yg_app/helper_utils/app_colors.dart';
import 'package:yg_app/pages/fliter_pages/fiber_filter_view.dart';
import 'package:yg_app/pages/market_pages/converstion_leasing.dart';
import 'package:yg_app/pages/market_pages/fiber_page/fiber_page.dart';
import 'package:yg_app/pages/market_pages/product_weaving.dart';
import 'package:yg_app/pages/market_pages/stock_lot.dart';
import 'package:yg_app/pages/market_pages/yarn_page/yarn_page.dart';

class MarketPage extends StatefulWidget {
  String? locality;

  MarketPage({Key? key, required this.locality}) : super(key: key);

  @override
  MarketPageState createState() => MarketPageState();
}

class MarketPageState extends State<MarketPage>
    with SingleTickerProviderStateMixin {
  List<String> tabsList = [
    'Fiber',
    'Yarn',
    // 'Product Weaving',
    // 'Converstion (Leasing)',
    // 'Stock Lot'
  ];

  GlobalKey<FiberPageState> stateFiberPage = GlobalKey<FiberPageState>();
  TabController? tabController;

  late ScrollController _scrollViewController;
  bool _showAppbar = true;
  bool isScrollingDown = false;

  @override
  void initState() {
    tabController = TabController(vsync: this, length: tabsList.length);
    tabController!.addListener(_handleTabSelection);
    super.initState();

    _scrollViewController = ScrollController();
    _scrollViewController.addListener(() {
      if (_scrollViewController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (!isScrollingDown) {
          isScrollingDown = true;
          _showAppbar = false;
          setState(() {});
        }
      }

      if (_scrollViewController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (isScrollingDown) {
          isScrollingDown = false;
          _showAppbar = true;
          setState(() {});
        }
      }
    });
  }

  void _handleTabSelection() {
    // if (_tabController!.indexIsChanging) {
    // Scaffold.of(context).showSnackBar(SnackBar(
    //   content: Text('${_tabController!.index}'),
    //   duration: Duration(milliseconds: 500),
    // ));
    // }
  }

  @override
  void dispose() {
    tabController!.dispose();
    _scrollViewController.dispose();
    _scrollViewController.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: DefaultTabController(
            length: tabsList.length,
            child: Scaffold(
              backgroundColor: Colors.white,
              // appBar: PreferredSize(
              //   preferredSize: Size(double.infinity,
              //       MediaQuery.of(context).size.height * 0.05),
              //   child: TabBar(
              //     isScrollable: true,
              //     controller: tabController,
              //     unselectedLabelColor: textColorGreyLight,
              //     labelColor: lightBlueTabs,
              //     indicatorColor: lightBlueTabs,
              //     indicatorSize: TabBarIndicatorSize.tab,
              //     indicator: UnderlineTabIndicator(
              //         borderSide:
              //             BorderSide(color: lightBlueTabs, width: 2.w),
              //         insets: const EdgeInsets.symmetric(
              //             horizontal: 24.0, vertical: 5)),
              //     tabs: tabMaker(),
              //   ),
              // ),
              body: NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    SliverOverlapAbsorber(handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                        sliver: SliverSafeArea(
                          top: false,
                          sliver:  SliverAppBar(
                            elevation: 0.0,
                            backgroundColor: Colors.white,
                            titleSpacing: 0,
                            title: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.grey.shade100,
                                          ),
                                          borderRadius:
                                          BorderRadius.all(Radius.circular(24.w)),
                                          color: searchBarWhiteBg),
                                      child: Padding(
                                        padding:
                                        EdgeInsets.only(top: 8.w, bottom: 8.w),
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: 8.w,
                                            ),
                                            Icon(
                                              Icons.search_rounded,
                                              size: 16.w,
                                              color: searchBarGreyStroke,
                                            ),
                                            SizedBox(
                                              width: 4.w,
                                            ),
                                            Expanded(
                                              child: TextFormField(
                                                cursorColor: Colors.black,
                                                keyboardType: TextInputType.text,
                                                style: TextStyle(fontSize: 11.sp),
                                                decoration: const InputDecoration(
                                                  border: InputBorder.none,
                                                  focusedBorder: InputBorder.none,
                                                  enabledBorder: InputBorder.none,
                                                  errorBorder: InputBorder.none,
                                                  disabledBorder: InputBorder.none,
                                                  isDense: true,
                                                  // this will remove the default content padding
                                                  // now you can customize it here or add padding widget
                                                  contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 0, vertical: 0),
                                                  // contentPadding:
                                                  // EdgeInsets.only(left: 4, bottom: 4, top: 4, right: 4),
                                                  hintText:
                                                  "Search Product,Brand and Category",
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 4.w,
                                  ),
                                  Card(
                                      elevation: 1,
                                      child: Padding(
                                          padding: EdgeInsets.all(4.w),
                                          child: Icon(
                                            Icons.notifications,
                                            color: Colors.grey,
                                            size: 16.w,
                                          ))),
                                  GestureDetector(
                                    onTap: () async {
                                      if (stateFiberPage.currentState!.familySateFiber
                                          .currentState!.fiberSyncResponse !=
                                          null) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => FiberFilterView(
                                                syncFiberResponse: stateFiberPage
                                                    .currentState!
                                                    .familySateFiber
                                                    .currentState!
                                                    .fiberSyncResponse!,
                                              )),
                                        ).then((value) {
                                          //Getting result from filter
                                          if (tabController!.index == 0) {
                                            if (value != null) {
                                              stateFiberPage.currentState!
                                                  .fiberListingState.currentState!
                                                  .refreshListing(value);
                                            }
                                          }
                                        });
                                      } else {
                                        Fluttertoast.showToast(msg: "Please wait...");
                                      }
                                    },
                                    child: Card(
                                        elevation: 1,
                                        child: Padding(
                                            padding: EdgeInsets.all(4.w),
                                            child: Icon(
                                              Icons.filter_alt_sharp,
                                              color: lightBlueTabs,
                                              size: 16.w,
                                            ))),
                                  ),
                                ],
                              ),
                            ),
                            floating: true,
                            pinned: true,
                            snap: true,
                            bottom: TabBar(
                              isScrollable: false,
                              controller: tabController,
                              unselectedLabelColor: textColorGreyLight,
                              labelColor: lightBlueTabs,
                              indicatorColor: lightBlueTabs,
                              indicatorSize: TabBarIndicatorSize.label,
                              indicator: UnderlineTabIndicator(
                                  borderSide: BorderSide(color: lightBlueTabs, width: 2.w),
                                  insets: const EdgeInsets.symmetric(
                                      horizontal: 24.0, vertical: 5)),
                              tabs: tabMaker(),
                            ),
                          ),
                        ),
                      
                    ),
                  ]; /*<Widget>[
                    SliverAppBar(
                      backgroundColor: Colors.white,
                      titleSpacing: 0,
                      title: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey.shade100,
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(24.w)),
                                    color: searchBarWhiteBg),
                                child: Padding(
                                  padding:
                                      EdgeInsets.only(top: 8.w, bottom: 8.w),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 8.w,
                                      ),
                                      Icon(
                                        Icons.search_rounded,
                                        size: 16.w,
                                        color: searchBarGreyStroke,
                                      ),
                                      SizedBox(
                                        width: 4.w,
                                      ),
                                      Expanded(
                                        child: TextFormField(
                                          cursorColor: Colors.black,
                                          keyboardType: TextInputType.text,
                                          style: TextStyle(fontSize: 11.sp),
                                          decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            focusedBorder: InputBorder.none,
                                            enabledBorder: InputBorder.none,
                                            errorBorder: InputBorder.none,
                                            disabledBorder: InputBorder.none,
                                            isDense: true,
                                            // this will remove the default content padding
                                            // now you can customize it here or add padding widget
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 0, vertical: 0),
                                            // contentPadding:
                                            // EdgeInsets.only(left: 4, bottom: 4, top: 4, right: 4),
                                            hintText:
                                                "Search Product,Brand and Category",
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 4.w,
                            ),
                            Card(
                                elevation: 1,
                                child: Padding(
                                    padding: EdgeInsets.all(4.w),
                                    child: Icon(
                                      Icons.notifications,
                                      color: Colors.grey,
                                      size: 16.w,
                                    ))),
                            GestureDetector(
                              onTap: () async {
                                if (stateFiberPage.currentState!.familySateFiber
                                        .currentState!.fiberSyncResponse !=
                                    null) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => FiberFilterView(
                                              syncFiberResponse: stateFiberPage
                                                  .currentState!
                                                  .familySateFiber
                                                  .currentState!
                                                  .fiberSyncResponse!,
                                            )),
                                  ).then((value) {
                                    //Getting result from filter
                                    if (tabController!.index == 0) {
                                      if (value != null) {
                                        stateFiberPage.currentState!
                                            .fiberListingState.currentState!
                                            .refreshListing(value);
                                      }
                                    }
                                  });
                                } else {
                                  Fluttertoast.showToast(msg: "Please wait...");
                                }
                              },
                              child: Card(
                                  elevation: 1,
                                  child: Padding(
                                      padding: EdgeInsets.all(4.w),
                                      child: Icon(
                                        Icons.filter_alt_sharp,
                                        color: lightBlueTabs,
                                        size: 16.w,
                                      ))),
                            ),
                          ],
                        ),
                      ),
                      floating: true,
                      pinned: true,
                      snap: true,
                      bottom: TabBar(
                        isScrollable: true,
                        controller: tabController,
                        unselectedLabelColor: textColorGreyLight,
                        labelColor: lightBlueTabs,
                        indicatorColor: lightBlueTabs,
                        indicatorSize: TabBarIndicatorSize.tab,
                        indicator: UnderlineTabIndicator(
                            borderSide:
                                BorderSide(color: lightBlueTabs, width: 2.w),
                            insets: const EdgeInsets.symmetric(
                                horizontal: 24.0, vertical: 5)),
                        tabs: tabMaker(),
                      ),
                    ),
                  ];*/
                },
                body: TabBarView(
                  children: [
                    FiberPage(
                      key: stateFiberPage,
                      locality: widget.locality,
                    ),
                    SpinningPage(
                      locality: widget.locality,
                    ),
                    // ProductWeavingPage(),
                    // ConverstionLeasingPage(),
                    // StockLotPage()
                  ],
                  controller: tabController,
                ),
              ),
            ),
            // body: TabBarView(
            //   children: [
            //     FiberPage(
            //       key: stateFiberPage,
            //       locality: widget.locality,
            //     ),
            //     SpinningPage(
            //       locality: widget.locality,
            //     ),
            //     ProductWeavingPage(),
            //     ConverstionLeasingPage(),
            //     StockLotPage()
            //   ],
            //   controller: tabController,
            // ),
          )),
    );
  }

  List<Tab> tabMaker() {
    List<Tab> tabs = []; //create an empty list of Tab
    for (var i = 0; i < tabsList.length; i++) {
      tabs.add(Tab(
        child: Align(
          alignment: Alignment.center,
          child: Text(
            tabsList[i],
            style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                fontFamily: 'Metropolis'),
          ),
        ),
      ));
    }
    return tabs;
  }
}
