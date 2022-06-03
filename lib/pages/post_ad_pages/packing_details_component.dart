import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
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
import 'package:yg_app/locators.dart';
import 'package:yg_app/model/request/post_ad_request/create_request_model.dart';
import 'package:yg_app/model/response/common_response_models/city_state_response.dart';
import 'package:yg_app/model/response/common_response_models/cone_type_reponse.dart';
import 'package:yg_app/model/response/common_response_models/countries_response.dart';
import 'package:yg_app/model/response/common_response_models/delievery_period.dart';
import 'package:yg_app/model/response/common_response_models/payment_type_response.dart';
import 'package:yg_app/model/response/common_response_models/ports_response.dart';
import 'package:yg_app/model/response/common_response_models/price_term.dart';
import 'package:yg_app/model/response/common_response_models/unit_of_count.dart';
import 'package:yg_app/model/response/login/login_response.dart';
import 'package:yg_app/model/response/yarn_response/sync/yarn_sync_response.dart';
import 'package:yg_app/pages/auth_pages/signup/country_search_page.dart';
import 'package:yg_app/providers/fabric_providers/post_fabric_provider.dart';
import 'package:yg_app/providers/fiber_providers/fiber_specification_provider.dart';
import 'package:yg_app/providers/fiber_providers/post_fiber_provider.dart';
import 'package:yg_app/providers/yarn_providers/post_yarn_provider.dart';
import 'package:yg_app/providers/yarn_providers/yarn_specifications_provider.dart';

class PackagingDetails extends StatefulWidget {
  final String? locality;
  final String? businessArea;
  final String? selectedTab;

  const PackagingDetails({
    Key? key,
    required this.locality,
    required this.businessArea,
    required this.selectedTab,
  }) : super(key: key);

  @override
  PackagingDetailsState createState() => PackagingDetailsState();
}

