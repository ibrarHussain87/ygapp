import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:stylish_dialog/stylish_dialog.dart';
import 'package:yg_app/api_services/api_service_class.dart';
import 'package:yg_app/app_database/app_database_instance.dart';
import 'package:yg_app/elements/add_picture_widget.dart';
import 'package:yg_app/elements/decoration_widgets.dart';
import 'package:yg_app/elements/elevated_button_widget.dart';
import 'package:yg_app/elements/list_widgets/single_select_tile_widget.dart';
import 'package:yg_app/elements/title_text_widget.dart';
import 'package:yg_app/helper_utils/dialog_builder.dart';
import 'package:yg_app/helper_utils/app_colors.dart';
import 'package:yg_app/helper_utils/app_constants.dart';
import 'package:yg_app/helper_utils/navigation_utils.dart';
import 'package:yg_app/helper_utils/progress_dialog_util.dart';
import 'package:yg_app/helper_utils/ui_utils.dart';
import 'package:yg_app/helper_utils/util.dart';
import 'package:yg_app/model/response/common_response_models/city_state_response.dart';
import 'package:yg_app/model/response/common_response_models/countries_response.dart';
import 'package:yg_app/model/response/common_response_models/delievery_period.dart';
import 'package:yg_app/model/response/common_response_models/lc_type_response.dart';
import 'package:yg_app/model/response/common_response_models/packing_response.dart';
import 'package:yg_app/model/response/common_response_models/payment_type_response.dart';
import 'package:yg_app/model/response/common_response_models/ports_response.dart';
import 'package:yg_app/model/response/common_response_models/price_term.dart';
import 'package:yg_app/model/response/common_response_models/unit_of_count.dart';
import 'package:yg_app/model/response/yarn_response/sync/yarn_sync_response.dart';
import 'package:yg_app/providers/fabric_providers/fabric_specifications_provider.dart';

import '../../../../providers/fabric_providers/post_fabric_provider.dart';
import '../../../../model/request/post_fabric_request/create_fabric_request_model.dart';

class FabricPackagingDetails extends StatefulWidget {
  final String? locality;
  final String? businessArea;
  final String? selectedTab;

  const FabricPackagingDetails({
    Key? key,
    required this.locality,
    required this.businessArea,
    required this.selectedTab,
  }) : super(key: key);

  @override
  FabricPackagingDetailsState createState() => FabricPackagingDetailsState();
}

