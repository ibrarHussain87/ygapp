import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:yg_app/api_services/api_service_class.dart';
import 'package:yg_app/model/request/post_ad_request/fiber_request.dart';
import 'package:yg_app/model/response/common_response_models/city_state_response.dart';
import 'package:yg_app/model/response/common_response_models/countries_response.dart';
import 'package:yg_app/model/response/common_response_models/ports_response.dart';
import 'package:yg_app/model/response/fiber_response/sync/sync_fiber_response.dart';
import 'package:yg_app/utils/colors.dart';
import 'package:yg_app/utils/progress_dialog_util.dart';
import 'package:yg_app/utils/show_messgae_util.dart';
import 'package:yg_app/utils/strings.dart';
import 'package:yg_app/widgets/add_picture_widget.dart';
import 'package:yg_app/widgets/decoration_widgets.dart';
import 'package:yg_app/widgets/elevated_button_widget.dart';
import 'package:yg_app/widgets/grid_tile_widget.dart';
import 'package:yg_app/widgets/title_text_widget.dart';

class PackagingDetails extends StatefulWidget {

  final SyncFiberResponse syncFiberResponse;
  final String? locality;
  final String? businessArea;
  final String? selectedTab;

  const PackagingDetails(
      {Key? key,
      // required this.requestModel,
      required this.syncFiberResponse,
      required this.locality,
      required this.businessArea,
      required this.selectedTab})
      : super(key: key);

  @override
  _PackagingDetailsState createState() => _PackagingDetailsState();
}

