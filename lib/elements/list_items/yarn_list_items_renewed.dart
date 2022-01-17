import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/elements/list_widgets/bg_light_blue_normal_text_widget.dart';
import 'package:yg_app/elements/list_widgets/bg_light_blue_text_widget.dart';
import 'package:yg_app/elements/list_widgets/bid_now_widget.dart';
import 'package:yg_app/elements/list_widgets/brand_text.dart';
import 'package:yg_app/elements/list_widgets/rating_widget.dart';
import 'package:yg_app/elements/list_widgets/short_detail_widget.dart';
import 'package:yg_app/elements/list_widgets/verified_supplier.dart';
import 'package:yg_app/elements/title_text_widget.dart';
import 'package:yg_app/helper_utils/app_colors.dart';
import 'package:yg_app/helper_utils/app_images.dart';
import 'package:yg_app/helper_utils/ui_utils.dart';
import 'package:yg_app/model/response/yarn_response/yarn_specification_response.dart';

Widget buildYarnRenewedWidget(YarnSpecification specification) {
  return Card(
      color: Colors.white,
      elevation: 18.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14.w),
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
                      const TitleSmallNormalTextWidget(title: "Koh-e-Noor Textile Mills LTD.",color: Colors.black,size: 9,),
                      SizedBox(
                        width: 6.w,
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
                                          '${specification.actualYarnCount}${specification.yarnTwistDirection != null ? "/${specification.yarnTwistDirection}"  :  ""} ${specification.yarnFamily}',
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
                                      title: specification.yarnBlend,
                                      color: Colors.black87,
                                      weight: FontWeight.w600,
                                      size: 12,
                                    ),
                                  ),
                                  flex: 1,
                                ),

                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 6.0.w, top: 8.w),
                              child: TitleSmallBoldTextWidget(
                                title:
                                '${specification.yarnBlend},${specification.yarnFamily != null ? "${specification.yarnDyingMethod ?? "N/A"}," : ""}${specification.yarnDetails ?? "N/A"}',
                                color: Colors.black,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 1.w,right: 40.w),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Expanded(
                                    child: BgLightBlueNormalTextWidget(
                                      title: 'AC ${specification.actualYarnCount}',
                                    ),
                                    flex: 1,
                                  ),
                                  SizedBox(width: 8.w),
                                  Expanded(
                                    child: BgLightBlueNormalTextWidget(
                                      title: 'CLSP ${specification.clsp}',
                                    ),
                                    flex: 1,
                                  ),
                                  SizedBox(width: 8.w),
                                  Expanded(
                                    child: BgLightBlueNormalTextWidget(
                                      title: 'IPI ${specification.actualYarnCount}',
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
                                      ShortDetailWidget(
                                        title: specification.weightBag ?? "N/A",
                                        imageIcon: IC_BAG,
                                      ),
                                      ShortDetailWidget(
                                        title: specification.weightCone ?? "N/A",
                                        imageIcon: IC_BAG,
                                      ),
                                      ShortDetailWidget(
                                        title: specification.deliveryPeriod ?? "N/A",
                                        imageIcon: DELIVERY_PERIOD_IMAGE,
                                      ),
                                      ShortDetailWidget(
                                        title: specification.locality ?? "N/A",
                                        imageIcon: LOCATION_IMAGE,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 6.w, right: 6.w),
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
                                      text: "PKR.",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12.sp,
                                          fontFamily: 'Metropolis',
                                          fontWeight: FontWeight.w400
                                      ),
                                    ),
                                    TextSpan(
                                      text: specification.priceUnit.toString() ,
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
                              const Center(
                                child: TitleSmallNormalTextWidget(title: "Ex- Factory",size: 8,),
                              )
                            ],
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
              Padding(
                padding: EdgeInsets.only(right: 8.w,bottom: 4.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text.rich(TextSpan(children: [
                      TextSpan(
                        text: "Last updated ",
                        style: TextStyle(
                            fontSize: 8.sp, color: Colors.black),
                      ),
                      TextSpan(
                        text: "Nov 23, 4:33 PM",
                        style: TextStyle(
                            fontSize: 8.sp, color: Colors.black),
                      )
                    ])),

                  ],
                ),
              )
            ],
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Visibility(
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
            ),
          )
        ],
      )
  );
}
