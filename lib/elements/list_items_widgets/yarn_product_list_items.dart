import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/elements/list_widgets/bg_light_blue_text_widget.dart';
import 'package:yg_app/elements/list_widgets/bid_now_widget.dart';
import 'package:yg_app/elements/list_widgets/bid_now_widget_modified.dart';
import 'package:yg_app/elements/list_widgets/rating_widget.dart';
import 'package:yg_app/elements/list_widgets/short_detail_widget.dart';
import 'package:yg_app/elements/list_widgets/verified_supplier.dart';
import 'package:yg_app/elements/title_text_widget.dart';
import 'package:yg_app/helper_utils/app_colors.dart';
import 'package:yg_app/helper_utils/app_images.dart';
import 'package:yg_app/helper_utils/ui_utils.dart';
import 'package:yg_app/model/response/yarn_response/yarn_specification_response.dart';

Widget buildYarnProductWidget(YarnSpecification specification) {
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
          Align(
            alignment: AlignmentDirectional.topEnd,
            child: Visibility(
              visible: true,
              maintainSize: true,
              maintainState: true,
              maintainAnimation: true,
              child: Container(
                  width: 48.w,
                  padding: EdgeInsets.all(3.w),
                  decoration: BoxDecoration(
                      color: btnGreen,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(16.w),
                      )),
                  child: Text(
                    'Active',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 6.sp,
                      fontFamily: 'Metropolis',
                      fontWeight: FontWeight.bold,
                    ),
                  )),
            ),
          ),
          SizedBox(height: 2.w,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /*Expanded(
                  flex: 1,
                  child: *//*specification.pictures.isNotEmpty
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
                      : ErrorImageWidget())*//*
                      Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(16)),
                        color: Colors.grey.shade200),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset(
                          YARN_LIST_IMAGE,
                          width: 54.w,
                        ),
                        Center(
                            child: Column(
                          children: [
                            TitleExtraSmallTextWidget(
                              title:
                              '${specification.actualYarnCount}${specification.yarnTwistDirection != null ? " / ${specification.yarnTwistDirection}"  :  ""}',
                              color: Colors.white,
                            ),
                            TitleExtraSmallTextWidget(
                              title: specification.yarnFamily,
                              color: Colors.white,
                              textSize: 5.sp,
                            ),
                          ],
                        ))
                      ],
                    ),
                  )),*/
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 18.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           Container(
                            color: blueBackgroundColor,
                              constraints: BoxConstraints(maxHeight: 15),
                              child: Padding(
                                padding: const EdgeInsets.all(3),
                                child: Center(
                                  child: TitleExtraSmallTextWidget(
                                    title:
                                    '${specification.actualYarnCount}${specification.yarnTwistDirection != null ? "/${specification.yarnTwistDirection}"  :  ""} ${specification.yarnFamily}',
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            ),
                          SizedBox(width: 2.w,),
                          Expanded(
                            child: TitleTextWidget(
                              title: specification.yarnBlend,
                            ),
                            flex: 1,
                          ),
                          SizedBox(
                            width: 2.w,
                          ),
                          Center(
                                child: Visibility(
                                    visible: Ui.showHide(specification.is_verified),
                                    maintainSize: true,
                                    maintainState: true,
                                    maintainAnimation: true,
                                    child: VerifiedSupplier()),
                              ),
                          // SizedBox(width: 8.w),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 8.0.w, top: 8.w),
                        child: TitleSmallTextWidget(
                          title:
                              '${specification.yarnBlend},${specification.yarnFamily != null ? "${specification.yarnDyingMethod ?? "N/A"}," : ""}${specification.yarnDetails ?? "N/A"}',
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
                            title: "PKR." +
                                specification.priceUnit.toString() +
                                "/KG",
                          ),
                          const TitleSmallTextWidget(title: "Ex- Factory"),
                          SizedBox(height: 3.w,),
                          Text.rich(TextSpan(children: [
                            TextSpan(
                              text: "Updated",
                              style: TextStyle(
                                  fontSize: 9.sp, color: Colors.black),
                            ),
                          ])),
                          SizedBox(height: 3.w,),
                          Text.rich(TextSpan(children: [
                            TextSpan(
                              text: "Nov 23, 4:33 PM",
                              style: TextStyle(
                                  fontSize: 9.sp, color: updatedDateColor),
                            )
                          ])),
                          SizedBox(height: 8.w,),
                          Text.rich(TextSpan(children: [
                            TextSpan(
                              text: "Avail. Quantity",
                              style: TextStyle(
                                  fontSize: 9.sp, color: Colors.black),
                            ),
                          ])),
                          SizedBox(height: 3.w,),
                          Text.rich(TextSpan(children: [
                            TextSpan(
                              text: "325",
                              style: TextStyle(
                                  fontSize: 9.sp, color: updatedDateColor),
                            )
                          ])),
                        ],
                      ),
                    ],
                  ),
                ),
                flex: 2,
              ),

            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.w,vertical: 6.w),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: btnGreen,
                        borderRadius:
                        BorderRadius.all(Radius.circular(2.w))),
                    child: Padding(
                      padding: EdgeInsets.only(top: 6.w,bottom: 6.w),
                      child: Center(
                        child: Text(
                          'Proposals',
                          style: TextStyle(
                              fontSize: 11.sp, color: Colors.white,fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                  )
                ),
                SizedBox(width: 10.w,),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: btnGreen,
                        borderRadius:
                        BorderRadius.all(Radius.circular(2.w))),
                    child: Padding(
                      padding: EdgeInsets.only(top: 6.w,bottom: 6.w),
                      child: Center(
                        child: Text(
                          'Matches',
                          style: TextStyle(
                              fontSize: 11.sp, color: Colors.white,fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                  )
                ),
                SizedBox(width: 60.w,),
                Expanded(
                  child: BidNowWidgetModified(title: 'Update')
                )
              ],
            ),
          )
        ],
      ));
}
