import 'package:dotted_border/dotted_border.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';
import 'package:yg_app/api_services/api_service_class.dart';
import 'package:yg_app/elements/elevated_button_widget_2.dart';
import 'package:yg_app/elements/list_widgets/brand_text.dart';
import 'package:yg_app/elements/title_text_widget.dart';
import 'package:yg_app/helper_utils/progress_dialog_util.dart';
import 'package:yg_app/helper_utils/shared_pref_util.dart';
import 'package:yg_app/helper_utils/ui_utils.dart';
import 'package:yg_app/model/request/post_ad_request/create_request_model.dart';
import 'package:yg_app/model/response/common_response_models/delievery_period.dart';
import 'package:yg_app/model/response/list_bid_response.dart';
import 'package:yg_app/model/response/yarn_response/yarn_specification_response.dart';
import 'package:intl/intl.dart';
import '../model/response/fiber_response/fiber_specification.dart';
import 'app_colors.dart';
import 'app_constants.dart';
import 'app_images.dart';
import 'navigation_utils.dart';

class Utils{

  static double splitMin(String? minMax) {
    var splitValue = minMax!.split('-');
    return double.parse(splitValue[0]);
  }

  static double splitMax(String? minMax) {
    var splitValue = minMax!.split('-');
    return double.parse(splitValue[1]);
  }

  static String checkNullString(bool prefix) {
    var debug = false;
    var value = '';
    if(debug){
      if(prefix){
        value = ',N/A';
      }else{
        value = 'N/A';
      }
    }
    return value;
  }

  static String createStringFromList(List<String?> myList){
    var resultString = '';
    myList.asMap().forEach((index, value) {
      if(index==0){
        resultString = resultString+(value??checkNullString(false));
      }else{
        if(value==null){
          if(resultString.isNotEmpty){
            resultString = resultString+checkNullString(false);
          }else{
            resultString = resultString+checkNullString(true);
          }
        }else{
          if(resultString.isNotEmpty){
            resultString = resultString+',$value';
          }else{
            resultString = resultString+value;
          }
        }
      }
    });
    return resultString;
  }

  static String setFamilyData(YarnSpecification specification) {
    String familyData = "";
    switch (specification.yarnFamilyId) {
      case '1':
        familyData =
        '${specification.count ?? Utils.checkNullString(false)}${specification.yarnPly != null ? "/${specification.yarnPly!.substring(0, 1)}" : ""} ${specification.yarnFamily ?? ''}';
        break;
      case '2':
        familyData =
        '${specification.count ?? Utils.checkNullString(false)}${specification.yarnPly != null ? "/${specification.yarnPly!.substring(0, 1)}" : ""} ${specification.bln_abrv ?? ''}';
        break;
      case '3':
        familyData =
        '${specification.count ?? Utils.checkNullString(false)}${specification.yarnPly != null ? "/${specification.yarnPly!.substring(0, 1)}" : ""} ${specification.yarnFamily ?? ''}';
        break;
      case '4':
        familyData =
        '${specification.dtyFilament ?? ""}${specification.fdyFilament != null ? "/${specification.fdyFilament}" : ""}${specification.yarnPly != null ? " /${specification.yarnPly}" : ""} ${specification.yarnFamily ?? ''}';
        break;
      case '5':
        familyData =
        '${specification.count ?? Utils.checkNullString(false)}${specification.yarnPly != null ? "/${specification.yarnPly!.substring(0, 1)}" : ""} ${specification.yarnFamily ?? ''}';
        break;
    }
    /*if(familyData.isEmpty){
    familyData = "20/S Cotton";
  }*/
    return familyData;
  }

  static String setTitleData(YarnSpecification specification) {
    String titleData = "";
    switch (specification.yarnFamilyId) {
      case '1':
        titleData =
          '${specification.yq_abrv ?? Utils.checkNullString(false)}${specification.yq_abrv != null ? ' for ' : ''}${specification.yarnUsage ?? Utils.checkNullString(false)}';
        break;
      case '2':
        titleData = specification.yarnFamily ?? Utils.checkNullString(false);
        break;
      case '3':
        titleData = specification.yarnOrientation ?? Utils.checkNullString(false);
        break;
      case '4':
        titleData =""/* specification.yarnType ?? Utils.checkNullString(false)*/;
        break;
      case '5':
        titleData = specification.yarnBlend ?? Utils.checkNullString(false);
        break;
    }
    /*if(titleData.isEmpty){
    titleData = "Combed Weaving";
  }*/
    return titleData;
  }

