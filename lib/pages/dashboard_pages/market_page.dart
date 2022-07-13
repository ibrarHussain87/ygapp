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
import 'package:yg_app/providers/stocklot_providers/stocklot_specification_provider.dart';

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
  final _stockLotSpecificationProvider = locator<StockLotSpecificationProvider>();
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
              body: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
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
              fontWeight: FontWeight.w500, /**/
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
            _stockLotSpecificationProvider.searchData(value);
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
