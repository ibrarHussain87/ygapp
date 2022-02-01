import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/elements/list_widgets/brand_text.dart';
import 'package:yg_app/elements/title_text_widget.dart';
import 'package:yg_app/helper_utils/app_colors.dart';
import 'package:yg_app/helper_utils/util.dart';
import 'package:yg_app/model/response/fiber_response/fiber_specification.dart';
import 'package:yg_app/model/response/yarn_response/yarn_specification_response.dart';
import 'detail_tab.dart';
import 'list_bidder_components/bider_tab.dart';
import 'matched_components/matched_tab_page.dart';

class FiberDetailPage extends StatefulWidget {
  final Specification? specification;
  final YarnSpecification? yarnSpecification;

  const FiberDetailPage({Key? key, this.specification, this.yarnSpecification})
      : super(key: key);

  @override
  _FiberDetailPageState createState() => _FiberDetailPageState();
}

class _FiberDetailPageState extends State<FiberDetailPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<String> tabsList = ['Details', 'Matched', 'Bidder List'];

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
                  Row(
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
                  ),
                  SizedBox(
                    height: 2.w,
                  ),
                  TitleTextWidget(
                    title:
                        widget.specification != null?
                        '${widget.specification!.material},${widget.specification!.apperance != null ? "${widget.specification!.apperance}/" : ""}${widget.specification!.productYear!.substring(0, 4)}':
                        '${widget.yarnSpecification!.yarnBlend ?? Utils.checkNullString(false)},${widget.yarnSpecification!.yarnApperance != null ? "${widget.yarnSpecification!.yarnApperance ??Utils.checkNullString(false)}/" : ""}${widget.yarnSpecification!.yarnPattern??Utils.checkNullString(false)}'

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
                  SizedBox(height: 6.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BrandWidget(title: 'Starting Bid'),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          TitleTextWidget(
                              title: '${widget.specification!=null?widget.specification!.priceUnit:widget.yarnSpecification!.priceUnit}'),
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
                  ),
                  SizedBox(
                    height: 16.w,
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
                          catId: widget.specification != null ? widget.specification!.categoryId! : "2",
                          specId: widget.specification != null ? widget.specification!.spcId : widget.yarnSpecification!.specId??1),
                      BidderListPage(
                          materialId: widget.specification != null ? widget.specification!.categoryId! : "2",
                          specId: widget.specification != null ? widget.specification!.spcId : widget.yarnSpecification!.specId??1)
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
