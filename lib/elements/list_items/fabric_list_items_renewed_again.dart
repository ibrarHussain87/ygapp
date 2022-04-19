import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:yg_app/elements/list_widgets/bg_light_blue_normal_text_widget.dart';
import 'package:yg_app/elements/list_widgets/bg_light_blue_text_widget.dart';
import 'package:yg_app/elements/list_widgets/bid_now_widget.dart';
import 'package:yg_app/elements/list_widgets/brand_text.dart';
import 'package:yg_app/elements/list_widgets/rating_widget.dart';
import 'package:yg_app/elements/list_widgets/short_detail_renewed_widget.dart';
import 'package:yg_app/elements/list_widgets/short_detail_widget.dart';
import 'package:yg_app/elements/list_widgets/verified_supplier.dart';
import 'package:yg_app/elements/title_text_widget.dart';
import 'package:yg_app/helper_utils/app_colors.dart';
import 'package:yg_app/helper_utils/app_images.dart';
import 'package:yg_app/helper_utils/extensions.dart';
import 'package:yg_app/helper_utils/ui_utils.dart';
import 'package:yg_app/helper_utils/util.dart';
import 'package:yg_app/model/response/fabric_response/fabric_specification_response.dart';
import 'package:yg_app/model/response/yarn_response/yarn_specification_response.dart';
import 'package:intl/intl.dart';
import 'package:yg_app/pages/detail_pages/detail_page/detail_page_renewed.dart';

import '../../helper_utils/app_constants.dart';
import '../../helper_utils/navigation_utils.dart';
import '../elevated_button_widget_2.dart';

