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
        borderRadius: BorderRadius.circular(0),
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
                  width: 28.w,
                  padding: EdgeInsets.symmetric(horizontal: 3.w,vertical: 3.w),
                  decoration: BoxDecoration(
                      color: lightGreenContainer,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(0.w),
                      )),
                  child: Text(
                    'Active',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: lightGreenLabel,
                      fontSize: 6.sp,
                      fontFamily: 'Metropolis',
                      fontWeight: FontWeight.bold,
                    ),
                  )),
            ),
          ),
          SizedBox(height: 1.w,),
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
                              constraints: const BoxConstraints(maxHeight: 19),
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: Center(
                                  child: TitleBoldSmallTextWidget(
                                    title:
                                    setFamilyData(specification),
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            ),
                          SizedBox(width: 4.w,),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: TitleMediumTextWidget(
                                title: setTitleData(specification),
                                color: Colors.black87,
                              ),
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
                        padding: EdgeInsets.only(bottom: 6.0.w, top: 6.w),
                        child: TitleSmallNormalTextWidget(
                          title: setDetailsData(specification),
                          color: lightGreyColor,
                          size: 8.sp,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 40.w),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                              child: BgLightBlueTextWidget(
                                title: 'AC ${specification.actualYarnCount}',
                                color: lightBlueLabel,
                              ),
                              flex: 1,
                            ),
                            SizedBox(width: 8.w),
                            Expanded(
                              child: BgLightBlueTextWidget(
                                title: 'CLSP ${specification.clsp}',
                                color: lightBlueLabel,
                              ),
                              flex: 1,
                            ),
                            SizedBox(width: 8.w),
                            Expanded(
                              child: BgLightBlueTextWidget(
                                title: 'IPI ${specification.actualYarnCount}',
                                color: lightBlueLabel,
                              ),
                              flex: 1,
                            ),
                          ],
                        ),
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
                                ShortDetailWidget(
                                  title: specification.weightBag ?? "N/A",
                                  imageIcon: 'images/img_bag.png',
                                  size: 8.sp,
                                ),
                                ShortDetailWidget(
                                  title: specification.weightCone ?? "N/A",
                                  imageIcon: 'images/img_cone.png',
                                  size: 8.sp,
                                ),
                                ShortDetailWidget(
                                  title: specification.deliveryPeriod ?? "N/A",
                                  imageIcon: 'images/img_van.png',
                                  size: 8.sp,
                                ),
                                ShortDetailWidget(
                                  title: specification.locality ?? "N/A",
                                  imageIcon: 'images/img_location.png',
                                  size: 8.sp,
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
                  padding: const EdgeInsets.only(right: 18.0,bottom: 4),
                  child: Container(
                    padding: EdgeInsets.only(left: 6.w, right: 0.w,top: 4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        /*TitleMediumTextWidget(
                          title: "PKR." +
                              specification.priceUnit.toString() +
                              "/KG",
                        ),*/
                        Text.rich( TextSpan(
                            children: [
                              TextSpan(
                                text: '${specification.priceUnit.toString().replaceAll(RegExp(r'[^a-zA-Z$]'),'')}.',
                                /*text: '${'Pkr'.toString().replaceAll(RegExp(r'[^a-zA-Z$]'),'')}.',*/
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
                        const TitleSmallNormalTextWidget(title: "Ex- Factory",size: 7,),
                        SizedBox(height: 8.w,),
                        Text.rich(TextSpan(children: [
                          TextSpan(
                            text: "Updated",
                            style: TextStyle(
                                fontSize: 7.sp, color: Colors.black),
                          ),
                        ])),
                        SizedBox(height: 3.w,),
                        Text.rich(TextSpan(children: [
                          TextSpan(
                            text: "Nov 23, 4:33 PM",
                            style: TextStyle(
                                fontSize: 8.sp, color: lightBlueLabel,fontWeight: FontWeight.w600),
                          )
                        ])),
                        SizedBox(height: 8.w,),
                        Text.rich(TextSpan(children: [
                          TextSpan(
                            text: "Avail. Quantity",
                            style: TextStyle(
                                fontSize: 7.sp, color: Colors.black),
                          ),
                        ])),
                        SizedBox(height: 3.w,),
                        Text.rich(TextSpan(children: [
                          TextSpan(
                            text: "325",
                            style: TextStyle(
                                fontSize: 8.sp, color: lightBlueLabel,fontWeight: FontWeight.w600),
                          )
                        ])),
                      ],
                    ),
                  ),
                ),
                flex: 2,
              ),

            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: 18.w,right: 18.w,top: 3.w,bottom: 10.w),
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
                        borderRadius:
                        BorderRadius.all(Radius.circular(4.w))),
                    child: Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 6.w),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  'Proposals',
                                  style: TextStyle(
                                      fontSize: 9.sp, color: Colors.black87,fontWeight: FontWeight.w400),
                                ),
                                Text(
                                  '4',
                                  style: TextStyle(
                                      fontSize: 9.sp, color: greenButton,fontWeight: FontWeight.w700),
                                ),
                                SizedBox(width: 3.w,)
                              ],
                            ),
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional.topEnd,
                          child: Padding(
                            padding: const EdgeInsets.all(2),
                            child: Container(
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                  color: redColor,
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(10.w))),
                              child: Center(
                                child: Text(
                                  '3',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 8.sp, color: Colors.white,fontWeight: FontWeight.w400),
                                ),
                              ),
                            ),
                          )
                        )
                      ],
                    )
                  )
                ),
                SizedBox(width: 10.w,),
                Expanded(
                    child: Container(
                        decoration: BoxDecoration(
                          /*color: lightYellowContainer,*/
                            border: Border.all(
                              color: greenButton,
                              width:
                              1, //                   <--- border width here
                            ),
                            borderRadius:
                            BorderRadius.all(Radius.circular(4.w))),
                        child: Stack(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 6.w),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      'Matches',
                                      style: TextStyle(
                                          fontSize: 9.sp, color: Colors.black87,fontWeight: FontWeight.w400),
                                    ),
                                    Text(
                                      '5',
                                      style: TextStyle(
                                          fontSize: 9.sp, color: greenButton,fontWeight: FontWeight.w700),
                                    ),
                                    SizedBox(width: 3.w,)
                                  ],
                                ),
                              ),
                            ),
                            Align(
                                alignment: AlignmentDirectional.topEnd,
                                child: Padding(
                                  padding: const EdgeInsets.all(2),
                                  child: Container(
                                    width: 10,
                                    height: 10,
                                    decoration: BoxDecoration(
                                        color: redColor,
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(10.w))),
                                    child: Center(
                                      child: Text(
                                        '3',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 8.sp, color: Colors.white,fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                  ),
                                )
                            )
                          ],
                        )
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

