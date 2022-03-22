import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:yg_app/Providers/stocklot_provider.dart';
import 'package:yg_app/elements/elevated_button_widget.dart';
import 'package:yg_app/elements/elevated_button_widget_2.dart';
import 'package:yg_app/elements/list_widgets/single_select_tile_widget.dart';
import 'package:yg_app/elements/title_text_widget.dart';
import 'package:yg_app/helper_utils/app_colors.dart';
import 'package:yg_app/model/request/post_ad_request/create_request_model.dart';
import 'package:yg_app/model/response/common_response_models/countries_response.dart';
import 'package:yg_app/model/stocklot_waste_model.dart';
import 'package:yg_app/pages/post_ad_pages/stocklot_page/component/stocklot_specification_body.dart';
import 'package:yg_app/pages/post_ad_pages/stocklot_page/component/stocklot_steps_segment.dart';

import '../../../elements/add_picture_widget.dart';
import '../../../elements/decoration_widgets.dart';
import '../../../elements/list_items/list__item_stocklot_widget.dart';
import '../../../helper_utils/app_constants.dart';
import '../../../helper_utils/util.dart';
import '../../../model/response/common_response_models/price_term.dart';
import '../../../model/response/common_response_models/unit_of_count.dart';
import '../../../model/response/sync/sync_response.dart';

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
  CreateRequestModel? _createRequestModel;
  final GlobalKey<StockLotStepsSegmentState> _stockLotStepSegment = GlobalKey();

  final GlobalKey<StockLotSpecificationBodyState> stockLotSpecificationKey =
      GlobalKey<StockLotSpecificationBodyState>();
  StocklotCategories? stocklotCategories;

  @override
  void initState() {
    // TODO: implement initState
    _createRequestModel = CreateRequestModel();
    _createRequestModel!.spc_category_idfk = "1";
    super.initState();
    final stocklotProvider =
        Provider.of<StocklotProvider>(context, listen: false);
    stocklotProvider.getStocklotData();
  }

  @override
  Widget build(BuildContext context) {
    return buildStocklotPage();
  }

  Widget buildStocklotPage() {
    return Builder(builder: (BuildContext buildContext) {
      final stocklotProvider = Provider.of<StocklotProvider>(buildContext);
      return stocklotProvider.stocklots!.isNotEmpty
          ? SafeArea(
              child: Scaffold(
                  body: Provider(
              create: (_) => _createRequestModel,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Container(
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
                                        spanCount: 3,
                                        listOfItems: /* ['Waste', 'Left Over', 'Rejection']*/ stocklotProvider
                                            .stocklots!,
                                        selectedIndex: 0,
                                        callback: (StocklotCategories value) {
                                          if (stocklotProvider
                                              .stocklotWasteList!.isEmpty) {
                                            stocklotProvider.getCategories(value.id.toString());
                                          }
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
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
                                        spanCount: 3,
                                        listOfItems:
                                            stocklotProvider.stocklotCategories!,
                                        selectedIndex: 0,
                                        callback: (StocklotCategories value) {
                                          if (stocklotProvider
                                              .stocklotWasteList!.isEmpty) {
                                            stocklotProvider.getSubcategories(
                                                value.id.toString());
                                          }
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
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
                                        title: "Subcategories"),
                                    SizedBox(
                                      height: 8.h,
                                    ),
                                    SingleSelectTileWidget(
                                      spanCount: 3,
                                      listOfItems:
                                          stocklotProvider.stocklotSubcategories!,
                                      selectedIndex: 0,
                                      callback: (StocklotCategories value) {
                                        stocklotCategories = value;
                                        stocklotProvider.getFilteredStocklotWaste(
                                            value.id ?? -1);
                                        var list = stocklotProvider
                                            .stocklotWasteList!
                                            .where((element) =>
                                                element.id == value.id.toString())
                                            .toList();
                                        if (list.isNotEmpty) {
                                          return;
                                        }
                                        showStocklotBottomSheet(
                                            value, stocklotProvider);
                                      },
                                    )
                                  ],
                                ),
                              ),
                              Visibility(
                                visible: stocklotProvider
                                    .filteredStocklotWasteList!.isNotEmpty,
                                maintainSize: false,
                                maintainState: false,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.only(
                                            top: 8.w, left: 8.w, bottom: 6.w),
                                        child: const TitleMediumTextWidget(
                                          title: 'Stocklot Waste',
                                        )),
                                    Padding(
                                      padding:
                                          EdgeInsets.only(left: 8.w, right: 8.w),
                                      child: SizedBox(
                                          /*height: 36.w,*/
                                          child: Column(
                                        children: [
                                          SizedBox(
                                            height: 4.h,
                                          ),
                                          Container(
                                            width:
                                                MediaQuery.of(context).size.width,
                                            child: Row(
                                              children: [
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.3,
                                                  child: Text(
                                                    'Description',
                                                    overflow: TextOverflow.fade,
                                                    maxLines: 1,
                                                    softWrap: false,
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 12.sp,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                ),
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.2,
                                                  child: Text(
                                                    'Quantity',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 12.sp,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                ),
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.2,
                                                  child: Text(
                                                    'Unit Count',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 12.sp,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                ),
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.2,
                                                  child: Text(
                                                    'Price',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 12.sp,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                ),
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.05,
                                                  child: const Visibility(
                                                    visible: false,
                                                    child: Icon(
                                                      Icons.add,
                                                      size: 12,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 6.h,
                                          ),
                                          Container(
                                            /*decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: Colors.grey.shade300,
                                                  width:
                                                  1, //                   <--- border width here
                                                ),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(24.w))),*/
                                            child: ListView.separated(
                                              itemCount: stocklotProvider
                                                  .filteredStocklotWasteList!
                                                  .length,
                                              shrinkWrap: true,
                                              separatorBuilder:
                                                  (BuildContext context,
                                                          int index) =>
                                                      const Divider(),
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              itemBuilder: (context, index) {
                                                return GestureDetector(
                                                  onTap: () {},
                                                  child: listItemStocklot(context, stocklotProvider.filteredStocklotWasteList![index],
                                                      index ==
                                                          stocklotProvider
                                                                  .filteredStocklotWasteList!
                                                                  .length -
                                                              1, () {
                                                    /*Logger().e('uytr' +
                                                        stocklotCategories!
                                                            .toJson()
                                                            .toString());*/
                                                    if (stocklotCategories !=
                                                        null) {
                                                      showStocklotBottomSheet(
                                                          stocklotCategories!,
                                                          stocklotProvider);
                                                    }
                                                  }),
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      )),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                      padding: EdgeInsets.only(
                                          top: 12.w, left: 8.w, bottom: 6.w),
                                      child: TitleMediumTextWidget(
                                        title: priceTerms,
                                      )),
                                  Padding(
                                    padding: EdgeInsets.only(
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
                                                Radius.circular(24.w))),
                                        child: DropdownButtonFormField(
                                          hint: const Text('Select Price Terms'),
                                          items: stocklotProvider.priceTermsList!
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
                                          onChanged: (FPriceTerms? value) {},
                                          // validator: (value) => value == null
                                          //     ? 'field required'
                                          //     : null,
                                          // value: widget.syncFiberResponse.data.fiber.brands.first,
                                          decoration: InputDecoration(
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
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                      padding: EdgeInsets.only(
                                          top: 8.w, left: 8.w, bottom: 6.w),
                                      child: const TitleMediumTextWidget(
                                        title: 'Currency',
                                      )),
                                  Padding(
                                    padding: EdgeInsets.only(
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
                                                Radius.circular(24.w))),
                                        child: DropdownButtonFormField(
                                          hint: const Text('Select Currency'),
                                          items: stocklotProvider.countryList!
                                              .map((value) => DropdownMenuItem(
                                                    child: Text(
                                                        value.conCurrency ??
                                                            Utils.checkNullString(
                                                                false),
                                                        textAlign:
                                                            TextAlign.center),
                                                    value: value,
                                                  ))
                                              .toList(),
                                          isExpanded: true,
                                          onChanged: (Countries? value) {},
                                          // validator: (value) => value == null
                                          //     ? 'field required'
                                          //     : null,
                                          // value: widget.syncFiberResponse.data.fiber.brands.first,
                                          decoration: InputDecoration(
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
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                      padding: EdgeInsets.only(
                                          top: 8.w, left: 8.w, bottom: 6.w),
                                      child: const TitleMediumTextWidget(
                                        title: 'Availability',
                                      )),
                                  Padding(
                                    padding: EdgeInsets.only(
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
                                                Radius.circular(24.w))),
                                        child: DropdownButtonFormField(
                                          hint: const Text('Select Availability'),
                                          items: /*stocklotProvider.countryList!*/ [
                                            'Available',
                                            'Not Available'
                                          ]
                                              .map((value) => DropdownMenuItem(
                                                    child: Text(
                                                        /*value.conCurrency*/
                                                        value ??
                                                            Utils.checkNullString(
                                                                false),
                                                        textAlign:
                                                            TextAlign.center),
                                                    value: value,
                                                  ))
                                              .toList(),
                                          isExpanded: true,
                                          onChanged: (/*Countries?*/ value) {},
                                          // validator: (value) => value == null
                                          //     ? 'field required'
                                          //     : null,
                                          // value: widget.syncFiberResponse.data.fiber.brands.first,
                                          decoration: InputDecoration(
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
                              Visibility(
                                visible: true,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    left: 8.w,
                                    right: 8.w,
                                    top: 16.w,
                                  ),
                                  child: AddPictureWidget(
                                    imageCount: 1,
                                    callbackImages: (value) {
                                      // imageFiles = value;
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Center(
                        child: ElevatedButtonWithoutIcon(
                          btnText: "Submit",
                          textSize: 12.sp,
                          color: Colors.green,
                          callback: () {
                            Fluttertoast.showToast(msg: 'Coming soon...');
                          },
                        ),
                      ),
                    )
                    /*Expanded(
                        flex: 7,
                        child: StockLotStepsSegment(
                                          key: _stockLotStepSegment,
                                          businessArea: widget.businessArea,
                                          locality: widget.locality,
                                          selectedTab: widget.selectedTab,
                                          callback: (value) {},
                                        ),
                      ),*/
                  ],
                ),
              ),
            )))
          : Container(
              color: Colors.transparent,
              height: 100,
            );
    });
  }

  void showStocklotBottomSheet(
      StocklotCategories value, StocklotProvider stocklotProvider) {
    /*stocklotProvider.getFilteredStocklotWaste(value.id??-1);*/
    /*var list = stocklotProvider.stocklotWasteList!.where((element) => element.id == value.id.toString()).toList();
    if(list.isNotEmpty){
      return;
    }*/
    var stocklotWaste = StocklotWasteModel(
        unitOfCount: stocklotProvider.unitsList![0].untName,
        id: value.id.toString());
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
              return Container(
                height: 0.53 * MediaQuery.of(context).size.height,
                margin: EdgeInsets.only(left: 16.w, right: 16.w, top: 8.w),
                child: Scaffold(
                  resizeToAvoidBottomInset: false,
                  body: Stack(
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
                                        'Add Waste',
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
                                            child: TitleSmallNormalTextWidget(
                                              title: unitCounting,
                                              size: 12,
                                            )),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        SingleSelectTileWidget(
                                            spanCount: 4,
                                            listOfItems:
                                                stocklotProvider.unitsList!,
                                            callback: (Units value) {
                                              stocklotWaste.unitOfCount =
                                                  value.untName;
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
                                                    const TitleSmallNormalTextWidget(
                                                  title: 'Price',
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
                                                      const TitleSmallNormalTextWidget(
                                                    title: "Quantity",
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
                                                      return "Quantity";
                                                    }
                                                    return null;
                                                  },
                                                  decoration:
                                                      roundedTextFieldDecoration(
                                                          "Quantity")),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Padding(
                                          padding: EdgeInsets.only(
                                              top: 8.w, left: 8.w, bottom: 6),
                                          child: TitleSmallNormalTextWidget(
                                            title: descriptionStr,
                                            size: 12,
                                          )),
                                    ),
                                    SizedBox(
                                      height: 5 * 22.w,
                                      child: TextFormField(
                                          keyboardType: TextInputType.text,
                                          maxLines: 5,
                                          cursorColor: lightBlueTabs,
                                          style: TextStyle(fontSize: 11.sp),
                                          textAlign: TextAlign.start,
                                          cursorHeight: 16.w,
                                          onSaved: (input) {
                                            stocklotWaste.description = input;
                                          },
                                          onChanged: (input) {
                                            stocklotWaste.description = input;
                                          },
                                          decoration:
                                              borderDecoration(descriptionStr)),
                                    ),
                                  ],
                                ),
                              ),
                              flex: 9,
                            ),
                            Expanded(
                              child: ElevatedButtonWithoutIcon(
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
                                          msg: "Please enter quantity");
                                    } else if (stocklotWaste
                                        .description!.isEmpty) {
                                      Fluttertoast.showToast(
                                          msg: "Please enter description");
                                    } else {
                                      Navigator.pop(context);
                                      stocklotProvider
                                          .addStocklotWaste(stocklotWaste);
                                      stocklotProvider.disableClick();
                                    }
                                  },
                                  color: btnColorLogin,
                                  btnText: 'Add'),
                            ),
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
              );
            }),
          );
        });
  }
}