class _PackagingDetailsState extends State<PackagingDetails>
    with AutomaticKeepAliveClientMixin {
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<String> sellingRegion = [];
  List<PickedFile> imageFiles = [];

  // FiberPriceTerms? _fiberPriceTerms;
  // PackingModel? _packingModel;
  // FiberDeliveryPeriod? _fiberDeliveryPeriod;
  // PaymentTypeModel? _paymentTypeModel;
  // LcTypeModel? _lcTypeModel;
  FiberRequestModel? _fiberRequestModel;

  @override
  void initState() {
    //INITIAL VALUES
    sellingRegion.add(widget.locality.toString());
    super.initState();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    _fiberRequestModel = Provider.of<FiberRequestModel?>(context);
    _initialValuesRequestModel();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(top: 16.w, left: 16.w, right: 16.w),
                child: Form(
                  key: globalFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TitleTextWidget(
                        title: AppStrings.packingDetails,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 8.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                                padding: EdgeInsets.only(left: 8.w),
                                child: TitleSmallTextWidget(
                                    title: AppStrings.sellingRegion)),
                            GridTileWidget(
                              spanCount: 2,
                              listOfItems: sellingRegion,
                              callback: (value) {},
                              selectedIndex: 0,
                            ),
                            Visibility(
                              visible:
                                  widget.locality == AppStrings.international
                                      ? true
                                      : false,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.only(top: 8.w),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                              padding:
                                                  EdgeInsets.only(left: 8.w),
                                              child: TitleSmallTextWidget(
                                                  title: AppStrings.country)),
                                          SizedBox(
                                            height: 36.w,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color:
                                                        AppColors.lightBlueTabs,
                                                    width:
                                                        1, //                   <--- border width here
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              24.w))),
                                              child: DropdownButtonFormField(
                                                hint: const Text(
                                                    'Select Country'),
                                                items: widget.syncFiberResponse
                                                    .data.fiber.countries
                                                    .map((value) =>
                                                        DropdownMenuItem(
                                                          child: Text(
                                                              value.conName,
                                                              textAlign:
                                                                  TextAlign
                                                                      .center),
                                                          value: value,
                                                        ))
                                                    .toList(),
                                                isExpanded: true,
                                                onChanged:
                                                    (Countries? value) {
                                                  _fiberRequestModel!
                                                          .spc_origin_idfk =
                                                      value!.conId.toString();
                                                },

                                                // value: widget.syncFiberResponse.data.fiber.brands.first,
                                                decoration: InputDecoration(
                                                  contentPadding:
                                                      EdgeInsets.only(
                                                          left: 16.w,
                                                          right: 6.w,
                                                          top: 0,
                                                          bottom: 0),
                                                  border:
                                                      const OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide.none),
                                                ),
                                                style: TextStyle(
                                                    fontSize: 11.sp,
                                                    color: AppColors
                                                        .textColorGrey),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 16.w),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.only(top: 8.w),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                              padding:
                                                  EdgeInsets.only(left: 8.w),
                                              child: TitleSmallTextWidget(
                                                  title: AppStrings.port)),
                                          SizedBox(
                                            height: 36.w,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color:
                                                        AppColors.lightBlueTabs,
                                                    width:
                                                        1, //                   <--- border width here
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              24.w))),
                                              child: DropdownButtonFormField(
                                                hint: const Text('Select Port'),
                                                items: widget.syncFiberResponse
                                                    .data.fiber.ports
                                                    .map((value) =>
                                                        DropdownMenuItem(
                                                          child: Text(
                                                              value.prtName,
                                                              textAlign:
                                                                  TextAlign
                                                                      .center),
                                                          value: value,
                                                        ))
                                                    .toList(),
                                                isExpanded: true,
                                                onChanged: (Ports? value) {
                                                  _fiberRequestModel!
                                                          .spc_port_idfk =
                                                      value!.prtId.toString();
                                                },

                                                // value: widget.syncFiberResponse.data.fiber.brands.first,
                                                decoration: InputDecoration(
                                                  contentPadding:
                                                      EdgeInsets.only(
                                                          left: 16.w,
                                                          right: 6.w,
                                                          top: 0,
                                                          bottom: 0),
                                                  border:
                                                      const OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide.none),
                                                ),
                                                style: TextStyle(
                                                    fontSize: 11.sp,
                                                    color: AppColors
                                                        .textColorGrey),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Visibility(
                                visible:
                                widget.locality == AppStrings.international
                                    ? true
                                    : false,
                                child: Padding(
                                  padding: EdgeInsets.only(top: 8.w),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                          padding:
                                          EdgeInsets.only(left: 8.w),
                                          child: TitleSmallTextWidget(
                                              title: AppStrings.cityState)),
                                      SizedBox(
                                        height: 36.w,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                color:
                                                AppColors.lightBlueTabs,
                                                width:
                                                1, //                   <--- border width here
                                              ),
                                              borderRadius:
                                              BorderRadius.all(
                                                  Radius.circular(
                                                      24.w))),
                                          child: DropdownButtonFormField(
                                            hint: Text(
                                                'Select ${AppStrings.cityState}'),
                                            items: widget.syncFiberResponse
                                                .data.fiber.cityState
                                                .map((value) =>
                                                DropdownMenuItem(
                                                  child: Text(
                                                      value.name,
                                                      textAlign:
                                                      TextAlign
                                                          .center),
                                                  value: value,
                                                ))
                                                .toList(),
                                            isExpanded: true,
                                            onChanged:
                                                (CityState? value) {
                                              _fiberRequestModel!
                                                  .spc_city_state_idfk =
                                                  value!.countryId.toString();
                                            },

                                            // value: widget.syncFiberResponse.data.fiber.brands.first,
                                            decoration: InputDecoration(
                                              contentPadding:
                                              EdgeInsets.only(
                                                  left: 16.w,
                                                  right: 6.w,
                                                  top: 0,
                                                  bottom: 0),
                                              border:
                                              const OutlineInputBorder(
                                                  borderSide:
                                                  BorderSide.none),
                                            ),
                                            style: TextStyle(
                                                fontSize: 11.sp,
                                                color: AppColors
                                                    .textColorGrey),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                            Padding(
                                padding: EdgeInsets.only(top: 8.w, left: 8.w),
                                child: TitleSmallTextWidget(
                                    title: AppStrings.priceTerms)),
                            GridTileWidget(
                                spanCount: 3,
                                listOfItems: widget
                                    .syncFiberResponse.data.fiber.priceTerms,
                                callback: (value) {
                                  _fiberRequestModel!.fbp_price_terms_idfk =
                                      widget.syncFiberResponse.data.fiber
                                          .priceTerms[value].ptrId
                                          .toString();
                                }),
                            Visibility(
                                visible:
                                    widget.locality == AppStrings.international
                                        ? true
                                        : false,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.only(
                                            top: 8.w, left: 8.w),
                                        child: TitleSmallTextWidget(
                                            title: AppStrings.paymentType)),
                                    GridTileWidget(
                                        spanCount: 3,
                                        listOfItems: widget.syncFiberResponse
                                            .data.fiber.paymentType,
                                        callback: (value) {
                                          _fiberRequestModel!
                                                  .payment_type_idfk =
                                              widget
                                                  .syncFiberResponse
                                                  .data
                                                  .fiber
                                                  .paymentType[value]
                                                  .payId;
                                        }),
                                  ],
                                )),
                            Visibility(
                              visible:
                                  widget.locality == AppStrings.international
                                      ? true
                                      : false,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                      padding:
                                          EdgeInsets.only(top: 8.w, left: 8.w),
                                      child: TitleSmallTextWidget(
                                          title: AppStrings.lcType)),
                                  GridTileWidget(
                                      spanCount: 4,
                                      listOfItems: widget
                                          .syncFiberResponse.data.fiber.lcType,
                                      callback: (value) {
                                        if (_fiberRequestModel != null) {
                                          _fiberRequestModel!.lc_type_idfk =
                                              widget.syncFiberResponse.data
                                                  .fiber.lcType[value].lcId
                                                  .toString();
                                        }
                                      }),
                                ],
                              ),
                            ),
                            Visibility(
                              visible:
                                  widget.locality == AppStrings.international
                                      ? true
                                      : false,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                      padding:
                                          EdgeInsets.only(top: 8.w, left: 8.w),
                                      child: TitleSmallTextWidget(
                                          title: AppStrings.unitCount)),
                                  GridTileWidget(
                                      spanCount: 4,
                                      listOfItems: widget
                                          .syncFiberResponse.data.fiber.units,
                                      callback: (value) {
                                        if (_fiberRequestModel != null) {
                                          _fiberRequestModel!
                                                  .fbp_count_unit_idfk =
                                              widget.syncFiberResponse.data
                                                  .fiber.units[value].untId
                                                  .toString();
                                        }
                                      }),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.only(
                                            top: 8.w, left: 8.w),
                                        child: TitleSmallTextWidget(
                                            title: AppStrings.priceUnits)),
                                    TextFormField(
                                        keyboardType: TextInputType.number,
                                        cursorColor: AppColors.lightBlueTabs,
                                        style: TextStyle(fontSize: 11.sp),
                                        textAlign: TextAlign.center,
                                        cursorHeight: 16.w,
                                        maxLines: 1,
                                        onSaved: (input) {
                                          if (_fiberRequestModel != null) {
                                            _fiberRequestModel!.fbp_price =
                                                input!;
                                          }
                                        },
                                        validator: (input) {
                                          if (input == null || input.isEmpty) {
                                            return AppStrings.priceUnits;
                                          }
                                          return null;
                                        },
                                        decoration: roundedTextFieldDecoration(
                                            AppStrings.priceUnits)),
                                  ],
                                )),
                                SizedBox(width: 16.w),
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.only(
                                            top: 8.w, left: 8.w),
                                        child: TitleSmallTextWidget(
                                            title: AppStrings.minQty)),
                                    TextFormField(
                                        keyboardType: TextInputType.number,
                                        cursorColor: AppColors.lightBlueTabs,
                                        style: TextStyle(fontSize: 11.sp),
                                        textAlign: TextAlign.center,
                                        cursorHeight: 16.w,
                                        maxLines: 1,
                                        onSaved: (input) {
                                          if (_fiberRequestModel != null) {
                                            _fiberRequestModel!
                                                .fbp_min_quantity = input!;
                                          }
                                        },
                                        validator: (input) {
                                          if (input == null || input.isEmpty) {
                                            return AppStrings.minQty;
                                          }
                                          return null;
                                        },
                                        decoration: roundedTextFieldDecoration(
                                            AppStrings.minQty)),
                                  ],
                                )),
                              ],
                            ),
                            Padding(
                                padding: EdgeInsets.only(top: 8.w, left: 8.w),
                                child: TitleSmallTextWidget(
                                    title: AppStrings.packing)),
                            GridTileWidget(
                                spanCount: 3,
                                listOfItems: widget
                                    .syncFiberResponse.data.fiber.packing,
                                callback: (value) {
                                  if (_fiberRequestModel != null) {
                                    _fiberRequestModel!.packing_idfk = widget
                                        .syncFiberResponse
                                        .data
                                        .fiber
                                        .packing[value]
                                        .pacId
                                        .toString();
                                  }
                                }),
                            Padding(
                                padding: EdgeInsets.only(top: 8.w, left: 8.w),
                                child: TitleSmallTextWidget(
                                    title: AppStrings.deliveryPeriod)),
                            GridTileWidget(
                                spanCount: 3,
                                listOfItems: widget.syncFiberResponse.data
                                    .fiber.deliveryPeriod,
                                callback: (value) {
                                  if (_fiberRequestModel != null) {
                                    _fiberRequestModel!
                                            .fbp_delivery_period_idfk =
                                        widget.syncFiberResponse.data.fiber
                                            .deliveryPeriod[value].dprId
                                            .toString();
                                  }
                                }),
                            Padding(
                                padding: EdgeInsets.only(top: 8.w, left: 8.w),
                                child: TitleSmallTextWidget(
                                    title: AppStrings.descriptionStr)),
                            SizedBox(
                              height: 5 * 22.w,
                              child: TextFormField(
                                  keyboardType: TextInputType.text,
                                  maxLines: 5,
                                  cursorColor: AppColors.lightBlueTabs,
                                  style: TextStyle(fontSize: 11.sp),
                                  textAlign: TextAlign.start,
                                  cursorHeight: 16.w,
                                  onSaved: (input) {
                                    if (_fiberRequestModel != null) {
                                      _fiberRequestModel!.fbp_description =
                                          input!;
                                    }
                                  },
                                  validator: (input) {
                                    if (input == null || input.isEmpty) {
                                      return AppStrings.descriptionStr;
                                    }
                                    return null;
                                  },
                                  decoration: roundedDescriptionDecoration(
                                      AppStrings.descriptionStr)),
                            ),
                            AddPictureWidget(
                              imageCount: 1,
                              callbackImages: (value) {
                                imageFiles = value;
                              },
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            flex: 9,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(8.w),
              child: SizedBox(
                width: double.maxFinite,
                child: ElevatedButtonWithIcon(
                  callback: () {
                    if (validateAndSave()) {
                      if (_fiberRequestModel != null) {
                        _fiberRequestModel!.spc_local_international =
                            widget.locality!.toUpperCase();

                        ProgressDialogUtil.showDialog(
                            context, 'Please wait...');

                        ApiService.multipartProdecudre(
                                _fiberRequestModel!, imageFiles[0].path)
                            .then((value) {
                          ProgressDialogUtil.hideDialog();
                          if (value.status) {
                            Fluttertoast.showToast(msg: value.message);
                            Navigator.pop(context);
                          } else {
                            ShowMessageUtils.showSnackBar(
                                context, value.message);
                          }
                        }).onError((error, stackTrace) {
                          ProgressDialogUtil.hideDialog();
                          ShowMessageUtils.showSnackBar(
                              context, error.toString());
                        });
                      }
                    }
                  },
                  color: AppColors.btnColorLogin,
                  btnText: AppStrings.submit,
                ),
              ),
            ),
            flex: 1,
          ),
        ],
      ),
    );
  }

  _initialValuesRequestModel() {
    if (widget.locality == AppStrings.international) {
      _fiberRequestModel!.lc_type_idfk =
          widget.syncFiberResponse.data.fiber.lcType.first.lcId.toString();
      _fiberRequestModel!.fbp_count_unit_idfk =
          widget.syncFiberResponse.data.fiber.units.first.untId.toString();
    }

    _fiberRequestModel!.is_offering = widget.selectedTab;

    _fiberRequestModel!.fbp_price_terms_idfk =
        widget.syncFiberResponse.data.fiber.priceTerms.first.ptrId.toString();
    _fiberRequestModel!.packing_idfk =
        widget.syncFiberResponse.data.fiber.packing.first.pacId.toString();
    _fiberRequestModel!.fbp_delivery_period_idfk = widget
        .syncFiberResponse.data.fiber.deliveryPeriod.first.dprId
        .toString();
  }

  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form!.validate()) {
      if (imageFiles.isNotEmpty) {
        form.save();
        return true;
      } else {
        Scaffold.of(context).showSnackBar(
            const SnackBar(content: Text('Please Capture Image first')));
      }
    }
    return false;
  }
}
