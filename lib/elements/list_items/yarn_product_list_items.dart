import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:yg_app/api_services/api_service_class.dart';
import 'package:yg_app/app_database/app_database_instance.dart';
import 'package:yg_app/elements/list_widgets/bg_light_blue_text_widget.dart';
import 'package:yg_app/elements/list_widgets/brand_text.dart';
import 'package:yg_app/elements/list_widgets/short_detail_widget.dart';
import 'package:yg_app/elements/list_widgets/verified_supplier.dart';
import 'package:yg_app/elements/title_text_widget.dart';
import 'package:yg_app/helper_utils/app_colors.dart';
import 'package:yg_app/helper_utils/progress_dialog_util.dart';
import 'package:yg_app/helper_utils/ui_utils.dart';
import 'package:yg_app/helper_utils/util.dart';
import 'package:yg_app/model/request/post_ad_request/create_request_model.dart';
import 'package:yg_app/model/response/yarn_response/yarn_specification_response.dart';

import '../../helper_utils/app_images.dart';
import '../../helper_utils/navigation_utils.dart';
import '../../model/response/common_response_models/delievery_period.dart';
import '../elevated_button_widget_2.dart';

class BuildYarnProductWidget extends StatefulWidget {
  final YarnSpecification specification;

  const BuildYarnProductWidget({Key? key, required this.specification})
      : super(key: key);

  @override
  _BuildYarnProductWidgetState createState() => _BuildYarnProductWidgetState();
}

class _BuildYarnProductWidgetState extends State<BuildYarnProductWidget> {
  final TextEditingController _controllerUpdatePrice = TextEditingController();
  final TextEditingController _controllerAvailQ = TextEditingController();
  late List<DeliveryPeriod> _deliveryPeriodList;
  late DeliveryPeriod _deliveryPeriod;
  final CreateRequestModel _createRequestModel = CreateRequestModel();

