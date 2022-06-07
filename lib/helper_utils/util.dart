import 'dart:developer';
import 'dart:math';

import 'package:dotted_border/dotted_border.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:stylish_dialog/stylish_dialog.dart';
import 'package:yg_app/api_services/api_service_class.dart';
import 'package:yg_app/app_database/app_database_instance.dart';
import 'package:yg_app/elements/elevated_button_widget_2.dart';
import 'package:yg_app/elements/list_widgets/brand_text.dart';
import 'package:yg_app/elements/title_text_widget.dart';
import 'package:yg_app/helper_utils/progress_dialog_util.dart';
import 'package:yg_app/helper_utils/shared_pref_util.dart';
import 'package:yg_app/helper_utils/ui_utils.dart';
import 'package:yg_app/locators.dart';
import 'package:yg_app/model/request/post_ad_request/create_request_model.dart';
import 'package:yg_app/model/request/post_fabric_request/create_fabric_request_model.dart';
import 'package:yg_app/model/response/common_response_models/delievery_period.dart';
import 'package:yg_app/model/response/fabric_response/fabric_specification_response.dart';
import 'package:yg_app/model/response/list_bid_response.dart';
import 'package:yg_app/model/response/stocklot_repose/stocklot_specification_response.dart';
import 'package:yg_app/model/response/yarn_response/yarn_specification_response.dart';
import 'package:intl/intl.dart';
import 'package:yg_app/providers/fiber_providers/fiber_specification_provider.dart';
import '../model/response/fabric_response/sync/fabric_sync_response.dart';
import '../providers/fabric_providers/fabric_specifications_provider.dart';
import '../providers/yarn_providers/yarn_specifications_provider.dart';
import '../model/request/update_fabric_request/update_fabric_request.dart';
import '../model/response/fiber_response/fiber_specification.dart';
import 'dialog_builder.dart';
import 'app_colors.dart';
import 'app_constants.dart';
import 'app_images.dart';
import 'navigation_utils.dart';

class Utils {
  static double splitMin(String? minMax) {
    var splitValue = minMax!.split('-');
    return double.parse(splitValue[0]);
  }

  static double splitMax(String? minMax) {
    var splitValue = minMax!.split('-');
    return double.parse(splitValue[1]);
  }

  static String getPropertyIcon(int index) {
    switch(index){
        case 0:
        return IC_BAG_RENEWED;
        case 1:
        return IC_CONE_RENEWED;
        case 2:
        return IC_VAN_RENEWED;
        case 3:
        return IC_LOCATION_RENEWED;
        default:
        return IC_BAG_RENEWED;
    }
  }

  static void addProperty(String? property, List<dynamic> list) {
    if (property != null && property.isNotEmpty) {
      list.add(property);
    }
  }


  static bool setCottonVisibility(List<dynamic> list) {
    bool showCotton = false;
    list.forEach((element) {
      if(element.blnName!.toLowerCase() == 'cotton'){
        showCotton = true;
      }
    });
    return showCotton;
  }

  static bool setPolyesterVisibility(List<dynamic> list) {
    bool showCotton = false;
    list.forEach((element) {
      if(element.blnAbrv!.toLowerCase() == 'p'){
        showCotton = true;
      }
    });
    return showCotton;
  }

  static String checkNullString(bool prefix) {
    var debug = false;
    var value = '';
    if (debug) {
      if (prefix) {
        value = ',N/A';
      } else {
        value = 'N/A';
      }
    }
    return value;
  }