class PackagingDetailsState extends State<PackagingDetails>
    with AutomaticKeepAliveClientMixin {
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<String> sellingRegion = [];
  List<PickedFile> imageFiles = [];
  CreateRequestModel? _createRequestModel;
  bool noOfDays = false;
  final TextEditingController _coneWithController = TextEditingController();
  final TextEditingController _weigthPerBagController = TextEditingController();
  final TextEditingController _conePerBagController = TextEditingController();

  // bool? _showPaymentType;
  // bool? _showLcType;
  bool? noOfDaysTF = false;
  int? selectedCountryId;
  String? unitCountSelected;

  List<FPriceTerms> _priceTermList = [];

  // List<Packing> _packingList= [];
  List<DeliveryPeriod> _deliverPeriodList = [];
  List<PaymentType> _paymentTypeList = [];

  // List<LcType> _lcTypeList= [];
  List<Units> _unitsList = [];
  List<Countries> _countriesList = [];
  List<CityState> _cityStateList = [];
  List<Ports> _portsList = [];
  List<ConeType> _coneTypeList = [];

  final _fiberPostProvider = locator<PostFiberProvider>();
  final _yarnPostProvider = locator<PostYarnProvider>();
  TextEditingController availableQuantityController = TextEditingController();
  TextEditingController minimumQuantityController = TextEditingController();
  final _fabricPostProvider = locator<PostFabricProvider>();
  final _fiberSpecificationProvider = locator<FiberSpecificationProvider>();
  final _yarnSpecificationProvider = locator<YarnSpecificationsProvider>();

  String? selectedCountryName;

  // List<FPriceTerms> _getPriceTerms() {
  //   if (widget.businessArea == yarn) {
  //     return _priceTermList
  //         .where((element) => (element.ptr_locality == widget.locality &&
  //             element.ptrCategoryIdfk == "2"))
  //         .toList();
  //   } else {
  //     return _priceTermList
  //         .where((element) => (element.ptr_locality == widget.locality &&
  //             element.ptrCategoryIdfk == "1"))
  //         .toList();
  //   }
  // }

  _getPackingDetailData() async {
    var dbInstance = await AppDbInstance().getDbInstance();

    _priceTermList = await dbInstance.priceTermsDao
        .findYarnFPriceTermsWithCatIdLocality(
            int.parse(_createRequestModel!.spc_category_idfk!),widget.locality!);
    _deliverPeriodList = await dbInstance.deliveryPeriodDao
        .findAllDeliveryPeriodWithCatId(
            int.parse(_createRequestModel!.spc_category_idfk!));
    _paymentTypeList = await dbInstance.paymentTypeDao.findAllPaymentTypes();

    _countriesList = await dbInstance.countriesDao.findAllCountries();
    _cityStateList = await dbInstance.cityStateDao.findAllCityState();
    _portsList = await dbInstance.portsDao.findAllPorts();
//    print("fiber"+_createRequestModel!.spc_fiber_family_idfk.toString());
    if (_createRequestModel!.spc_category_idfk == "1") {
      _unitsList = await dbInstance.unitDao.findAllUnitWithCatIdFamId(
          1, int.parse(_createRequestModel!.spc_fiber_family_idfk!));

    //  _coneTypeList = await dbInstance.coneTypeDao.findAllConeType();
      _coneTypeList = await dbInstance.coneTypeDao.findAllConeTypeWithCatAndFamID(
        int.parse(_createRequestModel!.spc_fiber_family_idfk!),1
          );
         /* .findAllConeTypeWithCatAndFamID(
              int.parse(_createRequestModel!.spc_fiber_family_idfk!), 1);
*/
    } else {
      _unitsList = await dbInstance.unitDao.findAllUnitWithCatIdFamId(
          2, int.parse(_createRequestModel!.ys_family_idfk!));

      _coneTypeList = await dbInstance.coneTypeDao
          .findAllConeTypeWithCatAndFamID(
              int.parse(_createRequestModel!.ys_family_idfk!), 2);

    }
    unitCountSelected = _unitsList.first.untName;
    _createRequestModel!.cone_type_id = _coneTypeList.first.yctId.toString();
    _createRequestModel!.fbp_count_unit_idfk = _unitsList.first.untId.toString();
    setState(() {

    });
  }

  @override
  void initState() {
    //INITIAL VALUES
    // Utils.disableClick = true;
    selectedCountryId = -1;
    sellingRegion.add(widget.locality.toString());

    super.initState();

    if (widget.businessArea == "Fiber") {

      _createRequestModel = _fiberPostProvider.createRequestModel;
    }else if (_yarnPostProvider.createRequestModel != null) {
      _createRequestModel = _yarnPostProvider.createRequestModel;
      _yarnPostProvider.familyDisabled = true;

    }
    // if (_createRequestModel!.spc_category_idfk != null &&
    //     _createRequestModel!.spc_category_idfk == '1') {
    //   _createRequestModel = _fiberPostProvider.createRequestModel;
    // } else if (_createRequestModel!.spc_category_idfk != null &&
    //     _createRequestModel!.spc_category_idfk == '2') {
    // }

    _getPackingDetailData();
  }

  @override
  void dispose() {
    // Utils.disableClick = false;
    _fiberPostProvider.createRequestModel = null;
    _yarnPostProvider.createRequestModel = null;
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    // _initialValuesRequestModel();
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
                padding: EdgeInsets.only(top: 0.w, left: 16.w, right: 16.w),
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
                                          left: 0.w, top: 4, bottom: 4),
                                      child: TitleSmallBoldTextWidget(
                                          title: unitCounting)),
                                  SingleSelectTileWidget(
                                      selectedIndex: 0,
                                      spanCount: 3,
                                      listOfItems: _unitsList,
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
                            //Show Cone type
                            Visibility(
                              // visible:
                              //     widget.businessArea != yarn ? false : true,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                      padding:
                                      EdgeInsets.only(top: 8.w, left: 8.w),
                                      child: const TitleSmallBoldTextWidget(
                                          title: "Packing")),
                                  SingleSelectTileWidget(
                                      spanCount: 3,
                                      selectedIndex: 0,
                                      listOfItems: _coneTypeList,
                                      callback: (ConeType value) {
                                        _createRequestModel!.cone_type_id =
                                            value.yctId.toString();
                                      }),
                                ],
                              ),
                            ),
                            //Weight of count calculation
                            Visibility(
                              visible:
                                  widget.businessArea == yarn ? true : false,
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
                                            SizedBox(
                                              height: 12.w,
                                            ),
//                                            Padding(
//                                                padding: EdgeInsets.only(
//                                                    top: 8.w, left: 8.w),
//                                                child: TitleSmallTextWidget(
//                                                    title:
//                                                        "Weight($unitCountSelected)/Bag")),
                                            TextFormField(
                                                controller:
                                                    _weigthPerBagController,
                                                keyboardType:
                                                    TextInputType.number,
                                                cursorColor: lightBlueTabs,
                                                style:
                                                    TextStyle(fontSize: 11.sp),
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
                                                    return "Weight($unitCountSelected)/Bag";
                                                  }
                                                  return null;
                                                },
                                                decoration: ygTextFieldDecoration(
                                                    "Weight($unitCountSelected)/Bag",
                                                    "Weight($unitCountSelected)/Bag",
                                                    true)),
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
//                                                    top: 8.w, left: 8.w),
//                                                child: TitleSmallTextWidget(
//                                                    title: coneBags)),
                                            SizedBox(
                                              height: 12.w,
                                            ),
                                            TextFormField(
                                                controller:
                                                    _conePerBagController,
                                                keyboardType:
                                                    TextInputType.number,
                                                cursorColor: lightBlueTabs,
                                                style:
                                                    TextStyle(fontSize: 11.sp),
                                                textAlign: TextAlign.center,
                                                cursorHeight: 16.w,
                                                maxLines: 1,
                                                onSaved: (input) {
                                                  if (_createRequestModel !=
                                                      null) {
                                                    _createRequestModel!
                                                        .fpb_cones_bag = input!;
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
                                                            double.parse(value))
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
                                          ],
                                        )),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
