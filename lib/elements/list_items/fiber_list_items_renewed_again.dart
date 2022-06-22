import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:yg_app/elements/list_widgets/bg_light_blue_normal_text_widget.dart';
import 'package:yg_app/elements/list_widgets/bid_now_widget.dart';
import 'package:yg_app/elements/list_widgets/short_detail_renewed_widget.dart';
import 'package:yg_app/elements/text_widgets.dart';
import 'package:yg_app/helper_utils/app_colors.dart';
import 'package:yg_app/helper_utils/app_images.dart';
import 'package:yg_app/helper_utils/extensions.dart';
import 'package:yg_app/helper_utils/ui_utils.dart';
import 'package:yg_app/helper_utils/util.dart';
import 'package:yg_app/model/response/fiber_response/fiber_specification.dart';

import '../../helper_utils/app_constants.dart';
import '../../helper_utils/navigation_utils.dart';
import '../../model/response/list_bid_response.dart';

Widget buildFiberRenewedAgainWidget(
    Specification specification, BuildContext context,
    {bool? showCount,bool? showDetailsButton=false,BidData? bidData}) {
  var size = MediaQuery.of(context).size;
  double paddingStart = 14;
  double paddingStartFeatured = 20;
  double paddingTop = 10;
  double paddingBottom = 10;
  double paddingEnd = 10;

  return Padding(
    padding: const EdgeInsets.only(left: 8, right: 8, bottom: 6),
    child: Material(
        color: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          side: BorderSide(
              color: newColorGrey,
              width: 1,
              style: BorderStyle.solid
          ),
          borderRadius: showDetailsButton == false ? BorderRadius.circular(10) :
          const BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10)),
        ),
        child: Stack(
          children: [
            SizedBox(
              width: size.width,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: specification.isFeatured == '0'
                            ? paddingStart
                            : paddingStartFeatured,
                        right: paddingEnd,
                        top: paddingTop,
                        bottom: paddingBottom),
                    child: Row(
                      children: [
                        SizedBox(
                          width: size.width * 0.63,
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
                                        /**/
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
                                            /**/
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
                                            specification.isVerified) /*true*/,
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
                                height: 8,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                      color: blueContainerLight,
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5, vertical: 1),
                                          child: TitleMediumBoldSmallTextWidget(
                                            title:
                                            '${specification.formation!.isNotEmpty ? specification.formation!.first.blendName : ""}',
                                            color: Colors.white,
                                            textSize: 11,
                                          ),
                                        ),
                                      )),
                                  const SizedBox(
                                    width: 2,
                                  ),
                                  Expanded(
                                    child: TitleMediumTextWidget(
                                      title: Utils.getFiberTitle(specification),
                                      /*title: 'Greige,wrap'.toUpperCase(),*/
                                      color: Colors.black87,
                                      weight: FontWeight.w600,
                                      size: 13,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              TitleSmallBoldTextWidget(
                                title: Utils.getFiberSubtitle(specification),
                                /*title:'Weaving,Ring Frame,Carded,Regular',*/
                                color: Colors.black87,
                                size: 12,
                                weight: FontWeight.w500,
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              SizedBox(
                                width: size.width * 0.55,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Expanded(
                                      child: BgLightBlueNormalTextWidget(
                                        title: specification.nature_id == '2'
                                            ? 'FL ${specification.length ?? ""}'
                                            : 'FL ${specification.length ?? ""}',
                                      ),
                                      flex: 1,
                                    ),
                                    SizedBox(width: 8.w),
                                    Expanded(
                                      child: BgLightBlueNormalTextWidget(
                                        title: specification.nature_id == '2'
                                            ? 'Mic ${specification.micronaire ?? ""}'
                                            : 'Mic ${specification.micronaire ?? ""}',
                                      ),
                                      flex: 1,
                                    ),
                                    SizedBox(width: 8.w),
                                    Expanded(
                                      child: BgLightBlueNormalTextWidget(
                                        title: specification.nature_id == '2'
                                            ? 'T ${specification.trash ?? ""}'
                                            : 'GD ${specification.grade ?? ""}',
                                      ),
                                      flex: 1,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 8.w),
                              Row(
                                children: [
                                  Expanded(
                                    child: Wrap(
                                      spacing: 4.0,
                                      runSpacing: 3.0,
                                      children: [
                                        ShortDetailRenewedWidget(
                                          title: specification.unitCount ??
                                              Utils.checkNullString(false),
                                          imageIcon: IC_BAG_RENEWED,
                                          size: 10.sp,
                                          iconSize: 12,
                                        ),
                                        ShortDetailRenewedWidget(
                                          title: specification.available ??
                                              Utils.checkNullString(false),
                                          imageIcon: IC_CONE_RENEWED,
                                          size: 10.sp,
                                          iconSize: 12,
                                        ),
                                        ShortDetailRenewedWidget(
                                          title: specification.deliveryPeriod == "No Of Days" ? "${specification.fbp_no_of_days??"0"} Days" : specification.deliveryPeriod,
                                          imageIcon: IC_VAN_RENEWED,
                                          size: 10.sp,
                                          iconSize: 12,
                                        ),
                                        Visibility(
                                          visible: specification.locality != local,
                                          child: ShortDetailRenewedWidget(
                                            title:specification.origin?.capitalizeAndLower()
                                            /*:Utils.checkNullString(false)*/,
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
                              SizedBox(height: 8.w),
                              Visibility(
                                visible: showCount ?? false,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 0.w,
                                      right: 18.w,
                                      top: 0.w,
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
                              Visibility(
                                visible: specification.is_offering == offeringType,
                                child: RichText(
                                    overflow: TextOverflow.ellipsis,
                                    text:TextSpan(children: [
                                      TextSpan(
                                        text:
                                        '${specification.priceUnit.toString().replaceAll(RegExp(r'[^a-zA-Z$]'), '')}.',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 11.sp,
                                            /**/
                                            fontWeight: FontWeight.w600),
                                      ),
                                      TextSpan(
                                        text: specification.priceUnit
                                            .toString()
                                            .replaceAll(
                                            RegExp(r'[^0-9]'), '') /*'1000'*/,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 17.sp,
                                            /**/
                                            fontWeight: FontWeight.w600),
                                      ),
                                      TextSpan(
                                        text:
                                        "/${specification.unitCount ?? Utils.checkNullString(false)}",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 11.sp,
                                            /**/
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ])),
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              const  Center(
                                child: TitleSmallNormalTextWidget(
                                  title:
                                  "Ex- Factory\nincl. tax" /*specification.deliveryPeriod*/,
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
                                visible: false,
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
                                height: 10,
                              ),
                              showDetailsButton == true ?
                              Padding(
                                  padding: EdgeInsets.only(
                                    left: 4.w,
                                    right: 4.w,
                                  ),
                                  child: GestureDetector(
                                      onTap: () {
                                        openDetailsScreen(context,
                                            specObj: bidData!.specification,
                                            isFromBid: true);
                                      },
                                      child: SizedBox(
                                        width: 80,
                                        height: 22,
                                        child: Center(
                                          child: BidNowWidget(
                                            title: 'Details',
                                            size: 10.sp,
                                            padding: 10,
                                          ),
                                        ),
                                      )))
                                  :
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
                                                  specification.spc_user_id) {
                                                Utils.updateDialog(context,
                                                    null, specification, null,(updateSpecification){

                                                    });
                                              } else {
                                                openDetailsScreen(context,
                                                    specObj:
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
                                                          .spc_user_id
                                                      ? 'Send Proposal'
                                                      : "Update",
                                                  size: 10.sp,
                                                  padding: 10,
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
                  showDetailsButton == true ?
                  Padding(
                    padding: EdgeInsets.only(
                        left: 0.w, right: 0.w, top: 0.w,bottom: 0.w),
                    child: Utils.buildContainer(bidData!),
                  ) : Container()
                ],
              ),
            ),
            Visibility(
              visible: Ui.showHide(specification.isFeatured) && showDetailsButton == false,
              child: Positioned.fill(
                left: 0,
                top: 1.2,
                bottom: 1.2,
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
            Positioned(
              top: 0,
              right: 18,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Visibility(
                    visible: Ui.showHide(specification.isFeatured) && showDetailsButton == true,
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

                            fontWeight: FontWeight.bold,
                          ),
                        )),
                  ),
                ],
              ),
            )
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
