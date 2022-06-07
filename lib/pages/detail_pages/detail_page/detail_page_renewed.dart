import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/elements/title_text_widget.dart';
import 'package:yg_app/helper_utils/app_colors.dart';
import 'package:yg_app/locators.dart';
import 'package:yg_app/model/response/stocklot_repose/stocklot_specification_response.dart';
import 'package:yg_app/providers/detail_provider/detail_page_provider.dart';

class DetailRenewedPage extends StatefulWidget {
  final dynamic specObj;
  final bool? isFromBid;
  final bool? sendProposal;

  const DetailRenewedPage(
      {Key? key, this.specObj, this.isFromBid, this.sendProposal})
      : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailRenewedPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _detailPageProvider = locator<DetailPageProvider>();

  @override
  void initState() {
    super.initState();

    _detailPageProvider.addListener(() {
      if(mounted){setState(() {});
    }});

    _detailPageProvider.checkSpecObject(widget.specObj,
        widget.sendProposal ?? false, widget.isFromBid ?? false);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          leading: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              Navigator.pop(context, true);
            },
            child: Padding(
                padding: EdgeInsets.all(12.w),
                child: Card(
                  child: Padding(
                      padding: EdgeInsets.only(left: 4.w),
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.black,
                        size: 12.w,
                      )),
                )),
          ),
          title: Text('Detail',
              style: TextStyle(
                  fontSize: 16.0.w,
                  color: appBarTextColor,
                  fontWeight: FontWeight.w400)),
        ),
        key: scaffoldKey,
        backgroundColor: Colors.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TitleSmallNormalTextWidget(
                        title: _detailPageProvider.setCompanyName(),
                        color: Colors.black,
                        size: 10,
                        weight: FontWeight.w600,
                      ),
                      SizedBox(
                        width: 4.w,
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 2.w),
                        child: Visibility(
                            visible:
                                _detailPageProvider.setVerifiedVisibility(),
                            maintainSize: true,
                            maintainState: true,
                            maintainAnimation: true,
                            child: Image.asset(
                              'images/ic_verified_supplier.png',
                              width: 8.w,
                              height: 8.w,
                              fit: BoxFit.fill,
                            )),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 2.w,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 3.w,
                            ),
                            Row(
                              children: [
                                Container(
                                    color: blueBackgroundColor,
                                    // constraints:
                                    //     const BoxConstraints(maxHeight: 14),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 1),
                                      child: Center(
                                        child: TitleMediumBoldSmallTextWidget(
                                          title: _detailPageProvider
                                              .setFamilyTitle(),
                                          color: Colors.white,
                                          textSize: 12,
                                        ),
                                      ),
                                    )),
                                SizedBox(
                                  width: 2.w,
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 1),
                                    child: TitleMediumTextWidget(
                                      title: _detailPageProvider.setTitle(),
                                      color: Colors.black87,
                                      weight: FontWeight.w600,
                                      size: 13,
                                    ),
                                  ),
                                  flex: 1,
                                ),
                              ],
                            ),
                            SizedBox(height: 4.w),
                            Row(
                              children: [
                                SizedBox(
                                  width: 4.w,
                                ),
                                Text.rich(TextSpan(children: [
                                  TextSpan(
                                    text: "Last Updated",
                                    style: TextStyle(
                                        fontSize: 9.sp, color: Colors.black),
                                  ),
                                ])),
                                SizedBox(
                                  width: 3.w,
                                ),
                                Text.rich(TextSpan(children: [
                                  TextSpan(
                                    /*fixed null exception date*/
                                    text: _detailPageProvider.setDateTime(),
                                    style: TextStyle(
                                        fontSize: 9.sp, color: lightBlueLabel),
                                  )
                                ])),
                              ],
                            ),
                            SizedBox(
                              height: 8.w,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding:
                            EdgeInsets.only(left: 6.w, right: 6.w, top: 5.h),
                        child: Column(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                widget.specObj is StockLotSpecification
                                    ? _detailPageProvider.stockLotPrice()

                                    /// REMOVING RICE FOR REQUIREMENT TYPE
                                    : Visibility(
                                        visible: _detailPageProvider
                                                .getPriceVisibility() ??
                                            false,
                                        child: Text.rich(TextSpan(
                                            children: _detailPageProvider
                                                .setPriceText())),
                                      ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                Center(
                                  child: TitleSmallNormalTextWidget(
                                    title: _detailPageProvider
                                        .setDeliveryPeriodText(),
                                    size: 7,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 2.w,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            _detailPageProvider.tabsList != null
                ? Expanded(
                    child: DefaultTabController(
                        length: _detailPageProvider.tabsList!.length,
                        child: Scaffold(
                          backgroundColor: Colors.white,
                          appBar: PreferredSize(
                            preferredSize: Size(double.infinity, 28.w),
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              child: Visibility(
                                visible:
                                    _detailPageProvider.tabsList!.length > 1,
                                maintainSize: false,
                                child: TabBar(
                                  // padding: EdgeInsets.only(left: 8.w, right: 8.w),
                                  isScrollable: false,
                                  unselectedLabelColor: lightBlueTabs,
                                  labelColor: Colors.white,
                                  indicatorColor: lightBlueTabs,
                                  indicatorSize: TabBarIndicatorSize.tab,
                                  indicator: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      color: lightBlueTabs),
                                  tabs: tabMakerUpdated(),
                                ),
                              ),
                            ),
                          ),
                          body: TabBarView(
                              children: _detailPageProvider.tabWidgetList!),
                        )),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  List<Tab> tabMaker() {
    List<Tab> tabs = []; //create an empty list of Tab
    for (var i = 0; i < _detailPageProvider.tabsList!.length; i++) {
      tabs.add(Tab(
        child: Align(
          alignment: Alignment.center,
          child: Padding(
              padding: const EdgeInsets.all(0),
              child: Text(
                _detailPageProvider.tabsList![i],
                style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.w400),
              )),
        ),
      ));
    }
    return tabs;
  }

  List<Tab> tabMakerUpdated() {
    List<Tab> tabs = []; //create an empty list of Tab
    for (var i = 0; i < _detailPageProvider.tabsList!.length; i++) {
      tabs.add(
        Tab(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: lightBlueTabs, width: 1),
            ),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                _detailPageProvider.tabsList![i],
                style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.w400),
              ),
            ),
          ),
        ),
      );
    }
    return tabs;
  }
}
