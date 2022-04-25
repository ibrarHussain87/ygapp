import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:yg_app/elements/title_text_widget.dart';
import 'package:yg_app/helper_utils/app_colors.dart';
import 'package:yg_app/helper_utils/app_constants.dart';
import 'package:yg_app/helper_utils/app_images.dart';
import 'package:yg_app/helper_utils/shared_pref_util.dart';
import 'package:yg_app/helper_utils/ui_utils.dart';
import 'package:yg_app/helper_utils/util.dart';
import 'package:yg_app/model/response/fabric_response/fabric_specification_response.dart';
import 'package:yg_app/model/response/fiber_response/fiber_specification.dart';
import 'package:yg_app/model/response/stocklot_repose/stocklot_specification_response.dart';
import 'package:yg_app/model/response/yarn_response/yarn_specification_response.dart';
import 'package:yg_app/pages/detail_pages/detail_page/history_bids_component/history_bids_page.dart';

import 'detail_tab.dart';
import 'list_bidder_components/bider_tab.dart';
import 'matched_components/matched_tab_page.dart';

class DetailRenewedPage extends StatefulWidget {
  final Specification? specification;
  final YarnSpecification? yarnSpecification;
  final dynamic specObj;
  final bool? isFromBid;
  final bool? sendProposal;

