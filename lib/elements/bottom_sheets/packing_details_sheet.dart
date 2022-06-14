//
//import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
//import 'package:flutter_screenutil/flutter_screenutil.dart';
//import 'package:fluttertoast/fluttertoast.dart';
//import 'package:image_picker/image_picker.dart';
//import 'package:logger/logger.dart';
//import 'package:provider/provider.dart';
//import 'package:yg_app/app_database/app_database_instance.dart';
//import 'package:yg_app/elements/decoration_widgets.dart';
//import 'package:yg_app/elements/text_widgets.dart';
//import 'package:yg_app/elements/yg_text_form_field.dart';
//import 'package:yg_app/helper_utils/app_colors.dart';
//import 'package:yg_app/helper_utils/fabric_bottom_sheet.dart';
//import 'package:yg_app/model/blend_model.dart';
//import 'package:yg_app/model/response/fabric_response/sync/fabric_sync_response.dart';
//import 'package:yg_app/model/response/yarn_response/sync/yarn_sync_response.dart';
//import 'package:yg_app/providers/yarn_providers/post_yarn_provider.dart';
//
//import '../../helper_utils/app_constants.dart';
//import '../../helper_utils/ui_utils.dart';
//import '../../helper_utils/util.dart';
//import '../../locators.dart';
//import '../../model/request/post_ad_request/create_request_model.dart';
//import '../../model/request/post_fabric_request/create_fabric_request_model.dart';
//import '../../model/response/common_response_models/city_state_response.dart';
//import '../../model/response/common_response_models/countries_response.dart';
//import '../../model/response/common_response_models/delievery_period.dart';
//import '../../model/response/common_response_models/lc_type_response.dart';
//import '../../model/response/common_response_models/packing_response.dart';
//import '../../model/response/common_response_models/payment_type_response.dart';
//import '../../model/response/common_response_models/ports_response.dart';
//import '../../model/response/common_response_models/price_term.dart';
//import '../../model/response/common_response_models/unit_of_count.dart';
//import '../../providers/fiber_providers/post_fiber_provider.dart';
//import '../list_widgets/single_select_tile_widget.dart';
//
//
//List<TextEditingController> textFieldControllers = [];
//GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
//final scaffoldKey = GlobalKey<ScaffoldState>();
//List<String> sellingRegion = [];
//
//// List<Packing> packingList = [];
//List<PickedFile> imageFiles = [];
//CreateRequestModel? _createRequestModel;
//bool noOfDays = false;
//final TextEditingController _coneWithController = TextEditingController();
//final TextEditingController _weigthPerBagController = TextEditingController();
//final TextEditingController _conePerBagController = TextEditingController();
//bool? _showPaymentType;
//bool? _showLcType;
//int? selectedCountryId;
//String? unitCountSelected;
//
//
//
//final _fiberPostProvider = locator<PostFiberProvider>();
//final _yarnPostProvider = locator<PostYarnProvider>();
//
//
//
//
//
//packingDetailsSheet(
//    BuildContext context,
//    Function callback,
//    List<FPriceTerms> _priceTermList,
//    List<Packing> _packingList,
//    List<DeliveryPeriod> _deliverPeriodList,
//    List<PaymentType> _paymentTypeList,
//    List<LcType> _lcTypeList,
//    List<Units> _unitsList,
//    List<Countries> _countriesList,
//    List<CityState> _cityStateList,
//    List<Ports> _portsList,
//    List<ConeType> _coneTypeList,
//   String locality,
//   String businessArea,
//    )
//{
//
//
//  showModalBottomSheet<int>(
//    isScrollControlled: true,
//    backgroundColor: Colors.transparent,
//    context: context,
//    builder: (context) {
//      return StatefulBuilder(
//          builder: (BuildContext contextBuilder, StateSetter setState) {
//            _createRequestModel = Provider.of<CreateRequestModel?>(context);
////            if(_createRequestModel == null){
////              _createRequestModel = _fiberPostProvider.createRequestModel;
////            }else if(_createRequestModel!.spc_category_idfk != null && _createRequestModel!.spc_category_idfk=='2'){
////              _yarnPostProvider.familyDisabled = true;
////            }
//            return SingleChildScrollView(
//              child: Container(
//                color: Colors.white,
//                /*padding: const EdgeInsets.only(left: 15.0,right: 15.0),*/
//                padding: EdgeInsets.only(
//                    bottom: MediaQuery.of(context).viewInsets.bottom,
//                    left: 15.0,right: 15.0),
////              height: MediaQuery.of(context).size.height/1.5,
//                child: Form(
//                  key: globalFormKey,
//                  child: Column(
//                    crossAxisAlignment: CrossAxisAlignment.start,
//                    mainAxisSize: MainAxisSize.min,
//                    mainAxisAlignment: MainAxisAlignment.start,
//                    children: [
//                      TitleTextWidget(
//                        title: packingDetails,
//                      ),
//                      Padding(
//                        padding: EdgeInsets.only(top: 8.w),
//                        child: Column(
//                          crossAxisAlignment: CrossAxisAlignment.start,
//                          children: [
//                            //Unit of count and Counting
//                            Visibility(
//                              visible: /*widget.locality == international*/ true,
//                              child: Column(
//                                crossAxisAlignment: CrossAxisAlignment.start,
//                                children: [
//                                  Padding(
//                                      padding: EdgeInsets.only(
//                                          left: 0.w, top: 4, bottom: 4),
//                                      child: TitleSmallBoldTextWidget(
//                                          title: unitCounting)),
//                                  SingleSelectTileWidget(
//                                      spanCount: 3,
//                                      listOfItems: _unitsList
//                                          .where((element) =>
//                                      element.untCategoryIdfk ==
//                                          _createRequestModel!
//                                              .spc_category_idfk)
//                                          .toList(),
//                                      callback: (Units value) {
//                                        setState(() {
//                                          unitCountSelected = value.untName;
//                                        });
//                                        if (_createRequestModel != null) {
//                                          _createRequestModel!
//                                              .fbp_count_unit_idfk =
//                                              value.untId.toString();
//                                        }
//                                      }),
//                                ],
//                              ),
//                            ),
//
//                            //Weight of count calculation
//                            Visibility(
//                              visible:
//                              businessArea == yarn ? true : false,
//                              child: Container(
//                                margin: EdgeInsets.only(top: 8.w),
//                                child: Column(
//                                  crossAxisAlignment: CrossAxisAlignment.start,
//                                  children: [
//                                    Row(
//                                      children: [
//                                        Expanded(
//                                            child: Column(
//                                              crossAxisAlignment:
//                                              CrossAxisAlignment.start,
//                                              children: [
//                                                SizedBox(
//                                                  height: 12.w,
//                                                ),
////                                            Padding(
////                                                padding: EdgeInsets.only(
////                                                    top: 8.w, left: 8.w),
////                                                child: TitleSmallTextWidget(
////                                                    title:
////                                                        "Weight($unitCountSelected)/Bag")),
//                                                TextFormField(
//                                                    controller:
//                                                    _weigthPerBagController,
//                                                    keyboardType:
//                                                    TextInputType.number,
//                                                    cursorColor: lightBlueTabs,
//                                                    style:
//                                                    TextStyle(fontSize: 11.sp),
//                                                    textAlign: TextAlign.center,
//                                                    cursorHeight: 16.w,
//                                                    maxLines: 1,
//                                                    onSaved: (input) {
//                                                      if (_createRequestModel !=
//                                                          null) {
//                                                        _createRequestModel!
//                                                            .fpb_weight_bag =
//                                                        input!;
//                                                      }
//                                                    },
//                                                    onChanged: (value) {
//                                                      if (_conePerBagController
//                                                          .text.isNotEmpty) {
//                                                        _coneWithController
//                                                            .text = (double.parse(
//                                                            _weigthPerBagController
//                                                                .text) /
//                                                            double.parse(
//                                                                _conePerBagController
//                                                                    .text))
//                                                            .toStringAsFixed(2);
//                                                      } else {
//                                                        _coneWithController.text =
//                                                        "";
//                                                      }
//                                                    },
//                                                    validator: (input) {
//                                                      if (input == null ||
//                                                          input.isEmpty) {
//                                                        return "Weight($unitCountSelected)/Bag";
//                                                      }
//                                                      return null;
//                                                    },
//                                                    decoration: ygTextFieldDecoration(
//                                                        "Weight($unitCountSelected)/Bag",
//                                                        "Weight($unitCountSelected)/Bag")),
//                                              ],
//                                            )),
//                                        SizedBox(width: 16.w),
//                                        Expanded(
//                                            child: Column(
//                                              crossAxisAlignment:
//                                              CrossAxisAlignment.start,
//                                              children: [
////                                            Padding(
////                                                padding: EdgeInsets.only(
////                                                    top: 8.w, left: 8.w),
////                                                child: TitleSmallTextWidget(
////                                                    title: coneBags)),
//                                                SizedBox(
//                                                  height: 12.w,
//                                                ),
//                                                TextFormField(
//                                                    controller:
//                                                    _conePerBagController,
//                                                    keyboardType:
//                                                    TextInputType.number,
//                                                    cursorColor: lightBlueTabs,
//                                                    style:
//                                                    TextStyle(fontSize: 11.sp),
//                                                    textAlign: TextAlign.center,
//                                                    cursorHeight: 16.w,
//                                                    maxLines: 1,
//                                                    onSaved: (input) {
//                                                      if (_createRequestModel !=
//                                                          null) {
//                                                        _createRequestModel!
//                                                            .fpb_cones_bag = input!;
//                                                      }
//                                                    },
//                                                    onChanged: (value) {
//                                                      if (_weigthPerBagController
//                                                          .text.isNotEmpty) {
//                                                        _coneWithController
//                                                            .text = (double.parse(
//                                                            _weigthPerBagController
//                                                                .text) /
//                                                            double.parse(value))
//                                                            .toStringAsFixed(2);
//                                                      } else {
//                                                        _coneWithController.text =
//                                                        "";
//                                                      }
//                                                    },
//                                                    validator: (input) {
//                                                      if (input == null ||
//                                                          input.isEmpty) {
//                                                        return coneBags;
//                                                      }
//                                                      return null;
//                                                    },
//                                                    decoration:
//                                                    ygTextFieldDecoration(
//                                                        coneBags, coneBags)),
//                                              ],
//                                            )),
//                                      ],
//                                    ),
//                                    Padding(
//                                      padding: const EdgeInsets.only(top: 8.0),
//                                      child: Column(
//                                        crossAxisAlignment:
//                                        CrossAxisAlignment.start,
//                                        children: [
////                                        Padding(
////                                            padding: EdgeInsets.only(
////                                                top: 8.w, left: 8.w),
////                                            child: TitleSmallTextWidget(
////                                                title: weightCones)),
//                                          SizedBox(
//                                            height: 12.w,
//                                          ),
//                                          TextFormField(
//                                              controller: _coneWithController,
//                                              keyboardType: TextInputType.number,
//                                              readOnly: true,
//                                              autofocus: false,
//                                              cursorColor: lightBlueTabs,
//                                              style: TextStyle(fontSize: 11.sp),
//                                              textAlign: TextAlign.center,
//                                              cursorHeight: 16.w,
//                                              maxLines: 1,
//                                              onSaved: (input) {
//                                                if (_createRequestModel != null) {
//                                                  _createRequestModel!
//                                                      .fpb_weight_cone = input!;
//                                                }
//                                              },
//                                              validator: (input) {
//                                                if (input == null ||
//                                                    input.isEmpty) {
//                                                  return weightCones;
//                                                }
//                                                return null;
//                                              },
//                                              decoration: ygTextFieldDecoration(
//                                                  weightCones, weightCones)),
//                                        ],
//                                      ),
//                                    ),
//                                  ],
//                                ),
//                              ),
//                            ),
//
//                            //Show Cone type
//                            Visibility(
//                              visible:
//                              businessArea != yarn ? false : true,
//                              child: Column(
//                                crossAxisAlignment: CrossAxisAlignment.start,
//                                children: [
//                                  Padding(
//                                      padding:
//                                      EdgeInsets.only(top: 8.w, left: 8.w),
//                                      child: const TitleSmallBoldTextWidget(
//                                          title: "Cone Type")),
//                                  SingleSelectTileWidget(
//                                      spanCount: 3,
//                                      selectedIndex: -1,
//                                      listOfItems: _coneTypeList
//                                          .where((element) =>
//                                      element.familyId ==
//                                          _createRequestModel!
//                                              .ys_family_idfk)
//                                          .toList(),
//                                      callback: (ConeType value) {
//                                        _createRequestModel!.cone_type_id =
//                                            value.yctId.toString();
//                                      }),
//                                ],
//                              ),
//                            ),
//
//                            //Selling Region
//                            Padding(
//                              padding: const EdgeInsets.only(top: 8.0),
//                              child: Column(
//                                crossAxisAlignment: CrossAxisAlignment.start,
//                                children: [
//                                  Padding(
//                                      padding: EdgeInsets.only(
//                                          left: 0.w, top: 4, bottom: 4),
//                                      child: TitleSmallBoldTextWidget(
//                                          title: sellingRegionStr)),
//                                  SingleSelectTileWidget(
//                                    spanCount: 2,
//                                    listOfItems: sellingRegion,
//                                    callback: (value) {},
//                                    selectedIndex: 0,
//                                  ),
//                                ],
//                              ),
//                            ),
//
//                            //Country,port
//                            Visibility(
//                              visible: locality == international
//                                  ? true
//                                  : false,
//                              child: Row(
//                                crossAxisAlignment: CrossAxisAlignment.start,
//                                children: [
//                                  Expanded(
//                                    child: Padding(
//                                      padding: EdgeInsets.only(top: 8.w),
//                                      child: Column(
//                                        crossAxisAlignment:
//                                        CrossAxisAlignment.start,
//                                        children: [
////                                          Padding(
////                                              padding:
////                                                  EdgeInsets.only(left: 8.w),
////                                              child: TitleSmallTextWidget(
////                                                  title: country)),
//                                          SizedBox(
//                                            height: 12.w,
//                                          ),
//                                          SizedBox(
//                                            height: 36.w,
//                                            child: Container(
//                                              decoration: BoxDecoration(
//                                                  border: Border.all(
//                                                    color: Colors.grey.shade300,
//                                                    width:
//                                                    1, //                   <--- border width here
//                                                  ),
//                                                  borderRadius:
//                                                  BorderRadius.all(
//                                                      Radius.circular(
//                                                          5.w))),
//                                              child: DropdownButtonFormField(
//                                                hint: const Text(
//                                                    'Select Country'),
//                                                items: _countriesList
//                                                    .map((value) =>
//                                                    DropdownMenuItem(
//                                                      child: Text(
//                                                          value.conName ??
//                                                              Utils.checkNullString(
//                                                                  false),
//                                                          textAlign:
//                                                          TextAlign
//                                                              .center),
//                                                      value: value,
//                                                    ))
//                                                    .toList(),
//                                                isExpanded: true,
//                                                onChanged: (Countries? value) {
//                                                  FocusScope.of(context)
//                                                      .requestFocus(
//                                                      FocusNode());
//                                                  selectedCountryId =
//                                                      value!.conId;
//                                                  _createRequestModel!
//                                                      .spc_origin_idfk =
//                                                      value.conId.toString();
//                                                },
//
//                                                // value: widget.syncFiberResponse.data.fiber.brands.first,
//                                                decoration: InputDecoration(
//                                                  label: Row(
//                                                    mainAxisSize:
//                                                    MainAxisSize.min,
//                                                    mainAxisAlignment:
//                                                    MainAxisAlignment.start,
//                                                    children: [
//                                                      Text(
//                                                        country,
//                                                        style: TextStyle(
//                                                            color:
//                                                            Colors.black87,
//                                                            fontSize: 14.sp,
//                                                            backgroundColor:
//                                                            Colors.white,
//                                                            /*fontFamily: 'Metropolis',*/
//                                                            fontWeight:
//                                                            FontWeight
//                                                                .w500),
//                                                      ),
//                                                      Text("*",
//                                                          style: TextStyle(
//                                                              color: Colors.red,
//                                                              fontSize: 16.sp,
//                                                              /*fontFamily: 'Metropolis',*/
//                                                              backgroundColor:
//                                                              Colors.white,
//                                                              fontWeight:
//                                                              FontWeight
//                                                                  .w500)),
//                                                    ],
//                                                  ),
//                                                  floatingLabelBehavior:
//                                                  FloatingLabelBehavior
//                                                      .always,
////                                                      hintText: hintLabel,
////                                                      hintStyle: TextStyle(fontSize: 10.sp,fontWeight: FontWeight.w500,color:hintColorGrey),
//
//                                                  contentPadding:
//                                                  EdgeInsets.only(
//                                                      left: 16.w,
//                                                      right: 6.w,
//                                                      top: 0,
//                                                      bottom: 0),
//                                                  border:
//                                                  const OutlineInputBorder(
//                                                      borderSide:
//                                                      BorderSide.none),
//                                                ),
//                                                style: TextStyle(
//                                                    fontSize: 11.sp,
//                                                    color: textColorGrey),
//                                              ),
//                                            ),
//                                          ),
//                                        ],
//                                      ),
//                                    ),
//                                  ),
//                                  SizedBox(width: 16.w),
//                                  Expanded(
//                                    child: Padding(
//                                      padding: EdgeInsets.only(top: 8.w),
//                                      child: Column(
//                                        crossAxisAlignment:
//                                        CrossAxisAlignment.start,
//                                        children: [
////                                          Padding(
////                                              padding:
////                                                  EdgeInsets.only(left: 8.w),
////                                              child: TitleSmallTextWidget(
////                                                  title: port)),
//                                          SizedBox(
//                                            height: 12.w,
//                                          ),
//                                          SizedBox(
//                                            height: 36.w,
//                                            child: Container(
//                                              decoration: BoxDecoration(
//                                                  border: Border.all(
//                                                    color: Colors.grey.shade300,
//                                                    width:
//                                                    1, //                   <--- border width here
//                                                  ),
//                                                  borderRadius:
//                                                  BorderRadius.all(
//                                                      Radius.circular(
//                                                          5.w))),
//                                              child: DropdownButtonFormField(
//                                                hint: const Text('Select Port'),
//                                                items: _portsList
//                                                    .where((element) =>
//                                                element
//                                                    .prtCountryIdfk ==
//                                                    selectedCountryId
//                                                        .toString())
//                                                    .toList()
//                                                    .map((value) =>
//                                                    DropdownMenuItem(
//                                                      child: Text(
//                                                          value.prtName ??
//                                                              Utils.checkNullString(
//                                                                  false),
//                                                          textAlign:
//                                                          TextAlign
//                                                              .center),
//                                                      value: value,
//                                                    ))
//                                                    .toList(),
//                                                isExpanded: true,
//                                                onChanged: (Ports? value) {
//                                                  FocusScope.of(context)
//                                                      .requestFocus(
//                                                      FocusNode());
//                                                  _createRequestModel!
//                                                      .spc_port_idfk =
//                                                      value!.prtId.toString();
//                                                },
//
//                                                // value: widget.syncFiberResponse.data.fiber.brands.first,
//                                                decoration: InputDecoration(
//                                                  label: Row(
//                                                    mainAxisSize:
//                                                    MainAxisSize.min,
//                                                    mainAxisAlignment:
//                                                    MainAxisAlignment.start,
//                                                    children: [
//                                                      Text(
//                                                        port,
//                                                        style: TextStyle(
//                                                            color:
//                                                            Colors.black87,
//                                                            fontSize: 14.sp,
//                                                            backgroundColor:
//                                                            Colors.white,
//                                                            /*fontFamily: 'Metropolis',*/
//                                                            fontWeight:
//                                                            FontWeight
//                                                                .w500),
//                                                      ),
//                                                      Text("*",
//                                                          style: TextStyle(
//                                                              color: Colors.red,
//                                                              fontSize: 16.sp,
//                                                              /*fontFamily: 'Metropolis',*/
//                                                              backgroundColor:
//                                                              Colors.white,
//                                                              fontWeight:
//                                                              FontWeight
//                                                                  .w500)),
//                                                    ],
//                                                  ),
//                                                  floatingLabelBehavior:
//                                                  FloatingLabelBehavior
//                                                      .always,
////                                                      hintText: hintLabel,
////                                                      hintStyle: TextStyle(fontSize: 10.sp,fontWeight: FontWeight.w500,color:hintColorGrey),
//
//                                                  contentPadding:
//                                                  EdgeInsets.only(
//                                                      left: 16.w,
//                                                      right: 6.w,
//                                                      top: 0,
//                                                      bottom: 0),
//                                                  border:
//                                                  const OutlineInputBorder(
//                                                      borderSide:
//                                                      BorderSide.none),
//                                                ),
//                                                style: TextStyle(
//                                                    fontSize: 11.sp,
//                                                    color: textColorGrey),
//                                              ),
//                                            ),
//                                          ),
//                                        ],
//                                      ),
//                                    ),
//                                  ),
//                                ],
//                              ),
//                            ),
//                            //City State
//                            Visibility(
//                                visible: locality == international
//                                    ? true
//                                    : false,
//                                child: Padding(
//                                  padding: EdgeInsets.only(top: 8.w),
//                                  child: Column(
//                                    crossAxisAlignment:
//                                    CrossAxisAlignment.start,
//                                    children: [
////                                      Padding(
////                                          padding: EdgeInsets.only(left: 8.w),
////                                          child: TitleSmallTextWidget(
////                                              title: cityState)),
//                                      SizedBox(
//                                        height: 12.w,
//                                      ),
//                                      SizedBox(
//                                        height: 36.w,
//                                        child: Container(
//                                          decoration: BoxDecoration(
//                                              border: Border.all(
//                                                color: Colors.grey.shade300,
//                                                width:
//                                                1, //                   <--- border width here
//                                              ),
//                                              borderRadius: BorderRadius.all(
//                                                  Radius.circular(5.w))),
//                                          child: DropdownButtonFormField(
//                                            hint: Text('Select $cityState'),
//                                            items: _cityStateList
//                                                .where((element) =>
//                                            element.countryId ==
//                                                selectedCountryId
//                                                    .toString())
//                                                .toList()
//                                                .map(
//                                                    (value) => DropdownMenuItem(
//                                                  child: Text(
//                                                      value.name ??
//                                                          Utils.checkNullString(
//                                                              false),
//                                                      textAlign:
//                                                      TextAlign
//                                                          .center),
//                                                  value: value,
//                                                ))
//                                                .toList(),
//                                            isExpanded: true,
//                                            onChanged: (CityState? value) {
//                                              FocusScope.of(context)
//                                                  .requestFocus(FocusNode());
//                                              _createRequestModel!
//                                                  .spc_city_state_idfk =
//                                                  value!.countryId.toString();
//                                            },
//
//                                            // value: widget.syncFiberResponse.data.fiber.brands.first,
//                                            decoration: InputDecoration(
//                                              label: Row(
//                                                mainAxisSize: MainAxisSize.min,
//                                                mainAxisAlignment:
//                                                MainAxisAlignment.start,
//                                                children: [
//                                                  Text(
//                                                    cityState,
//                                                    style: TextStyle(
//                                                        color: Colors.black87,
//                                                        fontSize: 14.sp,
//                                                        /*fontFamily: 'Metropolis',*/
//                                                        fontWeight:
//                                                        FontWeight.w500),
//                                                  ),
//                                                  Text("*",
//                                                      style: TextStyle(
//                                                          color: Colors.red,
//                                                          fontSize: 16.sp,
//                                                          /*fontFamily: 'Metropolis',*/
//                                                          fontWeight:
//                                                          FontWeight.w500)),
//                                                ],
//                                              ),
//                                              floatingLabelBehavior:
//                                              FloatingLabelBehavior.always,
////                                                      hintText: hintLabel,
////                                                      hintStyle: TextStyle(fontSize: 10.sp,fontWeight: FontWeight.w500,color:hintColorGrey),
//
//                                              contentPadding: EdgeInsets.only(
//                                                  left: 16.w,
//                                                  right: 6.w,
//                                                  top: 0,
//                                                  bottom: 0),
//                                              border: const OutlineInputBorder(
//                                                  borderSide: BorderSide.none),
//                                            ),
//                                            style: TextStyle(
//                                                fontSize: 11.sp,
//                                                color: textColorGrey),
//                                          ),
//                                        ),
//                                      ),
//                                    ],
//                                  ),
//                                )),
//
//                            //Price Terms
//                            Padding(
//                              padding: const EdgeInsets.only(top: 8.0),
//                              child: Column(
//                                crossAxisAlignment: CrossAxisAlignment.start,
//                                children: [
////                                Padding(
////                                    padding:
////                                        EdgeInsets.only(top: 8.w, left: 8.w),
////                                    child: TitleSmallTextWidget(
////                                        title: priceTerms)),
//                                  SizedBox(
//                                    height: 12.w,
//                                  ),
//                                  SizedBox(
//                                    height: 36.w,
//                                    child: Container(
//                                      decoration: BoxDecoration(
//                                          border: Border.all(
//                                            color: Colors.grey.shade300,
//                                            width:
//                                            1, //                   <--- border width here
//                                          ),
//                                          borderRadius: BorderRadius.all(
//                                              Radius.circular(5.w))),
//                                      child: DropdownButtonFormField(
//                                        hint: const Text('Select Price Terms'),
//                                        items: _getPriceTerms()
//                                            .map((value) => DropdownMenuItem(
//                                          child: Text(
//                                              value.ptrName ??
//                                                  Utils.checkNullString(
//                                                      false),
//                                              textAlign:
//                                              TextAlign.center),
//                                          value: value,
//                                        ))
//                                            .toList(),
//                                        isExpanded: true,
//                                        onChanged: (FPriceTerms? value) {
//                                          FocusScope.of(context)
//                                              .requestFocus(FocusNode());
//                                          setState(() {
//                                            if (value!.ptrId == 3) {
//                                              _showPaymentType = true;
//                                            } else {
//                                              _showPaymentType = false;
//                                              _showLcType = false;
//                                              _createRequestModel!
//                                                  .payment_type_idfk = null;
//                                              _createRequestModel!.lc_type_idfk =
//                                              null;
//                                            }
//                                          });
//                                          _createRequestModel!
//                                              .fbp_price_terms_idfk =
//                                              value!.ptrId.toString();
//                                        },
//                                        // validator: (value) => value == null
//                                        //     ? 'field required'
//                                        //     : null,
//                                        // value: widget.syncFiberResponse.data.fiber.brands.first,
//                                        decoration: InputDecoration(
//                                          label: Row(
//                                            mainAxisSize: MainAxisSize.min,
//                                            mainAxisAlignment:
//                                            MainAxisAlignment.start,
//                                            children: [
//                                              Text(
//                                                priceTerms,
//                                                style: TextStyle(
//                                                    color: Colors.black87,
//                                                    fontSize: 14.sp,
//                                                    backgroundColor: Colors.white,
//                                                    /*fontFamily: 'Metropolis',*/
//                                                    fontWeight: FontWeight.w500),
//                                              ),
//                                              Text("*",
//                                                  style: TextStyle(
//                                                      backgroundColor:
//                                                      Colors.white,
//                                                      color: Colors.red,
//                                                      fontSize: 16.sp,
//                                                      /*fontFamily: 'Metropolis',*/
//                                                      fontWeight:
//                                                      FontWeight.w500)),
//                                            ],
//                                          ),
//                                          floatingLabelBehavior:
//                                          FloatingLabelBehavior.always,
////                                                      hintText: hintLabel,
////                                                      hintStyle: TextStyle(fontSize: 10.sp,fontWeight: FontWeight.w500,color:hintColorGrey),
//
//                                          contentPadding: EdgeInsets.only(
//                                              left: 16.w,
//                                              right: 6.w,
//                                              top: 0,
//                                              bottom: 0),
//                                          border: const OutlineInputBorder(
//                                              borderSide: BorderSide.none),
//                                        ),
//                                        style: TextStyle(
//                                            fontSize: 11.sp,
//                                            color: textColorGrey),
//                                      ),
//                                    ),
//                                  ),
//                                ],
//                              ),
//                            ),
//
//                            //Payment Type
//                            Visibility(
//                                visible: _showPaymentType ?? false,
//                                child: Column(
//                                  crossAxisAlignment: CrossAxisAlignment.start,
//                                  children: [
//                                    Padding(
//                                        padding: EdgeInsets.only(
//                                            left: 0.w, top: 4, bottom: 4),
//                                        child: TitleSmallBoldTextWidget(
//                                            title: paymentType)),
//                                    SingleSelectTileWidget(
//                                        spanCount: 3,
//                                        selectedIndex: -1,
//                                        listOfItems: _paymentTypeList,
//                                        callback: (PaymentType value) {
//                                          _createRequestModel!
//                                              .payment_type_idfk = value.payId;
//
//                                          setState(() {
//                                            if (value.payId == "1") {
//                                              _showLcType = true;
//                                            } else {
//                                              _showLcType = false;
//                                              _createRequestModel!
//                                                  .lc_type_idfk = null;
//                                            }
//                                          });
//                                        }),
//                                  ],
//                                )),
//
//                            //Lc Type
//                            Visibility(
//                              visible: _showLcType ?? false,
//                              child: Column(
//                                crossAxisAlignment: CrossAxisAlignment.start,
//                                children: [
//                                  Padding(
//                                      padding: EdgeInsets.only(
//                                          left: 0.w, top: 4, bottom: 4),
//                                      child: TitleSmallBoldTextWidget(
//                                          title: lcType)),
//                                  SingleSelectTileWidget(
//                                      spanCount: 3,
//                                      selectedIndex: -1,
//                                      listOfItems: _lcTypeList,
//                                      callback: (LcType value) {
//                                        if (_createRequestModel != null) {
//                                          _createRequestModel!.lc_type_idfk =
//                                              value.lcId.toString();
//                                        }
//                                      }),
//                                ],
//                              ),
//                            ),
//
//                            //Price Unit and Available Quantity
//                            Padding(
//                              padding: const EdgeInsets.only(top: 8.0),
//                              child: Row(
//                                children: [
//                                  Expanded(
//                                      child: Column(
//                                        crossAxisAlignment: CrossAxisAlignment.start,
//                                        children: [
////                                    Padding(
////                                        padding: EdgeInsets.only(
////                                            top: 8.w, left: 8.w),
////                                        child: TitleSmallTextWidget(
////                                            title: priceUnits)),
//                                          SizedBox(height: 12.w),
//                                          TextFormField(
//                                              keyboardType: TextInputType.number,
//                                              cursorColor: lightBlueTabs,
//                                              style: TextStyle(fontSize: 11.sp),
//                                              textAlign: TextAlign.center,
//                                              cursorHeight: 16.w,
//                                              maxLines: 1,
//                                              inputFormatters: [
//                                                FilteringTextInputFormatter.allow(
//                                                    RegExp("[0-9]")),
//                                              ],
//                                              onSaved: (input) {
//                                                if (_createRequestModel != null) {
//                                                  _createRequestModel!.fbp_price =
//                                                  input!;
//                                                }
//                                              },
//                                              validator: (input) {
//                                                if (input == null ||
//                                                    input.isEmpty ||
//                                                    int.parse(input) < 1) {
//                                                  return priceUnits;
//                                                }
//                                                return null;
//                                              },
//                                              decoration: ygTextFieldDecoration(
//                                                  priceUnits, priceUnits)),
//                                        ],
//                                      )),
//                                  SizedBox(width: 16.w),
//                                  Expanded(
//                                    child:
//                                    //Available Quantity
//                                    Column(
//                                      crossAxisAlignment:
//                                      CrossAxisAlignment.start,
//                                      children: [
//                                        SizedBox(
//                                          height: 12.w,
//                                        ),
////                                      Padding(
////                                          padding: EdgeInsets.only(
////                                              top: 8.w, left: 8.w),
////                                          child: const TitleSmallTextWidget(
////                                              title: "Available Quantity")),
//                                        TextFormField(
//                                            keyboardType: TextInputType.number,
//                                            cursorColor: lightBlueTabs,
//                                            style: TextStyle(fontSize: 11.sp),
//                                            textAlign: TextAlign.center,
//                                            cursorHeight: 16.w,
//                                            maxLines: 1,
//                                            inputFormatters: [
//                                              FilteringTextInputFormatter.allow(
//                                                  RegExp("[0-9]")),
//                                            ],
//                                            onSaved: (input) {
//                                              if (_createRequestModel != null) {
//                                                _createRequestModel!
//                                                    .fbp_available_quantity =
//                                                input!;
//                                              }
//                                            },
//                                            validator: (input) {
//                                              if (input == null ||
//                                                  input.isEmpty ||
//                                                  int.parse(input) < 1) {
//                                                return "Available Quantity";
//                                              }
//                                              return null;
//                                            },
//                                            decoration: ygTextFieldDecoration(
//                                                "Available Quantity",
//                                                "Available Qunatity")),
//                                      ],
//                                    ),
//                                  ),
//                                ],
//                              ),
//                            ),
//
//                            //Minimum Quantity
//                            Visibility(
//                              visible: true,
//                              child: Padding(
//                                padding: const EdgeInsets.only(top: 8.0),
//                                child: Column(
//                                  crossAxisAlignment: CrossAxisAlignment.start,
//                                  children: [
////                                  Padding(
////                                      padding:
////                                          EdgeInsets.only(top: 8.w, left: 8.w),
////                                      child: TitleSmallTextWidget(title: minQty)),
//                                    SizedBox(height: 12.w),
//                                    TextFormField(
//                                        keyboardType: TextInputType.number,
//                                        cursorColor: lightBlueTabs,
//                                        style: TextStyle(fontSize: 11.sp),
//                                        textAlign: TextAlign.center,
//                                        cursorHeight: 16.w,
//                                        maxLines: 1,
//                                        inputFormatters: [
//                                          FilteringTextInputFormatter.allow(
//                                              RegExp("[0-9]")),
//                                        ],
//                                        onSaved: (input) {
//                                          if (_createRequestModel != null) {
//                                            _createRequestModel!
//                                                .fbp_min_quantity = input!;
//                                          }
//                                        },
//                                        validator: (input) {
//                                          if (input == null ||
//                                              input.isEmpty ||
//                                              int.parse(input) < 1) {
//                                            return minQty;
//                                          }
//                                          return null;
//                                        },
//                                        decoration: ygTextFieldDecoration(
//                                            minQty, minQty)),
//                                  ],
//                                ),
//                              ),
//                            ),
//
//                            //Required Quantity
//                            Visibility(
//                              visible: false,
//                              child: Padding(
//                                padding: const EdgeInsets.only(top: 8.0),
//                                child: Column(
//                                  crossAxisAlignment: CrossAxisAlignment.start,
//                                  children: [
////                                  Padding(
////                                      padding:
////                                      EdgeInsets.only(top: 8.w, left: 8.w),
////                                      child: const TitleSmallTextWidget(title: "Required Quantity")),
////
//                                    SizedBox(height: 12.w),
//                                    TextFormField(
//                                        keyboardType: TextInputType.number,
//                                        cursorColor: lightBlueTabs,
//                                        style: TextStyle(fontSize: 11.sp),
//                                        textAlign: TextAlign.center,
//                                        cursorHeight: 16.w,
//                                        maxLines: 1,
//                                        inputFormatters: [
//                                          FilteringTextInputFormatter.allow(
//                                              RegExp("[0-9]")),
//                                        ],
//                                        onSaved: (input) {
//                                          if (_createRequestModel != null) {
//                                            _createRequestModel!
//                                                .fbp_required_quantity = input!;
//                                          }
//                                        },
//                                        validator: (input) {
//                                          if (input == null ||
//                                              input.isEmpty ||
//                                              int.parse(input) < 1) {
//                                            return minQty;
//                                          }
//                                          return null;
//                                        },
//                                        decoration: ygTextFieldDecoration(
//                                            "Required Quantity",
//                                            "Required Quantity")),
//                                  ],
//                                ),
//                              ),
//                            ),
//
//                            //Packing
//                            Visibility(
//                              visible:
//                              businessArea == "Fiber" ? true : false,
//                              child: Column(
//                                crossAxisAlignment: CrossAxisAlignment.start,
//                                children: [
//                                  Padding(
//                                      padding: EdgeInsets.only(
//                                          left: 0.w, top: 8, bottom: 4),
//                                      child: TitleSmallBoldTextWidget(
//                                          title: packing)),
//                                  SingleSelectTileWidget(
//                                      spanCount: 3,
//                                      listOfItems: _packingList
//                                          .where((element) =>
//                                      element.pacCategoryId ==
//                                          _createRequestModel!
//                                              .spc_category_idfk
//                                              .toString())
//                                          .toList(),
//                                      callback: (Packing value) {
//                                        if (_createRequestModel != null) {
//                                          _createRequestModel!.packing_idfk =
//                                              value.pacId.toString();
//                                        }
//                                      }),
//                                ],
//                              ),
//                            ),
//
//                            //Delivery Period
//                            Column(
//                              crossAxisAlignment: CrossAxisAlignment.start,
//                              children: [
//                                Padding(
//                                    padding: EdgeInsets.only(
//                                        left: 0.w, top: 8, bottom: 4),
//                                    child: TitleSmallBoldTextWidget(
//                                        title: deliveryPeriod)),
//                                SingleSelectTileWidget(
//                                    spanCount: 3,
//                                    listOfItems: _deliverPeriodList
//                                        .where((element) =>
//                                    element.dprCategoryIdfk ==
//                                        _createRequestModel!
//                                            .spc_category_idfk)
//                                        .toList(),
//                                    callback: (DeliveryPeriod value) {
//                                      if (_createRequestModel != null) {
//                                        _createRequestModel!
//                                            .fbp_delivery_period_idfk =
//                                            value.dprId.toString();
//                                        if (value.dprId == 3) {
//                                          setState(() {
//                                            noOfDays = true;
//                                          });
//                                        } else {
//                                          setState(() {
//                                            noOfDays = false;
//                                          });
//                                        }
//                                      }
//                                    }),
//                              ],
//                            ),
//
//                            //No of Days
//                            Visibility(
//                              visible: noOfDays,
//                              child: Column(
//                                crossAxisAlignment: CrossAxisAlignment.start,
//                                children: [
////                                  Padding(
////                                      padding:
////                                          EdgeInsets.only(top: 8.w, left: 8.w),
////                                      child: const TitleSmallTextWidget(
////                                          title: "No of Days")),
//                                  SizedBox(
//                                    height: 12.w,
//                                  ),
//                                  SizedBox(
//                                    height: 36.w,
//                                    child: Container(
//                                      decoration: BoxDecoration(
//                                          border: Border.all(
//                                            color: Colors.grey.shade300,
//                                            width:
//                                            1, //                   <--- border width here
//                                          ),
//                                          borderRadius: BorderRadius.all(
//                                              Radius.circular(24.w))),
//                                      child: DropdownButtonFormField(
//                                        hint: const Text('Select Number'),
//                                        items: Iterable<int>.generate(101)
//                                            .toList()
//                                            .map((value) => DropdownMenuItem(
//                                          child: Text(value.toString(),
//                                              textAlign:
//                                              TextAlign.center),
//                                          value: value,
//                                        ))
//                                            .toList(),
//                                        isExpanded: true,
//                                        validator: (value) => value == null
//                                            ? 'field required'
//                                            : null,
//                                        onChanged: (int? value) {
//                                          FocusScope.of(context)
//                                              .requestFocus(FocusNode());
//                                          _createRequestModel!.spc_no_of_days =
//                                              value!.toString();
//                                        },
//
//                                        // value: widget.syncFiberResponse.data.fiber.brands.first,
//                                        decoration: InputDecoration(
//                                          label: Row(
//                                            mainAxisSize: MainAxisSize.min,
//                                            mainAxisAlignment:
//                                            MainAxisAlignment.start,
//                                            children: [
//                                              Text(
//                                                "No of Days",
//                                                style: TextStyle(
//                                                    color: Colors.black87,
//                                                    fontSize: 14.sp,
//                                                    backgroundColor:
//                                                    Colors.white,
//                                                    /*fontFamily: 'Metropolis',*/
//                                                    fontWeight:
//                                                    FontWeight.w500),
//                                              ),
//                                              Text("*",
//                                                  style: TextStyle(
//                                                      color: Colors.red,
//                                                      fontSize: 16.sp,
//                                                      /*fontFamily: 'Metropolis',*/
//                                                      backgroundColor:
//                                                      Colors.white,
//                                                      fontWeight:
//                                                      FontWeight.w500)),
//                                            ],
//                                          ),
//                                          floatingLabelBehavior:
//                                          FloatingLabelBehavior.always,
////                                                      hintText: hintLabel,
////                                                      hintStyle: TextStyle(fontSize: 10.sp,fontWeight: FontWeight.w500,color:hintColorGrey),
//
//                                          contentPadding: EdgeInsets.only(
//                                              left: 16.w,
//                                              right: 6.w,
//                                              top: 0,
//                                              bottom: 0),
//                                          border: const OutlineInputBorder(
//                                              borderSide: BorderSide.none),
//                                        ),
//                                        style: TextStyle(
//                                            fontSize: 11.sp,
//                                            color: textColorGrey),
//                                      ),
//                                    ),
//                                  ),
//                                ],
//                              ),
//                            ),
//
//
//
//                          ],
//                        ),
//                      ),
//                    ],
//                  ),
//                ),
//              ),
//            );
//          });
//    },
//  );
//
//
//
//}
//
//bool validateAndSavePly() {
//  final form = globalFormKey.currentState;
//  if (form!.validate()) {
//    form.save();
//    return true;
//  }
//  return false;
//}
//
//bool validationAllPage(FabricCreateRequestModel createRequestModel, FabricSetting fabricSetting, BuildContext context, String? selectedPlyId) {
//  if (validateAndSavePly()) {
//    if ((selectedPlyId == null || selectedPlyId == '') &&
//        Ui.showHide(fabricSetting.showPly)) {
//      Fluttertoast.showToast(msg: 'Please Select Ply');
//      return false;
//    }else{
//      return true;
//    }
//  }
//  return false;
//}
//
//
//
//
