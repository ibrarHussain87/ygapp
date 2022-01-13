import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/elements/error_image_widget.dart';
import 'package:yg_app/elements/list_widgets/bg_light_blue_text_widget.dart';
import 'package:yg_app/elements/list_widgets/bid_now_widget.dart';
import 'package:yg_app/elements/list_widgets/brand_text.dart';
import 'package:yg_app/elements/list_widgets/rating_widget.dart';
import 'package:yg_app/elements/list_widgets/short_detail_widget.dart';
import 'package:yg_app/elements/list_widgets/verified_supplier.dart';
import 'package:yg_app/elements/loading_widgets/loading_image_widget.dart';
import 'package:yg_app/elements/title_text_widget.dart';
import 'package:yg_app/helper_utils/app_colors.dart';
import 'package:yg_app/helper_utils/app_images.dart';
import 'package:yg_app/model/response/fiber_response/fiber_specification.dart';

Widget buildFiberProductWidget(Specification specification) {
  return Card(
    color: Colors.white,
    elevation: 18.0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: specification.isFeatured == '1' ? true : false,
          // visible: true,
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
              child: specification.pictures != null &&
                      specification.pictures!.isNotEmpty
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: CachedNetworkImage(
                        width: 48.w,
                        height: 48.w,
                        fit: BoxFit.cover,
                        imageUrl: specification.pictures!.first.picture ?? "",
                        placeholder: (context, url) =>
                            const ImageLoadingWidget(),
                        errorWidget: (context, url, error) =>
                            const ErrorImageWidget(),
                      ),
                    )
                  : const ErrorImageWidget(),
              flex: 1,
            ),
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
                          child: BrandWidget(
                            title: specification.brand,
                          ),
                          flex: 3,
                        ),
                        SizedBox(
                          width: 2.w,
                        ),
                        Expanded(
                            child: Center(
                              child: Visibility(
                                  visible: specification.isVerified == "1"
                                      ? true
                                      : false,
                                  // visible: true,
                                  maintainSize: true,
                                  maintainState: true,
                                  maintainAnimation: true,
                                  child: const VerifiedSupplier()),
                            ),
                            flex: 1),
                        // SizedBox(width: 8.w),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 2.0.w),
                      child: TitleTextWidget(
                        title:
                            '${specification.material},${specification.apperance != null ? "${specification.apperance}/" : ""}${specification.productYear!.substring(0, 4)}',
                      ),
                    ),
                    Row(
                      children: [
                        Text.rich(TextSpan(children: [
                          TextSpan(
                            text: "Last updated ",
                            style:
                                TextStyle(fontSize: 9.sp, color: Colors.black),
                          ),
                          TextSpan(
                            text: "Nov 23, 4:33 PM",
                            style: TextStyle(
                                fontSize: 9.sp, color: updatedDateColor),
                          )
                        ])),
                        SizedBox(
                          width: 8.w,
                        ),
                        ListRatingWidget(
                          rating: "4.5",
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8.w,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: BgLightBlueTextWidget(
                            title: '${specification.length ?? ""} mm',
                          ),
                          flex: 1,
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: BgLightBlueTextWidget(
                            title: '${specification.micronaire ?? ""} mic',
                          ),
                          flex: 1,
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: BgLightBlueTextWidget(
                            title: '${specification.trash ?? ""} %',
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
                                title: specification.priceTerms ?? "N/A",
                                imageIcon: IC_BAG,
                              ),
                              ShortDetailWidget(
                                title: specification.priceUnit ?? "N/A",
                                imageIcon: YARN_ROLL_IMAGE,
                              ),
                              ShortDetailWidget(
                                title: specification.deliveryPeriod ?? "N/A",
                                imageIcon: DELIVERY_PERIOD_IMAGE,
                              ),
                              ShortDetailWidget(
                                title: specification.cityState ?? "N/A",
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
              child: Padding(
                padding: EdgeInsets.only(left: 12.w, right: 6.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        TitleTextWidget(
                          title: specification.priceUnit ?? "N/A",
                        ),
                        TitleSmallTextWidget(title: "Ex- Factory")
                      ],
                    ),
                    SizedBox(
                      height: 12.w,
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
                        padding: EdgeInsets.only(left: 4.w, right: 4.w,bottom: 16.w),
                        child: BidNowWidget(title: 'Update'))
                  ],
                ),
              ),
              flex: 2,
            ),
          ],
        ),
      ],
    ),
  );
}