class FabricPackagingDetailsState extends State<FabricPackagingDetails>
    with AutomaticKeepAliveClientMixin {
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<String> sellingRegion = [];

  // List<Packing> packingList = [];
  List<PickedFile> imageFiles = [];
  FabricCreateRequestModel? _createRequestModel;
  bool noOfDays = false;
  final TextEditingController _coneWithController = TextEditingController();
  final TextEditingController _weigthPerBagController = TextEditingController();
  final TextEditingController _conePerBagController = TextEditingController();
  bool? _showPaymentType;
  bool? _showLcType;
  int? selectedCountryId;
  String? unitCountSelected;

  late List<FPriceTerms> _priceTermList;
  late List<Packing> _packingList;
  late List<DeliveryPeriod> _deliverPeriodList;
  late List<PaymentType> _paymentTypeList;
  late List<LcType> _lcTypeList;
  late List<Units> _unitsList;
  late List<Countries> _countriesList;
  late List<CityState> _cityStateList;
  late List<Ports> _portsList;
  late List<ConeType> _coneTypeList;

  TextEditingController availableQuantityController = TextEditingController();
  TextEditingController minimumQuantityController = TextEditingController();

  List<FPriceTerms> _getPriceTerms() {
    if (widget.businessArea == yarn) {
      return _priceTermList
          .where((element) => (element.ptr_locality == widget.locality &&
              element.ptrCategoryIdfk == "2"))
          .toList();
    } else {
      return _priceTermList
          .where((element) => (element.ptr_locality == widget.locality &&
              element.ptrCategoryIdfk == "1"))
          .toList();
    }
  }

  _getPackingDetailData() async {
    await AppDbInstance()
        .getPriceTerms()
        .then((value) => setState(() => _priceTermList = value));
    await AppDbInstance().getPacking().then((value) => setState(() {
          _packingList = value;
          _packingList = _packingList
              .where((element) => element.pacIsActive == "1")
              .toList();
        }));
    await AppDbInstance()
        .getDeliveryPeriod()
        .then((value) => setState(() => _deliverPeriodList = value));
    await AppDbInstance()
        .getPaymentType()
        .then((value) => setState(() => _paymentTypeList = value));
    await AppDbInstance()
        .getLcType()
        .then((value) => setState(() => _lcTypeList = value));
    await AppDbInstance()
        .getUnits()
        .then((value) => setState(() => _unitsList = value));
    await AppDbInstance()
        .getOriginsData()
        .then((value) => setState(() => _countriesList = value));
    await AppDbInstance()
        .getCityState()
        .then((value) => setState(() => _cityStateList = value));
    await AppDbInstance()
        .getPorts()
        .then((value) => setState(() => _portsList = value));
    await AppDbInstance()
        .getConeTypes()
        .then((value) => setState(() => _coneTypeList = value));
  }

  @override
  void initState() {
    final postFabricProvider =
        Provider.of<PostFabricProvider>(context, listen: false);
    _getPackingDetailData();
    selectedCountryId = -1;
    sellingRegion.add(widget.locality.toString());
    postFabricProvider.familyDisabled = true;
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // Utils.disableClick = false;
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    final postFabricProvider = Provider.of<PostFabricProvider>(context);
    _createRequestModel = postFabricProvider.fabricCreateRequestModel;
    Logger().e(_createRequestModel!.toJson().toString());
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
                padding: EdgeInsets.only(left: 8.w, right: 8.w),
                child: Form(
                  key: globalFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TitleTextWidget(
                        title: packingDetails,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 8.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //Unit of count and Counting
                            Visibility(
                              visible: /*widget.locality == international*/ true,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                      padding: EdgeInsets.only(
                                          left: 0.w, top: 8, bottom: 4),
                                      child: TitleSmallBoldTextWidget(
                                          title: unitCounting)),
                                  SingleSelectTileWidget(
                                      spanCount: 3,
                                      listOfItems: _unitsList
                                          .where((element) =>
                                              element.untCategoryIdfk ==
                                                  _createRequestModel!
                                                      .spc_category_idfk &&
                                              checkFamilyId(
                                                  element.unt_family_idfk!))
                                          .toList(),
                                      callback: (Units value) {
                                        setState(() {
                                          unitCountSelected = value.untName;
                                        });
                                        if (_createRequestModel != null) {
                                          _createRequestModel!
                                                  .fbp_count_unit_idfk =
                                              value.untId.toString();
                                        }
                                      }),
                                ],
                              ),
                            ),

                            //Weight of count calculation
                            Visibility(
                              visible: true,
                              child: Container(
                                margin: EdgeInsets.only(top: 8.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                            child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
//                                            Padding(
//                                                padding: EdgeInsets.only(
//                                                    top: 8.w, left: 8.w,bottom: 4),
//                                                child: TitleSmallTextWidget(
//                                                    title:
//                                                        "Weight/$unitCountSelected")),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  top: 14.w, bottom: 4),
                                              child: TextFormField(
                                                  controller:
                                                      _weigthPerBagController,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  cursorColor: lightBlueTabs,
                                                  style: TextStyle(
                                                      fontSize: 11.sp),
                                                  textAlign: TextAlign.center,
                                                  cursorHeight: 16.w,
                                                  maxLines: 1,
                                                  onSaved: (input) {
                                                    if (_createRequestModel !=
                                                        null) {
                                                      _createRequestModel!
                                                              .fpb_weight_bag =
                                                          input!;
                                                    }
                                                  },
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter
                                                        .allow(RegExp("[0-9]")),
                                                  ],
                                                  onChanged: (value) {
                                                    if (_conePerBagController
                                                        .text.isNotEmpty) {
                                                      _coneWithController
                                                          .text = (double.parse(
                                                                  _weigthPerBagController
                                                                      .text) /
                                                              double.parse(
                                                                  _conePerBagController
                                                                      .text))
                                                          .toStringAsFixed(2);
                                                    } else {
                                                      _coneWithController.text =
                                                          "";
                                                    }
                                                  },
                                                  validator: (input) {
                                                    if (input == null ||
                                                        input.isEmpty) {
                                                      return "Weight/$unitCountSelected";
                                                    }
                                                    return null;
                                                  },
                                                  decoration: ygTextFieldDecoration(
                                                      "Weight/$unitCountSelected",
                                                      "Weight/$unitCountSelected",
                                                      true)),
                                            ),
                                          ],
                                        )),
                                        SizedBox(width: 16.w),
                                        Expanded(
                                            child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
//                                            Padding(
//                                                padding: EdgeInsets.only(
//                                                    top: 8.w, left: 8.w,bottom: 4),
//                                                child: TitleSmallTextWidget(
//                                                    title: coneBags)),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  top: 14.w, bottom: 4),
                                              child: TextFormField(
                                                  controller:
                                                      _conePerBagController,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  cursorColor: lightBlueTabs,
                                                  style: TextStyle(
                                                      fontSize: 11.sp),
                                                  textAlign: TextAlign.center,
                                                  cursorHeight: 16.w,
                                                  maxLines: 1,
                                                  onSaved: (input) {
                                                    if (_createRequestModel !=
                                                        null) {
                                                      _createRequestModel!
                                                              .fpb_cones_bag =
                                                          input!;
                                                    }
                                                  },
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter
                                                        .allow(RegExp("[0-9]")),
                                                  ],
                                                  onChanged: (value) {
                                                    if (_weigthPerBagController
                                                        .text.isNotEmpty) {
                                                      _coneWithController
                                                          .text = (double.parse(
                                                                  _weigthPerBagController
                                                                      .text) /
                                                              double.parse(
                                                                  value))
                                                          .toStringAsFixed(2);
                                                    } else {
                                                      _coneWithController.text =
                                                          "";
                                                    }
                                                  },
                                                  validator: (input) {
                                                    if (input == null ||
                                                        input.isEmpty) {
                                                      return coneBags;
                                                    }
                                                    return null;
                                                  },
                                                  decoration:
                                                      ygTextFieldDecoration(
                                                          coneBags,
                                                          coneBags,
                                                          true)),
                                            ),
                                          ],
                                        )),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
