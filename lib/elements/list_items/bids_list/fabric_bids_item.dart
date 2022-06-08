import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:yg_app/elements/list_widgets/brand_text.dart';
import 'package:yg_app/helper_utils/navigation_utils.dart';
import 'package:yg_app/model/response/list_bid_response.dart';
import 'package:yg_app/model/response/yarn_response/yarn_specification_response.dart';

import '../../../helper_utils/app_colors.dart';
import '../../../helper_utils/ui_utils.dart';
import '../../../helper_utils/util.dart';
import '../../../model/response/fabric_response/fabric_specification_response.dart';
import '../../elevated_button_widget_2.dart';
import '../../list_widgets/bg_light_blue_normal_text_widget.dart';
import '../../list_widgets/short_detail_renewed_widget.dart';
import '../../title_text_widget.dart';
import '../fabric_list_items_renewed_again.dart';

class FabricBidsItem extends StatelessWidget {

  final BidData bidData;

  const FabricBidsItem({Key? key, required this.bidData}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    FabricSpecification fabricSpecification = bidData.specification as FabricSpecification;

    return Card(
        color: Colors.white,
        elevation: 18.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.w),
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                    padding: EdgeInsets.only(left: 10.w, top: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          child: Text(
                            fabricSpecification.company ??
                                Utils.checkNullString(false),
                            overflow: TextOverflow.fade,
                            maxLines: 1,
                            softWrap: false,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Metropolis',
                            ),
                          ),
                          width: MediaQuery.of(context).size.width * 0.30,
                        ),
                        SizedBox(
                          width: 4.w,
                        ),
                        SizedBox(
                          width: 8.w,
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 2.w),
                          child: Visibility(
                              visible:
                                  Ui.showHide(fabricSpecification.isVerified),
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
                    )),
                Padding(
                  padding: EdgeInsets.only(top: 3.w),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 5.w,
                              ),
                              Row(
                                children: [
                                  Container(
                                      color: blueBackgroundColor,
                                      /*constraints:
                                          const BoxConstraints(maxHeight: 14),*/
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5, vertical: 1),
                                        child: Center(
                                          child: TitleMediumBoldSmallTextWidget(
                                            title: Utils.setFabricFamilyData(
                                                fabricSpecification),
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
                                        title: Utils.setFabricTitle(fabricSpecification),
                                        color: Colors.black87,
                                        weight: FontWeight.w600,
                                        size: 13,
                                      ),
                                    ),
                                    flex: 1,
                                  ),
                                ],
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.only(bottom: 6.0.w, top: 8.w),
                                child: TitleSmallBoldTextWidget(
                                  title: Utils.setFabricDetails(fabricSpecification),
                                  /*title:'Weaving,Ring Frame,Carded,Regular',*/
                                  color: Colors.black87,
                                  size: 10,
                                  weight: FontWeight.w500,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 0.w, right: 35.w),
                                child:Container(
                                  width: MediaQuery.of(context).size.width * 0.55,
                                  child: Utils.setFabricBlueTags(fabricSpecification),
                                ),
                              ),
                              SizedBox(
                                height: 5.w,
                              ),
                              Utils.setPropertiesWithIcons(fabricSpecification),
                              SizedBox(
                                height: 2.h,
                              ),
                            ],
                          ),
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
                                Text.rich(TextSpan(children: [
                                  TextSpan(
                                    text:
                                        '${fabricSpecification.priceUnit.toString().replaceAll(RegExp(r'[^a-zA-Z$]'), '')}.',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12.sp,
                                        fontFamily: 'Metropolis',
                                        fontWeight: FontWeight.w400),
                                  ),
                                  TextSpan(
                                    text: fabricSpecification.priceUnit
                                        .toString()
                                        .replaceAll(RegExp(r'[^0-9]'), ''),
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 17.sp,
                                        fontFamily: 'Metropolis',
                                        fontWeight: FontWeight.w600),
                                  ),
                                  TextSpan(
                                    text:
                                        "/${fabricSpecification.unitCount ?? Utils.checkNullString(false)}",
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
                            SizedBox(
                              height: 4.w,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                            ),
                            SizedBox(
                              height: 8.w,
                            ),
                            SizedBox(
                              width: 64.w,
                              height: 24.w,
                              child: ElevatedButtonWithoutIcon(
                                btnText: "Details",
                                textSize: 8.sp,
                                callback: () {
                                  openDetailsScreen(context,
                                      specObj: bidData.specification
                                          as FabricSpecification,
                                      isFromBid: true);
                                },
                                color: Colors.green,
                              ),
                            ),
                            /*SizedBox(
                              height: 8.w,
                            ),*/
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: 0.w, right: 0.w, top: 0.w,bottom: 0.w),
                  child: Utils.buildContainer(bidData),
                )
              ],
            ),
            Positioned(
              top: 0,
              right: 18,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Visibility(
                    visible: Ui.showHide(fabricSpecification.isFeatured),
                    maintainSize: true,
                    maintainState: true,
                    maintainAnimation: true,
                    child: Container(
                        width: 58.w,
                        padding: EdgeInsets.all(3.w),
                        decoration: BoxDecoration(
                            color: pintFeatureClr,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(0.w),
                              bottomLeft: Radius.circular(3.w),
                              bottomRight: Radius.circular(3.w),
                            )),
                        child: Text(
                          'Featured'.toUpperCase(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 6.sp,
                            fontFamily: 'Metropolis',
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 0.w, bottom: 4.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text.rich(TextSpan(children: [
                          TextSpan(
                            text: "Updated ",
                            style: TextStyle(
                                fontSize: 5.sp,
                                color: Colors.black87,
                                fontWeight: FontWeight.w500),
                          ),
                          TextSpan(
                            text: DateFormat("MMM dd, yyyy").format(
                                DateTime.parse(fabricSpecification.date ?? "")),
                            style: TextStyle(
                                fontSize: 5.sp,
                                color: Colors.black87,
                                fontWeight: FontWeight.w500),
                          )
                        ])),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }


}