  const DetailRenewedPage(
      {Key? key,
      this.specification,
      this.yarnSpecification,
      this.specObj,
      this.isFromBid,
      this.sendProposal})
      : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailRenewedPage> {
  String? companyName() {
    if (widget.specification != null) {
      return widget.specification!.company ?? "";
    } else if (widget.yarnSpecification != null) {
      return widget.yarnSpecification!.company ?? "";
    } else if (widget.specObj is StockLotSpecification) {
      return (widget.specObj as StockLotSpecification).company ?? "";
    } else if (widget.specObj is FabricSpecification) {
      return (widget.specObj as FabricSpecification).company ?? "";
    }
    return null;
  }

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final List<String> _tabsListCreator = ['Details', "Matched", 'Bidder List'];
  final List<String> _tabsListBidder = [
    'Details', /* "Matched"*/
  ];
  final List<String> _tabsListBid = ['Details', "History"];
  List<String>? _tabsList;
  List<Widget>? _tabWidgetList;

  bool _isYarn() {
    if (widget.yarnSpecification != null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void initState() {
    _getUserId().then((userId) {
      if (widget.specification != null) {
        if (userId != widget.specification!.spc_user_id) {
          _creatorOrBidder(false);
        } else {
          _creatorOrBidder(true);
        }
      } else if (widget.yarnSpecification != null) {
        if (userId != widget.yarnSpecification!.ys_user_id) {
          _creatorOrBidder(false);
        } else {
          _creatorOrBidder(true);
        }
      } else if (widget.specObj is StockLotSpecification) {
        if (userId != (widget.specObj as StockLotSpecification).userId) {
          _creatorOrBidder(false);
        } else {
          _creatorOrBidder(true);
        }
      } else if (widget.specObj is FabricSpecification) {
        if (userId != (widget.specObj as FabricSpecification).fsUserId) {
          _creatorOrBidder(false);
        } else {
          _creatorOrBidder(true);
        }
      }
    });

    super.initState();
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
                  /*Row(
                    children: [
                      BrandWidget(
                          title: widget.specification == null
                              ? widget.yarnSpecification!.yarnFamily
                              : widget.specification!.brand),
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
                  ),*/
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TitleSmallNormalTextWidget(
                        title: companyName(),
                        color: Colors.black,
                        size: 10,
                        weight: FontWeight.w600,
                      ),
                      /*SizedBox(
                        width: 4.w,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const TitleSmallNormalTextWidget(
                            title: "4.5",
                            color: Colors.black,
                          ),
                          SizedBox(
                            width: 2.w,
                          ),
                          Image.asset(
                            ratingIcon,
                            width: 8.w,
                            height: 8.w,
                          )
                        ],
                      ),*/
                      SizedBox(
                        width: 4.w,
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 2.w),
                        child: Visibility(
                            visible: Ui.showHide(widget.specification != null
                                ? widget.specification!.isVerified
                                : widget.yarnSpecification != null
                                    ? widget.yarnSpecification!.is_verified
                                    : widget.specObj is StockLotSpecification
                                        ? (widget.specObj
                                                as StockLotSpecification)
                                            .isVerified
                                        : (widget.specObj
                                                as FabricSpecification)
                                            .isVerified),
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
                                    constraints:
                                        const BoxConstraints(maxHeight: 14),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 1),
                                      child: Center(
                                        child: TitleMediumBoldSmallTextWidget(
                                          title: widget.specification != null
                                              ? '${widget.specification!.material}'
                                              : widget.yarnSpecification != null
                                                  ? setFamilyData(
                                                      widget.yarnSpecification!)
                                                  : widget.specObj
                                                          is StockLotSpecification
                                                      ? (widget.specObj
                                                              as StockLotSpecification)
                                                          .category
                                                      : Utils.setFabricFamilyData(
                                                          (widget.specObj
                                                              as FabricSpecification)),
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
                                      /*title: '${specification.origin??Utils.checkNullString(false)},${specification.productYear??Utils.checkNullString(false)}',*/
                                      title: widget.specification != null
                                          ? Utils.createStringFromList([
                                              widget.specification!
                                                  .origin_fiber_spc,
                                              widget.specification!.productYear
                                            ])
                                          : widget.yarnSpecification != null
                                              ? setTitleData(
                                                  widget.yarnSpecification!)
                                              : widget.specObj
                                                      is StockLotSpecification
                                                  ? (widget.specObj
                                                          as StockLotSpecification)
                                                      .availablity
                                                  : Utils.setFabricTitle((widget
                                                          .specObj
                                                      as FabricSpecification)),
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
                                // Row(
                                //   crossAxisAlignment: CrossAxisAlignment.start,
                                //   children: [
                                //     const TitleSmallNormalTextWidget(
                                //       title: "4.5",
                                //       color: Colors.black,
                                //     ),
                                //     SizedBox(
                                //       width: 2.w,
                                //     ),
                                //     Image.asset(
                                //       ratingIcon,
                                //       width: 8.w,
                                //       height: 8.w,
                                //     )
                                //   ],
                                // ),
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
                                    text: widget.specification != null
                                        ? widget.specification!.date == null
                                            ? Utils.checkNullString(false)
                                            : DateFormat("MMM dd, yyyy").format(DateTime.parse(
                                                widget.specification!.date!))
                                        : widget.yarnSpecification != null
                                            ? widget.yarnSpecification!.date ==
                                                    null
                                                ? Utils.checkNullString(false)
                                                : DateFormat("MMM dd, yyyy")
                                                    .format(DateTime.parse(widget
                                                        .yarnSpecification!
                                                        .date!))
                                            : widget.specObj
                                                    is StockLotSpecification
                                                ? DateFormat("MMM dd, yyyy")
                                                    .format(DateTime.parse(
                                                        (widget.specObj as StockLotSpecification)
                                                            .date!))
                                                : DateFormat("MMM dd, yyyy")
                                                    .format(DateTime.parse((widget.specObj as FabricSpecification).date!)),
                                    style: TextStyle(
                                        fontSize: 9.sp, color: lightBlueLabel),
                                  )
                                ])),
                              ],
                            ),
                            Visibility(
                              visible: false,
                              child: Column(
                                children: [
                                  SizedBox(height: 4.w),
                                  Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                            text: 'Time Left',
                                            style: TextStyle(
                                                color: textColorGrey,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 11.sp)),
                                        TextSpan(
                                          text: '      0 DAYS. 8 HOURS,29 MINS',
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal,
                                              color: appBarTextColor,
                                              fontSize: 11.sp),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            /*SizedBox(height: 6.w),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                BrandWidget(title: 'Starting Bid'),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    TitleTextWidget(
                                        title:
                                        '${widget.specification != null ? widget.specification!.priceUnit : widget.yarnSpecification!.priceUnit}'),
                                    SizedBox(
                                      width: 12.w,
                                    ),
                                    Text(
                                      '(CLOSES 09/20/2021 | 09:35 AM EST)',
                                      style: TextStyle(
                                          fontSize: 7.sp, color: textColorGreyLight),
                                    )
                                  ],
                                )
                              ],
                            ),*/
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
                                    ? stockLotPrice()
                                    : Text.rich(TextSpan(children: [
                                        TextSpan(
                                          text: widget.specification != null
                                              ? '${widget.specification!.priceUnit.toString().replaceAll(RegExp(r'[^a-zA-Z$]'), '')}.'
                                              : widget.yarnSpecification != null
                                                  ? '${widget.yarnSpecification!.priceUnit.toString().replaceAll(RegExp(r'[^a-zA-Z$]'), '')}.'
                                                  : '${(widget.specObj as FabricSpecification).priceUnit.toString().replaceAll(RegExp(r'[^a-zA-Z$]'), '')}.',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 12.sp,
                                              fontFamily: 'Metropolis',
                                              fontWeight: FontWeight.w400),
                                        ),
                                        TextSpan(
                                          text: widget.specification != null
                                              ? widget.specification!.priceUnit
                                                  .toString()
                                                  .replaceAll(
                                                      RegExp(r'[^0-9]'), '')
                                              : widget.yarnSpecification != null
                                                  ? widget.yarnSpecification!
                                                      .priceUnit
                                                      .toString()
                                                      .replaceAll(
                                                          RegExp(r'[^0-9]'), '')
                                                  : (widget.specObj
                                                          as FabricSpecification)
                                                      .priceUnit
                                                      .toString()
                                                      .replaceAll(
                                                          RegExp(r'[^0-9]'),
                                                          ''),
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 17.sp,
                                              fontFamily: 'Metropolis',
                                              fontWeight: FontWeight.w600),
                                        ),
                                        TextSpan(
                                          text:
                                              "/ ${_isYarn() ? widget.yarnSpecification!.unitCount ?? "" : widget.specification != null ? widget.specification!.unitCount ?? "" : (widget.specObj as FabricSpecification).unitCount ?? ""}",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 12.sp,
                                              fontFamily: 'Metropolis',
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ])),
                                SizedBox(
                                  height: 1.h,
                                ),
                                const Center(
                                  child: TitleSmallNormalTextWidget(
                                    title: "Ex- Factory",
                                    size: 7,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 2.w,
                            ),
                            /*Padding(
                          padding: EdgeInsets.only(right: 8.w,bottom: 4.w),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text.rich(TextSpan(children: [
                                TextSpan(
                                  text: "Last Updated",
                                  style: TextStyle(
                                      fontSize: 9.sp, color: Colors.black),
                                ),
                              ])),
                              SizedBox(height: 3.w,),
                              Text.rich(TextSpan(children: [
                                TextSpan(
                                  text: "Nov 23, 4:33 PM",
                                  style: TextStyle(
                                      fontSize: 9.sp, color: lightBlueLabel),
                                )
                              ])),
                            ],
                          ),
                        ),*/
                            /*SizedBox(
                              height: 4.w,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceAround,
                              children: [
                                Image.asset(
                                  'images/ic_list.png',
                                  height: 24.w,
                                  width: 24.h,
                                ),
                                SizedBox(
                                  width: 4.w,
                                ),
                                Image.asset(
                                  'images/ic_list.png',
                                  height: 24.h,
                                  width: 24.w,
                                ),
                                SizedBox(
                                  width: 4.w,
                                ),
                                Image.asset(
                                  'images/ic_list.png',
                                  height: 24.h,
                                  width: 24.w,
                                ),
                              ],
                            ),*/
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            _tabsList != null
                ? Expanded(
                    child: DefaultTabController(
                        length: _tabsList!.length,
                        child: Scaffold(
                          backgroundColor: Colors.white,
                          appBar: PreferredSize(
                            preferredSize: Size(double.infinity, 28.w),
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              child: Visibility(
                                visible: _tabsList!.length > 1,
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
                          body: TabBarView(children: _tabWidgetList!),
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
    for (var i = 0; i < _tabsList!.length; i++) {
      tabs.add(Tab(
        child: Align(
          alignment: Alignment.center,
          child: Padding(
              padding: const EdgeInsets.all(0),
              child: Text(
                _tabsList![i],
                style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.w400),
              )),
        ),
      ));
    }
    return tabs;
  }

  List<Tab> tabMakerUpdated() {
    List<Tab> tabs = []; //create an empty list of Tab
    for (var i = 0; i < _tabsList!.length; i++) {
      tabs.add(
        /*Tab(
        child: Align(
          alignment: Alignment.center,
          child: Padding(
              padding: const EdgeInsets.all(0),
              child: Text(
                _tabsList![i],
                style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.w400),
              )),
        ),
      )*/
        Tab(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: lightBlueTabs, width: 1),
            ),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                _tabsList![i],
                style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.w400),
              ),
            ),
          ),
        ),
      );
    }
    return tabs;
  }

  _creatorOrBidder(bool isCreator) {
    if (isCreator) {
      setState(() {
        _tabsList = _tabsListCreator;
        _tabWidgetList = [
          DetailTabPage(
            specification: widget.specification,
            yarnSpecification: widget.yarnSpecification,
            specObject: widget.specObj,
          ),
          MatchedPage(
              catId: widget.specification != null
                  ? widget.specification!.categoryId!
                  : widget.yarnSpecification != null
                      ? "2"
                      : widget.specObj is StockLotSpecification
                          ? (widget.specObj as StockLotSpecification)
                              .stocklotCategoryId
                              .toString()
                          : "3",
              specId: widget.specification != null
                  ? widget.specification!.spcId
                  : widget.yarnSpecification != null
                      ? widget.yarnSpecification!.ysId ?? 1
                      : widget.specObj is StockLotSpecification
                          ? (widget.specObj as StockLotSpecification).id!
                          : (widget.specObj as FabricSpecification).fsId!),
          BidderListPage(
              materialId: widget.specification != null
                  ? widget.specification!.categoryId!
                  : widget.yarnSpecification != null
                      ? "2"
                      : widget.specObj is StockLotSpecification
                          ? (widget.specObj as StockLotSpecification)
                              .stocklotCategoryId
                              .toString()
                          : "3",
              specId: widget.specification != null
                  ? widget.specification!.spcId
                  : widget.yarnSpecification != null
                      ? widget.yarnSpecification!.ysId ?? 1
                      : widget.specObj is StockLotSpecification
                          ? (widget.specObj as StockLotSpecification).id!
                          : (widget.specObj as FabricSpecification).fsId!)
        ];
      });
    } else if (widget.isFromBid ?? false) {
      setState(() {
        _tabsList = _tabsListBid;
        _tabWidgetList = [
          DetailTabPage(
            specification: widget.specification,
            yarnSpecification: widget.yarnSpecification,
            specObject: widget.specObj,
          ),
          HistoryOfBidsPage(
              catId: widget.specification != null
                  ? widget.specification!.categoryId!
                  : widget.yarnSpecification != null
                      ? widget.yarnSpecification!.category_id!.toString()
                      : widget.specObj is StockLotSpecification
                          ? (widget.specObj as StockLotSpecification)
                              .stocklotCategoryId
                              .toString()
                          : "3",
              specId: widget.specification != null
                  ? widget.specification!.spcId.toString()
                  : widget.yarnSpecification != null
                      ? widget.yarnSpecification!.ysId.toString()
                      : widget.specObj is StockLotSpecification
                          ? (widget.specObj as StockLotSpecification)
                              .id
                              .toString()
                          : (widget.specObj as FabricSpecification)
                              .fsId!
                              .toString())
        ];
      });
    } else {
      setState(() {
        _tabsList = _tabsListBidder;
        _tabWidgetList = [
          DetailTabPage(
            specification: widget.specification,
            yarnSpecification: widget.yarnSpecification,
            specObject: widget.specObj,
            sendProposal: widget.sendProposal ?? false,
          ),
          /*MatchedPage(
              catId: widget.specification != null
                  ? widget.specification!.categoryId!
                  : "2",
              specId: widget.specification != null
                  ? widget.specification!.spcId
                  : widget.yarnSpecification!.ysId ?? 1),*/
        ];
      });
    }
  }
  stockLotPrice() {
    return Text.rich(
      TextSpan(
          children: (widget.specObj
          as StockLotSpecification)
              .specDetails!
              .length >
              1
              ? Utils.stockLotPriceRange(
              widget.specObj
              as StockLotSpecification)
              : [
            // TextSpan(
            //   text:
            //   '${specification.priceUnit.toString().replaceAll(RegExp(r'[^a-zA-Z$]'), '')}.',
            //   style: TextStyle(
            //       color: Colors.black,
            //       fontSize: 12.sp,
            //       // fontFamily: 'Metropolis',
            //       fontWeight: FontWeight.w500),
            // ),
            TextSpan(
              text: (widget.specObj
              as StockLotSpecification)
                  .specDetails!
                  .first
                  .price /*'1000'*/,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 17.sp,
                  // fontFamily: 'Metropolis',
                  fontWeight:
                  FontWeight.w600),
            ),
            TextSpan(
              text:
              "/${(widget.specObj as StockLotSpecification).specDetails!.first.priceUnit != null ? (widget.specObj as StockLotSpecification).specDetails!.first.priceUnit!.split(" ").first : ""}",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 12.sp,
                  // fontFamily: 'Metropolis',
                  fontWeight:
                  FontWeight.w500),
            ),
          ]),
    );
  }
}