  @override
  void initState() {
    // TODO: implement initState
    _controllerUpdatePrice.text =
        widget.specification.priceUnit!.replaceAll(RegExp(r'[^0-9]'), '');
    _controllerAvailQ.text = widget.specification.available ?? "";
    _createRequestModel.ys_id = widget.specification.ysId.toString();
    _createRequestModel.spc_category_idfk = "2";

    AppDbInstance().getDeliveryPeriod().then((value) {
      setState(() {
        _deliveryPeriod = value
            .where((element) =>
                element.dprName == widget.specification.deliveryPeriod)
            .first;
        _deliveryPeriodList = value;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.white,
        elevation: /*18.0*/0,
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
                    padding:
                        EdgeInsets.symmetric(horizontal: 3.w, vertical: 3.w),
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
                        /*fontFamily: 'Metropolis',*/
                        fontWeight: FontWeight.bold,
                      ),
                    )),
              ),
            ),
            SizedBox(
              height: 1.w,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /*Expanded(
                  flex: 1,
                  child: */ /*specification.pictures.isNotEmpty
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
                      : ErrorImageWidget())*/ /*
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
                                constraints:
                                    const BoxConstraints(maxHeight: 19),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 1),
                                  child: Center(
                                      child: FittedBox(
                                    fit: BoxFit.contain,
                                    child: TitleBoldSmallTextWidget(
                                      title:
                                      Utils.setFamilyData(widget.specification),
                                      color: Colors.white,
                                    ),
                                  )),
                                )),
                            SizedBox(
                              width: 4.w,
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 4),
                                child: TitleMediumTextWidget(
                                  title: Utils.setTitleData(widget.specification),
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
                                  visible: Ui.showHide(
                                      widget.specification.is_verified),
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
                            title: Utils.setDetailsData(widget.specification),
                            color: lightGreyColor,
                            size: 10.sp,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 40.w),
                          child: widget.specification.yarnFamilyId != "4"? Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Expanded(
                                child: BgLightBlueTextWidget(
                                  title:
                                      'AC ${widget.specification.actualYarnCount}',
                                  color: lightBlueLabel,
                                ),
                                flex: 1,
                              ),
                              SizedBox(width: 8.w),
                              Expanded(
                                child: BgLightBlueTextWidget(
                                  title: 'CLSP ${widget.specification.clsp}',
                                  color: lightBlueLabel,
                                ),
                                flex: 1,
                              ),
                              SizedBox(width: 8.w),
                              Expanded(
                                child: BgLightBlueTextWidget(
                                  title:
                                      'IPI ${widget.specification.actualYarnCount}',
                                  color: lightBlueLabel,
                                ),
                                flex: 1,
                              ),
                            ],
                          ) : Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Expanded(
                                child: BgLightBlueTextWidget(
                                  title:
                                  'Q ${widget.specification.yarnQuality}',
                                  color: lightBlueLabel,
                                ),
                                flex: 1,
                              ),
                              SizedBox(width: 8.w),
                              Expanded(
                                child: BgLightBlueTextWidget(
                                  title: 'A ${widget.specification.yarnApperance ?? ""}',
                                  color: lightBlueLabel,
                                ),
                                flex: 1,
                              ),
                              SizedBox(width: 8.w),
                              Expanded(
                                child: BgLightBlueTextWidget(
                                  title:
                                  'G ${widget.specification.yarnGrade ?? ""}',
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
                                    title: widget.specification.weightBag ??
                                        Utils.checkNullString(false),
                                    imageIcon: 'images/img_bag.png',
                                    size: 9.sp,
                                    iconSize: 14,
                                  ),
                                  ShortDetailWidget(
                                    title: widget.specification.weightCone ??
                                        Utils.checkNullString(false),
                                    imageIcon: 'images/img_cone.png',
                                    size: 9.sp,
                                    iconSize: 14,
                                  ),
                                  ShortDetailWidget(
                                    title:
                                        widget.specification.deliveryPeriod ??
                                            Utils.checkNullString(false),
                                    imageIcon: 'images/img_van.png',
                                    size: 9.sp,
                                    iconSize: 14,
                                  ),
                                  ShortDetailWidget(
                                    title: widget.specification.locality ??
                                        Utils.checkNullString(false),
                                    imageIcon: 'images/img_location.png',
                                    size: 9.sp,
                                    iconSize: 14,
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
                    padding: const EdgeInsets.only(right: 15.0, bottom: 4),
                    child: Container(
                      padding: EdgeInsets.only(left: 6.w, right: 0.w, top: 4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          /*TitleMediumTextWidget(
                          title: "PKR." +
                              widget.specification.priceUnit.toString() +
                              "/KG",
                        ),*/
                          Text.rich(TextSpan(children: [
                            TextSpan(
                              text:
                                  '${widget.specification.priceUnit.toString().replaceAll(RegExp(r'[^a-zA-Z$]'), '')}.',
                              /*text: '${'Pkr'.toString().replaceAll(RegExp(r'[^a-zA-Z$]'),'')}.',*/
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12.sp,
                                  /*fontFamily: 'Metropolis',*/
                                  fontWeight: FontWeight.w400),
                            ),
                            TextSpan(
                              text: widget.specification.priceUnit
                                  .toString()
                                  .replaceAll(RegExp(r'[^0-9]'), ''),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 17.sp,
                                  /*fontFamily: 'Metropolis',*/
                                  fontWeight: FontWeight.w600),
                            ),
                            TextSpan(
                              text: "/${widget.specification.unitCount??''}",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12.sp,
                                  /*fontFamily: 'Metropolis',*/
                                  fontWeight: FontWeight.w400),
                            ),
                          ])),
                          const TitleSmallNormalTextWidget(
                            title: "Ex- Factory",
                            size: 7,
                          ),
                          SizedBox(
                            height: 8.w,
                          ),
                          Text.rich(TextSpan(children: [
                            TextSpan(
                              text: "Updated",
                              style: TextStyle(
                                  fontSize: 7.sp, color: Colors.black),
                            ),
                          ])),
                          SizedBox(
                            height: 3.w,
                          ),
                          Text.rich(TextSpan(children: [
                            TextSpan(
                              text: "Nov 23, 4:33 PM",
                              style: TextStyle(
                                  fontSize: 8.sp,
                                  color: lightBlueLabel,
                                  fontWeight: FontWeight.w600),
                            )
                          ])),
                          SizedBox(
                            height: 8.w,
                          ),
                          Text.rich(TextSpan(children: [
                            TextSpan(
                              text: "Avail. Quantity",
                              style: TextStyle(
                                  fontSize: 7.sp, color: Colors.black),
                            ),
                          ])),
                          SizedBox(
                            height: 3.w,
                          ),
                          Text.rich(TextSpan(children: [
                            TextSpan(
                              text: "325",
                              style: TextStyle(
                                  fontSize: 8.sp,
                                  color: lightBlueLabel,
                                  fontWeight: FontWeight.w600),
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
              padding: EdgeInsets.only(
                  left: 18.w, right: 18.w, top: 3.w, bottom: 10.w),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        'Proposals',
                                        style: TextStyle(
                                            fontSize: 9.sp,
                                            color: Colors.black87,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      Text(
                                        '4',
                                        style: TextStyle(
                                            fontSize: 9.sp,
                                            color: greenButton,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      SizedBox(
                                        width: 3.w,
                                      )
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
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.w))),
                                      child: Center(
                                        child: Text(
                                          '3',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 8.sp,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                    ),
                                  ))
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4.w))),
                          child: Stack(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 6.w),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        'Matches',
                                        style: TextStyle(
                                            fontSize: 9.sp,
                                            color: Colors.black87,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      Text(
                                        '5',
                                        style: TextStyle(
                                            fontSize: 9.sp,
                                            color: greenButton,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      SizedBox(
                                        width: 3.w,
                                      )
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
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.w))),
                                      child: Center(
                                        child: Text(
                                          '3',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 8.sp,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                    ),
                                  ))
                            ],
                          ))),
                  SizedBox(
                    width: 60.w,
                  ),
                  SizedBox(
                    width: 64.w,
                    height: 24.w,
                    child: ElevatedButtonWithoutIcon(
                      btnText: "Update",
                      textSize: 8.sp,
                      callback: () {
                        Utils.updateDialog(context, widget.specification,null,null);
                      },
                      color: Colors.green,
                    ),
                  )
                ],
              ),
            ),

          ],
        ));
  }



  /*_updateDialog(context, YarnSpecification specification) {
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
                height: 270.h,
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
                                    controller: _controllerUpdatePrice,
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
                                        _createRequestModel.fbp_price = value;
                                      }
                                    },
                                  ),
                                  flex: 9,
                                ),
                                Expanded(
                                    child: TitleSmallTextWidget(
                                        title:
                                            '/${specification.priceUnit.toString().replaceAll(RegExp(r'[^a-zA-Z$]'), '')}'))
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
                                    controller: _controllerAvailQ,
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
                                        _createRequestModel
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
                              value: _deliveryPeriod,
                              items: _deliveryPeriodList
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
                                  _deliveryPeriod = value!;
                                });
                                _createRequestModel.fbp_delivery_period_idfk =
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
                                  _createRequestModel, "")
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
  }*/
}