  static String setDetailsData(YarnSpecification specification) {
    String detailsData = "";
    switch (specification.yarnFamilyId) {
      case '1':
        List<String?> list = [specification.yarnOrientation,specification.yarnSpunTechnique,specification.yarnColorTreatmentMethod,specification.doublingMethod,];
        detailsData = Utils.createStringFromList(list);
        break;
      case '2':
        List<String?> list = [specification.yarnOrientation,specification.yarnSpunTechnique,specification.yarnColorTreatmentMethod,specification.doublingMethod,];
        detailsData = Utils.createStringFromList(list);
        break;
      case '3':
        List<String?> list = [specification.yarnSpunTechnique,specification.yarnColorTreatmentMethod,specification.doublingMethod,];
        detailsData = Utils.createStringFromList(list);
        break;
      case '4':
        List<String?> list = [specification.yarnApperance,specification.yarnColorTreatmentMethod,specification.doublingMethod,];
        detailsData = Utils.createStringFromList(list);
        break;
      case '5':
        List<String?> list = [specification.yarnSpunTechnique,specification.yarnColorTreatmentMethod,specification.yarnPattern,];
        detailsData = Utils.createStringFromList(list);
        break;
    }
    return detailsData;
  }


  static getFiberSubtitle(Specification specification) {
    String subtitle = "";
    switch (specification.nature_id) {
      case '2':
      /*subtitle =
          '${specification.length ?? Utils.checkNullString(false)}'
              '${specification.length != null ? ',' : ''}'
              '${specification.micronaire != null ? '${specification.micronaire}' : Utils.checkNullString(true)}'
              '${specification.micronaire != null ? ',' : ''}'
          '${specification.apperance != null ? '${specification.apperance}' : Utils.checkNullString(true)}'
              '${specification.apperance != null ? ',' : ''}'
              '${specification.certification != null ? '${specification.certification}' : Utils.checkNullString(true)}';*/
        List<String?> list = [specification.length,specification.micronaire,specification.apperance,specification.certification];
        subtitle = Utils.createStringFromList(list);
        break;
      case '1':
      /*add color in specification at 2nd*/
      /*subtitle =
          '${specification.apperance != null ? '${specification.apperance}':Utils.checkNullString(false)}'
              '${specification.apperance != null ? ',' : ''}'
          '${specification.origin_fiber_spc != null ? '${specification.origin_fiber_spc}' : Utils.checkNullString(true)}';*/
        List<String?> list = [specification.apperance,specification.origin_fiber_spc];
        subtitle = Utils.createStringFromList(list);
        break;
      default:
        subtitle = Utils.checkNullString(false);
        break;
    }
    return subtitle;
  }

  static getFiberTitle(Specification specification) {
    String title = "";
    switch (specification.nature_id) {
      case '2':
      /*title =
          '${specification.origin_fiber_spc ?? Utils.checkNullString(false)}'
              '${specification.origin_fiber_spc != null ? ',' : ''}'
              '${specification.productYear != null ? '${specification.productYear}' : Utils.checkNullString(true)}';*/
        List<String?> list = [specification.origin_fiber_spc,specification.productYear];
        title = Utils.createStringFromList(list);
        break;
      case '1':
      /*title =
          '${specification.brand ?? Utils.checkNullString(false)}'
              '${specification.brand != null ? ',' : ''}'
              '${specification.lotNumber != null ? '${specification.lotNumber}' : Utils.checkNullString(true)}';*/
        List<String?> list = [specification.brand,specification.lotNumber];
        title = Utils.createStringFromList(list);
        break;
      default:
        title = Utils.checkNullString(false);
        break;
    }
    return title;
  }

  static getBackgroundColor(String status) {
    var color = Colors.white;
    switch(status){
      case '0':
        color = Colors.white;
        break;
      case '1':
        color = lightBlueBidderColor;
        break;
      case '2':
        color = lightOrangeBidderColor;
        break;
    }
    return color;
  }

  static getBackgroundColorCustom(String status) {
    var color = Colors.grey.shade50;
    switch(status){
      case '0':
        color = Colors.grey.shade200;
        break;
      case '1':
        color = lightBlueBidderColor;
        break;
      case '2':
        color = lightOrangeBidderColor;
        break;
    }
    return color;
  }

