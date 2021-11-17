import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/model/response/fiber_response/fiber_specification.dart';
import 'package:yg_app/utils/colors.dart';
import 'package:yg_app/widgets/list_widgets/bid_now_widget.dart';
import 'package:yg_app/widgets/list_widgets/brand_text.dart';
import 'package:yg_app/widgets/list_widgets/gray_text_widget.dart';
import 'package:yg_app/widgets/list_widgets/list_title_widget.dart';
import 'package:yg_app/widgets/list_widgets/rating_widget.dart';
import 'package:yg_app/widgets/list_widgets/short_detail_widget.dart';
import 'package:yg_app/widgets/list_widgets/verified_supplier.dart';
import 'package:yg_app/widgets/title_text_widget.dart';

Widget buildWidget(Specification specification) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Container(
        color: AppColors.pintFeatureClr,
        child: Padding(
          padding:
              EdgeInsets.only(left: 8.w, right: 8.w, top: 2.w, bottom: 2.w),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Featured',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 9.sp,
                  fontWeight: FontWeight.normal,
                ),
              ),
              Icon(
                Icons.info_rounded,
                size: 12.w,
                color: Colors.white,
              )
            ],
          ),
        ),
      ),
      SizedBox(
        height: 4.w,
      ),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Padding(
              child: CachedNetworkImage(
                imageUrl: "https://cdn.sanity.io/images/0vv8moc6/contobgyn/d198c3b708a35d9adcfa0435ee12fe454db49662-640x400.png",
                placeholder: (context, url) =>  Image.asset('images/image_not_available.png'),
                errorWidget: (context, url, error) =>  Icon(Icons.error),
                width: 124.w,
              ),

              padding: EdgeInsets.only(left: 4.w),
            ),
            flex: 2,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 8.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: BrandWidget(
                          title: specification.brand,
                        ),
                        flex: 2,
                      ),
                      Expanded(
                        child: Center(
                          child: ListRatingWidget(
                            rating: "4.5",
                          ),
                        ),
                        flex: 1
                      ),
                      // SizedBox(width: 8.w),
                      VerifiedSupplier(),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 4.0.w),
                    child: ListTitleTextWidget(
                      title:
                          '${specification.material},${specification.apperance != null?"${specification.apperance}/":""}${specification.productYear!.substring(0, 4)}',
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
                    height: 8.w,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: Wrap(
                          children: [
                            ShortDetailWidget(
                                title: specification.unitCount),
                            ShortDetailWidget(
                                title: specification.priceUnit),
                            ShortDetailWidget(
                                title: specification.deliveryPeriod),
                            ShortDetailWidget(
                                title: specification.minQuantity),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            flex: 5,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 16.w, right: 8.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.max,
                children: [
                  TitleTextWidget(
                    title: 'PKR.${specification.priceUnit}',
                  ),
                  SizedBox(height:6.w,),
                  Row(
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
                  SizedBox(height:8.w,),
                  BidNowWidget(title: 'Bid Now')
                ],
              ),
            ),
            flex: 3,
          ),
        ],
      ),
    ],
  );
}
