import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:stylish_dialog/stylish_dialog.dart';
import 'package:yg_app/elements/custom_header.dart';
import 'package:yg_app/elements/elevated_button_widget_2.dart';
import 'package:yg_app/elements/list_widgets/single_select_tile_widget.dart';
import 'package:yg_app/elements/title_text_widget.dart';
import 'package:yg_app/helper_utils/dialog_builder.dart';
import 'package:yg_app/helper_utils/app_colors.dart';
import 'package:yg_app/model/response/common_response_models/countries_response.dart';
import 'package:yg_app/model/response/stocklot_repose/stocklot_sync/stocklot_sync_response.dart';
import 'package:yg_app/model/stocklot_waste_model.dart';
import 'package:yg_app/pages/post_ad_pages/stocklot_page/component/stocklot_specification_body.dart';
import 'package:yg_app/providers/stocklot_providers/stocklot_provider.dart';
import '../../../elements/add_picture_widget.dart';
import '../../../elements/decoration_widgets.dart';
import '../../../elements/list_items/list__item_stocklot_widget.dart';
import '../../../helper_utils/app_constants.dart';
import '../../../helper_utils/top_round_corners.dart';
import '../../../helper_utils/ui_utils.dart';
import '../../../helper_utils/util.dart';
import '../../../model/response/common_response_models/ports_response.dart';
import '../../../model/response/common_response_models/price_term.dart';
import '../../../model/response/common_response_models/unit_of_count.dart';

class CreateStockLotPage extends StatefulWidget {
  final String? locality;
  final String? businessArea;
  final String? selectedTab;

  const CreateStockLotPage(
      {Key? key, required this.locality, this.businessArea, this.selectedTab})
      : super(key: key);

  @override
  _CreateStockLotPageState createState() => _CreateStockLotPageState();
}

class _CreateStockLotPageState extends State<CreateStockLotPage> {
  // CreateRequestModel? _createRequestModel;

  final GlobalKey<StockLotSpecificationBodyState> stockLotSpecificationKey =
      GlobalKey<StockLotSpecificationBodyState>();
  StockLotFamily? stocklotCategories;

  // Countries? countryModel;
  final GlobalKey<FormState> _globalFormKey = GlobalKey<FormState>();

  late StocklotProvider stocklotProvider;
  final GlobalKey<SingleSelectTileWidgetState> categoryKey =
  GlobalKey<SingleSelectTileWidgetState>();
  final GlobalKey<SingleSelectTileWidgetState> subCategoryKey =
  GlobalKey<SingleSelectTileWidgetState>();

  String? subCategoryName;

  var familyID="0";

  int? selectedCountryId;

  @override
  void initState() {
    super.initState();
    stocklotProvider = Provider.of<StocklotProvider>(context, listen: false);
    stocklotProvider.resetValues();
    stocklotProvider.getStocklotData();
    selectedCountryId = -1;
    //stocklotProvider.stocklotRequestModel.isOffering=widget.selectedTab;
  }

  @override
  Widget build(BuildContext context) {
    return buildStocklotPage();
  }

