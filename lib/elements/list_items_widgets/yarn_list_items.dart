import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/helper_utils/app_images.dart';
import 'package:yg_app/model/response/yarn_response/yarn_specification_response.dart';
import 'package:yg_app/helper_utils/app_colors.dart';
import 'package:yg_app/elements/error_image_widget.dart';
import 'package:yg_app/elements/list_widgets/bid_now_widget.dart';
import 'package:yg_app/elements/list_widgets/brand_text.dart';
import 'package:yg_app/elements/list_widgets/bg_light_blue_text_widget.dart';
import 'package:yg_app/elements/list_widgets/rating_widget.dart';
import 'package:yg_app/elements/list_widgets/short_detail_widget.dart';
import 'package:yg_app/elements/list_widgets/verified_supplier.dart';
import 'package:yg_app/elements/loading_widgets/loading_image_widget.dart';
import 'package:yg_app/elements/title_text_widget.dart';

Widget buildYarnWidget(YarnSpecification specification) {
  return Card(
      color: Colors.white,
      elevation: 18.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Visibility(
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
                      topLeft: Radius.circular(16.w),
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
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                  child: specification.pictures.isNotEmpty
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: CachedNetworkImage(
                            width: 48.w,
                            height: 48.w,
                            fit: BoxFit.cover,
                            imageUrl: specification.pictures.first.toString(),
                            placeholder: (context, url) => ImageLoadingWidget(),
                            errorWidget: (context, url, error) =>
                                ErrorImageWidget(),
                          ),
                        )
                      : ErrorImageWidget()),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 8.w, bottom: 8.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: TitleTextWidget(
                              title: specification.yarnBlend,
                            ),
                            flex: 3,
                          ),
                          SizedBox(
                            width: 2.w,
                          ),
                          Expanded(
                              child: Center(
                                child: Visibility(
                                    visible: true,
                                    maintainSize: true,
                                    maintainState: true,
                                    maintainAnimation: true,
                                    child: Container(child: VerifiedSupplier())),
                              ),
                              flex: 1),
                          // SizedBox(width: 8.w),
                        ],
                      ),

                      Row(
                        children: [
                          Text.rich(
                              TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "Last updated ",
                                      style: TextStyle(
                                          fontSize: 9.sp,
                                          color: Colors.black
                                      ),
                                    ),
                                    TextSpan(
                                      text: "Nov 23, 4:33PM",
                                      style: TextStyle(
                                          fontSize: 9.sp,
                                          color: updatedDateColor
                                      ),
                                    )

                                  ]
                              )
                          ),
                          SizedBox(
                            width: 8.w,
                          ),
                          ListRatingWidget(
                            rating: "4.5",
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 8.0.w,top: 8.w),
                        child: TitleSmallTextWidget(
                          title:
                          '${specification.yarnBlend},${specification.yarnFamily != null ? "${specification.yarnDyingMethod??"N/A"}," : ""}${specification.yarnDetails??"N/A"}',
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: BgLightBlueTextWidget(
                              title: 'AC ${specification.actualYarnCount}',
                            ),
                            flex: 1,
                          ),
                          SizedBox(width: 8.w),
                          Expanded(
                            child: BgLightBlueTextWidget(
                              title: 'CLSP ${specification.clsp}',
                            ),
                            flex: 1,
                          ),
                          SizedBox(width: 8.w),
                          Expanded(
                            child: BgLightBlueTextWidget(
                              title: 'IPI ${specification.actualYarnCount}',
                            ),
                            flex: 1,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8.w,
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
                flex: 4,
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(left: 6.w, right: 6.w),
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          TitleTextWidget(
                            title: "PKR." + specification.priceUnit.toString() +"/KG",
                          ),
                          TitleSmallTextWidget(title: "Ex- Factory")
                        ],
                      ),
                      SizedBox(
                        height: 16.w,
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
                          Image.asset(
                            'images/ic_list.png',
                            height: 24.h,
                            width: 24.w,
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
                      Padding(
                          padding: EdgeInsets.only(left: 4.w, right: 4.w),
                          child: BidNowWidget(title: 'Bid Now'))
                    ],
                  ),
                ),
                flex: 2,
              ),
            ],
          ),
        ],
      ));
}