//                                        Padding(
//                                            padding: EdgeInsets.only(
//                                                top: 8.w, left: 8.w),
//                                            child: TitleSmallTextWidget(
//                                                title: weightCones)),
                                          SizedBox(
                                            height: 12.w,
                                          ),
                                          TextFormField(
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
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),



                            //Selling Region
                            Visibility(
                              visible: false,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 0.w, top: 4, bottom: 4),
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
                                    child:Padding(
                                      padding: EdgeInsets.only(top: 8.w),
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 12.w,
                                          ),
                                          GestureDetector(
                                            onTap: (){
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => SelectCountryPage(title:"Country",isCodeVisible: false, callback:(Countries value)=>{
                                                    setState(() {
                                                     FocusScope.of(context)
                                                      .requestFocus(
                                                          FocusNode());
                                                  selectedCountryId =
                                                      value.conId;
                                                  selectedCountryName =
                                                      value.conName;

                                                  if (widget.businessArea ==
                                                      yarn) {
                                                    _createRequestModel!
                                                            .ys_origin_idfk =
                                                        value.conId.toString();
                                                  } else {
                                                    _createRequestModel!
                                                            .ys_origin_idfk =
                                                        value.conId.toString();
                                                  }
                                                    }
                                                    )


                                                  },
                                                  ),
                                                ),
                                              );
                                            },
                                            child: SizedBox(
                                              height: 40.w,
                                              child:Container(
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: Colors.grey.shade300,
                                                      width:
                                                      1, //                   <--- border width here
                                                    ),
                                                    borderRadius: BorderRadius.all(
                                                        Radius.circular(5.w))),
                                                child: InputDecorator(
                                                  decoration: InputDecoration(
                                                    label: Row(
                                                      mainAxisSize:
                                                      MainAxisSize.min,
                                                      mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          'Country',
                                                          style: TextStyle(
                                                              color: Colors.black87,
                                                              fontSize: 14.sp,
                                                              /*fontFamily: 'Metropolis',*/
                                                              backgroundColor:
                                                              Colors.white,
                                                              fontWeight:
                                                              FontWeight.w500),
                                                        ),
                                                        Text("*",
                                                            style: TextStyle(
                                                                color: Colors.red,
                                                                fontSize: 16.sp,
                                                                /*fontFamily: 'Metropolis',*/
                                                                backgroundColor:
                                                                Colors.white,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w500)),
                                                      ],
                                                    ),
                                                    contentPadding: EdgeInsets.only(
                                                        left: 10.w,
                                                        right: 6.w,
                                                        top: 0,
                                                        bottom: 0),
                                                    suffixIcon:const Icon(Icons.arrow_drop_down,color: Colors.black54,),
                                                    floatingLabelBehavior:FloatingLabelBehavior.always ,
                                                    hintText:'Select Country',
                                                    border: const OutlineInputBorder(
                                                        borderSide:
                                                        BorderSide.none),
                                                    hintStyle: TextStyle(
                                                        fontSize: 11.sp,
                                                        color: textColorGrey),
                                                  ),

                                                  child: Row(
                                                    children: [

                                                      Expanded(
                                                          flex:8,
                                                          child: Text(
                                                             selectedCountryName ?? "Select Country",textAlign: TextAlign.start,style:TextStyle(
                                                              fontSize: 11.sp,
                                                              color: textColorGrey))),

                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
//                                    Padding(
//                                      padding: EdgeInsets.only(top: 8.w),
//                                      child: Column(
//                                        crossAxisAlignment:
//                                            CrossAxisAlignment.start,
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
//                                            height: 40.w,
//                                            child: Container(
//                                              decoration: BoxDecoration(
//                                                  border: Border.all(
//                                                    color: Colors.grey.shade300,
//                                                    width:
//                                                        1, //                   <--- border width here
//                                                  ),
//                                                  borderRadius:
//                                                      BorderRadius.all(
//                                                          Radius.circular(
//                                                              5.w))),
//                                              child: DropdownButtonFormField(
//                                                hint: const Text(
//                                                    'Select Country'),
//                                                items: _countriesList
//                                                    .map((value) =>
//                                                        DropdownMenuItem(
//                                                          child: Text(
//                                                              value.conName ??
//                                                                  Utils.checkNullString(
//                                                                      false),
//                                                              textAlign:
//                                                                  TextAlign
//                                                                      .center),
//                                                          value: value,
//                                                        ))
//                                                    .toList(),
//                                                isExpanded: true,
//                                                onChanged: (Countries? value) {
//                                                  FocusScope.of(context)
//                                                      .requestFocus(
//                                                          FocusNode());
//                                                  selectedCountryId =
//                                                      value!.conId;
//
//                                                  if (widget.businessArea ==
//                                                      yarn) {
//                                                    _createRequestModel!
//                                                            .ys_origin_idfk =
//                                                        value.conId.toString();
//                                                  } else {
//                                                    _createRequestModel!
//                                                            .ys_origin_idfk =
//                                                        value.conId.toString();
//                                                  }
//                                                },
//
//                                                // value: widget.syncFiberResponse.data.fiber.brands.first,
//                                                decoration: InputDecoration(
//                                                  label: Row(
//                                                    mainAxisSize:
//                                                        MainAxisSize.min,
//                                                    mainAxisAlignment:
//                                                        MainAxisAlignment.start,
//                                                    children: [
//                                                      Text(
//                                                        country,
//                                                        style: TextStyle(
//                                                            color:
//                                                                Colors.black87,
//                                                            fontSize: 14.sp,
//                                                            backgroundColor:
//                                                                Colors.white,
//                                                            /*fontFamily: 'Metropolis',*/
//                                                            fontWeight:
//                                                                FontWeight
//                                                                    .w500),
//                                                      ),
//                                                      Text("*",
//                                                          style: TextStyle(
//                                                              color: Colors.red,
//                                                              fontSize: 16.sp,
//                                                              /*fontFamily: 'Metropolis',*/
//                                                              backgroundColor:
//                                                                  Colors.white,
//                                                              fontWeight:
//                                                                  FontWeight
//                                                                      .w500)),
//                                                    ],
//                                                  ),
//                                                  floatingLabelBehavior:
//                                                      FloatingLabelBehavior
//                                                          .always,
////                                                      hintText: hintLabel,
////                                                      hintStyle: TextStyle(fontSize: 10.sp,fontWeight: FontWeight.w500,color:hintColorGrey),
//
//                                                  contentPadding:
//                                                      EdgeInsets.only(
//                                                          left: 16.w,
//                                                          right: 6.w,
//                                                          top: 0,
//                                                          bottom: 0),
//                                                  border:
//                                                      const OutlineInputBorder(
//                                                          borderSide:
//                                                              BorderSide.none),
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
//                                                  EdgeInsets.only(left: 8.w),
//                                              child: TitleSmallTextWidget(
//                                                  title: port)),
                                          SizedBox(
                                            height: 12.w,
                                          ),
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
                                                          .spc_port_idfk =
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
                                                            /*fontFamily: 'Metropolis',*/
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                      Text("*",
                                                          style: TextStyle(
                                                              color: Colors.red,
                                                              fontSize: 16.sp,
                                                              /*fontFamily: 'Metropolis',*/
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
//                                          padding: EdgeInsets.only(left: 8.w),
//                                          child: TitleSmallTextWidget(
//                                              title: cityState)),
                                      SizedBox(
                                        height: 12.w,
                                      ),
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
                                                      .spc_city_state_idfk =
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
                                                        /*fontFamily: 'Metropolis',*/
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  Text("*",
                                                      style: TextStyle(
                                                          color: Colors.red,
                                                          fontSize: 16.sp,
                                                          /*fontFamily: 'Metropolis',*/
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
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
//                                Padding(
//                                    padding:
//                                        EdgeInsets.only(top: 8.w, left: 8.w),
//                                    child: TitleSmallTextWidget(
//                                        title: priceTerms)),
                                  SizedBox(
                                    height: 12.w,
                                  ),
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
                                        hint: const Text('Select Price Terms'),
                                        items: _priceTermList
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
                                              // _showPaymentType = true;
                                            } else {
                                              // _showPaymentType = false;
                                              // _showLcType = false;
                                              _createRequestModel!
                                                  .payment_type_idfk = null;
                                              _createRequestModel!
                                                  .lc_type_idfk = null;
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
                                                    /*fontFamily: 'Metropolis',*/
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              Text("*",
                                                  style: TextStyle(
                                                      backgroundColor:
                                                          Colors.white,
                                                      color: Colors.red,
                                                      fontSize: 16.sp,
                                                      /*fontFamily: 'Metropolis',*/
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
                            ),

                            //Payment Type
                            Visibility(
                                visible: widget.locality == international,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 0.w, top: 4, bottom: 4),
                                        child: TitleSmallBoldTextWidget(
                                            title: paymentType)),
                                    SingleSelectTileWidget(
                                        spanCount: 3,
                                        selectedIndex: -1,
                                        listOfItems: _paymentTypeList,
                                        callback: (PaymentType value) {
                                          _createRequestModel!
                                              .payment_type_idfk = value.payId;

                                          // setState(() {
                                          //   if (value.payId == "1") {
                                          //     _showLcType = true;
                                          //   } else {
                                          //     _showLcType = false;
                                          //     _createRequestModel!
                                          //         .lc_type_idfk = null;
                                          //   }
                                          // });
                                        }),
                                  ],
                                )),

                            //Lc Type
                            /*Visibility(
                              visible: _showLcType ?? false,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                      padding: EdgeInsets.only(
                                          left: 0.w, top: 4, bottom: 4),
                                      child: TitleSmallBoldTextWidget(
                                          title: lcType)),
                                  SingleSelectTileWidget(
                                      spanCount: 3,
                                      selectedIndex: -1,
                                      listOfItems: _lcTypeList,
                                      callback: (LcType value) {
                                        if (_createRequestModel != null) {
                                          _createRequestModel!.lc_type_idfk =
                                              value.lcId.toString();
                                        }
                                      }),
                                ],
                              ),
                            ),*/

                            //Price Unit
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
//                                    Padding(
//                                        padding: EdgeInsets.only(
//                                            top: 8.w, left: 8.w),
//                                        child: TitleSmallTextWidget(
//                                            title: priceUnits)),
                                  SizedBox(height: 12.w),
                                  TextFormField(
                                      keyboardType: TextInputType.number,
                                      cursorColor: lightBlueTabs,
                                      style: TextStyle(fontSize: 11.sp),
                                      textAlign: TextAlign.center,
                                      cursorHeight: 16.w,
                                      maxLines: 1,
                                      maxLength: 6,
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
                                ],
                              ),
                            ),
                            // Delivery Period
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
                                    element.dprCategoryIdfk ==
                                        _createRequestModel!
                                            .spc_category_idfk)
                                        .toList(),
                                    callback: (DeliveryPeriod value) {
                                      if (_createRequestModel != null) {
                                        _createRequestModel!
                                            .fbp_delivery_period_idfk =
                                            value.dprId.toString();
                                        if (value.dprId == 3 ||
                                            value.dprId == 9) {
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
                            // No of days
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
                                        if(value == 'Other'){
                                          setState(() {
                                            noOfDaysTF = true;
                                          });
                                        }else{
                                          setState(() {
                                            noOfDaysTF = false;

                                          });

                                          _createRequestModel!.spc_no_of_days =
                                              value!.toString();
                                        }

                                      }),
                                ],
                              ),
                            ),
                            Visibility(
                              visible: noOfDaysTF??false,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 8.h,),
