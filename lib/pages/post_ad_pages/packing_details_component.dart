import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yg_app/api_services/api_service_class.dart';
import 'package:yg_app/model/request/fiber_request.dart';
import 'package:yg_app/model/response/sync/common_response_models/countries_response.dart';
import 'package:yg_app/model/response/sync/common_response_models/lc_type_response.dart';
import 'package:yg_app/model/response/sync/common_response_models/packing_response.dart';
import 'package:yg_app/model/response/sync/common_response_models/payment_type_response.dart';
import 'package:yg_app/model/response/sync/common_response_models/ports_response.dart';
import 'package:yg_app/model/response/sync/fiber_sync_response/fiber_delievery_period.dart';
import 'package:yg_app/model/response/sync/fiber_sync_response/price_term.dart';
import 'package:yg_app/model/response/sync/fiber_sync_response/sync_fiber_response.dart';
import 'package:yg_app/pages/post_ad_pages/fiber_post/component/fiber_specification_component.dart';
import 'package:yg_app/utils/colors.dart';
import 'package:yg_app/utils/progress_dialog_util.dart';
import 'package:yg_app/widgets/add_picture_widget.dart';
import 'package:yg_app/widgets/decoration_widgets.dart';
import 'package:yg_app/widgets/elevated_button_widget.dart';
import 'package:yg_app/widgets/grid_tile_widget.dart';
import 'package:yg_app/widgets/title_text_widget.dart';

class PackagingDetails extends StatefulWidget {
  // FiberRequestModel? requestModel;
  SyncFiberResponse? syncFiberResponse;
  final String? businessArea;
  final String? selectedTab;

