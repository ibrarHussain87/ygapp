import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:yg_app/Providers/stocklot_provider.dart';
import 'package:yg_app/elements/elevated_button_widget.dart';
import 'package:yg_app/elements/elevated_button_widget_2.dart';
import 'package:yg_app/elements/list_widgets/single_select_tile_widget.dart';
import 'package:yg_app/elements/title_text_widget.dart';
import 'package:yg_app/helper_utils/app_colors.dart';
import 'package:yg_app/helper_utils/progress_dialog_util.dart';
import 'package:yg_app/model/request/post_ad_request/create_request_model.dart';
import 'package:yg_app/model/response/common_response_models/countries_response.dart';
import 'package:yg_app/model/stocklot_waste_model.dart';
import 'package:yg_app/pages/post_ad_pages/stocklot_page/component/stocklot_specification_body.dart';
import 'package:yg_app/pages/post_ad_pages/stocklot_page/component/stocklot_steps_segment.dart';

import '../../../elements/add_picture_widget.dart';
import '../../../elements/decoration_widgets.dart';
import '../../../elements/list_items/list__item_stocklot_widget.dart';
import '../../../helper_utils/app_constants.dart';
import '../../../helper_utils/ui_utils.dart';
import '../../../helper_utils/util.dart';
import '../../../model/request/stocklot_request/stocklot_request.dart';
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
  // CreateRequestModel? _createRequestModel;

  final GlobalKey<StockLotSpecificationBodyState> stockLotSpecificationKey =
      GlobalKey<StockLotSpecificationBodyState>();
  StocklotCategories? stocklotCategories;
  Countries? countryModel;
  List<PickedFile> imageFiles = [];
  final GlobalKey<FormState> _globalFormKey = GlobalKey<FormState>();

  late StocklotProvider stocklotProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    stocklotProvider = Provider.of<StocklotProvider>(context, listen: false);
    stocklotProvider.getStocklotData();
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
                  body: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  Expanded(
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
                                      spanCount: 3,
                                      listOfItems: /* ['Waste', 'Left Over', 'Rejection']*/ stocklotProvider
                                          .stocklots!,
                                      selectedIndex: 0,
                                      callback: (StocklotCategories value) {
                                        if (stocklotProvider
                                            .stocklotWasteList!.isEmpty) {
                                          stocklotProvider.getCategories(
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
                                      selectedIndex: -1,
                                      callback: (StocklotCategories value) {
                                        stocklotProvider.stocklotRequestModel
                                                .subcategoryId =
                                            value.id.toString();
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
                                      title: "Sub Categories"),
                                  SizedBox(
                                    height: 8.h,
                                  ),
                                  SingleSelectTileWidget(
                                    spanCount: 3,
                                    listOfItems:
                                        stocklotProvider.stocklotSubcategories!,
                                    selectedIndex: -1,
                                    callback: (StocklotCategories value) {
                                      stocklotCategories = value;
                                      stocklotProvider.getFilteredStocklotWaste(
                                          value.id ?? -1);
                                      var list = stocklotProvider
                                          .stocklotWasteList!
                                          .where((element) =>
                                              element.id == value.id.toString())
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
                            Visibility(
                              visible: stocklotProvider
                                  .filteredStocklotWasteList!.isNotEmpty,
                              maintainSize: false,
                              maintainState: false,
                              child: Container(
                                margin: EdgeInsets.only(left: 8.w, right: 8.w),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black12),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(6))),
                                child: SizedBox(
                                    /*height: 36.w,*/
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
                                                top: 8.w,
                                                left: 8.w,
                                                bottom: 6.w),
                                            child: const TitleMediumTextWidget(
                                              title: 'Stocklot Waste',
                                            )),
                                        GestureDetector(
                                          onTap: (){
                                            stocklotProvider.changeExpandStockLostWast();
                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(top: 4,right: 6,bottom: 4),
                                            decoration: BoxDecoration(
                                              color: Colors.green.shade700
                                                  .withOpacity(0.1),
                                              shape: BoxShape.circle,
                                            ),
                                            child: Icon(
                                              stocklotProvider.expandStockLostWast ? Icons.keyboard_arrow_up_outlined :Icons.keyboard_arrow_down_outlined,
                                              size: 24,
                                              color: Colors.green,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Visibility(
                                      visible: stocklotProvider.expandStockLostWast,
                                      child: Column(
                                        children: [
                                          Divider(),
                                          Padding(
                                            padding:
                                            const EdgeInsets.only(left: 4,right: 4,bottom: 8),
                                            child: ListView.separated(
                                              itemCount: stocklotProvider
                                                  .filteredStocklotWasteList!.length,
                                              shrinkWrap: true,
                                              separatorBuilder:
                                                  (BuildContext context, int index) =>
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
                                                    callback: (value) {
                                                      stocklotProvider
                                                          .removeStockWaste(value);
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
                                        onChanged: (Countries? value) {
                                          countryModel = value;
                                        },
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
                                                      value,
                                                      textAlign:
                                                          TextAlign.center),
                                                  value: value,
                                                ))
                                            .toList(),
                                        isExpanded: true,
                                        onChanged: (/*Countries?*/
                                            String? value) {
                                          stocklotProvider.stocklotRequestModel
                                              .availability = value;
                                        },
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
                                    imageFiles = value;
                                  },
                                ),
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
                            stocklotProvider
                                .stocklotRequestModel.spc_category_idfk = "5";
                            stocklotProvider.stocklotRequestModel.countryId =
                                countryModel!.conId.toString();
                            stocklotProvider.stocklotRequestModel.currency =
                                countryModel!.conCurrency.toString();
                            stocklotProvider.stocklotRequestModel
                                    .stocklotWasteModelList =
                                stocklotProvider.stocklotWasteList;
                            stocklotProvider.createStockLot();
                            if (!stocklotProvider.loading) {
                              ProgressDialogUtil.hideDialog();
                            } else {
                              ProgressDialogUtil.showDialog(
                                  context, "Please wait...");
                            }
                          }
                        },
                      ),
                    ),
                  )
                ],
              ),
            )))
          : Container(
              color: Colors.transparent,
              height: 100,
            );
    });
  }

  void showStocklotBottomSheet(StocklotCategories value,
      StocklotProvider stocklotProvider, StocklotWasteModel? editWasteModel) {
    /*stocklotProvider.getFilteredStocklotWaste(value.id??-1);*/
    /*var list = stocklotProvider.stocklotWasteList!.where((element) => element.id == value.id.toString()).toList();
    if(list.isNotEmpty){
      return;
    }*/
    var stocklotWaste = StocklotWasteModel(
        unitOfCount: editWasteModel != null
            ? editWasteModel.unitOfCount
            : stocklotProvider.unitsList![0].untName,
        name: editWasteModel != null ? editWasteModel.name : value.category,
        price: editWasteModel != null ? editWasteModel.price : '',
        quantity: editWasteModel != null ? editWasteModel.quantity : '',
        description: editWasteModel != null ? editWasteModel.description : '',
        id: editWasteModel != null ? editWasteModel.id : value.id.toString());
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
                                            selectedIndex: editWasteModel !=
                                                    null
                                                ? stocklotProvider.unitsList!
                                                    .indexWhere((element) =>
                                                        element.untName ==
                                                        editWasteModel
                                                            .unitOfCount)
                                                : 0,
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
                                          initialValue: editWasteModel != null
                                              ? editWasteModel.description
                                              : '',
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

  bool validateAndSave() {
    final form = _globalFormKey.currentState;

    if (stocklotProvider.stocklotRequestModel.subcategoryId == null) {
      Ui.showSnackBar(context, "Please select category");
      return false;
    }

    if (stocklotProvider.stocklotRequestModel.stocklotWasteModelList != null &&
        stocklotProvider.stocklotRequestModel.stocklotWasteModelList!.isEmpty) {
      Ui.showSnackBar(context, "Please select select sub category");
      return false;
    }

    if (stocklotProvider.stocklotRequestModel.priceTermsId == null) {
      Ui.showSnackBar(context, "Please select price terms");
      return false;
    }

    if (stocklotProvider.stocklotRequestModel.availability == null) {
      Ui.showSnackBar(context, "Please select availability");
      return false;
    }

    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
