import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/pages/fliter_pages/fiber_filter_page.dart';
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

class _MarketPageState extends State<MarketPage>
    with SingleTickerProviderStateMixin {
  List<String> tabsList = [
    'Fiber',
    'Spinning',
    'Product Weaving',
    'Converstion (Leasing)',
    'Stock Lot'
  ];

  GlobalKey<FiberPageState> stateFiberPage = GlobalKey<FiberPageState>();
  TabController? _tabController;

  @override
  void initState() {
    _tabController = TabController(vsync: this, length: tabsList.length);
    _tabController!.addListener(_handleTabSelection);
    super.initState();
  }

  void _handleTabSelection() {
    // if (_tabController!.indexIsChanging) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text('${_tabController!.index}'),
      duration: Duration(milliseconds: 500),
    ));
    // }
  }

  @override
  void dispose() {
    _tabController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            body: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 8.w, left: 8.w, right: 8.w),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey.shade300,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4.w)),
                              color: AppColors.searchBarWhiteBg),
                          child: Padding(
                            padding: EdgeInsets.only(top: 4.w, bottom: 4.w),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 8.w,
                                ),
                                Icon(
                                  Icons.search_rounded,
                                  size: 16.w,
                                  color: AppColors.searchBarGreyStroke,
                                ),
                                Expanded(
                                  child: TextFormField(
                                    cursorColor: Colors.black,
                                    keyboardType: TextInputType.text,
                                    style: TextStyle(fontSize: 10.sp),
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                      isDense: true,
                                      // this will remove the default content padding
                                      // now you can customize it here or add padding widget
                                      contentPadding: EdgeInsets.symmetric(
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const FiberFilterPage()),
                          ).then((value) {
                            //Getting result from filter
                            if (_tabController!.index == 0) {
                              stateFiberPage.currentState!
                                  .refreshListing(value);
                            }
                          });
                        },
                        child: Card(
                            elevation: 1,
                            child: Padding(
                                padding: EdgeInsets.all(4.w),
                                child: Icon(
                                  Icons.filter_alt_sharp,
                                  color: AppColors.lightBlueTabs,
                                  size: 16.w,
                                ))),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: DefaultTabController(
                      length: tabsList.length,
                      child: Scaffold(
                        backgroundColor: Colors.white,
                        appBar: PreferredSize(
                          preferredSize:
                              const Size(double.infinity, kToolbarHeight),
                          child: TabBar(
                            padding: EdgeInsets.only(left: 8.w, right: 8.w),
                            isScrollable: true,
                            controller: _tabController,
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
                        body: TabBarView(
                          children: [
                            FiberPage(
                              key: stateFiberPage,
                            ),
                            SpinningPage(),
                            ProductWeavingPage(),
                            ConverstionLeasingPage(),
                            StockLotPage()
                          ],
                          controller: _tabController,
                        ),
                      )),
                )
              ],
            )));
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
                style: TextStyle(fontSize: 12.sp),
              )),
        ),
      ));
    }
    return tabs;
  }
}
