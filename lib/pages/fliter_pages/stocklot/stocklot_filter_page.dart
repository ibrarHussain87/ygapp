import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:yg_app/elements/elevated_button_without_icon_widget.dart';
import 'package:yg_app/elements/list_widgets/single_select_tile_widget.dart';
import 'package:yg_app/helper_utils/app_colors.dart';
import 'package:yg_app/helper_utils/app_constants.dart';
import 'package:yg_app/helper_utils/util.dart';
import 'package:yg_app/locators.dart';
import 'package:yg_app/model/request/stocklot_request/get_stock_lot_spec_request.dart';
import 'package:yg_app/model/response/common_response_models/price_term.dart';
import 'package:yg_app/model/response/stocklot_repose/stocklot_sync/stocklot_sync_response.dart';
import 'package:yg_app/providers/stocklot_providers/stocklot_specification_provider.dart';

import '../../../elements/custom_header.dart';
import '../../../elements/text_widgets.dart';

class StockLotFilterPage extends StatefulWidget {
  const StockLotFilterPage({Key? key}) : super(key: key);

  @override
  State<StockLotFilterPage> createState() => _StockLotFilterPageState();
}

class _StockLotFilterPageState extends State<StockLotFilterPage> {
  final _stockLotSpecificationProvider =
      locator<StockLotSpecificationProvider>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _stockLotSpecificationProvider.stockLotCategories = [];
    // _stockLotSpecificationProvider.getStockLotData();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _stockLotSpecificationProvider.getStockLotData();
    });
    _stockLotSpecificationProvider.addListener(() {
      updateUI();
    });
  }
  updateUI() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // _stockLotSpecificationProvider.resetValue();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: !_stockLotSpecificationProvider.isLoading
            ? Scaffold(
                appBar: appBar(context, "StockLot Filter"),
                body: WillPopScope(
                  onWillPop: (){
                    // _stockLotSpecificationProvider.resetValue();
                    return Future.value(true);
                  },
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      children: [
                        Expanded(
                            child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
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
                                        title: "StockLot"),
                                    SizedBox(
                                      height: 8.h,
                                    ),
                                    SingleSelectTileWidget(
                                      key: _stockLotSpecificationProvider.stocklotKey,
                                      spanCount: 3,
                                      listOfItems: /* ['Waste', 'Left Over', 'Rejection']*/ _stockLotSpecificationProvider
                                          .stockLots!,
                                      selectedIndex: -1,
                                      callback: (StockLotFamily value) {
                                        _stockLotSpecificationProvider
                                                .getStockLotSpecRequestModel
                                                .stocklotFamilyId =
                                            [value.stocklotFamilyId.toString()];
                                        _stockLotSpecificationProvider
                                            .getStockLotCategoriesData(
                                                value.stocklotFamilyId!);
                                        // _stockLotSpecificationProvider
                                        //     .setShowCategory(true);
                                        // _stockLotSpecificationProvider
                                        //     .setShowSubCategory(true);
                                        _stockLotSpecificationProvider
                                            .getStockLotSpecRequestModel
                                            .stocklotParentFamilyId = null;
                                      },
                                    )
                                  ],
                                ),
                              ),
                              Visibility(
                                visible: _stockLotSpecificationProvider
                                    .stockLotCategories!.isNotEmpty,
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
                                      SingleSelectTileWidget(
                                        key: _stockLotSpecificationProvider
                                            .categoryKey,
                                        spanCount: 3,
                                        listOfItems:
                                            _stockLotSpecificationProvider
                                                .stockLotCategories!,
                                        selectedIndex: -1,
                                        callback: (StockLotFamily value) {
                                          _stockLotSpecificationProvider
                                                  .getStockLotSpecRequestModel
                                                  .stocklotParentFamilyId =
                                              [value.stocklotFamilyId.toString()];
                                        },
                                      )
                                    ],
                                  ),
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
                                          items: _stockLotSpecificationProvider
                                              .priceTermsList
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
                                            _stockLotSpecificationProvider
                                                    .getStockLotSpecRequestModel
                                                    .priceTermId =
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
                            ],
                          ),
                        )),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: ElevatedButtonWithoutIcon(
                                  btnText: "Reset",
                                  textSize: 12.sp,
                                  color: Colors.grey.shade300,
                                  textColor: 'black',
                                  callback: () {
                                    if (_stockLotSpecificationProvider
                                            .stocklotKey.currentState !=
                                        null) {
                                      _stockLotSpecificationProvider
                                          .stocklotKey.currentState!
                                          .resetWidget();
                                    }
                                    if (_stockLotSpecificationProvider
                                            .categoryKey.currentState !=
                                        null) {
                                      _stockLotSpecificationProvider
                                          .categoryKey.currentState!
                                          .resetWidget();
                                    }
                                    if (_stockLotSpecificationProvider
                                            .subFamilyKey.currentState !=
                                        null) {
                                      _stockLotSpecificationProvider
                                          .subFamilyKey.currentState!
                                          .resetWidget();
                                    }
                                    _stockLotSpecificationProvider
                                            .getStockLotSpecRequestModel =
                                        GetStockLotSpecRequestModel(
                                            categoryId: "5");

                                    _stockLotSpecificationProvider.resetValue();
                                  },
                                ),
                              ),
                              SizedBox(
                                width: 8.w,
                              ),
                              Expanded(
                                child: ElevatedButtonWithoutIcon(
                                  btnText: "Apply Filter",
                                  textSize: 12.sp,
                                  color: Colors.green,
                                  callback: () {

                                    _stockLotSpecificationProvider.resetValue();
                                    Navigator.pop(
                                        context,
                                        _stockLotSpecificationProvider
                                            .getStockLotSpecRequestModel);
                                  },
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ))
            : Container(
                color: Colors.white,
                height: 100,
              ));
  }
}