//                                        Padding(
//                                            padding: EdgeInsets.only(
//                                                top: 8.w, left: 8.w,bottom: 4),
//                                            child: TitleSmallTextWidget(
//                                                title: weightCones)),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: 14.w, bottom: 4),
                                          child: TextFormField(
                                              controller: _coneWithController,
                                              keyboardType:
                                                  TextInputType.number,
                                              readOnly: true,
                                              autofocus: false,
                                              cursorColor: lightBlueTabs,
                                              style: TextStyle(fontSize: 11.sp),
                                              textAlign: TextAlign.center,
                                              cursorHeight: 16.w,
                                              maxLines: 1,
                                              onSaved: (input) {
                                                if (_createRequestModel !=
                                                    null) {
                                                  _createRequestModel!
                                                      .fpb_weight_cone = input!;
                                                }
                                              },
                                              validator: (input) {
                                                if (input == null ||
                                                    input.isEmpty) {
                                                  return weightCones;
                                                }
                                                return null;
                                              },
                                              decoration: ygTextFieldDecoration(
                                                  weightCones,
                                                  weightCones,
                                                  true)),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            //Selling Region
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                      padding: EdgeInsets.only(
                                          left: 0.w, top: 8, bottom: 4),
                                      child: TitleSmallBoldTextWidget(
                                          title: sellingRegionStr)),
                                  SingleSelectTileWidget(
                                    spanCount: 2,
                                    listOfItems: sellingRegion,
                                    callback: (value) {},
                                    selectedIndex: -1,
                                  ),
                                ],
                              ),
                            ),

                            //Country,port
                            Visibility(
                              visible: widget.locality == international
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
//                                          Padding(
//                                              padding:
//                                                  EdgeInsets.only(left: 8.w,bottom: 4),
//                                              child: TitleSmallTextWidget(
//                                                  title: country)),
                                          SizedBox(
                                            height: 40.w,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: Colors.grey.shade300,
                                                    width:
                                                        1, //                   <--- border width here
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              5.w))),
                                              child: DropdownButtonFormField(
                                                hint: const Text(
                                                    'Select Country'),
                                                items: _countriesList
                                                    .map((value) =>
                                                        DropdownMenuItem(
                                                          child: Text(
                                                              value.conName ??
                                                                  Utils.checkNullString(
                                                                      false),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center),
                                                          value: value,
                                                        ))
                                                    .toList(),
                                                isExpanded: true,
                                                onChanged: (Countries? value) {
                                                  FocusScope.of(context)
                                                      .requestFocus(
                                                          FocusNode());
                                                  selectedCountryId =
                                                      value!.conId;
                                                  _createRequestModel!
                                                          .fs_origin_idfk =
                                                      value.conId.toString();
                                                },

                                                // value: widget.syncFiberResponse.data.fiber.brands.first,
                                                decoration: InputDecoration(
                                                  label: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        country,
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black87,
                                                            fontSize: 14.sp,
                                                            backgroundColor:
                                                                Colors.white,
                                                            fontFamily:
                                                                'Metropolis',
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                      Text("*",
                                                          style: TextStyle(
                                                              color: Colors.red,
                                                              fontSize: 16.sp,
                                                              fontFamily:
                                                                  'Metropolis',
                                                              backgroundColor:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500)),
                                                    ],
                                                  ),
                                                  floatingLabelBehavior:
                                                      FloatingLabelBehavior
                                                          .always,
