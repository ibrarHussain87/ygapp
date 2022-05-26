import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
import 'package:yg_app/model/response/yarn_response/yarn_specification_response.dart';
import 'package:intl/intl.dart';
import 'package:yg_app/pages/detail_pages/detail_page/detail_page_renewed.dart';

import '../../helper_utils/app_constants.dart';
import '../../helper_utils/navigation_utils.dart';
import '../elevated_button_widget_2.dart';

Widget buildYarnRenewedAgainWidget(
    YarnSpecification specification, BuildContext context,
    {bool? showCount}) {
  var size = MediaQuery.of(context).size;
  double paddingStart = 10;
  double paddingStartFeatured = 20;
  double paddingTop = 15;
  double paddingBottom = 10;
  double paddingEnd = 10;

  return Padding(
    padding: const EdgeInsets.only(left: 8, right: 8, bottom: 6),
    child: Material(
        color: Colors.white,
        elevation: 10,
        shape: RoundedRectangleBorder(
          side: BorderSide(
              color: border_color,
              width: 1,
              style: BorderStyle.solid
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          children: [
            Container(
              width: size.width,
              child: Padding(
                padding: EdgeInsets.only(
                    left: specification.is_featured == '0'
                        ? paddingStart
                        : paddingStartFeatured,
                    right: paddingEnd,
                    top: paddingTop,
                    bottom: paddingBottom),
                child: Container(
                  child: Row(
                    children: [
                      Container(
                        width: size.width * 0.65,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  child: Text(
                                    specification.company != null
                                        ? specification
                                            .company! /*'koh-e-Noor Textile Mills LTD.'*/
                                            .capitalize()
                                        : Utils.checkNullString(false),
                                    overflow: TextOverflow.fade,
                                    maxLines: 1,
                                    softWrap: false,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      // /*fontFamily: 'Metropolis',*/,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "4.5",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                          // /*fontFamily: 'Metropolis',*/,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 2.w,
                                      ),
                                      Image.asset(
                                        ratingIcon,
                                        width: 8.w,
                                        height: 8.w,
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 8.w,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 2.w),
                                  child: Visibility(
                                      visible: Ui.showHide(
                                          specification.is_verified) /*true*/,
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
                            const SizedBox(
                              height: 13,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                    color: blueContainerLight,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 1),
                                      child: Center(
                                        child: TitleMediumBoldSmallTextWidget(
                                          title: Utils.setFamilyData(
                                              specification),
                                          color: Colors.white,
                                          textSize: 12,
                                        ),
                                      ),
                                    )),
                                const SizedBox(
                                  width: 2,
                                ),
                                Expanded(
                                  child: TitleMediumTextWidget(
                                    title: Utils.setTitleData(specification),
                                    /*title: 'Greige,wrap'.toUpperCase(),*/
                                    color: Colors.black87,
                                    weight: FontWeight.w600,
                                    size: 13,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TitleSmallBoldTextWidget(
                              title: Utils.setDetailsData(specification),
                              /*title:'Weaving,Ring Frame,Carded,Regular',*/
                              color: Colors.black87,
                              size: 11,
                              weight: FontWeight.w500,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Container(
                              width: size.width * 0.55,
                              child: specification.yarnFamilyId != "4"
                                  ? Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Expanded(
                                          child: BgLightBlueNormalTextWidget(
                                            title:
                                                'AC ${specification.actualYarnCount ?? ""}',
                                          ),
                                          flex: 1,
                                        ),
                                        SizedBox(width: 8.w),
                                        Expanded(
                                          child: BgLightBlueNormalTextWidget(
                                            title:
                                                'CLSP ${specification.clsp ?? ""}',
                                          ),
                                          flex: 1,
                                        ),
                                        SizedBox(width: 8.w),
                                        Expanded(
                                          child: BgLightBlueNormalTextWidget(
                                            title:
                                                'IPI ${specification.ys_ipm_km ?? ""}',
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
                                            title: specification.yarnType ?? "",
                                          ),
                                          flex: 1,
                                        ),
                                        SizedBox(width: 8.w),
                                        Expanded(
                                          child: BgLightBlueNormalTextWidget(
                                            title:
                                                specification.yarnQuality ?? "",
                                          ),
                                          flex: 1,
                                        ),
                                        SizedBox(width: 8.w),
                                        Expanded(
                                          child: BgLightBlueNormalTextWidget(
                                            title:
                                                specification.yarnGrade ?? "",
                                          ),
                                          flex: 1,
                                        ),
                                      ],
                                    ),
                            ),
                            SizedBox(height: 13.w),
                            Visibility(
                              visible: specification.is_offering == offering_type,
                              child: Row(
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
                                        Visibility(
                                          visible: specification.locality != local,
                                          child: ShortDetailRenewedWidget(
                                            title: /*specification.locality ==
                                                    international
                                                ? */specification.yarn_country?.capitalizeAndLower()
                                                /*: specification.locality
                                                    ?.capitalizeAndLower()*/ /*:Utils.checkNullString(false)*/,
                                            imageIcon: IC_LOCATION_RENEWED,
                                            size: 10.sp,
                                            iconSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Visibility(
                              visible: showCount ?? false,
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: 0.w,
                                    right: 18.w,
                                    top: 8.w,
                                    bottom: 0.w),
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: greenButton,
                                                  width:
                                                      1, //                   <--- border width here
                                                ),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(4.w))),
                                            child: Stack(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 6.w),
                                                  child: Center(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: [
                                                        Text(
                                                          'Proposals',
                                                          style: TextStyle(
                                                              fontSize: 9.sp,
                                                              color: Colors
                                                                  .black87,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                        ),
                                                        Text(
                                                          specification
                                                              .proposalCount
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontSize: 9.sp,
                                                              color:
                                                                  greenButton,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700),
                                                        ),
                                                        // SizedBox(
                                                        //   width: 3.w,
                                                        // )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                // Align(
                                                //     alignment: AlignmentDirectional.topEnd,
                                                //     child: Padding(
                                                //       padding: const EdgeInsets.all(2),
                                                //       child: Container(
                                                //         width: 10,
                                                //         height: 10,
                                                //         decoration: BoxDecoration(
                                                //             color: redColor,
                                                //             borderRadius: BorderRadius.all(
                                                //                 Radius.circular(10.w))),
                                                //         child: Center(
                                                //           child: Text(
                                                //             specification.proposalCount.toString(),
                                                //             textAlign: TextAlign.center,
                                                //             style: TextStyle(
                                                //                 fontSize: 8.sp,
                                                //                 color: Colors.white,
                                                //                 fontWeight: FontWeight.w400),
                                                //           ),
                                                //         ),
                                                //       ),
                                                //     ))
                                              ],
                                            ))),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    Expanded(
                                        child: Container(
                                            decoration: BoxDecoration(
                                                /*color: lightYellowContainer,*/
                                                border: Border.all(
                                                  color: greenButton,
                                                  width:
                                                      1, //                   <--- border width here
                                                ),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(4.w))),
                                            child: Stack(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 6.w),
                                                  child: Center(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: [
                                                        Text(
                                                          'Matches',
                                                          style: TextStyle(
                                                              fontSize: 9.sp,
                                                              color: Colors
                                                                  .black87,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                        ),
                                                        Text(
                                                          specification
                                                              .matchedCount
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontSize: 9.sp,
                                                              color:
                                                                  greenButton,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700),
                                                        ),
                                                        // SizedBox(
                                                        //   width: 3.w,
                                                        // )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                // Align(
                                                //     alignment: AlignmentDirectional.topEnd,
                                                //     child: Padding(
                                                //       padding: const EdgeInsets.all(2),
                                                //       child: Container(
                                                //         width: 10,
                                                //         height: 10,
                                                //         decoration: BoxDecoration(
                                                //             color: redColor,
                                                //             borderRadius: BorderRadius.all(
                                                //                 Radius.circular(10.w))),
                                                //         child: Center(
                                                //           child: Text(
                                                //             '3',
                                                //             textAlign: TextAlign.center,
                                                //             style: TextStyle(
                                                //                 fontSize: 8.sp,
                                                //                 color: Colors.white,
                                                //                 fontWeight: FontWeight.w400),
                                                //           ),
                                                //         ),
                                                //       ),
                                                //     ))
                                              ],
                                            ))),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Column(
                              children: [
                                Visibility(
                                  visible: specification.is_offering == offering_type,
                                  child: Text.rich(TextSpan(children: [
                                    TextSpan(
                                      text:
                                          '${specification.priceUnit.toString().replaceAll(RegExp(r'[^a-zA-Z$]'), '')}.',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12.sp,
                                          // /*fontFamily: 'Metropolis',*/,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    TextSpan(
                                      text: specification.priceUnit
                                          .toString()
                                          .replaceAll(
                                              RegExp(r'[^0-9]'), '') /*'1000'*/,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 17.sp,
                                          // /*fontFamily: 'Metropolis',*/,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    TextSpan(
                                      text:
                                          "/${specification.unitCount ?? Utils.checkNullString(false)}",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12.sp,
                                          // /*fontFamily: 'Metropolis',*/,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ])),
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                              ],
                            ),

                             Center(
                              child: TitleSmallNormalTextWidget(
                                title: "Ex- Factory"/*specification.deliveryPeriod*/,
                                size: 8,
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text.rich(TextSpan(children: [
                                  TextSpan(
                                    text: "Last Updated",
                                    style: TextStyle(
                                        fontSize: 8.sp,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ])),
                                SizedBox(
                                  height: 2.w,
                                ),
                                Text.rich(TextSpan(children: [
                                  TextSpan(
                                    text: /*"Nov 23, 4:33 PM"*/ DateFormat(
                                            "MMM dd, yyyy")
                                        .format(DateTime.parse(
                                            specification.date ?? "")),
                                    style: TextStyle(
                                        fontSize: 10.sp,
                                        color: lightBlueLabel),
                                  )
                                ])),
                              ],
                            ),
                            const SizedBox(
                              height: 7,
                            ),
                            Visibility(
                              visible: specification.is_offering == offering_type,
                              child: SizedBox(
                                height: 20.h,
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemCount:
                                        specification.certifications!.length,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(25),
                                            border: Border.all(
                                                color: Colors.grey.shade500)),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(25),
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
                            ),
                            const SizedBox(
                              height: 7,
                            ),
                            FutureBuilder<String>(
                              future: Utils.getUserId(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Padding(
                                      padding: EdgeInsets.only(
                                        left: 4.w,
                                        right: 4.w,
                                      ),
                                      child: GestureDetector(
                                          onTap: () {
                                            if (snapshot.data ==
                                                specification.ys_user_id) {
                                              Utils.updateDialog(context,
                                                  specification, null, null);
                                            } else {
                                              openDetailsScreen(context,
                                                  yarnSpecification:
                                                      specification,
                                                  sendProposal: true);
                                            }
                                          },
                                          child: SizedBox(
                                            width: 80,
                                            height: 22,
                                            child: Center(
                                              child: BidNowWidget(
                                                title: snapshot.data !=
                                                        specification
                                                            .ys_user_id
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
                      )
                    ],
                  ),
                ),
              ),
            ),
            Visibility(
              visible: Ui.showHide(specification.is_featured),
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
                  */ /*height: 80.h,*/ /*
                  color: Colors.red,
                )*/
                ,
              ),
            ),
          ],
        )),
  );
}

/*String setFamilyData(YarnSpecification specification){
  String familyData = "";
  switch (specification.yarnFamilyId) {
    case '1':
      familyData = '${specification.count??Utils.checkNullString(false)}${specification.yarnPly != null ? "/${specification.yarnPly!.substring(0,1)}"  :  ""} ${specification.yarnFamily??''}';
      break;
      case '2':
        familyData = '${specification.count??Utils.checkNullString(false)}${specification.yarnPly != null ? "/${specification.yarnPly!.substring(0,1)}"  :  ""} ${specification.bln_abrv??''}';
      break;
      case '3':
      familyData = '${specification.count??Utils.checkNullString(false)}${specification.yarnPly != null ? "/${specification.yarnPly!.substring(0,1)}"  :  ""} ${specification.yarnFamily??''}';
      break;
      case '4':
        familyData = '${specification.dtyFilament ?? ""}${specification.fdyFilament != null ? "/${specification.fdyFilament}" : ""} ${specification.yarnFamily??''}';
      break;
      case '5':
      familyData = '${specification.count??Utils.checkNullString(false)}${specification.yarnPly != null ? "/${specification.yarnPly!.substring(0,1)}"  :  ""} ${specification.yarnFamily??''}';
      break;
  }
  return familyData;
}

String setTitleData(YarnSpecification specification){
  String titleData = "";
  switch (specification.yarnFamilyId) {
    case '1':
      titleData = '${specification.yq_abrv??specification.yarnQuality??Utils.checkNullString(false)} for ${specification.yarnUsage??Utils.checkNullString(false)}';
      break;
      case '2':
      titleData = specification.count??Utils.checkNullString(false);
      break;
      case '3':
      titleData = specification.yarnOrientation??Utils.checkNullString(false);
      break;
      case '4':
      titleData = specification.yarnType??Utils.checkNullString(false);
      break;
      case '5':
      titleData = specification.bln_abrv??specification.yarnBlend??Utils.checkNullString(false);
      break;
  }
  return titleData;
}

String setDetailsData(YarnSpecification specification){
  String detailsData = "";
  switch (specification.yarnFamilyId) {
    case '1':
      detailsData = '${specification.yarnQuality??Utils.checkNullString(false)}${specification.yarnSpunTechnique!= null ?  ',${specification.yarnSpunTechnique}':Utils.checkNullString(true)}${specification.yarnColorTreatmentMethod!= null ?  ',${specification.yarnColorTreatmentMethod}':Utils.checkNullString(true)}${specification.doublingMethod!= null ?  ',${specification.doublingMethod}':Utils.checkNullString(true)}';
      break;
      case '2':
      detailsData = '${specification.yarnOrientation??Utils.checkNullString(false)}${specification.yarnSpunTechnique!= null ?  ',${specification.yarnSpunTechnique}':Utils.checkNullString(true)}${specification.yarnColorTreatmentMethod!= null ?  ',${specification.yarnColorTreatmentMethod}':Utils.checkNullString(true)}${specification.doublingMethod!= null ?  ',${specification.doublingMethod}':Utils.checkNullString(true)}';
      break;
      case '3':
      detailsData = '${specification.yarnSpunTechnique??Utils.checkNullString(false)}${specification.yarnColorTreatmentMethod!= null ?  ',${specification.yarnColorTreatmentMethod}':Utils.checkNullString(true)}${specification.doublingMethod!= null ?  ',${specification.doublingMethod}':Utils.checkNullString(true)}';
      break;
      case '4':
      detailsData = '${specification.yarnColorTreatmentMethod??Utils.checkNullString(false)}${specification.yarnApperance!= null ?  ',${specification.yarnApperance}':Utils.checkNullString(true)}${specification.doublingMethod!= null ?  ',${specification.doublingMethod}':Utils.checkNullString(true)}${specification.yarnGrade!= null ?  ',${specification.yarnGrade}':Utils.checkNullString(true)}';
      break;
      case '5':
      detailsData = '${specification.yarnSpunTechnique??Utils.checkNullString(false)}${specification.yarnColorTreatmentMethod!= null ?  ',${specification.yarnColorTreatmentMethod}':Utils.checkNullString(true)}${specification.yarnPattern!= null ?  ',${specification.yarnPattern}':Utils.checkNullString(true)}';*/ /*,${specification.doublingMethod??Utils.checkNullString(false)}*/ /*
      break;
  }
  return detailsData;
}*/
