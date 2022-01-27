import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/elements/error_image_widget.dart';
import 'package:yg_app/elements/list_widgets/bg_light_blue_normal_text_widget.dart';
import 'package:yg_app/elements/list_widgets/bg_light_blue_text_widget.dart';
import 'package:yg_app/elements/list_widgets/bid_now_widget.dart';
import 'package:yg_app/elements/list_widgets/brand_text.dart';
import 'package:yg_app/elements/list_widgets/rating_widget.dart';
import 'package:yg_app/elements/list_widgets/short_detail_renewed_widget.dart';
import 'package:yg_app/elements/list_widgets/short_detail_widget.dart';
import 'package:yg_app/elements/list_widgets/verified_supplier.dart';
import 'package:yg_app/elements/loading_widgets/loading_image_widget.dart';
import 'package:yg_app/elements/title_text_widget.dart';
import 'package:yg_app/helper_utils/app_colors.dart';
import 'package:yg_app/helper_utils/app_images.dart';
import 'package:yg_app/helper_utils/ui_utils.dart';
import 'package:yg_app/model/response/fiber_response/fiber_specification.dart';

Widget buildFiberRenewedWidget(Specification specification, BuildContext context) {
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
              /*Visibility(
              visible: true,
              maintainSize: true,
              maintainState: true,
              maintainAnimation: true,
              child: Container(
                  width: 48.w,
                  padding: EdgeInsets.all(3.w),
                  decoration: BoxDecoration(
                      color: pintFeatureClr,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(14.w),
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
            ),*/
              Padding(
                  padding: EdgeInsets.only(left: 10.w,top: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        child: Text(
                          specification.company??"N/A",
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
                        width: MediaQuery.of(context).size.width*0.30,
                      ),
                      SizedBox(
                        width: 4.w,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const TitleSmallNormalTextWidget(title: "4.5",color: Colors.black,),
                          SizedBox(width: 2.w,),
                          Image.asset(ratingIcon,width: 8.w,height: 8.w,)
                        ],
                      ),
                      SizedBox(
                        width: 8.w,
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 2.w),
                        child: Visibility(
                            visible: Ui.showHide(specification.isVerified),
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
                  )
              ),
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
                            SizedBox(height: 5.w,),
                            Row(
                              children: [
                                Container(
                                    color: blueBackgroundColor,
                                    constraints: const BoxConstraints(maxHeight: 14),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 1),
                                      child: Center(
                                        child: TitleMediumBoldSmallTextWidget(
                                          title:
                                          '${specification.material}',
                                          color: Colors.white,
                                          textSize: 12,
                                        ),
                                      ),
                                    )
                                ),
                                SizedBox(width: 2.w,),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 1),
                                    child: TitleMediumTextWidget(
                                      title: '${specification.origin??'N/A'},${specification.productYear??'N/A'}',
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
                              padding: EdgeInsets.only(bottom: 6.0.w, top: 8.w),
                              child: TitleSmallBoldTextWidget(
                                title:'${specification.length??'N/A'},${specification.micronaire??'N/A'},'
                                    '${specification.apperance??'N/A'},${specification.certification??'N/A'}',
                                color: Colors.black87,
                                size: 10,
                                weight: FontWeight.w500,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 0.w,right: 35.w),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Expanded(
                                    child: BgLightBlueNormalTextWidget(
                                      title: 'RD ${specification.rd}',
                                    ),
                                    flex: 1,
                                  ),
                                  SizedBox(width: 8.w),
                                  Expanded(
                                    child: BgLightBlueNormalTextWidget(
                                      title: 'M ${specification.moisture}',
                                    ),
                                    flex: 1,
                                  ),
                                  SizedBox(width: 8.w),
                                  Expanded(
                                    child: BgLightBlueNormalTextWidget(
                                      title: 'T ${specification.trash}',
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
                                        title: specification.unitCount ?? "N/A",
                                        imageIcon: 'images/img_bag.png',
                                        size: 9.sp,
                                        iconSize: 14,
                                      ),
                                      ShortDetailRenewedWidget(
                                        title: specification.available ?? "N/A",
                                        imageIcon: 'images/img_cone.png',
                                        size: 9.sp,
                                        iconSize: 14,
                                      ),
                                      ShortDetailRenewedWidget(
                                        title: specification.deliveryPeriod ?? "N/A",
                                        imageIcon: 'images/img_van.png',
                                        size: 9.sp,
                                        iconSize: 14,
                                      ),
                                      ShortDetailRenewedWidget(
                                        title: specification.locality ?? "N/A",
                                        imageIcon: 'images/img_location.png',
                                        size: 9.sp,
                                        iconSize: 14,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: 5.h,)
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 6.w, right: 6.w,top: 5.h),
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
                              Text.rich( TextSpan(
                                  children: [
                                    TextSpan(
                                      text: '${specification.priceUnit.toString().replaceAll(RegExp(r'[^a-zA-Z$]'),'')}.',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12.sp,
                                          fontFamily: 'Metropolis',
                                          fontWeight: FontWeight.w400
                                      ),
                                    ),
                                    TextSpan(
                                      text: specification.priceUnit.toString().replaceAll(RegExp(r'[^0-9]'),''),
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 17.sp,
                                          fontFamily: 'Metropolis',
                                          fontWeight: FontWeight.w600
                                      ),
                                    ),
                                    TextSpan(
                                      text: "/kg",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12.sp,
                                          fontFamily: 'Metropolis',
                                          fontWeight: FontWeight.w400
                                      ),
                                    ),
                                  ]
                              )),
                              SizedBox(height: 1.h,),
                              const Center(
                                child: TitleSmallNormalTextWidget(title: "Ex- Factory",size: 7,),
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
                              SizedBox(width: 4.w,),
                              Image.asset(
                                'images/ic_list.png',
                                height: 24.h,
                                width: 24.w,
                              ),
                              SizedBox(width: 4.w,),
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
                          Padding(
                              padding: EdgeInsets.only(left: 4.w, right: 4.w),
                              child: BidNowWidget(title: 'Send Proposal',size: 10.sp,padding: 5,)),

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
                  visible: Ui.showHide(specification.isFeatured),
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
                SizedBox(height: 5.h,),
                Padding(
                  padding: EdgeInsets.only(right: 0.w,bottom: 4.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text.rich(TextSpan(children: [
                        TextSpan(
                          text: "Updated ",
                          style: TextStyle(
                              fontSize: 5.sp, color: Colors.black87,fontWeight: FontWeight.w500),
                        ),
                        TextSpan(
                          text: "Nov 23, 2021",
                          style: TextStyle(
                              fontSize: 5.sp, color: Colors.black87,fontWeight: FontWeight.w500),
                        )
                      ])),

                    ],
                  ),
                )
              ],
            ),
          )
        ],
      )
  );
}
