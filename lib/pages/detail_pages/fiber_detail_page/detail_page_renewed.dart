import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/elements/list_widgets/brand_text.dart';
import 'package:yg_app/elements/title_text_widget.dart';
import 'package:yg_app/helper_utils/app_colors.dart';
import 'package:yg_app/helper_utils/app_images.dart';
import 'package:yg_app/model/response/fiber_response/fiber_specification.dart';
import 'package:yg_app/model/response/yarn_response/yarn_specification_response.dart';
import 'package:yg_app/pages/detail_pages/fiber_detail_page/matched_components/matched_tab_page.dart';

import 'detail_tab.dart';
import 'list_bidder_components/bider_tab.dart';

class FiberDetailRenewedPage extends StatefulWidget {
  final Specification? specification;
  final YarnSpecification? yarnSpecification;

  const FiberDetailRenewedPage(
      {Key? key, this.specification, this.yarnSpecification})
      : super(key: key);

  @override
  _FiberDetailPageState createState() => _FiberDetailPageState();
}

class _FiberDetailPageState extends State<FiberDetailRenewedPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<String> tabsList = ['Details', "Matched", 'Bidder List'];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
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
                      const TitleSmallNormalTextWidget(
                        title: "Koh-e-Noor Textile Mills LTD.",
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
                            visible: true,
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
                                              : setFamilyData(widget.yarnSpecification!),
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
                                      /*title: '${specification.origin??'N/A'},${specification.productYear??'N/A'}',*/
                                      title: widget.specification != null
                                          ? '${widget.specification!.origin??'N/A'},${widget.specification!.productYear??'N/A'}'
                                          : setTitleData(widget.yarnSpecification!),
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
                                ),
                                SizedBox(
                                  width: 4.w,
                                ),
                                Text.rich(TextSpan(children: [
                                  TextSpan(
                                    text: "Last Updated",
                                    style: TextStyle(
                                        fontSize: 9.sp,
                                        color: Colors.black),
                                  ),
                                ])),
                                SizedBox(
                                  width: 3.w,
                                ),
                                Text.rich(TextSpan(children: [
                                  TextSpan(
                                    text: "Nov 23, 4:33 PM",
                                    style: TextStyle(
                                        fontSize: 9.sp,
                                        color: lightBlueLabel),
                                  )
                                ])),
                              ],
                            ),
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
                                /*TitleMediumTextWidget(
                            title: "PKR." +
                                specification.priceUnit.toString() +
                                "/KG",
                          ),*/
                                Text.rich(TextSpan(children: [
                                  TextSpan(
                                    text: widget.specification != null
                                        ? '${widget.specification!.priceUnit.toString().replaceAll(RegExp(r'[^a-zA-Z$]'), '')}.'
                                        : '${widget.yarnSpecification!.priceUnit.toString().replaceAll(RegExp(r'[^a-zA-Z$]'), '')}.',
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
                                            .replaceAll(RegExp(r'[^0-9]'), '')
                                        : widget.yarnSpecification!.priceUnit
                                            .toString()
                                            .replaceAll(RegExp(r'[^0-9]'), ''),
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 17.sp,
                                        fontFamily: 'Metropolis',
                                        fontWeight: FontWeight.w600),
                                  ),
                                  TextSpan(
                                    text: "/kg",
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
            Expanded(
              child: DefaultTabController(
                  length: tabsList.length,
                  child: Scaffold(
                    backgroundColor: Colors.white,
                    appBar: PreferredSize(
                      preferredSize: Size(double.infinity, 28.w),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: TabBar(
                          // padding: EdgeInsets.only(left: 8.w, right: 8.w),
                          isScrollable: false,
                          unselectedLabelColor: textColorGrey,
                          labelColor: Colors.white,
                          indicatorColor: lightBlueTabs,
                          indicatorSize: TabBarIndicatorSize.tab,
                          indicator: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [lightBlueTabs, lightBlueTabs]),
                            borderRadius: BorderRadius.circular(8.w),
                          ),
                          tabs: tabMaker(),
                        ),
                      ),
                    ),
                    body: TabBarView(children: [
                      DetailTabPage(
                        specification: widget.specification,
                        yarnSpecification: widget.yarnSpecification,
                      ),
                      MatchedPage(
                          catId: widget.specification != null
                              ? widget.specification!.categoryId!
                              : "2",
                          specId: widget.specification != null
                              ? widget.specification!.spcId
                              : widget.yarnSpecification!.specId ?? 1),
                      BidderListPage(
                          materialId: widget.specification != null
                              ? widget.specification!.categoryId!
                              : "2",
                          specId: widget.specification != null
                              ? widget.specification!.spcId
                              : widget.yarnSpecification!.specId ?? 1)
                    ]),
                  )),
            ),
          ],
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
              padding: const EdgeInsets.all(0),
              child: Text(
                tabsList[i],
                style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.w400),
              )),
        ),
      ));
    }
    return tabs;
  }
}

String setFamilyData(YarnSpecification specification){
  String familyData = "";
  switch (specification.yarnFamilyId) {
    case '1':
      familyData = '${specification.count??"N/A"}${specification.yarnPly != null ? "/${specification.yarnPly!.substring(0,1)}"  :  ""} ${specification.yarnFamily??''}';
      break;
    case '2':
      familyData = '${specification.count??"N/A"}${specification.yarnPly != null ? "/${specification.yarnPly!.substring(0,1)}"  :  ""} ${specification.yarnFamily??''}';
      break;
    case '3':
      familyData = '${specification.count??"N/A"}${specification.yarnPly != null ? "/${specification.yarnPly!.substring(0,1)}"  :  ""} ${specification.yarnFamily??''}';
      break;
    case '4':
      familyData = '${specification.fdyFilament != null ? "/${specification.dtyFilament}"  :  ""} ${specification.yarnFamily??''}';
      break;
    case '5':
      familyData = '${specification.count??"N/A"}${specification.yarnPly != null ? "/${specification.yarnPly!.substring(0,1)}"  :  ""} ${specification.yarnFamily??''}';
      break;
  }
  return familyData;
}

String setTitleData(YarnSpecification specification){
  String titleData = "";
  switch (specification.yarnFamilyId) {
    case '1':
      titleData = '${specification.yarnQuality??'N/A'} for ${specification.yarnUsage??'N/A'}';
      break;
    case '2':
      titleData = specification.yarnBlend??'N/A';
      break;
    case '3':
      titleData = specification.yarnOrientation??'N/A';
      break;
    case '4':
      titleData = specification.yarnType??'N/A';
      break;
    case '5':
      titleData = specification.yarnBlend??'N/A';
      break;
  }
  return titleData;
}