  static Container buildContainer(BidData bidData) {
    return Container(
      padding: EdgeInsets.only(bottom: 0.w, top: 8.w),
      child: Container(
        decoration: BoxDecoration(
            color: Utils.getBackgroundColorCustom(bidData.status!),
            borderRadius: const BorderRadius.all(Radius.circular(0))
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: DottedLine(
                dashColor: geryTextColor,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w,vertical: 12.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Image.asset(
                  //   postAdGreyIcon,
                  //   width: 24.w,
                  //   height: 24.w,
                  // ),
                  // SizedBox(
                  //   width: 8.w,
                  // ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomBrandWidget(title: "Proposed Price:",color: geryTextColor,size: 12,),
                            SizedBox(width: 2.w,),
                            CustomBrandWidget(title: '${bidData.price}',size: 13,),
                            SizedBox(width: 4.w,),
                          ],
                        ),
                        SizedBox(height: 5.w,),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomBrandWidget(title: "Quantity:",color: geryTextColor,size: 12,),
                            SizedBox(width: 2.w,),
                            CustomBrandWidget(title: bidData.quantity,size: 13,),
                            SizedBox(width: 8.w,),
                            CustomBrandWidget(title: DateFormat("dd-MM-yyyy | HH:MM:ss").format(DateTime.parse(bidData.date??"")),size: 11,color: geryTextColor,)
                          ],
                        ),
                      ],
                    ),
                    flex: 8,
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CustomBrandWidget(title: 'Status',color: geryTextColor,size: 12,),
                        SizedBox(
                          height: 6.w,
                        ),
                        Container(
                            width: 60.w,
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.w, vertical: 5.w),
                            decoration: BoxDecoration(
                                color: bidData.status == "0"
                                    ? Colors.brown.shade100.withOpacity(0.4)
                                    : bidData.status == "1"
                                    ? Colors.green.shade100
                                    : Colors.red.shade100,
                                borderRadius: const BorderRadius.all(Radius.circular(2))
                                ),
                            child: Text(
                              showStatus(int.parse(bidData.status!)),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: bidData.status == "0"
                                    ? Colors.brown
                                    : bidData.status == "1"
                                    ? Colors.green
                                    : Colors.red,
                                fontSize: 8.sp,
                                fontFamily: 'Metropolis',
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static String showStatus(int bidStatus) {
    if (bidStatus == 0) {
      return "Pending";
    } else if (bidStatus == 1) {
      return "Accepted";
    } else {
      return "Rejected";
    }
  }

  static Future updateDialog(context, YarnSpecification? yarnSpecification,
      Specification? specification, DeliveryPeriod deliveryPeriod,
      List<DeliveryPeriod> deliveryPeriodList, CreateRequestModel createRequestModel,
      TextEditingController controllerAvailQ, TextEditingController controllerUpdatePrice) {

    /*final TextEditingController _controllerUpdatePrice = TextEditingController();
    final TextEditingController _controllerAvailQ = TextEditingController();
    final CreateRequestModel _createRequestModel = CreateRequestModel();*/

    return showGeneralDialog(
      context: context,
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 700),
      pageBuilder: (_, __, ___) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Scaffold(
                backgroundColor: Colors.transparent,
                body: Center(
                  child: Container(
                    height: 300.h,
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 9,
                          child: Column(
                            children: [
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  Image.asset(
                                    ic_update_header,
                                    fit: BoxFit.cover,
                                    height: 38.h,
                                    width: double.maxFinite,
                                  ),
                                  const Center(
                                      child: TitleSmallBoldTextWidget(
                                        title: "Update Product",
                                        color: Colors.white,
                                      )),
                                  Positioned(
                                    child: GestureDetector(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Icon(
                                          Icons.clear,
                                          size: 24,
                                          color: Colors.white,
                                        )),
                                    right: 1,
                                    top: 1,
                                  )
                                ],
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey.shade100,
                                    ),
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(4.w)),
                                    color: searchBarWhiteBg),
                                margin: EdgeInsets.only(
                                    top: 8.w, right: 8.w, bottom: 8.w, left: 8.w),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        controller: controllerUpdatePrice,
                                        keyboardType: TextInputType.number,
                                        cursorColor: lightBlueTabs,
                                        decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            focusedBorder: InputBorder.none,
                                            enabledBorder: InputBorder.none,
                                            errorBorder: InputBorder.none,
                                            disabledBorder: InputBorder.none,
                                            contentPadding:
                                            EdgeInsets.only(left: 8),
                                            hintText: "Price"),
                                        style: TextStyle(fontSize: 14.sp),
                                        maxLines: 1,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(
                                              RegExp("[0-9]")),
                                        ],
                                        onChanged: (value) {
                                          // _controllerUpdatePrice.text = value;
                                          if (value.isNotEmpty) {
                                            createRequestModel.fbp_price = value;
                                          }
                                        },
                                      ),
                                      flex: 9,
                                    ),
                                    Expanded(
                                        child: TitleSmallTextWidget(
                                            title:
                                            specification == null ? '/${yarnSpecification!.priceUnit.toString().replaceAll(RegExp(r'[^a-zA-Z$]'), '')}'
                                        : '/${specification.priceUnit.toString().replaceAll(RegExp(r'[^a-zA-Z$]'), '')}'))
                                  ],
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey.shade100,
                                    ),
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(4.w)),
                                    color: searchBarWhiteBg),
                                margin: EdgeInsets.only(
                                    top: 8.w, right: 8.w, bottom: 8.w, left: 8.w),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        controller: controllerAvailQ,
                                        keyboardType: TextInputType.number,
                                        cursorColor: lightBlueTabs,
                                        decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            focusedBorder: InputBorder.none,
                                            enabledBorder: InputBorder.none,
                                            errorBorder: InputBorder.none,
                                            disabledBorder: InputBorder.none,
                                            contentPadding:
                                            EdgeInsets.only(left: 8),
                                            hintText: "Available Quantity"),
                                        style: TextStyle(fontSize: 14.sp),
                                        maxLines: 1,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(
                                              RegExp("[0-9]")),
                                        ],
                                        onChanged: (value) {
                                          if (value.isNotEmpty) {
                                            createRequestModel
                                                .fbp_available_quantity = value;
                                          }
                                          // _controllerUpdatePrice.text = value;
                                        },
                                      ),
                                    ),
                                    // Expanded(
                                    //     child: TitleSmallTextWidget(
                                    //         title:
                                    //         ''))
                                  ],
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey.shade100,
                                    ),
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(4.w)),
                                    color: searchBarWhiteBg),
                                margin: EdgeInsets.only(
                                    top: 8.w, right: 8.w, bottom: 8.w, left: 8.w),
                                padding: EdgeInsets.symmetric(horizontal: 8.w),
                                child: DropdownButton(
                                  isExpanded: true,
                                  value: deliveryPeriod,
                                  items: deliveryPeriodList
                                      .map((value) =>
                                      DropdownMenuItem<DeliveryPeriod>(
                                        child: Text(value.dprName ?? "",
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                                fontFamily: 'Metropolis')),
                                        value: value,
                                      ))
                                      .toList(),
                                  underline: const SizedBox(),
                                  onChanged: (DeliveryPeriod? value) {
                                    setState(() {
                                      deliveryPeriod = value!;
                                    });
                                    createRequestModel.fbp_delivery_period_idfk =
                                        value!.dprId.toString();
                                  },
                                  // value: widget.syncFiberResponse.data.fiber.countries.first,
                                  style: TextStyle(
                                      fontSize: 11.sp, color: textColorGrey),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButtonWithoutIcon(
                            callback: () {
                              ProgressDialogUtil.showDialog(
                                  context, "Please wait..");
                              ApiService.createSpecification(
                                  createRequestModel, "")
                                  .then((value) {
                                ProgressDialogUtil.hideDialog();
                                if (value.status) {
                                  Fluttertoast.showToast(msg: value.message);
                                  if (value.responseCode == 205) {
                                    openMyAdsScreen(context);
                                  } else {
                                    Navigator.pop(context);
                                  }
                                } else {
                                  Ui.showSnackBar(context, value.message);
                                }
                              }).onError((error, stackTrace) {
                                ProgressDialogUtil.hideDialog();
                                Ui.showSnackBar(context, error.toString());
                              });
                            },
                            color: Colors.green,
                            btnText: "Update",
                          ),
                        )
                      ],
                    ),
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    // decoration: BoxDecoration(
                    //     color: Colors.white, borderRadius: BorderRadius.circular(40)),
                  ),
                ),
              );
            });
      },
      transitionBuilder: (_, anim, __, child) {
        Tween<Offset> tween;
        if (anim.status == AnimationStatus.reverse) {
          tween = Tween(begin: const Offset(-1, 0), end: Offset.zero);
        } else {
          tween = Tween(begin: const Offset(1, 0), end: Offset.zero);
        }

        return SlideTransition(
          position: tween.animate(anim),
          child: FadeTransition(
            opacity: anim,
            child: child,
          ),
        );
      },
    );
  }

  static Future<String?> getUserId() async {
    return await SharedPreferenceUtil.getStringValuesSF(USER_ID_KEY);
  }

}