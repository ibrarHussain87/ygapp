import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:yg_app/helper_utils/navigation_utils.dart';
import 'package:yg_app/model/response/list_bid_response.dart';
import 'package:yg_app/model/response/yarn_response/yarn_specification_response.dart';

import '../../../helper_utils/app_colors.dart';
import '../../../helper_utils/ui_utils.dart';
import '../../../helper_utils/util.dart';
import '../../elevated_button_widget_2.dart';
import '../../list_widgets/bg_light_blue_normal_text_widget.dart';
import '../../list_widgets/short_detail_renewed_widget.dart';
import '../../title_text_widget.dart';

class YarnBidsItem extends StatelessWidget {
  final BidData bidData;

  const YarnBidsItem({Key? key, required this.bidData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    YarnSpecification yarnSpecification = bidData
        .specification as YarnSpecification;
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
                Align(
                  alignment: AlignmentDirectional.topEnd,
                  child: Visibility(
                    visible: true,
                    maintainSize: true,
                    maintainState: true,
                    maintainAnimation: true,
                    child: Container(
                        width: 34.w,
                        padding:
                        EdgeInsets.symmetric(horizontal: 3.w, vertical: 3.w),
                        decoration: BoxDecoration(
                            color: bidData.status == "0" ? Colors.brown
                                .shade100.withOpacity(0.4) : bidData.status == "1" ? Colors.green
                                .shade100 : Colors.red.shade100,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(0.w),
                            )),
                        child: Text(
                          _showStatus(int.parse(bidData.status!)),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: bidData.status == "0" ? Colors.
                            brown : bidData.status == "1" ? Colors.green : Colors.red,
                            fontSize: 6.sp,
                            fontFamily: 'Metropolis',
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(left: 10.w, top: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          child: Text(
                            yarnSpecification.company ??
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
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.30,
                        ),
                        SizedBox(
                          width: 4.w,
                        ),
                        // Row(
                        //   crossAxisAlignment: CrossAxisAlignment.start,
                        //   children: [
                        //     const TitleSmallNormalTextWidget(title: "4.5",color: Colors.black,),
                        //     SizedBox(width: 2.w,),
                        //     Image.asset(ratingIcon,width: 8.w,height: 8.w,)
                        //   ],
                        // ),
                        SizedBox(
                          width: 8.w,
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 2.w),
                          child: Visibility(
                              visible:
                              Ui.showHide(yarnSpecification.is_verified),
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
                                      constraints:
                                      const BoxConstraints(maxHeight: 14),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5, vertical: 1),
                                        child: Center(
                                          child: TitleMediumBoldSmallTextWidget(
                                            title: Utils.setFamilyData(
                                                yarnSpecification),
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
                                        title: Utils.setTitleData(
                                            yarnSpecification),
                                        /*title: 'Greige,wrap'.toUpperCase(),*/
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
                                  title:
                                  Utils.setDetailsData(yarnSpecification),
                                  /*title:'Weaving,Ring Frame,Carded,Regular',*/
                                  color: Colors.black87,
                                  size: 10,
                                  weight: FontWeight.w500,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 0.w, right: 35.w),
                                child: yarnSpecification.yarnFamilyId != "4"
                                    ? Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Expanded(
                                      child: BgLightBlueNormalTextWidget(
                                        title:
                                        'AC ${yarnSpecification
                                            .actualYarnCount ?? ""}',
                                      ),
                                      flex: 1,
                                    ),
                                    SizedBox(width: 8.w),
                                    Expanded(
                                      child: BgLightBlueNormalTextWidget(
                                        title:
                                        'CLSP ${yarnSpecification.clsp ?? ""}',
                                      ),
                                      flex: 1,
                                    ),
                                    SizedBox(width: 8.w),
                                    Expanded(
                                      child: BgLightBlueNormalTextWidget(
                                        title:
                                        'IPI ${yarnSpecification.ys_ipm_km ??
                                            ""}',
                                      ),
                                      flex: 1,
                                    ),
                                  ],
                                )
                                    : Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Expanded(
                                      child: BgLightBlueNormalTextWidget(
                                        title:
                                        'Q ${yarnSpecification.yarnQuality ??
                                            ""}',
                                      ),
                                      flex: 1,
                                    ),
                                    SizedBox(width: 8.w),
                                    Expanded(
                                      child: BgLightBlueNormalTextWidget(
                                        title:
                                        'A ${yarnSpecification.yarnApperance ??
                                            ""}',
                                      ),
                                      flex: 1,
                                    ),
                                    SizedBox(width: 8.w),
                                    Expanded(
                                      child: BgLightBlueNormalTextWidget(
                                        title:
                                        'G ${yarnSpecification.yarnGrade ??
                                            ""}',
                                      ),
                                      flex: 1,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 5.w,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Wrap(
                                      spacing: 4.0,
                                      runSpacing: 3.0,
                                      children: [
                                        ShortDetailRenewedWidget(
                                          title: yarnSpecification.weightBag ??
                                              Utils.checkNullString(false),
                                          imageIcon: 'images/img_bag.png',
                                          size: 9.sp,
                                          iconSize: 14,
                                        ),
                                        ShortDetailRenewedWidget(
                                          title: yarnSpecification.weightCone ??
                                              Utils.checkNullString(false),
                                          imageIcon: 'images/img_cone.png',
                                          size: 9.sp,
                                          iconSize: 14,
                                        ),
                                        ShortDetailRenewedWidget(
                                          title: yarnSpecification
                                              .deliveryPeriod ??
                                              Utils.checkNullString(false),
                                          imageIcon: 'images/img_van.png',
                                          size: 9.sp,
                                          iconSize: 14,
                                        ),
                                        ShortDetailRenewedWidget(
                                          title: yarnSpecification.locality ??
                                              Utils.checkNullString(false),
                                          imageIcon: 'images/img_location.png',
                                          size: 9.sp,
                                          iconSize: 14,
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              Wrap(
                                direction: Axis.horizontal,
                                spacing: 4.0,
                                runSpacing: 4.0,
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: [
                                  Container(
                                      width: MediaQuery
                                          .of(context)
                                          .size
                                          .width * 0.17,
                                      decoration: BoxDecoration(
                                        /*color: lightYellowContainer,*/
                                          border: Border.all(
                                            color: greenButton,
                                            width:
                                            1, //                   <--- border width here
                                          ),
                                          borderRadius:
                                          BorderRadius.all(
                                              Radius.circular(4.w))),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 4.w, horizontal: 4.w),
                                        child: Center(
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              // Text(
                                              //   'Price',
                                              //   style: TextStyle(
                                              //       fontSize: 9.sp,
                                              //       color: Colors.black87,
                                              //       fontWeight: FontWeight.w400),
                                              // ),
                                              // SizedBox(width: 2.w,),
                                              Text(
                                                '${bidData.price}',
                                                style: TextStyle(
                                                    fontSize: 9.sp,
                                                    color: greenButton,
                                                    fontWeight: FontWeight
                                                        .w700),
                                              ),
                                              SizedBox(
                                                width: 3.w,
                                              )
                                            ],
                                          ),
                                        ),
                                      )),
                                  Container(
                                      width: MediaQuery
                                          .of(context)
                                          .size
                                          .width * 0.17,
                                      decoration: BoxDecoration(
                                        /*color: lightYellowContainer,*/
                                          border: Border.all(
                                            color: greenButton,
                                            width:
                                            1, //                   <--- border width here
                                          ),
                                          borderRadius:
                                          BorderRadius.all(
                                              Radius.circular(4.w))),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 4.w, horizontal: 4.w),
                                        child: Center(
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'QTY',
                                                style: TextStyle(
                                                    fontSize: 9.sp,
                                                    color: Colors.black87,
                                                    fontWeight: FontWeight
                                                        .w400),
                                              ),
                                              SizedBox(width: 2.w,),
                                              Text(
                                                '${bidData.quantity}',
                                                style: TextStyle(
                                                    fontSize: 9.sp,
                                                    color: greenButton,
                                                    fontWeight: FontWeight
                                                        .w700),
                                              ),
                                              SizedBox(
                                                width: 3.w,
                                              )
                                            ],
                                          ),
                                        ),
                                      )),

                                  TitleExtraSmallTextWidget(title: bidData.date)

                                ],
                              ),
                              SizedBox(
                                height: 4.h,
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
                                    '${yarnSpecification.priceUnit.toString()
                                        .replaceAll(
                                        RegExp(r'[^a-zA-Z$]'), '')}.',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12.sp,
                                        fontFamily: 'Metropolis',
                                        fontWeight: FontWeight.w400),
                                  ),
                                  TextSpan(
                                    text: yarnSpecification.priceUnit
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
                                    "/${yarnSpecification.unitCount ??
                                        Utils.checkNullString(false)}",
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
                                  openDetailsScreen(context,yarnSpecification: bidData.specification as YarnSpecification,isFromBid: true);
                                },
                                color: Colors.green,
                              ),
                            ),
                            SizedBox(
                              height: 8.w,
                            ),

                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                /*Padding(
                padding: EdgeInsets.only(right: 8.w,bottom: 4.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text.rich(TextSpan(children: [
                      TextSpan(
                        text: "Last updated ",
                        style: TextStyle(
                            fontSize: 7.sp, color: Colors.black),
                      ),
                      TextSpan(
                        text: "Nov 23, 4:33 PM",
                        style: TextStyle(
                            fontSize: 7.sp, color: Colors.black),
                      )
                    ])),

                  ],
                ),
              )*/

              ],
            ),
            Positioned(
              top: 0,
              right: 18,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Visibility(
                    visible: Ui.showHide(yarnSpecification.is_featured),
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
                                DateTime.parse(yarnSpecification.date ?? "")),
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

String _showStatus(int bidStatus) {
  if (bidStatus == 0) {
    return "Pending";
  } else if (bidStatus == 1) {
    return "Accepted";
  } else {
    return "Rejected";
  }
}