  static String createStringFromList(List<String?> myList) {
    var resultString = '';
    myList.asMap().forEach((index, value) {
      if (index == 0) {
        resultString = resultString + (value ?? checkNullString(false));
      } else {
        if (value == null) {
          if (resultString.isNotEmpty) {
            resultString = resultString + checkNullString(false);
          } else {
            resultString = resultString + checkNullString(true);
          }
        } else {
          if (resultString.isNotEmpty) {
            resultString = resultString + ',$value';
          } else {
            resultString = resultString + value;
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
        '${specification.count ?? Utils.checkNullString(false)}${specification.yarnPly != null ? "/${specification.yarnPly!.substring(0, 1)}" : ""} ${specification.formationDisplayText != null && specification.formationDisplayText!.isNotEmpty ?' ${specification.formationDisplayText}':''}';
        break;
      case '3':
        familyData =
        '${specification.count ?? Utils.checkNullString(false)}${specification.yarnPly != null ? "/${specification.yarnPly!.substring(0, 1)}" : ""} ${specification.yarnFamily ?? ''}';
        break;
      case '4':
        familyData =
        '${specification.ys_yarn_type ?? ""} ${specification.dtyFilament != null ? "${specification.dtyFilament}" : ""}${specification.fdyFilament != null ? "/${specification.fdyFilament}" : ""} /${specification.yarnPly ?? ''}';
        // '${specification.dtyFilament ?? ""}${specification.fdyFilament != null ? "/${specification.fdyFilament}" : ""}${specification.yarnPly != null ? " /${specification.yarnPly}" : ""} ${specification.yarnFamily ?? ''}';
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


  static String formatFormations(List<GenericFormation> yarnFormation) {
    String formationTileModel;
    switch (yarnFormation.length) {
      case 1:
        if (yarnFormation.first.formationRatio == "100") {
          formationTileModel = '';
        } else {
          formationTileModel =
          "${yarnFormation.first.blendName != null? yarnFormation.first.blendName![0]:""} :${yarnFormation.first.formationRatio}";
        }
        break;
      case 2:
        formationTileModel =
        '${yarnFormation.first.blendName != null? yarnFormation.first.blendName![0]:""} : ${yarnFormation.first.formationRatio ?? Utils.checkNullString(false)} '
            '${yarnFormation[1].blendName != null? yarnFormation[1].blendName![0]:""} : ${yarnFormation[1].formationRatio ?? Utils.checkNullString(false)}';
        break;
      default:
        String? blendString = '';
        for (var element in yarnFormation) {
          if (blendString!.isEmpty) {
            blendString =
                blendString + '${element.blendName != null? element.blendName![0]:""}:${element.formationRatio ?? Utils.checkNullString(false)}';
          } else {
            blendString =
                blendString + ':${element.blendName != null? element.blendName![0]:""}:${element.formationRatio ?? Utils.checkNullString(false)} ';
          }
        }
        formationTileModel = blendString ?? Utils.checkNullString(false);
        break;
    }
    return formationTileModel;
  }


  static String setFabricFamilyData(FabricSpecification specification) {
    String familyData = "";
    switch (specification.fabricFamilyId) {
      case '101':
        familyData = '${specification.count ?? Utils.checkNullString(false)}'
            '/${getPlyString(specification.fabricPly ?? Utils.checkNullString(false))}';
        break;
      case '102':
       familyData =
        '${specification.fabricLoomName ?? Utils.checkNullString(false)} ${specification.warpCount ?? Utils.checkNullString(false)}/'
            '${getPlyString(specification.fabricWarpPlyName ?? Utils.checkNullString(false))}'
            'x${specification.weftCount ?? Utils.checkNullString(false)}/${getPlyString(specification.fabricWeftPlyName ?? Utils.checkNullString(false))}'
            'x${specification.noOfEndsWarp ?? Utils.checkNullString(false)}x${specification.noOfPickWeft ?? Utils.checkNullString(false)}';

        break;
      case '103':
        familyData =
        '${specification.count ?? Utils.checkNullString(false)}/${getPlyString(specification.fabricPly ?? Utils.checkNullString(false))}, ${specification.once ?? Utils.checkNullString(false)}';
        break;
      case '104':
        familyData =
        '${specification.fabricLayyerName != null ? '${specification.fabricLayyerName} Layer' : Utils.checkNullString(false)}, ${specification.gsmCount != null ? '${specification.gsmCount} Grams' : Utils.checkNullString(false)}';
        break;
    }
    return familyData;
  }

  static String getPlyString(String fabricPly) {
    String ply = '';
    if (fabricPly.toLowerCase() == 'single') {
      ply = '1';
    } else if (fabricPly.toLowerCase() == 'double') {
      ply = '2';
    }
    return ply;
  }

  static String setFabricTitle(FabricSpecification specification) {
    String titleData = "";
    switch (specification.fabricFamilyId) {
      case '101':
        titleData =
        '${specification.gsmCount ?? Utils.checkNullString(false)}, ${specification.formationDisplayText ?? Utils.checkNullString(false)}';
        break;
      case '102':
        titleData =
        '${specification.width != null ? ' ${specification.width}″' : Utils.checkNullString(false)}, ${specification.formationDisplayText}';
        break;
      case '103':
        titleData =
        ' ${specification.once != null ? '${specification.once} Oz' :Utils.checkNullString(false)}, ${specification.formationDisplayText ?? Utils.checkNullString(false)}/*, ${specification.fabricDenimTypeName ?? Utils.checkNullString(false)}*/';
        break;
      case '104':
        titleData ='${specification.width != null ? '${specification.width}″' : Utils.checkNullString(false)}, ${specification.color ?? Utils.checkNullString(false)}';
        break;
    }
    return titleData;
  }

  static String setFabricDetails(FabricSpecification specification) {
    String detailsData = "";
    detailsData = '${specification.fabricFamily}/${specification.fabricBlend}';
    switch (specification.fabricFamilyId) {
      case '101':
        List<String?> list = [
          specification.fabricKnittingTypeName,
          specification.fabricColorTreatmentMethod,
        ];
        if(specification.fabricDyingTechnique != null){
          list.add(specification.fabricDyingTechnique);
        }
        if(specification.color != null){
          list.add(specification.color);
        }
        detailsData = Utils.createStringFromList(list);
        break;
      case '102':
        List<String?> list = [
          specification.fabricWeaveName,
          specification.fabricWeavePatternName,
          specification.fabricApperance
        ];
        detailsData = Utils.createStringFromList(list);
        break;
      case '103':
        List<String?> list = [
          specification.fabricApperance,
          specification.fabricDyingTechnique
        ];
        detailsData = Utils.createStringFromList(list);
        break;
      case '104':
        detailsData = '';
        break;
    }
    return detailsData;
  }

  static String setTitleData(YarnSpecification specification) {
    String titleData = "";
    switch (specification.yarnFamilyId) {
      case '1':
        titleData =
        '${specification.yq_abrv ?? Utils.checkNullString(false)}${specification.yq_abrv != null ? ' for ' : ''}${specification.yarnUsage ?? Utils.checkNullString(false)}';
        break;
      case '2':
        titleData = "";/*specification.yarnFamily ?? Utils.checkNullString(false);*/
        break;
      case '3':
        titleData =
            specification.yarnOrientation ?? Utils.checkNullString(false);
        break;
      case '4':
        titleData =
        "" /* specification.yarnType ?? Utils.checkNullString(false)*/;
        break;
      case '5':
        titleData = specification.formationDisplayText != null && specification.formationDisplayText!.isNotEmpty ?' ${specification.formationDisplayText}':'';
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
        List<String?> list = [
          specification.yarnOrientation,
          specification.yarnSpunTechnique,
          specification.yarnColorTreatmentMethod,
          specification.doublingMethod,
        ];
        detailsData = Utils.createStringFromList(list);
        break;
      case '2':
        List<String?> list = [
          specification.yarnOrientation,
          specification.yarnSpunTechnique,
          specification.yarnColorTreatmentMethod,
          specification.doublingMethod,
        ];
        detailsData = Utils.createStringFromList(list);
        break;
      case '3':
        List<String?> list = [
          specification.yarnSpunTechnique,
          specification.yarnColorTreatmentMethod,
          specification.doublingMethod,
        ];
        detailsData = Utils.createStringFromList(list);
        break;
      case '4':
        List<String?> list = [
          specification.yarnApperance,
          specification.yarnColorTreatmentMethod,
          specification.color,
        ];
        detailsData = Utils.createStringFromList(list);
        break;
      case '5':
        List<String?> list = [
          specification.yarnSpunTechnique,
          specification.yarnColorTreatmentMethod,
          specification.yarnPattern,
        ];
        detailsData = Utils.createStringFromList(list);
        break;
    }
    return detailsData;
  }

  static getFiberSubtitle(Specification specification) {
    String subtitle = "";
    switch (specification.nature_id) {
      case '18':
      /*subtitle =
          '${specification.length ?? Utils.checkNullString(false)}'
              '${specification.length != null ? ',' : ''}'
              '${specification.micronaire != null ? '${specification.micronaire}' : Utils.checkNullString(true)}'
              '${specification.micronaire != null ? ',' : ''}'
          '${specification.apperance != null ? '${specification.apperance}' : Utils.checkNullString(true)}'
              '${specification.apperance != null ? ',' : ''}'
              '${specification.certification != null ? '${specification.certification}' : Utils.checkNullString(true)}';*/
        List<String?> list = [
          specification.length,
          specification.micronaire,
          specification.apperance,
          specification.certification
        ];
        subtitle = Utils.createStringFromList(list);
        break;
      case '17':
      /*add color in specification at 2nd*/
      /*subtitle =
          '${specification.apperance != null ? '${specification.apperance}':Utils.checkNullString(false)}'
              '${specification.apperance != null ? ',' : ''}'
          '${specification.origin_fiber_spc != null ? '${specification.origin_fiber_spc}' : Utils.checkNullString(true)}';*/
        List<String?> list = [
          specification.apperance,
          specification.origin_fiber_spc
        ];
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
      case '18':
      /*title =
          '${specification.origin_fiber_spc ?? Utils.checkNullString(false)}'
              '${specification.origin_fiber_spc != null ? ',' : ''}'
              '${specification.productYear != null ? '${specification.productYear}' : Utils.checkNullString(true)}';*/
        List<String?> list = [
          specification.origin_fiber_spc,
          specification.productYear
        ];
        title = Utils.createStringFromList(list);
        break;
      case '17':
      /*title =
          '${specification.brand ?? Utils.checkNullString(false)}'
              '${specification.brand != null ? ',' : ''}'
              '${specification.lotNumber != null ? '${specification.lotNumber}' : Utils.checkNullString(true)}';*/
        List<String?> list = [specification.brand, specification.lotNumber];
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
    switch (status) {
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
    switch (status) {
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
            borderRadius: const BorderRadius.all(Radius.circular(0))),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: DottedLine(
                dashColor: geryTextColor,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.w),
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
                            CustomBrandWidget(
                              title: "Proposed Price:",
                              color: geryTextColor,
                              size: 12,
                            ),
                            SizedBox(
                              width: 2.w,
                            ),
                            CustomBrandWidget(
                              title: '${bidData.price}',
                              size: 13,
                            ),
                            SizedBox(
                              width: 4.w,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5.w,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomBrandWidget(
                              title: "Quantity:",
                              color: geryTextColor,
                              size: 12,
                            ),
                            SizedBox(
                              width: 2.w,
                            ),
                            CustomBrandWidget(
                              title: bidData.quantity,
                              size: 13,
                            ),
                            SizedBox(
                              width: 8.w,
                            ),
                            CustomBrandWidget(
                              title: DateFormat("dd-MM-yyyy | HH:mm:ss")
                                  .format(DateTime.parse(bidData.date ?? "")),
                              size: 11,
                              color: geryTextColor,
                            )
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
                        CustomBrandWidget(
                          title: 'Status',
                          color: geryTextColor,
                          size: 12,
                        ),
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
                                borderRadius:
                                const BorderRadius.all(Radius.circular(2))),
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
                                /*fontFamily: 'Metropolis',*/
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

  /*static void updateDialog(
    context,
    YarnSpecification? yarnSpecification,
    Specification? specification,
  ) {
    final TextEditingController controllerUpdatePrice = TextEditingController();
    final TextEditingController controllerAvailQ = TextEditingController();
    late List<DeliveryPeriod> deliveryPeriodList;
    late DeliveryPeriod deliveryPeriod;
    var isSwitched = true;
    var strActive = "Active";
    final CreateRequestModel createRequestModel = CreateRequestModel();
    controllerUpdatePrice.text = specification != null
        ? specification.priceUnit!.replaceAll(RegExp(r'[^0-9]'), '')
        : yarnSpecification!.priceUnit!.replaceAll(RegExp(r'[^0-9]'), '');
    controllerAvailQ.text = specification != null
        ? specification.available ?? ""
        : yarnSpecification!.available ?? "";
    if (yarnSpecification != null) {
      createRequestModel.ys_id = specification != null
          ? specification.spcId.toString()
          : yarnSpecification.ysId.toString();
    }
    if (specification != null) {
      createRequestModel.spc_id = specification != null
          ? specification.spcId.toString()
          : yarnSpecification!.ysId.toString();
    }
    createRequestModel.fbp_price = controllerUpdatePrice.text.toString();
    createRequestModel.spc_category_idfk = specification != null ? "1" : "2";

    AppDbInstance.getDeliveryPeriod().then((value1) {
      var period = specification != null
          ? specification.deliveryPeriod
          : yarnSpecification!.deliveryPeriod;
      */ /*Logger().e(period.toString());
      Logger().e(value1.toString());*/ /*
      deliveryPeriod =
          value1.where((element) => element.dprName == period).first;
      createRequestModel.fbp_delivery_period_idfk =
          deliveryPeriod.dprId.toString();
      deliveryPeriodList = value1;
      */ /*Logger().e(deliveryPeriod.toString());
      Logger().e(deliveryPeriodList.toString());*/ /*

      showGeneralDialog(
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
                        flex: 2,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Image.asset(
                              ic_update_header,
                              fit: BoxFit.cover,
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
                      ),
                      Expanded(
                        flex: 9,
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    TitleMediumTextWidget(
                                        title: isSwitched
                                            ? strActive = "Active"
                                            : "InActive"),
                                    Switch(
                                      onChanged: (bool value) {
                                        setState(() {
                                          isSwitched = value;
                                        });
                                        if (value) {
                                          createRequestModel.spc_active = "1";
                                        } else {
                                          createRequestModel.spc_active = "0";
                                        }
                                      },
                                      value: isSwitched,
                                      activeColor: Colors.green,
                                      activeTrackColor: Colors.green.shade200,
                                      inactiveThumbColor: Colors.grey,
                                      inactiveTrackColor: Colors.grey.shade200,
                                    ),
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
                                    top: 8.w,
                                    right: 8.w,
                                    bottom: 8.w,
                                    left: 8.w),
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
                                            createRequestModel.fbp_price =
                                                value;
                                          }
                                        },
                                      ),
                                      flex: 9,
                                    ),
                                    Expanded(
                                        child: TitleSmallTextWidget(
                                            title: specification == null
                                                ? '/${yarnSpecification!.priceUnit.toString().replaceAll(RegExp(r'[^a-zA-Z$]'), '')}'
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
                                    top: 8.w,
                                    right: 8.w,
                                    bottom: 8.w,
                                    left: 8.w),
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
                                    top: 8.w,
                                    right: 8.w,
                                    bottom: 8.w,
                                    left: 8.w),
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
                                                    /*fontFamily: 'Metropolis',*/)),
                                            value: value,
                                          ))
                                      .toList(),
                                  underline: const SizedBox(),
                                  onChanged: (DeliveryPeriod? value) {
                                    setState(() {
                                      deliveryPeriod = value!;
                                    });
                                    createRequestModel
                                            .fbp_delivery_period_idfk =
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
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButtonWithoutIcon(
                          callback: () {
                            showGenericDialog(
                                "Alert",
                                'Are you sure, you want to update specification?',
                                context,
                                StylishDialogType.WARNING,
                                "Confirm", () {
                              Logger()
                                  .e(createRequestModel.toJson().toString());
                              ProgressDialogUtil.showDialog(
                                  context, "Please wait..");
                              ApiService.createSpecification(
                                      createRequestModel, "")
                                  .then((value) {
                                ProgressDialogUtil.hideDialog();
                                if (value.status) {
                                  Logger().e(value.toJson().toString());
                                  // Fluttertoast.showToast(msg: value.message);
                                  if (value.responseCode == 205) {
                                    showGenericDialog(
                                        "Alert",
                                        value.message,
                                        context,
                                        StylishDialogType.WARNING,
                                        "My Products", () {
                                      Navigator.pop(context);
                                      openMyAdsScreen(context);
                                    });
                                  } else {
                                    log(value.message);
                                    Navigator.pop(context);
                                    if (specification == null) {
                                      log('yarn s');
                                      final yarnSpecificationsProvider =
                                          Provider.of<
                                                  YarnSpecificationsProvider>(
                                              context,
                                              listen: false);
                                      yarnSpecificationsProvider
                                          .getUpdatedYarnSpecificationsData();
                                    } else {
                                      final fiberSpecificationsProvider =
                                          Provider.of<
                                                  FiberSpecificationsProvider>(
                                              context,
                                              listen: false);
                                      fiberSpecificationsProvider
                                          .getUpdatedFiberSpecificationsData();
                                    }
                                  }
                                } else {
                                  Ui.showSnackBar(context, value.message);
                                }
                              }).onError((error, stackTrace) {
                                ProgressDialogUtil.hideDialog();
                                Ui.showSnackBar(context, error.toString());
                              });
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
    });
  }*/

  static void updateDialog(context, YarnSpecification? yarnSpecification,
      Specification? specification, dynamic specObj) {
    final TextEditingController controllerUpdatePrice = TextEditingController();
    final TextEditingController controllerAvailQ = TextEditingController();
    late List<DeliveryPeriod> deliveryPeriodList;
    late DeliveryPeriod deliveryPeriod;
    var isSwitched = true;
    var strActive = "Active";
    //  final CreateRequestModel createRequestModel = CreateRequestModel();
    final UpdateFabricRequestModel updateFabricRequestModel =
    UpdateFabricRequestModel();

    if (specification != null) {
      controllerUpdatePrice.text =
          specification.priceUnit!.replaceAll(RegExp(r'[^0-9]'), '');
      controllerAvailQ.text = specification.available != null && specification.available!.isNotEmpty ? specification.available! : "0";
      updateFabricRequestModel.category_id = 1.toString();
      updateFabricRequestModel.specification_id = specification.spcId.toString();
      updateFabricRequestModel.specification_rate = controllerUpdatePrice.text.toString();
      updateFabricRequestModel.specification_quantity = controllerAvailQ.text;
      updateFabricRequestModel.specification_status = isSwitched ? "1" : "0";
    } else if (yarnSpecification != null) {
      controllerUpdatePrice.text =
          yarnSpecification.priceUnit!.replaceAll(RegExp(r'[^0-9]'), '');
      controllerAvailQ.text = yarnSpecification.available != null && yarnSpecification.available!.isNotEmpty ? yarnSpecification.available! : "0";
      updateFabricRequestModel.category_id = 2.toString();
      updateFabricRequestModel.specification_id = yarnSpecification.ysId.toString();
      updateFabricRequestModel.specification_rate = controllerUpdatePrice.text.toString();
      updateFabricRequestModel.specification_quantity = controllerAvailQ.text;
      updateFabricRequestModel.specification_status = isSwitched ? "1" : "0";
    } else if (specObj is FabricSpecification) {
      var fabricSpecification = specObj;
      controllerUpdatePrice.text =
          fabricSpecification.priceUnit!.replaceAll(RegExp(r'[^0-9]'), '');
      controllerAvailQ.text = fabricSpecification.available != null && fabricSpecification.available!.isNotEmpty ? fabricSpecification.available! : "0";
      updateFabricRequestModel.category_id = 3.toString();
      updateFabricRequestModel.specification_id =
          fabricSpecification.fsId.toString();
      updateFabricRequestModel.specification_rate =
          controllerUpdatePrice.text.toString();
      updateFabricRequestModel.specification_quantity = controllerAvailQ.text;
      updateFabricRequestModel.specification_status = isSwitched ? "1" : "0";
    }

    AppDbInstance().getDeliveryPeriod().then((value1) {
      if (specification != null) {
        var period = specification.deliveryPeriod;
        deliveryPeriod =
            value1.where((element) => element.dprName == period).first;
        updateFabricRequestModel.specification_delivery_period =
            deliveryPeriod.dprId.toString();
      } else if (yarnSpecification != null) {
        var period = yarnSpecification.deliveryPeriod;
        deliveryPeriod =
            value1.where((element) => element.dprName == period).first;
        updateFabricRequestModel.specification_delivery_period =
            deliveryPeriod.dprId.toString();
      } else if (specObj is FabricSpecification) {
        var fabricSpecification = specObj;
        var period = fabricSpecification.deliveryPeriod;
        deliveryPeriod =
            value1.where((element) => element.dprName == period).first;
        updateFabricRequestModel.specification_delivery_period =
            deliveryPeriod.dprId.toString();
      }
      deliveryPeriodList = value1;

      showGeneralDialog(
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
                            flex: 2,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Image.asset(
                                  ic_update_header,
                                  fit: BoxFit.cover,
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
                          ),
                          Expanded(
                            flex: 9,
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        TitleMediumTextWidget(
                                            title: isSwitched
                                                ? strActive = "Active"
                                                : "InActive"),
                                        Switch(
                                          onChanged: (bool value) {
                                            setState(() {
                                              isSwitched = value;
                                            });
                                            if (specObj is FabricSpecification) {
                                              if (value) {
                                                updateFabricRequestModel
                                                    .specification_status = "1";
                                              } else {
                                                updateFabricRequestModel
                                                    .specification_status = "0";
                                              }
                                            } else {
                                              if (value) {
                                                updateFabricRequestModel.specification_status = "1";
                                              } else {
                                                updateFabricRequestModel.specification_status = "0";
                                              }
                                            }
                                          },
                                          value: isSwitched,
                                          activeColor: Colors.green,
                                          activeTrackColor: Colors.green.shade200,
                                          inactiveThumbColor: Colors.grey,
                                          inactiveTrackColor: Colors.grey.shade200,
                                        ),
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
                                        top: 8.w,
                                        right: 8.w,
                                        bottom: 8.w,
                                        left: 8.w),
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
                                                if (specObj
                                                is FabricSpecification) {
                                                  updateFabricRequestModel
                                                      .specification_rate = value;
                                                } else {
                                                  updateFabricRequestModel.specification_rate =
                                                      value;
                                                }
                                              }
                                            },
                                          ),
                                          flex: 9,
                                        ),
                                        Expanded(
                                            child: TitleSmallTextWidget(
                                                title: specification != null
                                                    ? '/${specification.priceUnit.toString().replaceAll(RegExp(r'[^a-zA-Z$]'), '')}'
                                                    : yarnSpecification != null
                                                    ? '/${yarnSpecification.priceUnit.toString().replaceAll(RegExp(r'[^a-zA-Z$]'), '')}'
                                                    : '/${(specObj as FabricSpecification).priceUnit.toString().replaceAll(RegExp(r'[^a-zA-Z$]'), '')}'))
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
                                        top: 8.w,
                                        right: 8.w,
                                        bottom: 8.w,
                                        left: 8.w),
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
                                                if (specObj
                                                is FabricSpecification) {
                                                  updateFabricRequestModel
                                                      .specification_quantity =
                                                      value;
                                                } else {
                                                  updateFabricRequestModel.specification_quantity=
                                                      value;
                                                }
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
                                        top: 8.w,
                                        right: 8.w,
                                        bottom: 8.w,
                                        left: 8.w),
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
                                                    /*fontFamily: 'Metropolis',*/)),
                                            value: value,
                                          ))
                                          .toList(),
                                      underline: const SizedBox(),
                                      onChanged: (DeliveryPeriod? value) {
                                        setState(() {
                                          deliveryPeriod = value!;
                                        });
                                        if (specObj is FabricSpecification) {
                                          updateFabricRequestModel
                                              .specification_delivery_period =
                                              value!.dprId.toString();
                                        } else {
                                          updateFabricRequestModel.specification_delivery_period =
                                              value!.dprId.toString();
                                        }
                                      },
                                      // value: widget.syncFiberResponse.data.fiber.countries.first,
                                      style: TextStyle(
                                          fontSize: 11.sp, color: textColorGrey),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButtonWithoutIcon(
                              callback: () {
                                showGenericDialog(
                                    "Alert",
                                    'Are you sure, you want to update specification?',
                                    context,
                                    StylishDialogType.WARNING,
                                    "Confirm", () {
                                  Logger().e(updateFabricRequestModel
                                      .toJson()
                                      .toString());
                                  ProgressDialogUtil.showDialog(
                                      context, "Please wait..");
                                  ApiService.updateFabricSpecification(
                                      updateFabricRequestModel, "")
                                      .then((value) {
                                    ProgressDialogUtil.hideDialog();
                                    if (value.status!) {
                                      Logger().e(value.toJson().toString());
                                      // Fluttertoast.showToast(msg: value.message);
                                      if (value.responseCode == 205) {
                                        showGenericDialog(
                                            "Alert",
                                            value.message!,
                                            context,
                                            StylishDialogType.WARNING,
                                            "My Products", () {
                                          Navigator.pop(context);
                                          openMyAdsScreen(context);
                                        });
                                      } else {
                                        Navigator.pop(context);
                                        if (yarnSpecification != null) {
                                          final yarnSpecificationsProvider =
                                          Provider.of<
                                              YarnSpecificationsProvider>(
                                              context,
                                              listen: false);
                                          yarnSpecificationsProvider
                                              .getUpdatedYarnSpecificationsData();
                                        } else if(specification != null) {
                                          final _fiberSpecificationsProvider = locator<FiberSpecificationProvider>();
                                          _fiberSpecificationsProvider
                                              .getUpdatedFiberSpecificationsData();
                                        }else if(specObj is FabricSpecification){
                                          final fabricSpecificationsProvider =
                                          Provider.of<FabricSpecificationsProvider>(
                                              context,
                                              listen: false);
                                          fabricSpecificationsProvider
                                              .getUpdatedFabricSpecificationsData();
                                        }
                                      }
                                    } else {
                                      Ui.showSnackBar(context, value.message!);
                                    }
                                  }).onError((error, stackTrace) {
                                    ProgressDialogUtil.hideDialog();
                                    Ui.showSnackBar(context, error.toString());
                                  });
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
    });
  }

  static Future<String> getUserId() async {
    return await SharedPreferenceUtil.getStringValuesSF(USER_ID_KEY);
  }

  static String? validateMobile(String value) {
    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = RegExp(pattern);
    if (value.isEmpty) {
      return 'Please enter mobile number';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter valid mobile number';
    }
    return null;
  }

  static stockLotSubCategoryTitle(StockLotSpecification specification) {
    String? subCategory;
    for (var element in specification.specDetails!) {
      if (subCategory == null) {
        subCategory = element.subCategory;
      } else {
        subCategory = "$subCategory,${element.subCategory}";
      }
    }

    return subCategory;
  }

  static stockLotPriceRange(StockLotSpecification specification) {
    String? priceRange;
    int min = int.parse(specification.specDetails!.first.price!),
        max = int.parse(specification.specDetails!.first.price!);
    String? minUnit;
    String? maxUnit;
    for (var element in specification.specDetails!) {
      if (int.parse(element.price!) < min) {
        min = int.parse(element.price!);
        if (element.priceUnit != null) {
          minUnit = element.priceUnit!.split(" ").first;
        }
      } else {
        if (element.priceUnit != null) {
          minUnit = element.priceUnit!.split(" ").first;
        }
      }
    }

    for (var element in specification.specDetails!) {
      if (int.parse(element.price!) > max) {
        max = int.parse(element.price!);
        if (element.priceUnit != null) {
          maxUnit = element.priceUnit!.split(" ").first;
        }
      } else {
        if (element.priceUnit != null) {
          maxUnit = element.priceUnit!.split(" ").first;
        }
      }
    }

    priceRange = '$min - $max/${maxUnit??""}';
    return [
      // TextSpan(
      //   text:
      //   '${specification.priceUnit.toString().replaceAll(RegExp(r'[^a-zA-Z$]'), '')}.',
      //   style: TextStyle(
      //       color: Colors.black,
      //       fontSize: 12.sp,
      //       // /*fontFamily: 'Metropolis',*/,
      //       fontWeight: FontWeight.w500),
      // ),
      TextSpan(
        text: '$min - $max'/*'1000'*/,
        style: TextStyle(
            color: Colors.black,
            fontSize: 17.sp,
            // /*fontFamily: 'Metropolis',*/,
            fontWeight: FontWeight.w600),
      ),
      TextSpan(
        text:
        "/${maxUnit??""}",
        style: TextStyle(
            color: Colors.black,
            fontSize: 12.sp,
            // /*fontFamily: 'Metropolis',*/,
            fontWeight: FontWeight.w500),
      ),
    ];
  }

  static stockLotPriceMin(StockLotSpecification specification) {
    int min = int.parse(specification.specDetails!.first.price!);
    for (var element in specification.specDetails!) {
      if (int.parse(element.price!) < min) {
        min = int.parse(element.price!);
      }
    }
    return min;
  }

  static stockLotPriceMax(StockLotSpecification specification) {
    int max = int.parse(specification.specDetails!.first.price!);
    for (var element in specification.specDetails!) {
      if (int.parse(element.price!) > max) {
        max = int.parse(element.price!);
      }
    }
  }
}