  PackagingDetails(
      {Key? key,
      // required this.requestModel,
      required this.syncFiberResponse,
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
  FiberPriceTerms? _fiberPriceTerms;
  PackingModel? _packingModel;
  FiberDeliveryPeriod? _fiberDeliveryPeriod;
  PaymentTypeModel? _paymentTypeModel;
  LcTypeModel? _lcTypeModel;
  FiberRequestModel? _fiberRequestModel;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    _fiberRequestModel = FiberSpecificationComponent.fiberRequestModel;
    sellingRegion.add(widget.businessArea.toString());
    _fiberPriceTerms = widget.syncFiberResponse!.data.fiber.priceTerms.first;
    _packingModel = widget.syncFiberResponse!.data.fiber.packing.first;
    _fiberDeliveryPeriod =
        widget.syncFiberResponse!.data.fiber.deliveryPeriod.first;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                      const TitleTextWidget(
                        title: 'Packing Details',
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 8.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                                padding: EdgeInsets.only(left: 8.w),
                                child: TitleSmallTextWidget(
                                    title: 'Selling Region')),
                            GridTileWidget(
                              spanCount: 2,
                              listOfItems: sellingRegion,
                              callback: (value) {},
                              selectedIndex: 0,
                            ),
                            Visibility(
                              visible: false,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(top: 8.w),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                            padding: EdgeInsets.only(left: 8.w),
                                            child: TitleSmallTextWidget(
                                                title: 'Country')),
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
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(24.w))),
                                            child: DropdownButtonFormField(
                                              hint: Text('Select Country'),
                                              items: widget.syncFiberResponse!
                                                  .data.fiber.countries
                                                  .map((value) =>
                                                      DropdownMenuItem(
                                                        child: Text(
                                                            value.conName,
                                                            textAlign: TextAlign
                                                                .center),
                                                        value: value,
                                                      ))
                                                  .toList(),
                                              onChanged:
                                                  (CountriesModel? value) {
                                                _fiberRequestModel!
                                                        .spc_origin_idfk =
                                                    value!.conId.toString();
                                              },

                                              // value: widget.syncFiberResponse.data.fiber.brands.first,
                                              decoration: InputDecoration(
                                                contentPadding: EdgeInsets.only(
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
                                                  color:
                                                      AppColors.textColorGrey),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 8.w),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                            padding: EdgeInsets.only(left: 8.w),
                                            child: TitleSmallTextWidget(
                                                title: 'Port')),
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
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(24.w))),
                                            child: DropdownButtonFormField(
                                              hint: Text('Select Port'),
                                              items: widget.syncFiberResponse!
                                                  .data.fiber.ports
                                                  .map((value) =>
                                                      DropdownMenuItem(
                                                        child: Text(
                                                            value.prtName,
                                                            textAlign: TextAlign
                                                                .center),
                                                        value: value,
                                                      ))
                                                  .toList(),
                                              onChanged: (PortsModel? value) {
                                                _fiberRequestModel!
                                                        .spc_origin_idfk =
                                                    value!.prtId.toString();
                                              },

                                              // value: widget.syncFiberResponse.data.fiber.brands.first,
                                              decoration: InputDecoration(
                                                contentPadding: EdgeInsets.only(
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
                                                  color:
                                                      AppColors.textColorGrey),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.only(top: 8.w, left: 8.w),
                                child:
                                    TitleSmallTextWidget(title: 'Price Terms')),
                            GridTileWidget(
                                spanCount: 3,
                                listOfItems: widget
                                    .syncFiberResponse!.data.fiber.priceTerms,
                                callback: (value) {
                                  _fiberPriceTerms = widget.syncFiberResponse!
                                      .data.fiber.priceTerms[value];
                                }),
                            Visibility(
                                visible: false,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.only(
                                            top: 8.w, left: 8.w),
                                        child: TitleSmallTextWidget(
                                            title: 'Payment Type')),
                                    GridTileWidget(
                                        spanCount: 3,
                                        listOfItems: widget.syncFiberResponse!
                                            .data.fiber.paymentType,
                                        callback: (value) {
                                          _paymentTypeModel = widget
                                              .syncFiberResponse!
                                              .data
                                              .fiber
                                              .paymentType[value];
                                        }),
                                  ],
                                )),
                            Visibility(
                              visible: false,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                      padding:
                                          EdgeInsets.only(top: 8.w, left: 8.w),
                                      child: TitleSmallTextWidget(
                                          title: 'LC Type')),
                                  GridTileWidget(
                                      spanCount: 4,
                                      listOfItems: widget
                                          .syncFiberResponse!.data.fiber.lcType,
                                      callback: (value) {
                                        if (_fiberRequestModel != null) {
                                          _lcTypeModel = widget
                                              .syncFiberResponse!
                                              .data
                                              .fiber
                                              .lcType[value];
                                        }
                                      }),
                                ],
                              ),
                            ),
                            Visibility(
                              visible: false,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                      padding:
                                          EdgeInsets.only(top: 8.w, left: 8.w),
                                      child: TitleSmallTextWidget(
                                          title: 'Unit Of Count')),
                                  GridTileWidget(
                                      spanCount: 4,
                                      listOfItems: widget
                                          .syncFiberResponse!.data.fiber.units,
                                      callback: (value) {
                                        if (_fiberRequestModel != null) {
                                          _fiberRequestModel!
                                                  .fbp_count_unit_idfk =
                                              (widget
                                                  .syncFiberResponse!
                                                  .data
                                                  .fiber
                                                  .units[value]
                                                  .untId as String?)!;
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
                                            title: 'Price/Unit')),
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
                                            return "Price/Unit";
                                          }
                                          return null;
                                        },
                                        decoration: roundedTextFieldDecoration(
                                            "Price/Unit")),
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
                                            title: 'Minimum Qty')),
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
                                            return "Minimum Qty";
                                          }
                                          return null;
                                        },
                                        decoration: roundedTextFieldDecoration(
                                            "Minimum Qty")),
                                  ],
                                )),
                              ],
                            ),
                            Padding(
                                padding: EdgeInsets.only(top: 8.w, left: 8.w),
                                child: TitleSmallTextWidget(title: 'Packing')),
                            GridTileWidget(
                                spanCount: 3,
                                listOfItems: widget
                                    .syncFiberResponse!.data.fiber.packing,
                                callback: (value) {
                                  if (_fiberRequestModel != null) {
                                    _packingModel = widget.syncFiberResponse!
                                        .data.fiber.packing[value];
                                  }
                                }),
                            Padding(
                                padding: EdgeInsets.only(top: 8.w, left: 8.w),
                                child: TitleSmallTextWidget(
                                    title: 'Deilevery Period')),
                            GridTileWidget(
                                spanCount: 3,
                                listOfItems: widget.syncFiberResponse!.data
                                    .fiber.deliveryPeriod,
                                callback: (value) {
                                  if (_fiberRequestModel != null) {
                                    _fiberDeliveryPeriod = widget
                                        .syncFiberResponse!
                                        .data
                                        .fiber
                                        .deliveryPeriod[value];
                                  }
                                }),
                            Padding(
                                padding: EdgeInsets.only(top: 8.w, left: 8.w),
                                child:
                                    TitleSmallTextWidget(title: 'Description')),
                            SizedBox(
                              height: 5 * 22.w,
                              child: TextFormField(
                                  keyboardType: TextInputType.number,
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
                                      return "Description";
                                    }
                                    return null;
                                  },
                                  decoration: roundedDescriptionDecoration(
                                      "Description")),
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
                            widget.businessArea!;
                        _fiberRequestModel!.spc_local_international =
                            widget.businessArea!.toUpperCase();
                        _fiberRequestModel!.fbp_price_terms_idfk =
                            _fiberPriceTerms!.ptrId.toString();
                        _fiberRequestModel!.packing_idfk =
                            _packingModel!.pacId.toString();
                        _fiberRequestModel!.fbp_delivery_period_idfk =
                            _fiberDeliveryPeriod!.dprId.toString();

                        ProgressDialogUtil.showDialog(
                            context, 'Please wait...');

                        ApiService.multipartProdecudre(
                                _fiberRequestModel!, imageFiles[0].path)
                            .then((value) {
                          ProgressDialogUtil.hideDialog();

                          if(value.success){

                              }else{
                                Scaffold.of(context).showSnackBar(
                                    SnackBar(content: Text(value.message)));
                              }

                        }).onError((error, stackTrace){
                          ProgressDialogUtil.hideDialog();
                          Scaffold.of(context).showSnackBar(
                              SnackBar(content: Text(error.toString())));
                        });
                      }
                    }
                  },
                  color: AppColors.btnColorLogin,
                  btnText: 'Submit',
                ),
              ),
            ),
            flex: 1,
          ),
        ],
      ),
    );
  }

  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form!.validate()) {
      if (!imageFiles.isEmpty) {
        form.save();
        return true;
      } else {
        Scaffold.of(context).showSnackBar(
            SnackBar(content: Text('Please Capture Image first')));
      }
    }
    return false;
  }
}
