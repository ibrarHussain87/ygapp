import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:yg_app/Providers/stocklot_provider.dart';
import 'package:yg_app/elements/elevated_button_widget_2.dart';
import 'package:yg_app/elements/list_items/list__item_stocklot_widget.dart';
import 'package:yg_app/elements/list_widgets/single_select_tile_widget.dart';
import 'package:yg_app/helper_utils/app_colors.dart';
import 'package:yg_app/helper_utils/app_constants.dart';
import 'package:yg_app/helper_utils/util.dart';
import 'package:yg_app/model/request/stocklot_request/get_stock_lot_spec_request.dart';
import 'package:yg_app/model/response/common_response_models/countries_response.dart';
import 'package:yg_app/model/response/common_response_models/price_term.dart';
import 'package:yg_app/model/response/stocklot_repose/stocklot_sync/stocklot_sync_response.dart';

import '../../../elements/title_text_widget.dart';

class StockLotFilterPage extends StatefulWidget {
  const StockLotFilterPage({Key? key}) : super(key: key);

  @override
  State<StockLotFilterPage> createState() => _StockLotFilterPageState();
}

class _StockLotFilterPageState extends State<StockLotFilterPage> {
  late StocklotProvider stocklotProvider;
  final GetStockLotSpecRequestModel _getStockLotSpecRequestModel = GetStockLotSpecRequestModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    stocklotProvider = Provider.of<StocklotProvider>(context, listen: false);
    stocklotProvider.getStocklotData();
  }

  @override
  Widget build(BuildContext context) {
    stocklotProvider = Provider.of<StocklotProvider>(context);
    return SafeArea(
        child: stocklotProvider.stocklots!.isNotEmpty
            ? Scaffold(
                body: Container(
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
                                const TitleMediumTextWidget(title: "Stocklot"),
                                SizedBox(
                                  height: 8.h,
                                ),
                                SingleSelectTileWidget(
                                  key: stocklotProvider.stocklotKey,
                                  spanCount: 3,
                                  listOfItems: /* ['Waste', 'Left Over', 'Rejection']*/ stocklotProvider
                                      .stocklots!,
                                  selectedIndex: -1,
                                  callback: (StocklotCategories value) {

                                      stocklotProvider
                                          .getCategories(value.id.toString());

                                  },
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
                                const TitleMediumTextWidget(title: "Category"),
                                SizedBox(
                                  height: 8.h,
                                ),
                                IgnorePointer(
                                  ignoring: stocklotProvider.ignoreClick,
                                  child: SingleSelectTileWidget(
                                    key: stocklotProvider.categoryKey,
                                    spanCount: 3,
                                    listOfItems:
                                        stocklotProvider.stocklotCategories!,
                                    selectedIndex: -1,
                                    callback: (StocklotCategories value) {
                                      // stocklotProvider.stocklotRequestModel
                                      //     .subcategoryId = value.id.toString();
                                      _getStockLotSpecRequestModel.categoryId = value.id.toString();
                                      stocklotProvider.getSubcategories(
                                          value.id.toString());
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                                left: 8.w, right: 8.w, top: 10.w, bottom: 8.w),
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
                                  key: stocklotProvider.subCategoryKey,
                                  spanCount: 3,
                                  listOfItems:
                                      stocklotProvider.stocklotSubcategories!,
                                  selectedIndex: -1,
                                  callback: (StocklotCategories value) {
                                    stocklotProvider.getFilteredStocklotWaste(
                                        value.id ?? -1);
                                    _getStockLotSpecRequestModel.stocklotSubCategoryId = value.id.toString();

                                  },
                                )
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
                                       _getStockLotSpecRequestModel.priceTermId = value!.ptrId.toString();
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
                                      items: stocklotProvider.availabilityList!
                                          .map((value) => DropdownMenuItem(
                                                child: Text(
                                                    /*value.conCurrency*/
                                                    value.toString(),
                                                    textAlign:
                                                        TextAlign.center),
                                                value: value,
                                              ))
                                          .toList(),
                                      isExpanded: true,
                                      onChanged: (/*Countries?*/
                                          AvailabilityModel? value) {
                                        _getStockLotSpecRequestModel.avalibilityId = value!.afm_id.toString();

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
                              callback: () {},
                            ),
                          ),
                          SizedBox(width: 8.w,),
                          Expanded(
                            child: ElevatedButtonWithoutIcon(
                              btnText: "Apply Filter",
                              textSize: 12.sp,
                              color: Colors.green,
                              callback: () {
                                Navigator.pop(context, _getStockLotSpecRequestModel);
                              },
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ))
            : Container(
                color: Colors.white,
                height: 100,
              ));
  }
}
