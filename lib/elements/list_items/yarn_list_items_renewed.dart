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
import 'package:yg_app/helper_utils/ui_utils.dart';
import 'package:yg_app/helper_utils/util.dart';
import 'package:yg_app/model/response/yarn_response/yarn_specification_response.dart';
import 'package:intl/intl.dart';
import 'package:yg_app/pages/detail_pages/detail_page/detail_page_renewed.dart';

Widget buildYarnRenewedWidget(YarnSpecification specification, BuildContext context) {
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
                      SizedBox(
                        child: Text(
                          specification.company??Utils.checkNullString(false),
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
                      // Row(
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: [
                      //     const TitleSmallNormalTextWidget(title: "4.5",color: Colors.black,),
                      //     SizedBox(width: 2.w,),
                      //     Image.asset(ratingIcon,width: 8.w,height: 8.w,)
                      //   ],
                      // ),
                      SizedBox(
                        width: 8.w,
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 2.w),
                        child: Visibility(
                            visible: Ui.showHide(specification.is_verified),
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
                                          Utils.setFamilyData(specification),
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
                                      title: Utils.setTitleData(specification),
                                      /*title: 'Greige,wrap'.toUpperCase(),*/
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
                                title:Utils.setDetailsData(specification),
                                /*title:'Weaving,Ring Frame,Carded,Regular',*/
                                color: Colors.black87,
                                size: 10,
                                weight: FontWeight.w500,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 0.w,right: 35.w),
                              child: specification.yarnFamilyId != "4" ? Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Expanded(
                                    child: BgLightBlueNormalTextWidget(
                                      title: 'AC ${specification.actualYarnCount??""}',
                                    ),
                                    flex: 1,
                                  ),
                                  SizedBox(width: 8.w),
                                  Expanded(
                                    child: BgLightBlueNormalTextWidget(
                                      title: 'CLSP ${specification.clsp??""}',
                                    ),
                                    flex: 1,
                                  ),
                                  SizedBox(width: 8.w),
                                  Expanded(
                                    child: BgLightBlueNormalTextWidget(
                                      title: 'IPI ${specification.ys_ipm_km??""}',
                                    ),
                                    flex: 1,
                                  ),
                                ],
                              ): Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Expanded(
                                    child: BgLightBlueNormalTextWidget(
                                      title: specification.yarnType??"",
                                    ),
                                    flex: 1,
                                  ),
                                  SizedBox(width: 8.w),
                                  Expanded(
                                    child: BgLightBlueNormalTextWidget(
                                      title: specification.yarnQuality??"",
                                    ),
                                    flex: 1,
                                  ),
                                  SizedBox(width: 8.w),
                                  Expanded(
                                    child: BgLightBlueNormalTextWidget(
                                      title: specification.yarnGrade??"",
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
                                        title: specification.weightBag ?? Utils.checkNullString(false),
                                        imageIcon: 'images/img_bag.png',
                                        size: 9.sp,
                                        iconSize: 14,
                                      ),
                                      ShortDetailRenewedWidget(
                                        title: specification.weightCone ?? Utils.checkNullString(false),
                                        imageIcon: 'images/img_cone.png',
                                        size: 9.sp,
                                        iconSize: 14,
                                      ),
                                      ShortDetailRenewedWidget(
                                        title: specification.deliveryPeriod ?? Utils.checkNullString(false),
                                        imageIcon: 'images/img_van.png',
                                        size: 9.sp,
                                        iconSize: 14,
                                      ),
                                      ShortDetailRenewedWidget(
                                        title: specification.locality ?? Utils.checkNullString(false),
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
                                      text: "/${specification.unitCount??Utils.checkNullString(false)}",
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
                              padding: EdgeInsets.only(left: 4.w, right: 4.w,bottom: 4.w),
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
                  visible: Ui.showHide(specification.is_featured),
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
                          text: DateFormat("MMM dd, yyyy").format(DateTime.parse(specification.date??"")),
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
      detailsData = '${specification.yarnSpunTechnique??Utils.checkNullString(false)}${specification.yarnColorTreatmentMethod!= null ?  ',${specification.yarnColorTreatmentMethod}':Utils.checkNullString(true)}${specification.yarnPattern!= null ?  ',${specification.yarnPattern}':Utils.checkNullString(true)}';*//*,${specification.doublingMethod??Utils.checkNullString(false)}*//*
      break;
  }
  return detailsData;
}*/