  Widget buildStocklotPage() {
    return Builder(builder: (BuildContext buildContext) {
      stocklotProvider = Provider.of<StocklotProvider>(buildContext);
      return stocklotProvider.stocklots!.isNotEmpty
          ? SafeArea(
              child: Scaffold(
                  appBar: appBar(context, "Stocklot"),
                  body: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  Expanded  (
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Form(
                        key: _globalFormKey,
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.only(
                                left: 8.w,
                                right: 8.w,
                                top: 16.w,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  const TitleMediumTextWidget(
                                      title: "Stocklot"),
                                  SizedBox(
                                    height: 8.h,
                                  ),
                                  IgnorePointer(
                                    ignoring: stocklotProvider.ignoreClick,
                                    child: SingleSelectTileWidget(
                                      key: stocklotProvider.stocklotKey,
                                      spanCount: 3,
                                      listOfItems: /* ['Waste', 'Left Over', 'Rejection']*/ stocklotProvider
                                          .stocklots!,
                                      selectedIndex: -1,
                                      callback: (StockLotFamily value) {
                                        if (stocklotProvider
                                            .stocklotWasteList!.isEmpty) {

                                          familyID=value.stocklotFamilyId.toString();
                                          stocklotProvider.getCategories(
                                              value.stocklotFamilyId.toString());
                                          stocklotProvider.setShowCategory(true);
                                          stocklotProvider.setShowSubCategory(false);
                                          if(categoryKey.currentState!=null) categoryKey.currentState!.checkedTile = -1;
                                          stocklotProvider.stocklotRequestModel.subcategoryId = null;
                                          stocklotCategories = null;
                                        }
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Visibility(
                              visible: stocklotProvider.showCategory,
                              child: Container(
                                padding: EdgeInsets.only(
                                  left: 8.w,
                                  right: 8.w,
                                  top: 10.w,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    const TitleMediumTextWidget(
                                        title: "Category"),
                                    SizedBox(
                                      height: 8.h,
                                    ),
                                    IgnorePointer(
                                      ignoring: stocklotProvider.ignoreClick,
                                      child: SingleSelectTileWidget(
                                        key: categoryKey,
                                        spanCount: 3,
                                        listOfItems:
                                            stocklotProvider.stocklotCategories!,
                                        selectedIndex: -1,
                                        callback: (StockLotFamily value) {
                                          stocklotProvider.setShowSubCategory(true);
                                          stocklotProvider.stocklotRequestModel
                                                  .subcategoryId =
                                              value.stocklotFamilyId.toString();

                                          if (stocklotProvider
                                              .stocklotWasteList!.isEmpty) {
                                            stocklotProvider.getSubcategories(
                                                value.stocklotFamilyId.toString());
                                          }
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Visibility(
                              visible: stocklotProvider.showSubCategory,
                              child: Container(
                                padding: EdgeInsets.only(
                                    left: 8.w,
                                    right: 8.w,
                                    top: 10.w,
                                    bottom: 8.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    const TitleMediumTextWidget(
                                        title: "Sub Categories"),
                                    SizedBox(
                                      height: 8.h,
                                    ),
                                    SingleSelectTileWidget(
                                      spanCount: 3,
                                      listOfItems:
                                          stocklotProvider.stocklotSubcategories!,
                                      selectedIndex: -1,
                                      callback: (StockLotFamily value) {
                                        print("FamilyLot"+value.stocklotFamilyId.toString());
                                        stocklotCategories = value;
                                        stocklotProvider.getFilteredStocklotWaste(
                                            value.stocklotFamilyId ?? -1);
                                        var list = stocklotProvider
                                            .stocklotWasteList!
                                            .where((element) =>
                                                element.id == value.stocklotFamilyId.toString())
                                            .toList();
                                        var editWasteModel =
                                            list.isNotEmpty ? list.first : null;
                                        showStocklotBottomSheet(value,
                                            stocklotProvider, editWasteModel);
                                      },
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Visibility(
                              visible: stocklotProvider
                                  .filteredStocklotWasteList!.isNotEmpty,
                              maintainSize: false,
                              maintainState: false,
                              child: Container(
                                margin: EdgeInsets.only(left: 8.w, right: 8.w,top: 8),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black12),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(6))),
                                child: Container(
                                    color: newColorGrey.withOpacity(0.3),
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Padding(
                                            padding: EdgeInsets.only(
                                                top: 10.w,
                                                left: 8.w,
                                                bottom: 10.w),
                                            child: const TitleMediumTextWidget(
                                              title: 'Stocklot Waste',
                                            )),
                                        GestureDetector(
                                          onTap: () {
                                            stocklotProvider
                                                .changeExpandStockLostWast();
                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(
                                                top: 4, right: 6, bottom: 4),
                                            decoration: BoxDecoration(
                                              color: Colors.blueAccent.shade700
                                                  .withOpacity(0.1),
                                              shape: BoxShape.circle,
                                            ),
                                            child: Icon(
                                              stocklotProvider
                                                      .expandStockLostWast
                                                  ? Icons
                                                      .keyboard_arrow_up_outlined
                                                  : Icons
                                                      .keyboard_arrow_down_outlined,
                                              size: 24,
                                              color: darkBlueChip,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Visibility(
                                      visible:
                                          stocklotProvider.expandStockLostWast,
                                      child: Column(
                                        children: [
                                          Divider(),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 4, right: 4, bottom: 8),
                                            child: ListView.separated(
                                              itemCount: stocklotProvider
                                                  .filteredStocklotWasteList!
                                                  .length,
                                              shrinkWrap: true,
                                              physics: NeverScrollableScrollPhysics(),
                                              separatorBuilder:
                                                  (BuildContext context,
                                                          int index) =>
                                                      const Divider(),
                                              itemBuilder: (context, index) {
                                                return ListItemStockLot(
                                                    stocklotWaste: stocklotProvider
                                                            .filteredStocklotWasteList![
                                                        index],
                                                    addMore: index ==
                                                        stocklotProvider
                                                                .filteredStocklotWasteList!
                                                                .length -
                                                            1,
                                                    callback: (value,index) {
                                                      if(index == 2){
                                                        stocklotProvider
                                                            .removeStockWaste(
                                                            value);
                                                      }else if(index == 1){
                                                        if(stocklotCategories == null){
                                                          toast('Something went wrong. Please try again later');
                                                        }else{
                                                          showStocklotBottomSheet(stocklotCategories!,
                                                              stocklotProvider, value);
                                                        }
                                                      }
                                                    },
                                                    i: index + 1);
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                )),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
//                                Padding(
//                                    padding: EdgeInsets.only(
//                                        top: 12.w, left: 8.w, bottom: 6.w),
//                                    child: TitleMediumTextWidget(
//                                      title: priceTerms,
//                                    )),
                                Padding(
                                  padding: EdgeInsets.only(
                                    top:18.w,
                                    left: 8.w,
                                    right: 8.w,
                                  ),
                                  child: SizedBox(
                                    height: 36.w,
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
                                        items: stocklotProvider.priceTermsList
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
                                          stocklotProvider.stocklotRequestModel
                                                  .priceTermsId =
                                              value!.ptrId.toString();
                                        },
                                        // validator: (value) => value == null
                                        //     ? 'field required'
                                        //     : null,
                                        // value: widget.syncFiberResponse.data.fiber.brands.first,
                                        decoration: InputDecoration(
                                          label: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Text(priceTerms,style:TextStyle(
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
                              padding: EdgeInsets.only(
                                top:18.w,
                                left: 8.w,
                                right: 8.w,
                              ),
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
                                            height: 36.w,
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
                                                items: stocklotProvider.countryList!
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
                                                  stocklotProvider.stocklotRequestModel.countryId=
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
                                  SizedBox(width: 4.w),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        top:18.w,
                                        left: 8.w,
                                        right: 8.w,
                                      ),
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
                                            height: 36.w,
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
                                                items: stocklotProvider.portsList!
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
                                                 stocklotProvider.stocklotRequestModel
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
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
//                                Padding(
//                                    padding: EdgeInsets.only(
//                                        top: 8.w, left: 8.w, bottom: 6.w),
//                                    child: const TitleMediumTextWidget(
//                                      title: 'Currency',
//                                    )),
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: 8.w,
                                    top:18.w,
                                    right: 8.w,
                                  ),
                                  child: SizedBox(
                                    height: 36.w,
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
                                        hint: const Text('Select Currency'),
                                        items: stocklotProvider.countryList!
                                            .map((Countries value) => DropdownMenuItem(
                                                  child: Text(value.countryCurrencyCode.toString()+"("+value.countryCurrencySymbol.toString()+")",
                                                      textAlign:
                                                          TextAlign.center),
                                                  value: value,
                                                ))
                                            .toList(),
                                        isExpanded: true,
                                        onChanged: (Countries? value) {
                                          if (value != null) {
                                            stocklotProvider
                                                    .stocklotRequestModel
                                                    .countryId =
                                                value.conId.toString();
                                            stocklotProvider
                                                    .stocklotRequestModel
                                                    .currency =
                                                value.countryCurrencySymbol.toString();
                                          }
                                        },
                                        // validator: (value) => value == null
                                        //     ? 'field required'
                                        //     : null,
                                        // value: widget.syncFiberResponse.data.fiber.brands.first,
                                        decoration:InputDecoration(
                                          label: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Text("Currency",style:TextStyle(
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
                            /*Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
//                                Padding(
//                                    padding: EdgeInsets.only(
//                                        top: 8.w, left: 8.w, bottom: 6.w),
//                                    child: const TitleMediumTextWidget(
//                                      title: 'Availability',
//                                    )),
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: 8.w,
                                    top:18.w,
                                    right: 8.w,
                                  ),
                                  child: SizedBox(
                                    height: 36.w,
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
                                        hint: const Text('Select Availability'),
                                        items: stocklotProvider
                                            .availabilityList!
                                            .map((value) => DropdownMenuItem(
                                                  child: Text(
                                                      *//*value.conCurrency*//*
                                                      value.toString(),
                                                      textAlign:
                                                          TextAlign.center),
                                                  value: value,
                                                ))
                                            .toList(),
                                        isExpanded: true,
                                        onChanged: (*//*Countries?*//*
                                            AvailabilityModel? value) {
                                          stocklotProvider.stocklotRequestModel
                                                  .availability =
                                              value!.afm_id.toString();
                                        },
                                        // validator: (value) => value == null
                                        //     ? 'field required'
                                        //     : null,
                                        // value: widget.syncFiberResponse.data.fiber.brands.first,
                                        decoration: InputDecoration(
                                          label: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Text("Select Availability",style:TextStyle(
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
                            ),*/
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Column(children: [
//                                Align(
//                                  alignment: Alignment.topLeft,
//                                  child: Padding(
//                                      padding: EdgeInsets.only(
//                                          top: 8.w, left: 8.w, bottom: 6),
//                                      child: TitleSmallNormalTextWidget(
//                                        title: descriptionStr,
//                                        size: 12,
//                                      )),
//                                ),
                                Padding(
                                  padding:  EdgeInsets.only(top:18.w,bottom: 6),
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
                                          stocklotProvider.stocklotRequestModel.description = input;
                                        },
                                        onChanged: (input) {
                                          stocklotProvider.stocklotRequestModel.description = input;
                                        },
                                        decoration:
                                        ygTextFieldDecoration(descriptionStr,descriptionStr,true)),
                                  ),
                                ),
                              ],),
                            ),
                            Visibility(
                              visible: true,
                              child: Padding(
                                padding: EdgeInsets.only(
                                  left: 8.w,
                                  right: 8.w,
                                  top: 0.w,
                                ),
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: TitleSmallBoldTextWidget(
                                          title: attachment),
                                    ),
                                    const SizedBox(height: 4,),
                                    AddPictureWidget(
                                      imageCount: 1,
                                      callbackImages: (value) {
                                        stocklotProvider.imageFiles = value;
                                      },
                                    ),
                                  ],
                                )
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Center(
                      child: ElevatedButtonWithoutIcon(
                        btnText: "Submit",
                        textSize: 12.sp,
                        color: Colors.green,
                        callback: () {
                          if (validateAndSave()) {
                            showGenericDialog(
                              '',
                              "Are you sure, you want to submit?",
                              context,
                              StylishDialogType.WARNING,
                              'Yes',
                              () {
                                stocklotProvider.stocklotRequestModel
                                    .spc_category_idfk = "5";
                                stocklotProvider.stocklotRequestModel
                                    .isOffering = widget.selectedTab;
                                stocklotProvider.stocklotRequestModel.locality =
                                    widget.locality;
                                stocklotProvider.stocklotRequestModel
                                        .stocklotWasteModelList =
                                    stocklotProvider.stocklotWasteList;
                                stocklotProvider.createStockLot(context,(){
                                  Navigator.of(context).pop();
                                });
                              },
                            );
                          }
                        },
                      ),
                    ),
                  )
                ],
              ),
            )))
          : Container(
              color: Colors.white,
              height: 100,
            );
    });
  }

  void showStocklotBottomSheet(StockLotFamily value,
      StocklotProvider stocklotProvider, StocklotWasteModel? editWasteModel) {
    /*stocklotProvider.getFilteredStocklotWaste(value.id??-1);*/
    /*var list = stocklotProvider.stocklotWasteList!.where((element) => element.id == value.id.toString()).toList();
    if(list.isNotEmpty){
      return;
    }*/

    print("Family ID"+familyID.toString());
    String? unitName;
    var stocklotWaste = StocklotWasteModel(
        unitOfCount: editWasteModel != null
            ? editWasteModel.unitOfCount
            : stocklotProvider.unitsList!.where((element) =>
        element.untCategoryIdfk ==
            "5").toList()[0].untId.toString(),
        name: editWasteModel != null ? editWasteModel.name : value.stocklotFamilyName,
        price: editWasteModel != null ? editWasteModel.price : '',
        quantity: editWasteModel != null ? editWasteModel.quantity : '',
        // description: editWasteModel != null ? editWasteModel.description : '',
        id: editWasteModel != null ? editWasteModel.id : value.stocklotFamilyId.toString());
    unitName =  editWasteModel != null
        ? stocklotProvider.unitsList!.where((element) =>
    element.untCategoryIdfk ==
        "5").toList().where((element) => element.untId.toString() == editWasteModel.unitOfCount).toList().first.untName
        : stocklotProvider.unitsList!.where((element) =>
    element.untCategoryIdfk ==
        "5").toList().first.untName;
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        isDismissible: false,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState /*You can rename this!*/) {
                return Padding(
                  padding: MediaQuery.of(context).viewInsets,
                  child: StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) {
                        return Container(
                          decoration: getRoundedTopCorners(),
                          height: 0.4 * MediaQuery.of(context).size.height,
                          child: Padding(
                            padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 8.w),
                            child: Scaffold(
                              resizeToAvoidBottomInset: false,
                              body: Container(
                                color: Colors.white,
                                child: Stack(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: SingleChildScrollView(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Center(
                                                    child: Text(
                                                      value.stocklotFamilyName??"",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 16.sp,
                                                          fontWeight: FontWeight.w600),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 10.h,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                          padding: EdgeInsets.only(
                                                              top: 8.w, left: 8.w),
                                                          child: TitleSmallBoldTextWidget(
                                                            title: unitCounting,
                                                            size: 12,
                                                          )),
                                                      const SizedBox(
                                                        height: 8,
                                                      ),
                                                      SingleSelectTileWidget(
                                                          spanCount: 3,
                                                          selectedIndex: editWasteModel !=
                                                              null
                                                              ? stocklotProvider.unitsList!.where((element) =>
                                                          element.untCategoryIdfk ==
                                                              "5").toList()
                                                              .indexWhere((element) =>
                                                          element.untId.toString() ==
                                                              editWasteModel
                                                                  .unitOfCount)
                                                              : 0,
                                                          listOfItems: stocklotProvider
                                                              .unitsList!
                                                              .where((element) =>
                                                          element.untCategoryIdfk ==
                                                              "5").where((element) => element.unt_family_idfk==familyID.toString())
                                                              .toList(),
                                                          callback: (Units value) {
                                                            stocklotProvider.setUnitName(value.untName.toString());
                                                            stocklotWaste.unitOfCount =
                                                                value.untId.toString();

                                                            setState((){
                                                              unitName = value.untName.toString();
                                                            });
                                                          }),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 8,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                          child: Column(
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment.start,
                                                            children: [
                                                              Padding(
                                                                  padding: EdgeInsets.only(
                                                                      top: 8.w,
                                                                      left: 8.w,
                                                                      bottom: 6.w),
                                                                  child:
                                                                  TitleSmallBoldTextWidget(
                                                                    title: 'Price ${unitName??""}',
                                                                    size: 12,
                                                                  )),
                                                              TextFormField(
                                                                  keyboardType:
                                                                  TextInputType.number,
                                                                  cursorColor: lightBlueTabs,
                                                                  style:
                                                                  TextStyle(fontSize: 11.sp),
                                                                  textAlign: TextAlign.center,
                                                                  cursorHeight: 16.w,
                                                                  maxLines: 1,
                                                                  inputFormatters: [
                                                                    FilteringTextInputFormatter
                                                                        .allow(RegExp("[0-9]")),
                                                                  ],
                                                                  initialValue:
                                                                  editWasteModel != null
                                                                      ? editWasteModel.price
                                                                      : '',
                                                                  onSaved: (input) {
                                                                    stocklotWaste.price = input;
                                                                  },
                                                                  onChanged: (input) {
                                                                    stocklotWaste.price = input;
                                                                  },
                                                                  validator: (input) {
                                                                    if (input == null ||
                                                                        input.isEmpty ||
                                                                        int.parse(input) < 1) {
                                                                      return priceUnits;
                                                                    }
                                                                    return null;
                                                                  },
                                                                  decoration:
                                                                  roundedTextFieldDecoration(
                                                                      'Price')),
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
                                                            Padding(
                                                                padding: EdgeInsets.only(
                                                                    top: 8.w,
                                                                    left: 8.w,
                                                                    bottom: 6.w),
                                                                child:
                                                                const TitleSmallBoldTextWidget(
                                                                  title: "Available Qty",
                                                                  size: 12,
                                                                )),
                                                            TextFormField(
                                                                keyboardType:
                                                                TextInputType.number,
                                                                cursorColor: lightBlueTabs,
                                                                style: TextStyle(
                                                                    fontSize: 11.sp),
                                                                textAlign: TextAlign.center,
                                                                cursorHeight: 16.w,
                                                                maxLines: 1,
                                                                inputFormatters: [
                                                                  FilteringTextInputFormatter
                                                                      .allow(RegExp("[0-9]")),
                                                                ],
                                                                initialValue:
                                                                editWasteModel != null
                                                                    ? editWasteModel
                                                                    .quantity
                                                                    : '',
                                                                onSaved: (input) {
                                                                  stocklotWaste.quantity =
                                                                      input;
                                                                },
                                                                onChanged: (input) {
                                                                  stocklotWaste.quantity =
                                                                      input;
                                                                },
                                                                validator: (input) {
                                                                  if (input == null ||
                                                                      input.isEmpty ||
                                                                      int.parse(input) < 1) {
                                                                    return "Available Qty";
                                                                  }
                                                                  return null;
                                                                },
                                                                decoration:
                                                                roundedTextFieldDecoration(
                                                                    "Available Qty")),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),

                                                ],
                                              ),
                                            ),
                                            flex: 7,
                                          ),
                                          ElevatedButtonWithoutIcon(
                                              callback: () {
                                                if (stocklotWaste.unitOfCount!.isEmpty) {
                                                  Fluttertoast.showToast(
                                                      msg: "Please select unit of count");
                                                } else if (stocklotWaste.price!.isEmpty) {
                                                  Fluttertoast.showToast(
                                                      msg: "Please enter price");
                                                } else if (stocklotWaste
                                                    .quantity!.isEmpty) {
                                                  Fluttertoast.showToast(
                                                      msg: "Please enter Available Qty");
                                                } else {
                                                  Navigator.pop(context);
                                                  stocklotProvider
                                                      .addStocklotWaste(stocklotWaste);
                                                  stocklotProvider.disableClick();
                                                }
                                              },
                                              color: btnColorLogin,
                                              btnText: 'Add'),
                                          SizedBox(
                                            height: 4.h,
                                          )
                                        ],
                                      ),
                                    ),
                                    Align(
                                        alignment: Alignment.topRight,
                                        child: GestureDetector(
                                          behavior: HitTestBehavior.opaque,
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Icon(Icons.close),
                                        )),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                );
          });
        });
  }

  bool validateAndSave() {
    final form = _globalFormKey.currentState;
    if (stocklotProvider.stocklotRequestModel.subcategoryId == null) {
      Ui.showSnackBar(context, "Please select category");
      return false;
    }

    if (stocklotProvider.filteredStocklotWasteList!.isEmpty) {
      Ui.showSnackBar(context, "Please select select sub category");
      return false;
    }

    if (stocklotProvider.stocklotRequestModel.priceTermsId == null) {
      Ui.showSnackBar(context, "Please select price terms");
      return false;
    }

    if (widget.locality == international) {
      if (stocklotProvider.stocklotRequestModel.countryId == null) {
        Ui.showSnackBar(context, "Please select country");
        return false;
      }
    }

    if (widget.locality == international) {
      if (stocklotProvider.stocklotRequestModel.fbp_port_idfk == null) {
        Ui.showSnackBar(context, "Please select port");
        return false;
      }
    }

    if (stocklotProvider.stocklotRequestModel.currency == null) {
      Ui.showSnackBar(context, "Please select currency");
      return false;
    }

//    if (stocklotProvider.stocklotRequestModel.availability == null) {
//      Ui.showSnackBar(context, "Please select availability");
//      return false;
//    }

    if(stocklotProvider.stocklotRequestModel.description == null){
      Ui.showSnackBar(context, "Please enter description");
      return false;
    }

//    if (stocklotProvider.imageFiles.isEmpty) {
//      Ui.showSnackBar(context, "Image is required");
//      return false;
//    }

    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