//                                                      hintText: hintLabel,
//                                                      hintStyle: TextStyle(fontSize: 10.sp,fontWeight: FontWeight.w500,color:hintColorGrey),

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
                                                    color: textColorGrey),
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
//                                          Padding(
//                                              padding:
//                                                  EdgeInsets.only(left: 8.w,bottom: 4),
//                                              child: TitleSmallTextWidget(
//                                                  title: port)),
                                          SizedBox(
                                            height: 40.w,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: Colors.grey.shade300,
                                                    width:
                                                        1, //                   <--- border width here
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              5.w))),
                                              child: DropdownButtonFormField(
                                                hint: const Text('Select Port'),
                                                items: _portsList
                                                    .where((element) =>
                                                        element
                                                            .prtCountryIdfk ==
                                                        selectedCountryId
                                                            .toString())
                                                    .toList()
                                                    .map((value) =>
                                                        DropdownMenuItem(
                                                          child: Text(
                                                              value.prtName ??
                                                                  Utils.checkNullString(
                                                                      false),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center),
                                                          value: value,
                                                        ))
                                                    .toList(),
                                                isExpanded: true,
                                                onChanged: (Ports? value) {
                                                  FocusScope.of(context)
                                                      .requestFocus(
                                                          FocusNode());
                                                  _createRequestModel!
                                                          .fbp_port_idfk =
                                                      value!.prtId.toString();
                                                },

                                                // value: widget.syncFiberResponse.data.fiber.brands.first,
                                                decoration: InputDecoration(
                                                  label: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        port,
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black87,
                                                            fontSize: 14.sp,
                                                            backgroundColor:
                                                                Colors.white,
                                                            fontFamily:
                                                                'Metropolis',
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                      Text("*",
                                                          style: TextStyle(
                                                              color: Colors.red,
                                                              fontSize: 16.sp,
                                                              fontFamily:
                                                                  'Metropolis',
                                                              backgroundColor:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500)),
                                                    ],
                                                  ),
                                                  floatingLabelBehavior:
                                                      FloatingLabelBehavior
                                                          .always,
