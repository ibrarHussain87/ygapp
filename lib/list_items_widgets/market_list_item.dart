import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/model/response/fiber_response/fiber_specification.dart';
import 'package:yg_app/utils/colors.dart';
import 'package:yg_app/widgets/list_widgets/bid_now_widget.dart';
import 'package:yg_app/widgets/list_widgets/brand_text.dart';
import 'package:yg_app/widgets/list_widgets/gray_text_widget.dart';
import 'package:yg_app/widgets/list_widgets/rating_widget.dart';
import 'package:yg_app/widgets/list_widgets/short_detail_widget.dart';
import 'package:yg_app/widgets/list_widgets/verified_supplier.dart';
import 'package:yg_app/widgets/title_text_widget.dart';

Widget buildWidget(Specification specification) {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Visibility(
            visible: specification.isFeatured == '1' ? true : false,
            child: Container(
                color: AppColors.pintFeatureClr,
                child: Padding(
                  padding: EdgeInsets.only(
                      left: 6.w, top: 1.w, bottom: 1.w, right: 2.w),
                  child: Row(
                    children: [
                      Text(
                        'Featured'.toUpperCase(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 6.sp,
                          fontFamily: 'Metropolis',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 4.w),
                        child: Icon(
                          Icons.info_rounded,
                          size: 8.w,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                )),
          ),
          Visibility(visible: specification.isVerified == "1" ? true: false,child: VerifiedSupplier()),
        ],
      ),
      Padding(
        padding: EdgeInsets.only(top: 4.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            specification.pictures.isNotEmpty ? CachedNetworkImage(
              width: 56.w,
              height: 56.w,
              fit: BoxFit.cover,
              imageUrl: specification.pictures.first.picture,
              placeholder: (context, url) =>
                  Image.asset('images/ic_loading.png'),
              errorWidget: (context, url, error) =>
                  Image.asset('images/image_not_available.png',height: 56.w,width: 56.w,fit: BoxFit.cover),
            ) :Image.asset('images/image_not_available.png',height: 56.w,width: 56.w,fit: BoxFit.cover,),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 4.w),
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
                        SizedBox(width: 2.w,),
                        Expanded(
                            child: Center(
                              child: ListRatingWidget(
                                rating: "4.5",
                              ),
                            ),
                            flex: 1),
                        // SizedBox(width: 8.w),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 4.0.w),
                      child: TitleTextWidget(
                        title:
                            '${specification.material},${specification.apperance != null ? "${specification.apperance}/" : ""}${specification.productYear!.substring(0, 4)}',
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: GreyTextWidget(
                            title: '${specification.length} mm',
                          ),
                          flex: 1,
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: GreyTextWidget(
                            title: '${specification.micronaire} mic',
                          ),
                          flex: 1,
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: GreyTextWidget(
                            title: '${specification.trash} %',
                          ),
                          flex: 1,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 4.w,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Wrap(
                            spacing: 4.0,
                            runSpacing: 3.0,
                            children: [
                              ShortDetailWidget(title: specification.unitCount),
                              ShortDetailWidget(title: specification.priceUnit),
                              ShortDetailWidget(
                                  title: specification.deliveryPeriod),
                              ShortDetailWidget(title: specification.minQuantity),
                              ShortDetailWidget(title: specification.minQuantity),
                              ShortDetailWidget(title: specification.minQuantity),
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
                padding: EdgeInsets.only(left: 12.w,right: 6.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TitleTextWidget(
                      title: specification.priceUnit,
                    ),
                    SizedBox(height: 8.w,),
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
                    SizedBox(height: 8.w,),
                    Padding(
                      padding: EdgeInsets.only(left: 4.w,right: 4.w),
                        child: BidNowWidget(title: 'Bid Now'))
                  ],
                ),
              ),
              flex: 2,
            ),
          ],
        ),
      ),
      SizedBox(height: 8.w,)
    ],
  );
}
