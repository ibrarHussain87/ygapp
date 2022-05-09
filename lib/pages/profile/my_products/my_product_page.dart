import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:yg_app/api_services/api_service_class.dart';
import 'package:yg_app/elements/title_text_widget.dart';
import 'package:yg_app/helper_utils/app_colors.dart';
import 'package:yg_app/model/response/fiber_response/sync/sync_fiber_response.dart';
import 'package:yg_app/model/response/my_products_response.dart';
import 'package:yg_app/model/response/yarn_response/sync/yarn_sync_response.dart';
import 'package:yg_app/pages/profile/my_products/yarn/yarn_product_page.dart';

import 'fiber/fiber_product_page.dart';
class MyProductPage extends StatefulWidget {
  const MyProductPage({Key? key}) : super(key: key);

  @override
  _MyProductPageState createState() => _MyProductPageState();
}

class _MyProductPageState extends State<MyProductPage>
    with SingleTickerProviderStateMixin {
  List<String> tabsList = [
    'Fiber',
    'Yarn',
    // 'Product Weaving',
    // 'Converstion (Leasing)',
    // 'Stock Lot'
  ];
  TabController? tabController;
  List<FiberNature> fiberNatureList = [];
  List<FiberMaterial> fiberMaterialList = [];
  List<Blends> yarnBlendsList = [];
  List<Family> yarnFamilyList = [];
  final GlobalKey<YarnProductPageState> yarnProductPageState =
      GlobalKey<YarnProductPageState>();
  final GlobalKey<FiberProductPageState> fiberProductPageState =
      GlobalKey<FiberProductPageState>();

  @override
  void initState() {
    tabController = TabController(vsync: this, length: tabsList.length);
    tabController!.addListener(_handleTabSelection);
    // AppDbInstance.getDbInstance().then((db) async {
    //   await db.yarnBlendDao
    //       .findAllYarnBlends()
    //       .then((value) => yarnBlendsList = value);
    //   await db.yarnFamilyDao
    //       .findAllYarnFamily()
    //       .then((value) => yarnFamilyList = value);
    //   await db.fiberNatureDao
    //       .findAllFiberNatures()
    //       .then((value) => fiberNatureList = value);
    //   await db.fiberMaterialDao
    //       .findAllFiberMaterials()
    //       .then((value) => fiberMaterialList = value);
    // });
    super.initState();
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: FutureBuilder<MyProductsResponse>(
          future: ApiService.myProducts(),
          builder: (context, snapshots) {
            if (snapshots.hasData &&
                snapshots.connectionState == ConnectionState.done &&
                snapshots.data != null) {
              return Scaffold(
                  backgroundColor: Colors.white,
                  body: DefaultTabController(
                    length: tabsList.length,
                    child: Scaffold(
                      backgroundColor: Colors.white,
                      body: NestedScrollView(
                        headerSliverBuilder:
                            (BuildContext context, bool innerBoxIsScrolled) {
                          return <Widget>[
                            SliverOverlapAbsorber(
                              handle: NestedScrollView
                                  .sliverOverlapAbsorberHandleFor(context),
                              sliver: SliverSafeArea(
                                top: false,
                                sliver: SliverAppBar(
                                  elevation: 0.0,
                                  automaticallyImplyLeading: false,
                                  backgroundColor: Colors.white,
                                  titleSpacing: 0,
                                  title: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.grey.shade100,
                                          ),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(24.w)),
                                          color: searchBarWhiteBg),
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

                                                  if (fiberProductPageState
                                                      .currentState !=
                                                      null) {
                                                    fiberProductPageState
                                                        .currentState!
                                                        .filterListSearch(
                                                        value);
                                                  }

                                                  if (yarnProductPageState
                                                          .currentState !=
                                                      null) {
                                                    yarnProductPageState
                                                        .currentState!
                                                        .filterListSearch(
                                                            value);
                                                  }
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
                                        borderSide: BorderSide(
                                            color: lightBlueTabs, width: 2.w),
                                        insets: const EdgeInsets.symmetric(
                                            horizontal: 24.0, vertical: 5)),
                                    tabs: tabMaker(),
                                  ),
                                ),
                              ),
                            ),
                          ];
                        },
                        body: TabBarView(
                          children: [
                            FiberProductPage(
                                key: fiberProductPageState,
                                specification: snapshots.data!.data!.fiber),
                            YarnProductPage(
                                key: yarnProductPageState,
                                specification: snapshots.data!.data!.yarn),
                            // StockLotPage()
                          ],
                          controller: tabController,
                        ),
                      ),
                    ),
                  ));
            } else if (snapshots.hasError) {
              return Center(
                child: TitleSmallTextWidget(
                  title: snapshots.error.toString(),
                ),
              );
            } else {
              return Container(
                  color: Colors.white,
                  child: const Center(child: SpinKitWave(
                    color: Colors.green,
                    size: 24.0,
                  )));
            }
          },
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
          child: Text(
            tabsList[i],
            style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                /*fontFamily: 'Metropolis',*/),
          ),
        ),
      ));
    }
    return tabs;
  }
}