Future<String?> _getUserId() async {
  return await SharedPreferenceUtil.getStringValuesSF(USER_ID_KEY);
}

String setFamilyData(YarnSpecification specification) {
  String familyData = "";
  switch (specification.yarnFamilyId) {
    case '1':
      familyData =
          '${specification.count ?? Utils.checkNullString(false)}${specification.yarnPly != null ? "/${specification.yarnPly!.substring(0, 1)}" : ""} ${specification.yarnFamily ?? ''}';
      break;
    case '2':
      familyData =
          '${specification.count ?? Utils.checkNullString(false)}${specification.yarnPly != null ? "/${specification.yarnPly!.substring(0, 1)}" : ""} ${specification.yarnFamily ?? ''}';
      break;
    case '3':
      familyData =
          '${specification.count ?? Utils.checkNullString(false)}${specification.yarnPly != null ? "/${specification.yarnPly!.substring(0, 1)}" : ""} ${specification.yarnFamily ?? ''}';
      break;
    case '4':
      familyData =
          '${specification.dtyFilament ?? ""} ${specification.fdyFilament != null ? "/${specification.fdyFilament}" : ""} ${specification.yarnFamily ?? ''}';
      break;
    case '5':
      familyData =
          '${specification.count ?? Utils.checkNullString(false)}${specification.yarnPly != null ? "/${specification.yarnPly!.substring(0, 1)}" : ""} ${specification.yarnFamily ?? ''}';
      break;
  }
  return familyData;
}

String setTitleData(YarnSpecification specification) {
  String titleData = "";
  switch (specification.yarnFamilyId) {
    case '1':
      titleData =
          '${specification.yarnQuality ?? Utils.checkNullString(false)} for ${specification.yarnUsage ?? Utils.checkNullString(false)}';
      break;
    case '2':
      titleData = specification.yarnBlend ?? Utils.checkNullString(false);
      break;
    case '3':
      titleData = specification.yarnOrientation ?? Utils.checkNullString(false);
      break;
    case '4':
      titleData = specification.yarnType ?? Utils.checkNullString(false);
      break;
    case '5':
      titleData = specification.yarnBlend ?? Utils.checkNullString(false);
      break;
  }
  return titleData;
}