String setFamilyData(YarnSpecification specification){
  String familyData = "";
  switch (specification.yarnFamilyId) {
    case '1':
      familyData = '${specification.count??"N/A"}${specification.yarnPly != null ? "/${specification.yarnPly!.substring(0,1)}"  :  ""} ${specification.yarnFamily??''}';
      break;
    case '2':
      familyData = '${specification.count??"N/A"}${specification.yarnPly != null ? "/${specification.yarnPly!.substring(0,1)}"  :  ""} ${specification.yarnFamily??''}';
      break;
    case '3':
      familyData = '${specification.count??"N/A"}${specification.yarnPly != null ? "/${specification.yarnPly!.substring(0,1)}"  :  ""} ${specification.yarnFamily??''}';
      break;
    case '4':
      familyData = '${specification.dtyFilament ?? ""}${specification.fdyFilament != null ? "/${specification.fdyFilament}" : ""} ${specification.yarnFamily??''}';
      break;
    case '5':
      familyData = '${specification.count??"N/A"}${specification.yarnPly != null ? "/${specification.yarnPly!.substring(0,1)}"  :  ""} ${specification.yarnFamily??''}';
      break;
  }
  /*if(familyData.isEmpty){
    familyData = "20/S Cotton";
  }*/
  return familyData;
}

String setTitleData(YarnSpecification specification){
  String titleData = "";
  switch (specification.yarnFamilyId) {
    case '1':
      titleData = '${specification.yarnQuality??'N/A'} for ${specification.yarnUsage??'N/A'}';
      break;
    case '2':
      titleData = specification.yarnBlend??'N/A';
      break;
    case '3':
      titleData = specification.yarnOrientation??'N/A';
      break;
    case '4':
      titleData = specification.yarnType??'N/A';
      break;
    case '5':
      titleData = specification.yarnBlend??'N/A';
      break;
  }
  /*if(titleData.isEmpty){
    titleData = "Combed Weaving";
  }*/
  return titleData;
}

String setDetailsData(YarnSpecification specification){
  String detailsData = "";
  switch (specification.yarnFamilyId) {
    case '1':
      detailsData = '${specification.yarnOrientation??'N/A'},${specification.yarnSpunTechnique??"N/A"},${specification.yarnColorTreatmentMethod??"N/A"},${specification.doublingMethod??"N/A"}';
      break;
    case '2':
      detailsData = '${specification.yarnOrientation??'N/A'},${specification.yarnSpunTechnique??"N/A"},${specification.yarnColorTreatmentMethod??"N/A"},${specification.doublingMethod??"N/A"}';
      break;
    case '3':
      detailsData = '${specification.yarnSpunTechnique??"N/A"},${specification.yarnColorTreatmentMethod??"N/A"},${specification.doublingMethod??"N/A"}';
      break;
    case '4':
      detailsData = '${specification.yarnSpunTechnique??"N/A"},${specification.yarnColorTreatmentMethod??"N/A"},${specification.yarnApperance??"N/A"},${specification.doublingMethod??"N/A"},${specification.yarnGrade??"N/A"}';
      break;
    case '5':
      detailsData = '${specification.yarnSpunTechnique??"N/A"},${specification.yarnColorTreatmentMethod??"N/A"},${specification.yarnPattern??"N/A"}';/*,${specification.doublingMethod??"N/A"}*/
      break;
  }
  /*if(detailsData.isEmpty){
    detailsData = "Weaving,Ring Frame,Warp,Regular";
  }*/
  return detailsData;
}