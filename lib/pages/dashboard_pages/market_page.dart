import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/helper_utils/app_colors.dart';
import 'package:yg_app/locators.dart';
import 'package:yg_app/pages/fliter_pages/fabric/fabric_filter_page.dart';
import 'package:yg_app/pages/fliter_pages/fiber/fiber_filter_page.dart';
import 'package:yg_app/pages/fliter_pages/stocklot/stocklot_filter_page.dart';
import 'package:yg_app/pages/fliter_pages/yarn/yarn_filter_page.dart';
import 'package:yg_app/pages/market_pages/fiber_page/fiber_page.dart';
import 'package:yg_app/pages/market_pages/yarn_page/yarn_page.dart';
import 'package:yg_app/providers/fiber_providers/fiber_specification_provider.dart';
import 'package:yg_app/providers/specification_local_filter_provider.dart';

import '../../helper_utils/app_images.dart';
import '../market_pages/fabric_page/fabric_page.dart';
import '../market_pages/stocklot_page/stocklot_page.dart';

class MarketPage extends StatefulWidget {
  final String? locality;
  final int? pageIndex;

  const MarketPage({Key? key, required this.locality,this.pageIndex}) : super(key: key);

  @override
  MarketPageState createState() => MarketPageState();
}

class MarketPageState extends State<MarketPage>
    with SingleTickerProviderStateMixin {
  List<String> tabsList = [
    'Fiber',
    'Yarn',
    'Fabric',
    // 'Product Weaving',
    // 'Converstion (Leasing)',
    'Stock Lot'
  ];

  GlobalKey<FiberPageState> stateFiberPage = GlobalKey<FiberPageState>();
  GlobalKey<YarnPageState> yarnPageState = GlobalKey<YarnPageState>();
  final GlobalKey<StockLotPageState> _stocklotPageState =
  GlobalKey<StockLotPageState>();
  final GlobalKey<FabricPageState> _fabricPageState =
  GlobalKey<FabricPageState>();
  TabController? tabController;
  final _fiberSpecificationProvider = locator<FiberSpecificationProvider>();
  final _specificationLocalFilterProvider = locator<SpecificationLocalFilterProvider>();
  int pageIndex = 0;

  @override
  void initState() {
    pageIndex = widget.pageIndex??0;
    tabController = TabController(vsync: this, length: tabsList.length);
    tabController!.animateTo(pageIndex);
    tabController!.addListener(_handleTabSelection);
    super.initState();
  }

  void _handleTabSelection() {
    // if (_tabController!.indexIsChanging) {
    // Scaffold.of(context).showSnackBar(SnackBar(
    //   content: Text('${_tabController!.index}'),
    //   duration: Duration(milliseconds: 500),
    // ));
    // }
    // tabController!.animateTo(2);
  }

  @override
  void dispose() {
    tabController!.dispose();
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
              backgroundColor:Colors.white,

              body: NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    SliverOverlapAbsorber(
                      handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                          context),
                      sliver: SliverSafeArea(
                        top: false,
                        sliver: SliverAppBar(
                          elevation: 0.0,
                          backgroundColor: bgColor,
                          titleSpacing: 0,
                          title: Container(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 8, right: 8, top: 8, bottom: 1),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            color: searchBarColor,
                                          ),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(24.w)),
                                          color: Colors.grey.shade100),
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            top: 8.w, bottom: 8.w),
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
                                                onChanged: (value) {
                                                  _filterList(value);
                                                },
                                                cursorColor: Colors.black,
                                                keyboardType:
                                                TextInputType.text,
                                                style:
                                                TextStyle(fontSize: 11.sp),
                                                decoration:
                                                const InputDecoration(
                                                  border: InputBorder.none,
                                                  focusedBorder:
                                                  InputBorder.none,
                                                  enabledBorder:
                                                  InputBorder.none,
                                                  errorBorder: InputBorder.none,
                                                  disabledBorder:
                                                  InputBorder.none,
                                                  isDense: true,
                                                  // this will remove the default content padding
                                                  // now you can customize it here or add padding widget
                                                  contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 0,
                                                      vertical: 0),
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
                                  Visibility(
                                    visible: false,
                                    child: Card(
                                        elevation: 1,
                                        child: Padding(
                                            padding: EdgeInsets.all(4.w),
                                            child: Icon(
                                              Icons.notifications,
                                              color: Colors.grey,
                                              size: 16.w,
                                            ))),
                                  ),
                                  GestureDetector(
                                      behavior: HitTestBehavior.opaque,
                                      onTap: () async {
                                        if (stateFiberPage.currentState !=
                                            null) {
                                          _openFiberFilterView();
                                        } else if (yarnPageState.currentState !=
                                            null) {
                                          _openYarnFilterPage();
                                        } else if (_stocklotPageState
                                            .currentState !=
                                            null) {
                                          _openStockLotFilterPage();
                                        } else if (_fabricPageState
                                            .currentState !=
                                            null) {
                                          _openFabricFilterPage();
                                        }
                                      },
                                      child: /*Card(
                                        elevation: 1,
                                        child: Padding(
                                            padding: EdgeInsets.all(4.w),
                                            child: Icon(
                                              Icons.filter_alt_sharp,
                                              color: lightBlueTabs,
                                              size: 16.w,
                                            )
                                        )
                                    ),*/
                                      Padding(
                                        padding: const EdgeInsets.only(left: 4),
                                        child: Image.asset(
                                          FILTERED_RENEWED,
                                          width: 25.w,
                                          height: 25.h,
                                        ),
                                      )),
                                ],
                              ),
                            ),
                          ),
                          floating: true,
                          pinned: true,
                          snap: true,
                          // bottom: TabBar(
                          //   isScrollable: true,
                          //   controller: tabController,
                          //   labelPadding: EdgeInsets.only(left: 24,right: 24),
                          //   unselectedLabelColor: font_light_grey,
                          //   labelColor: font_dark_grey,
                          //   indicatorColor: darkBlueChip,
                          //   indicatorSize: TabBarIndicatorSize.label,
                          //   indicator: UnderlineTabIndicator(
                          //       borderSide: BorderSide(
                          //           color: darkBlueChip, width: 2.w),
                          //       insets: const EdgeInsets.symmetric(
                          //           horizontal: 24.0, vertical: 0)),
                          //   tabs: tabMaker(),
                          // ),
                        ),
                      ),
                    ),
                  ];
                },
                body: TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    FiberPage(
                      key: stateFiberPage,
                      locality: widget.locality!,
                    ),
                    YarnPage(
                      key: yarnPageState,
                      locality: widget.locality,
                    ),
                    FabricPage(
                      key: _fabricPageState,
                      locality: widget.locality,
                    ),
                    StockLotPage(
                      key: _stocklotPageState,
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
              fontWeight: FontWeight.w500, /*fontFamily: 'Metropolis',*/
            ),
          ),
        ),
      ));
    }
    return tabs;
  }

  _filterList(value) {
    if (yarnPageState.currentState != null) {
      yarnPageState.currentState!.yarnSpecificationListState.currentState!
          .yarnListBodyState.currentState!
          .filterListSearch(value);
    }

    if (stateFiberPage.currentState != null) {
      _specificationLocalFilterProvider.fiberFilterListSearch(value);
    }

    if (_fabricPageState.currentState != null) {
      _fabricPageState.currentState!.fabricSpecificationListState.currentState!
          .fabricListBodyState.currentState!
          .filterListSearch(value);
    }
  }

  _openFiberFilterView() {
    if (stateFiberPage
        .currentState !=
        null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const FiberFilterView()),
      ).then((value) {
        //Getting result from filter
        if (tabController!.index == 0) {
          if (value != null) {
            _fiberSpecificationProvider.specificationRequestModel = value;
            _fiberSpecificationProvider.notifyUI();
          }
        }
      });
    }
  }

    _openYarnFilterPage() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const YarnFilterBody()),
      ).then((value) {
        //Getting result from filter
        if (tabController!.index == 1) {
          if (value != null) {
            yarnPageState.currentState!.yarnSpecificationListState.currentState!
                .searchData(value);
          }
        }
      });
    }

    _openStockLotFilterPage() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const StockLotFilterPage()),
      ).then((value) {
        //Getting result from filter
        if (tabController!.index == 3) {
          if (value != null) {
            _stocklotPageState.currentState!.stocklotProvider.searchData(value);
          }
        }
      });
    }

    _openFabricFilterPage() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const FabricFilterPage()),
      ).then((value) {
        //Getting result from filter
        if (tabController!.index == 2) {
          if (value != null) {
            _fabricPageState
                .currentState!.fabricSpecificationListState.currentState!
                .searchData(value);
          }
        }
      });
    }
  }