Widget buildFabricRenewedAgainWidget(
  FabricSpecification specification,
  BuildContext context,
) {
  var size = MediaQuery.of(context).size;
  double paddingStart = 10;
  double paddingStartFeatured = 20;
  double paddingTop = 15;
  double paddingBottom = 10;
  double paddingEnd = 10;

  return Padding(
    padding: const EdgeInsets.only(left: 8,right: 8,bottom: 6),
    child: Material(
        color: Colors.white,
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          children: [
            Container(
              width: size.width,
              child: Padding(
                padding: EdgeInsets.only(left: specification.isFeatured == '0' ? paddingStart:paddingStartFeatured,right: paddingEnd,top: paddingTop,bottom: paddingBottom),
                child: Container(
                  child: Row(
                    children: [
                      Container(
                        width: size.width*0.65,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  child: Text(
                                    specification.company != null ? specification.company!/*'koh-e-Noor Textile Mills LTD.'*/.capitalize() : Utils.checkNullString(false),
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
                                  width: size.width * 0.40,
                                ),
                                SizedBox(
                                  width: 4.w,
                                ),
                                Visibility(
                                  visible: false,
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text("4.5",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'Metropolis',
                                        ),
                                      ),
                                      SizedBox(width: 2.w,),
                                      Image.asset(ratingIcon,width: 8.w,height: 8.w,)
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 8.w,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 2.w),
                                  child: Visibility(
                                      visible: Ui.showHide(specification.isVerified)/*true*/,
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
                            ),
                            const SizedBox(height: 13,),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                    color: blueContainerLight,
                                    constraints:
                                    const BoxConstraints(maxHeight: 14),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 1),
                                      child: Center(
                                        child: TitleMediumBoldSmallTextWidget(
                                          title: Utils.setFabricFamilyData(specification),
                                          color: Colors.white,
                                          textSize: 12,
                                        ),
                                      ),
                                    )),
                                const SizedBox(width: 2,),
                                Expanded(
                                  child: TitleMediumTextWidget(
                                    title: Utils.setFabricTitle(specification),
                                    color: Colors.black87,
                                    weight: FontWeight.w600,
                                    size: 13,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10,),
                            TitleSmallBoldTextWidget(
                              title: Utils.setFabricDetails(specification),
                              color: Colors.black87,
                              size: 11,
                              weight: FontWeight.w500,
                            ),
                            const SizedBox(height: 8,),
                            Container(
                              width: size.width*0.55,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Expanded(
                                    child: BgLightBlueNormalTextWidget(
                                      title: specification.fabricBlendAbrv ?? specification.fabricBlend??Utils.checkNullString(false),
                                    ),
                                    flex: 1,
                                  ),
                                  SizedBox(width: 8.w),
                                  Expanded(
                                    child: BgLightBlueNormalTextWidget(
                                      title:
                                      specification.fabricQuality ?? Utils.checkNullString(false),
                                    ),
                                    flex: 1,
                                  ),
                                  SizedBox(width: 8.w),
                                  Expanded(
                                    child: BgLightBlueNormalTextWidget(
                                      title:
                                      specification.fabricGrade ?? Utils.checkNullString(false),
                                    ),
                                    flex: 1,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 13.w),
                            Row(
                              children: [
                                Expanded(
                                  child: Wrap(
                                    spacing: 4.0,
                                    runSpacing: 3.0,
                                    children: [
                                      ShortDetailRenewedWidget(
                                        title: specification.weightBag ??
                                            Utils.checkNullString(false),
                                        imageIcon: IC_BAG_RENEWED,
                                        size: 10.sp,
                                        iconSize: 12,
                                      ),
                                      ShortDetailRenewedWidget(
                                        title: specification.weightCone ??
                                            Utils.checkNullString(false),
                                        imageIcon: IC_CONE_RENEWED,
                                        size: 10.sp,
                                        iconSize: 12,
                                      ),
                                      ShortDetailRenewedWidget(
                                        title: specification.deliveryPeriod ??
                                            Utils.checkNullString(false),
                                        imageIcon: IC_VAN_RENEWED,
                                        size: 10.sp,
                                        iconSize: 12,
                                      ),
                                      ShortDetailRenewedWidget(
                                        title: specification.locality == international  ? specification.fabricCountry?.capitalizeAndLower() :specification.locality?.capitalizeAndLower()
                                            /*:Utils.checkNullString(false)*/,
                                        imageIcon: IC_LOCATION_RENEWED,
                                        size: 10.sp,
                                        iconSize: 12,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text.rich(TextSpan(children: [
                                TextSpan(
                                  text:
                                  '${specification.priceUnit.toString().replaceAll(RegExp(r'[^a-zA-Z$]'), '')}.',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12.sp,
                                      fontFamily: 'Metropolis',
                                      fontWeight: FontWeight.w500),
                                ),
                                TextSpan(
                                  text: specification.priceUnit
                                      .toString()
                                      .replaceAll(RegExp(r'[^0-9]'), '')/*'1000'*/,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 17.sp,
                                      fontFamily: 'Metropolis',
                                      fontWeight: FontWeight.w600),
                                ),
                                TextSpan(
                                  text:
                                  "/${specification.unitCount ?? Utils.checkNullString(false)}",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12.sp,
                                      fontFamily: 'Metropolis',
                                      fontWeight: FontWeight.w500),
                                ),
                              ])),
                              SizedBox(
                                height: 1.h,
                              ),
                              const Center(
                                child: TitleSmallNormalTextWidget(
                                  title: "Ex- Factory",
                                  size: 8,
                                ),
                              ),
                              const SizedBox(height: 8,),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text.rich(TextSpan(children: [
                                    TextSpan(
                                      text: "Last Updated",
                                      style: TextStyle(
                                          fontSize: 8.sp, color: Colors.black,fontWeight: FontWeight.w500),
                                    ),
                                  ])),
                                  SizedBox(height: 2.w,),
                                  Text.rich(TextSpan(children: [
                                    TextSpan(
                                      text: /*"Nov 23, 4:33 PM"*/DateFormat("MMM dd, yyyy").format(DateTime.parse(specification.date??"")),
                                      style: TextStyle(
                                          fontSize: 10.sp, color: lightBlueLabel),
                                    )
                                  ])),
                                ],
                              ),
                              const SizedBox(height: 7,),
                              SizedBox(
                                height: 20.h,
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemCount: specification.certifications!.length,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(25),
                                            border: Border.all(color: Colors.grey.shade500)
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(25),
                                          child: Image.network(
                                            specification.certifications![index]
                                                .certification!.icon ??
                                                'images/ic_list.png',
                                            height: 20.w,
                                            width: 20.h,
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                              const SizedBox(height: 7,),

                              FutureBuilder<String>(
                                future: Utils.getUserId(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Padding(
                                        padding: EdgeInsets.only(
                                          left: 4.w, right: 4.w,),
                                        child: GestureDetector(
                                            onTap: () {
                                              /*if (snapshot.data ==
                                                  specification.fsUserId) {
                                                Utils.updateDialog(
                                                  context,
                                                  specification,
                                                  null,
                                                );
                                              }else{
                                                openDetailsScreen(
                                                    context,yarnSpecification: specification,sendProposal: true);
                                              }*/
                                              Fluttertoast.showToast(msg: 'coming soon');
                                            },
                                            child: SizedBox(
                                              width: 80,
                                              height: 22,
                                              child: Center(
                                                child: BidNowWidget(
                                                  title: snapshot.data !=
                                                      specification.fsUserId
                                                      ? 'Send Proposal'
                                                      : "Update",
                                                  size: 10.sp,
                                                  padding: 5,
                                                ),
                                              ),
                                            )));
                                  } else {
                                    return Text(
                                      'Error: ${snapshot.error}',
                                      overflow: TextOverflow.fade,
                                      maxLines: 1,
                                      softWrap: false,
                                    );
                                  }
                                },
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Visibility(
              visible: Ui.showHide(specification.isFeatured),
              child: Positioned.fill(
                left: 0,
                top: 0,
                bottom: 0,
                child: Container(
                  alignment: Alignment.topLeft,
                  child: Image.asset(
                    FEATURED_VERTICAL,
                    width: 13.w,
                    fit: BoxFit.fill,
                    height: double.maxFinite,
                  ),
                )
                /*Container(
                  width: 13.w,
                  *//*height: 80.h,*//*
                  color: Colors.red,
                )*/,
              ),
            ),
          ],
        )
    ),
  );
}