//                                  Padding(
//                                      padding:
//                                          EdgeInsets.only(top: 8.w, left: 8.w,bottom: 4),
//                                      child: const TitleSmallTextWidget(
//                                          title: "No of Days")),
                                  TextFormField(
                                      keyboardType: TextInputType.number,
                                      cursorColor: lightBlueTabs,
                                      style: TextStyle(fontSize: 11.sp),
                                      textAlign: TextAlign.center,
                                      cursorHeight: 16.w,
                                      maxLines: 1,
                                      maxLength: 6,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                            RegExp("[0-9]")),
                                      ],
                                      onSaved: (input) {
                                        if (_createRequestModel != null) {
                                          _createRequestModel!.spc_no_of_days= input!;
                                        }
                                      },
                                      validator: (input) {
                                        if (input == null ||
                                            input.isEmpty ||
                                            int.parse(input) < 1) {
                                          return "No of days";
                                        }
                                        return null;
                                      },
                                      onChanged: (String value) {
                                        if (_createRequestModel != null) {
                                          _createRequestModel!.spc_no_of_days= value;
                                        }
                                      },
                                      decoration: ygTextFieldDecoration(
                                          "No of days", "No of days", true)),
                                ],
                              ),
                            ),
                            // Available Quantity
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 12.w,
                                  ),