//                                                      hintText: hintLabel,
//                                                      hintStyle: TextStyle(fontSize: 10.sp,fontWeight: FontWeight.w500,color:hintColorGrey),

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
                                                    color: textColorGrey),
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
                            //City State
                            Visibility(
                                visible: widget.locality == international
                                    ? true
                                    : false,
                                child: Padding(
                                  padding: EdgeInsets.only(top: 8.w),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
//                                      Padding(
//                                          padding: EdgeInsets.only(left: 8.w,bottom: 4),
//                                          child: TitleSmallTextWidget(
//                                              title: cityState)),
                                      SizedBox(
                                        height: 40.w,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Colors.grey.shade300,
                                                width:
                                                    1, //                   <--- border width here
                                              ),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5.w))),
                                          child: DropdownButtonFormField(
                                            hint: Text('Select $cityState'),
                                            items: _cityStateList
                                                .where((element) =>
                                                    element.countryId ==
                                                    selectedCountryId
                                                        .toString())
                                                .toList()
                                                .map(
                                                    (value) => DropdownMenuItem(
                                                          child: Text(
                                                              value.name ??
                                                                  Utils.checkNullString(
                                                                      false),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center),
                                                          value: value,
                                                        ))
                                                .toList(),
                                            isExpanded: true,
                                            onChanged: (CityState? value) {
                                              FocusScope.of(context)
                                                  .requestFocus(FocusNode());
                                              _createRequestModel!
                                                      .fs_city_state_idfk =
                                                  value!.countryId.toString();
                                            },

                                            // value: widget.syncFiberResponse.data.fiber.brands.first,
                                            decoration: InputDecoration(
                                              label: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    cityState,
                                                    style: TextStyle(
                                                        color: Colors.black87,
                                                        fontSize: 14.sp,
                                                        backgroundColor:
                                                            Colors.white,
                                                        fontFamily:
                                                            'Metropolis',
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  Text("*",
                                                      style: TextStyle(
                                                          color: Colors.red,
                                                          fontSize: 16.sp,
                                                          fontFamily:
                                                              'Metropolis',
                                                          backgroundColor:
                                                              Colors.white,
                                                          fontWeight:
                                                              FontWeight.w500)),
                                                ],
                                              ),
                                              floatingLabelBehavior:
                                                  FloatingLabelBehavior.always,
//                                                      hintText: hintLabel,
//                                                      hintStyle: TextStyle(fontSize: 10.sp,fontWeight: FontWeight.w500,color:hintColorGrey),

                                              contentPadding: EdgeInsets.only(
                                                  left: 16.w,
                                                  right: 6.w,
                                                  top: 0,
                                                  bottom: 0),
                                              border: const OutlineInputBorder(
                                                  borderSide: BorderSide.none),
                                            ),
                                            style: TextStyle(
                                                fontSize: 11.sp,
                                                color: textColorGrey),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )),

                            //Price Terms
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
//                                Padding(
//                                    padding:
//                                        EdgeInsets.only(top: 8.w, left: 8.w,bottom: 4),
//                                    child: TitleSmallTextWidget(
//                                        title: priceTerms)),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 14.0, bottom: 4),
                                  child: SizedBox(
                                    height: 40.w,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.grey.shade300,
                                            width:
                                                1, //                   <--- border width here
                                          ),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5.w))),
                                      child: DropdownButtonFormField(
                                        hint: const Text('Select Price Terms'),
                                        items: _getPriceTerms()
                                            .map((value) => DropdownMenuItem(
                                                  child: Text(
                                                      value.ptrName ??
                                                          Utils.checkNullString(
                                                              false),
                                                      textAlign:
                                                          TextAlign.center),
                                                  value: value,
                                                ))
                                            .toList(),
                                        isExpanded: true,
                                        onChanged: (FPriceTerms? value) {
                                          FocusScope.of(context)
                                              .requestFocus(FocusNode());
                                          setState(() {
                                            if (value!.ptrId == 3) {
                                              _showPaymentType = true;
                                            } else {
                                              _showPaymentType = false;
                                              _showLcType = false;
                                              _createRequestModel!
                                                  .fpb_payment_type_idfk = null;
                                              _createRequestModel!
                                                  .fpb_lc_type_idfk = null;
                                            }
                                          });
                                          _createRequestModel!
                                                  .fbp_price_terms_idfk =
                                              value!.ptrId.toString();
                                        },
                                        // validator: (value) => value == null
                                        //     ? 'field required'
                                        //     : null,
                                        // value: widget.syncFiberResponse.data.fiber.brands.first,
                                        decoration: InputDecoration(
                                          label: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                priceTerms,
                                                style: TextStyle(
                                                    color: Colors.black87,
                                                    fontSize: 14.sp,
                                                    backgroundColor:
                                                        Colors.white,
                                                    fontFamily: 'Metropolis',
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              Text("*",
                                                  style: TextStyle(
                                                      color: Colors.red,
                                                      fontSize: 16.sp,
                                                      fontFamily: 'Metropolis',
                                                      backgroundColor:
                                                          Colors.white,
                                                      fontWeight:
                                                          FontWeight.w500)),
                                            ],
                                          ),
                                          floatingLabelBehavior:
                                              FloatingLabelBehavior.always,
//                                                      hintText: hintLabel,
//                                                      hintStyle: TextStyle(fontSize: 10.sp,fontWeight: FontWeight.w500,color:hintColorGrey),

                                          contentPadding: EdgeInsets.only(
                                              left: 16.w,
                                              right: 6.w,
                                              top: 0,
                                              bottom: 0),
                                          border: const OutlineInputBorder(
                                              borderSide: BorderSide.none),
                                        ),
                                        style: TextStyle(
                                            fontSize: 11.sp,
                                            color: textColorGrey),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            //Payment Type
                            Visibility(
                                visible: true,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 0.w, top: 8, bottom: 4),
                                        child: TitleSmallBoldTextWidget(
                                            title: paymentType)),
                                    SingleSelectTileWidget(
                                        spanCount: 3,
                                        selectedIndex: -1,
                                        listOfItems: _paymentTypeList,
                                        callback: (PaymentType value) {
                                          _createRequestModel!
                                                  .fpb_payment_type_idfk =
                                              value.payId;

                                          setState(() {
                                            if (value.payId == "1") {
                                              _showLcType = true;
                                            } else {
                                              _showLcType = false;
                                              _createRequestModel!
                                                  .fpb_lc_type_idfk = null;
                                            }
                                          });
                                        }),
                                  ],
                                )),

                            //Lc Type
                            Visibility(
                              visible: _showLcType ?? false,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                      padding: EdgeInsets.only(
                                          left: 0.w, top: 8, bottom: 4),
                                      child: TitleSmallBoldTextWidget(
                                          title: lcType)),
                                  SingleSelectTileWidget(
                                      spanCount: 3,
                                      selectedIndex: -1,
                                      listOfItems: _lcTypeList,
                                      callback: (LcType value) {
                                        if (_createRequestModel != null) {
                                          _createRequestModel!
                                                  .fpb_lc_type_idfk =
                                              value.lcId.toString();
                                        }
                                      }),
                                ],
                              ),
                            ),

                            //Price Unit and Available Quantity
                            Row(
                              children: [
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
//                                    Padding(
//                                        padding: EdgeInsets.only(
//                                            top: 8.w, left: 8.w,bottom: 4),
//                                        child: TitleSmallTextWidget(
//                                            title: priceUnits)),
                                    Padding(
                                      padding:
                                          EdgeInsets.only(top: 14.w, bottom: 4),
                                      child: TextFormField(
                                          keyboardType: TextInputType.number,
                                          cursorColor: lightBlueTabs,
                                          style: TextStyle(fontSize: 11.sp),
                                          textAlign: TextAlign.center,
                                          cursorHeight: 16.w,
                                          maxLines: 1,
                                          inputFormatters: [
                                            FilteringTextInputFormatter.allow(
                                                RegExp("[0-9]")),
                                          ],
                                          onSaved: (input) {
                                            if (_createRequestModel != null) {
                                              _createRequestModel!.fbp_price =
                                                  input!;
                                            }
                                          },
                                          validator: (input) {
                                            if (input == null ||
                                                input.isEmpty ||
                                                int.parse(input) < 1) {
                                              return priceUnits;
                                            }
                                            return null;
                                          },
                                          decoration: ygTextFieldDecoration(
                                              priceUnits, priceUnits, true)),
                                    ),
                                  ],
                                )),
                                SizedBox(width: 16.w),
                                Expanded(
                                  child:
                                      //Available Quantity
                                      Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
//                                      Padding(
//                                          padding: EdgeInsets.only(
//                                              top: 8.w, left: 8.w),
//                                          child: const TitleSmallTextWidget(
//                                              title: "Available Quantity")),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: 14.w, bottom: 4),
                                        child: TextFormField(
                                            controller:
                                                availableQuantityController,
                                            keyboardType: TextInputType.number,
                                            cursorColor: lightBlueTabs,
                                            style: TextStyle(fontSize: 11.sp),
                                            textAlign: TextAlign.center,
                                            cursorHeight: 16.w,
                                            maxLines: 1,
                                            inputFormatters: [
                                              FilteringTextInputFormatter.allow(
                                                  RegExp("[0-9]")),
                                            ],
                                            onSaved: (input) {
                                              if (_createRequestModel != null) {
                                                _createRequestModel!
                                                        .fbp_available_quantity =
                                                    input!;
                                              }
                                            },
                                            validator: (input) {
                                              if (input == null ||
                                                  input.isEmpty ||
                                                  int.parse(input) < 1) {
                                                return "Available Quantity";
                                              }
                                              return null;
                                            },
                                            decoration: ygTextFieldDecoration(
                                                "Available Quantity",
                                                "Available Quantity",
                                                true)),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            /*//Available Quantity
                            Visibility(
                              visible: true,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                      padding:
                                          EdgeInsets.only(top: 8.w, left: 8.w),
                                      child: const TitleSmallTextWidget(title: 'Available Quantity')),
                                  TextFormField(
                                      keyboardType: TextInputType.number,
                                      cursorColor: lightBlueTabs,
                                      style: TextStyle(fontSize: 11.sp),
                                      textAlign: TextAlign.center,
                                      cursorHeight: 16.w,
                                      maxLines: 1,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                            RegExp("[0-9]")),
                                      ],
                                      onSaved: (input) {
                                        if (_createRequestModel != null) {
                                          _createRequestModel!.fbp_available_quantity =
                                              input!;
                                        }
                                      },
                                      validator: (input) {
                                        if (input == null ||
                                            input.isEmpty ||
                                            int.parse(input) < 1) {
                                          return 'Available Quantity';
                                        }
                                        return null;
                                      },
                                      decoration:
                                          roundedTextFieldDecoration('Available Quantity')),
                                ],
                              ),
                            ),*/

                            //Minimum Quantity
                            Visibility(
                              visible: true,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
//                                  Padding(
//                                      padding:
//                                          EdgeInsets.only(top: 8.w, left: 8.w,bottom: 4),
//                                      child: TitleSmallTextWidget(title: minQty)),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(top: 14.w, bottom: 4),
                                    child: TextFormField(
                                        controller: minimumQuantityController,
                                        keyboardType: TextInputType.number,
                                        cursorColor: lightBlueTabs,
                                        style: TextStyle(fontSize: 11.sp),
                                        textAlign: TextAlign.center,
                                        cursorHeight: 16.w,
                                        maxLines: 1,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(
                                              RegExp("[0-9]")),
                                        ],
                                        onSaved: (input) {
                                          if (_createRequestModel != null) {
                                            _createRequestModel!
                                                .fbp_min_quantity = input!;
                                          }
                                        },
                                        validator: (input) {
                                          if (input == null ||
                                              input.isEmpty ||
                                              int.parse(input) < 1) {
                                            return minQty;
                                          }
                                          return null;
                                        },
                                        onChanged: (String value) {
                                          if (value.isNotEmpty) {
                                            int availableQuantity = int.parse(
                                                availableQuantityController
                                                    .text);
                                            int minimumQuantity =
                                                int.parse(value);
                                            if (minimumQuantity >
                                                availableQuantity) {
                                              FocusScope.of(context).unfocus();
                                              minimumQuantityController.text =
                                                  '';
                                              Fluttertoast.showToast(
                                                  msg:
                                                      'Minimum Quantity can not be greater than Available Quantity');
                                            }
                                          }
                                        },
                                        decoration: ygTextFieldDecoration(
                                            minQty, minQty, true)),
                                  ),
                                ],
                              ),
                            ),

                            //Packing
                            Visibility(
                              visible: true,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                      padding: EdgeInsets.only(
                                          left: 0.w, top: 8, bottom: 4),
                                      child: TitleSmallBoldTextWidget(
                                          title: packing)),
                                  SingleSelectTileWidget(
                                    selectedIndex: -1,
                                      spanCount: 3,
                                      listOfItems: _packingList,
                                      callback: (Packing value) {
                                        if (_createRequestModel != null) {
                                          _createRequestModel!.fpb_packing =
                                              value.pacId.toString();
                                        }
                                      }),
                                ],
                              ),
                            ),

                            //Delivery Period
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: 0.w, top: 8, bottom: 4),
                                    child: TitleSmallBoldTextWidget(
                                        title: deliveryPeriod)),
                                SingleSelectTileWidget(
                                    selectedIndex: -1,
                                    spanCount: 3,
                                    listOfItems: _deliverPeriodList
                                        .where((element) =>
                                            element.dprCategoryIdfk == '3')
                                        .toList(),
                                    callback: (DeliveryPeriod value) {
                                      if (_createRequestModel != null) {
                                        _createRequestModel!
                                                .fbp_delivery_period_idfk =
                                            value.dprId.toString();
                                        if (value.dprName == 'No Of Days') {
                                          setState(() {
                                            noOfDays = true;
                                          });
                                        } else {
                                          setState(() {
                                            noOfDays = false;
                                          });
                                        }
                                      }
                                    }),
                              ],
                            ),

                            //No of Days
                            Visibility(
                              visible: noOfDays,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                      padding: EdgeInsets.only(
                                          left: 0.w, top: 8, bottom: 4),
                                      child: const TitleSmallBoldTextWidget(
                                          title: 'No of Days')),
                                  SingleSelectTileWidget(
                                      spanCount: 3,
                                      listOfItems: Iterable<int>.generate(102)
                                          .toList()
                                          .map((value) => value == 101
                                              ? 'Other'
                                              : value.toString())
                                          .toList(),
                                      callback: (String? value) {
                                        _createRequestModel!.fbp_no_of_days =
                                            value!.toString();
                                      }),
                                ],
                              ),
                            ),

                            /*Visibility(
                              visible: noOfDays,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
//                                  Padding(
//                                      padding:
//                                          EdgeInsets.only(top: 8.w, left: 8.w,bottom: 4),
//                                      child: const TitleSmallTextWidget(
//                                          title: "No of Days")),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 14.0,bottom: 4),
                                    child: SizedBox(
                                      height: 40.w,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Colors.grey.shade300,
                                              width:
                                                  1, //                   <--- border width here
                                            ),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5.w))),
                                        child: DropdownButtonFormField(
                                          hint: const Text('Select Number'),
                                          items: Iterable<int>.generate(101)
                                              .toList()
                                              .map((value) => DropdownMenuItem(
                                                    child: Text(value.toString(),
                                                        textAlign:
                                                            TextAlign.center),
                                                    value: value,
                                                  ))
                                              .toList(),
                                          isExpanded: true,
                                          validator: (value) => value == null
                                              ? 'field required'
                                              : null,
                                          onChanged: (int? value) {
                                            FocusScope.of(context)
                                                .requestFocus(FocusNode());
                                            _createRequestModel!.fbp_no_of_days =
                                                value!.toString();
                                          },

                                          // value: widget.syncFiberResponse.data.fiber.brands.first,
                                          decoration: InputDecoration(
                                            label: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Text("No of Days",style:TextStyle(
                                                    color: Colors.black87,
                                                    fontSize: 14.sp,
                                                    backgroundColor: Colors.white,
                                                    fontFamily: 'Metropolis',
                                                    fontWeight: FontWeight.w500),),
                                                Text("*", style: TextStyle(color: Colors.red,fontSize: 16.sp,
                                                    fontFamily: 'Metropolis',
                                                    backgroundColor: Colors.white,
                                                    fontWeight: FontWeight.w500)),
                                              ],
                                            ),
                                            floatingLabelBehavior:FloatingLabelBehavior.always ,
//                                                      hintText: hintLabel,
//                                                      hintStyle: TextStyle(fontSize: 10.sp,fontWeight: FontWeight.w500,color:hintColorGrey),

                                            contentPadding:
                                            EdgeInsets.only(
                                                left: 16.w,
                                                right: 6.w,
                                                top: 0,
                                                bottom: 0),
                                            border:
                                            const OutlineInputBorder(
                                                borderSide:
                                                BorderSide
                                                    .none),
                                          ),
                                          style: TextStyle(
                                              fontSize: 11.sp,
                                              color: textColorGrey),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),*/

                            //Description
//                            Padding(
//                                padding: EdgeInsets.only(top: 8.w, left: 8.w),
//                                child: TitleSmallTextWidget(
//                                    title: descriptionStr)),

                            Padding(
                              padding: EdgeInsets.only(top: 14.w, bottom: 4),
                              child: SizedBox(
                                height: 5 * 22.w,
                                child: TextFormField(
                                    keyboardType: TextInputType.text,
                                    maxLines: 5,
                                    cursorColor: lightBlueTabs,
                                    style: TextStyle(fontSize: 11.sp),
                                    textAlign: TextAlign.start,
                                    cursorHeight: 16.w,
                                    onSaved: (input) {
                                      if (_createRequestModel != null) {
                                        _createRequestModel!.fbp_description =
                                            input!;
                                      }
                                    },
                                    // validator: (input) {
                                    //   if (input == null || input.isEmpty) {
                                    //     return descriptionStr;
                                    //   }
                                    //   return null;
                                    // },
                                    decoration: ygTextFieldDecoration(
                                        descriptionStr, descriptionStr, true)),
                              ),
                            ),

                            Visibility(
                                visible: true,
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: TitleSmallBoldTextWidget(
                                          title: attachment),
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    AddPictureWidget(
                                      imageCount: 1,
                                      callbackImages: (value) {
                                        imageFiles = value;
                                      },
                                    ),
                                  ],
                                ))
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
          Padding(
            padding: EdgeInsets.all(8.w),
            child: SizedBox(
              width: double.maxFinite,
              child: ElevatedButtonWithIcon(
                callback: () {
                  FocusScope.of(context).unfocus();
                  if (validateAndSave()) {
                    showGenericDialog(
                      '',
                      "Are you sure, you want to submit?",
                      context,
                      StylishDialogType.WARNING,
                      'Yes',
                      () {
                        submitData(context);
                      },
                    );
                  }
                },
                color: btnColorLogin,
                btnText: submit,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void submitData(BuildContext context) {
    if (_createRequestModel != null) {
      /*if (widget.businessArea == yarn) {
        _createRequestModel!.fs_local_international =
            widget.locality!.toUpperCase();
      } else {
        _createRequestModel!.fs_local_international =
            widget.locality!.toUpperCase();
      }*/
      _createRequestModel!.fs_local_international =
          widget.locality!.toUpperCase();

      ProgressDialogUtil.showDialog(context, 'Please wait...');

      ApiService.createFabricSpecification(_createRequestModel!,
              imageFiles.isNotEmpty ? imageFiles[0].path : "")
          .then((value) {
        ProgressDialogUtil.hideDialog();
        if (value.status) {
          Fluttertoast.showToast(msg: value.message);
          if (value.responseCode == 205) {
            showGenericDialog(
              '',
              value.message.toString(),
              context,
              StylishDialogType.WARNING,
              'Update',
              () {
                openMyAdsScreen(context);
              },
            );
          } else {
            final fabricSpecificationsProvider =
                Provider.of<FabricSpecificationsProvider>(context,
                    listen: false);
            fabricSpecificationsProvider.getUpdatedFabricSpecificationsData();
            Navigator.pop(context);
          }
        } else {
          //Ui.showSnackBar(context, value.message);
          showGenericDialog(
            '',
            value.message.toString(),
            context,
            StylishDialogType.ERROR,
            'Yes',
            () {},
          );
        }
      }).onError((error, stackTrace) {
        ProgressDialogUtil.hideDialog();
        //Ui.showSnackBar(context, error.toString());
        showGenericDialog(
          '',
          error.toString(),
          context,
          StylishDialogType.ERROR,
          'Yes',
          () {},
        );
      });
    }
  }

  _initialValuesRequestModel() {
    if (widget.locality == international) {
      _createRequestModel!.fpb_lc_type_idfk = _lcTypeList.first.lcId.toString();
    }
    _createRequestModel!.is_offering = widget.selectedTab;
    // _createRequestModel!.fbp_price_terms_idfk =
    //     widget.priceTerms!.first.ptrId.toString();
    _createRequestModel!.fbp_count_unit_idfk = _unitsList
        .where((element) =>
            element.untCategoryIdfk == _createRequestModel!.spc_category_idfk)
        .toList()
        .first
        .untId
        .toString();
    unitCountSelected ??= _unitsList
        .where((element) =>
            element.untCategoryIdfk == _createRequestModel!.spc_category_idfk)
        .toList()
        .first
        .untName;
    // _createRequestModel!.fpb_packing = _packingList.first.pacId.toString();
    // _createRequestModel!.fbp_delivery_period_idfk =
    //     _deliverPeriodList.first.dprId.toString();
  }

  bool validateAndSave() {
    final form = globalFormKey.currentState;

    if (_createRequestModel!.fbp_price_terms_idfk == null) {
      Ui.showSnackBar(context, "Please select price terms");
      return false;
    }

     if (_createRequestModel!.fbp_delivery_period_idfk == null) {
      Ui.showSnackBar(context, "Please select delivery period");
      return false;
    }

    if (_createRequestModel!.fbp_no_of_days == null && noOfDays) {
      Ui.showSnackBar(context, "Please select number of days");
      return false;
    }

    if (form!.validate()) {
      // if (imageFiles.isNotEmpty) {
      form.save();
      return true;
      // } else {
      //   Scaffold.of(context).showSnackBar(
      //       const SnackBar(content: Text('Please Capture Image first')));
      // }
    }
    return false;
    // return true;
  }

  bool checkFamilyId(String familyId) {
    return familyId == _createRequestModel!.fs_family_idfk;
  }
}