//                                      Padding(
//                                          padding: EdgeInsets.only(
//                                              top: 8.w, left: 8.w),
//                                          child: const TitleSmallTextWidget(
//                                              title: "Available Quantity")),
                                  TextFormField(
                                      controller:
                                      availableQuantityController,
                                      keyboardType: TextInputType.number,
                                      cursorColor: lightBlueTabs,
                                      style: TextStyle(fontSize: 11.sp),
                                      textAlign: TextAlign.center,
                                      cursorHeight: 16.w,
                                      maxLines: 1,
                                      maxLength: 6,
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
                                          "Available Qunatity",
                                          true)),
                                ],
                              ),
                            ),

                            //Minimum Quantity
                            Visibility(
                              visible: true,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
//                                  Padding(
//                                      padding:
//                                          EdgeInsets.only(top: 8.w, left: 8.w),
//                                      child: TitleSmallTextWidget(title: minQty)),
                                    SizedBox(height: 12.w),
                                    TextFormField(
                                        controller: minimumQuantityController,
                                        keyboardType: TextInputType.number,
                                        cursorColor: lightBlueTabs,
                                        style: TextStyle(fontSize: 11.sp),
                                        textAlign: TextAlign.center,
                                        cursorHeight: 16.w,
                                        maxLines: 1,
                                        maxLength: 6,
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
                                  ],
                                ),
                              ),
                            ),

                            //Required Quantity
                            Visibility(
                              visible: false,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
//                                  Padding(
//                                      padding:
//                                      EdgeInsets.only(top: 8.w, left: 8.w),
//                                      child: const TitleSmallTextWidget(title: "Required Quantity")),
//
                                    SizedBox(height: 12.w),
                                    TextFormField(
                                        keyboardType: TextInputType.number,
                                        cursorColor: lightBlueTabs,
                                        style: TextStyle(fontSize: 11.sp),
                                        textAlign: TextAlign.center,
                                        cursorHeight: 16.w,
                                        maxLines: 1,
                                        maxLength: 6,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(
                                              RegExp("[0-9]")),
                                        ],
                                        onSaved: (input) {
                                          if (_createRequestModel != null) {
                                            _createRequestModel!
                                                .fbp_required_quantity = input!;
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
                                        decoration: ygTextFieldDecoration(
                                            "Required Quantity",
                                            "Required Quantity",
                                            true)),
                                  ],
                                ),
                              ),
                            ),

                            ///REMOVED PACKING
                            //Packing
                            // Visibility(
                            //   visible:
                            //       widget.businessArea != yarn ? true : false,
                            //   child: Column(
                            //     crossAxisAlignment: CrossAxisAlignment.start,
                            //     children: [
                            //       Padding(
                            //           padding: EdgeInsets.only(
                            //               left: 0.w, top: 8, bottom: 4),
                            //           child: TitleSmallBoldTextWidget(
                            //               title: packing)),
                            //       SingleSelectTileWidget(
                            //           selectedIndex: -1,
                            //           spanCount: 3,
                            //           listOfItems: _packingList
                            //               .where((element) =>
                            //                   element.pacCategoryId ==
                            //                   _createRequestModel!
                            //                       .spc_category_idfk
                            //                       .toString())
                            //               .toList(),
                            //           callback: (Packing value) {
                            //             if (_createRequestModel != null) {
                            //               _createRequestModel!.packing_idfk =
                            //                   value.pacId.toString();
                            //             }
                            //           }),
                            //     ],
                            //   ),
                            // ),

                            //Delivery Period

                            //No of Days


                            Padding(
                              padding: const EdgeInsets.only(top: 18.0),
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
                              visible:
                                  /*widget.businessArea != yarn ? true : false*/true,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 4),
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
                                ),
                              ),
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

  void submitData(BuildContext context) async {
    if (_createRequestModel != null) {
      if (widget.businessArea == yarn) {
        _createRequestModel!.ys_local_international =
            widget.locality!.toUpperCase();

        if (widget.locality != international) {
          var dbInstance = await AppDbInstance().getDbInstance();
          User? user = await dbInstance.userDao.getUser();
          _createRequestModel!.ys_origin_idfk = user!.countryId;
        }
      } else {
        _createRequestModel!.spc_local_international =
            widget.locality!.toUpperCase();

        if (widget.locality != international) {
          var dbInstance = await AppDbInstance().getDbInstance();
          User? user = await dbInstance.userDao.getUser();
          _createRequestModel!.spc_origin_idfk = user!.countryId;
        }
      }
      _createRequestModel!.is_offering = widget.selectedTab;

      ProgressDialogUtil.showDialog(context, 'Please wait...');

      ApiService.createSpecification(_createRequestModel!,
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
            if (_createRequestModel!.spc_category_idfk == "1") {
              _fiberPostProvider.createRequestModel = null;
              _fiberSpecificationProvider.getUpdatedFiberSpecificationsData();
            } else if (_createRequestModel!.spc_category_idfk == "2") {
              _yarnPostProvider.createRequestModel = null;
              _yarnSpecificationProvider.getUpdatedYarnSpecificationsData();
            }
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
    // if (widget.locality == international) {
    //   _createRequestModel!.lc_type_idfk = _lcTypeList.first.lcId.toString();
    // }
    // _createRequestModel!.fbp_price_terms_idfk =
    //     widget.priceTerms!.first.ptrId.toString();
    // _createRequestModel!.fbp_count_unit_idfk = _unitsList
    //     .where((element) =>
    //         element.untCategoryIdfk == _createRequestModel!.spc_category_idfk)
    //     .toList()
    //     .first
    //     .untId
    //     .toString();
    // unitCountSelected ??= _unitsList
    //     .where((element) =>
    //         element.untCategoryIdfk == _createRequestModel!.spc_category_idfk)
    //     .toList()
    //     .first
    //     .untName;
    // _createRequestModel!.packing_idfk = _packingList.first.pacId.toString();
    // _createRequestModel!.fbp_delivery_period_idfk =
    //     _deliverPeriodList.first.dprId.toString();
  }

  bool validateAndSave() {
    final form = globalFormKey.currentState;

    if (_createRequestModel!.cone_type_id == null &&
        widget.businessArea == yarn) {
      Ui.showSnackBar(context, "Please select Packing");
      return false;
    }

    if (_createRequestModel!.fbp_price_terms_idfk == null) {
      Ui.showSnackBar(context, "Please select price terms");
      return false;
    }

    if (_createRequestModel!.fbp_delivery_period_idfk == null) {
      Ui.showSnackBar(context, "Please select delivery period");
      return false;
    }

    if (_createRequestModel!.spc_no_of_days == null && noOfDays && !noOfDaysTF!) {
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
  }

  bool checkFamilyId(String familyId) {
    if (_createRequestModel!.spc_category_idfk == '1') {
      return familyId == _createRequestModel!.spc_fiber_family_idfk;
    } else {
      return familyId == _createRequestModel!.ys_family_idfk;
    }
  }
}
