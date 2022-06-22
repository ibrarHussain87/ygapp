import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:search_choices/search_choices.dart';
import 'package:yg_app/app_database/app_database_instance.dart';
import 'package:yg_app/elements/list_widgets/blend_with_image_listview_widget.dart';
import 'package:yg_app/elements/list_widgets/single_select_tile_renewed_widget.dart';
import 'package:yg_app/elements/text_widgets.dart';
import 'package:yg_app/helper_utils/app_colors.dart';
import 'package:yg_app/helper_utils/navigation_utils.dart';
import 'package:yg_app/helper_utils/util.dart';
import 'package:yg_app/model/response/common_response_models/countries_response.dart';
import 'package:yg_app/pages/market_pages/common_components/offering_requirment__segment_component.dart';
import 'package:yg_app/pages/market_pages/stocklot_page/stocklot_listing_future.dart';
import 'package:yg_app/providers/stocklot_providers/stocklot_provider.dart';

import '../../../elements/bottom_sheets/offering_requirment_bottom_sheet.dart';
import '../../../elements/custom_header.dart';
import '../../../helper_utils/app_constants.dart';
import '../../../helper_utils/app_images.dart';
import '../../../model/response/stocklot_repose/stocklot_sync/stocklot_sync_response.dart';
import '../../fliter_pages/stocklot/stocklot_filter_page.dart';

class StockLotPage extends StatefulWidget {
  final String? locality;

  const StockLotPage({Key? key, required this.locality}) : super(key: key);

  @override
  StockLotPageState createState() => StockLotPageState();
}

class StockLotPageState extends State<StockLotPage> {
  List<Countries> _countries = [];
  late StocklotProvider stocklotProvider;
  StockLotFamily? stocklotCategories;

  @override
  void initState() {
    AppDbInstance()
        .getOriginsData()
        .then((value) => setState(() => _countries = value));
    super.initState();
    stocklotProvider = Provider.of<StocklotProvider>(context, listen: false);
    stocklotProvider.getStockLotSpecRequestModel.stocklotParentFamilyId = '';
    stocklotProvider.getStocklotData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Builder(builder: (context) {
        stocklotProvider = Provider.of<StocklotProvider>(context);
        return stocklotProvider.stocklots!.isNotEmpty
            ? Scaffold(
                appBar: appBar(context, 'Stocklot', isFilterVisible: true,
                    filterCallback: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const StockLotFilterPage()),
                      ).then((value) {
                        //Getting result from filter
                          if (value != null) {
                            stocklotProvider.searchData(value);
                          }
                      });
                }),
                backgroundColor: Colors.white,
                floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    showBottomSheetOR(context, (value) {
                      openStockLotPostPage(
                          context, widget.locality, "StockLot", value);
                    });
                  },
                  child: const Icon(Icons.add),
                  backgroundColor: Colors.blueAccent,
                  heroTag: null,
                ),
                body: Container(
                  color: bgColor,
                  child: Column(
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            child: Row(
                              children: [
                                Expanded(
                                  flex:
                                      widget.locality == international ? 8 : 10,
                                  child: OfferingRequirementSegmentComponent(
                                    callback: (value) {
                                      stocklotProvider
                                          .setIsOffering(value.toString());
                                    },
                                  ),
                                ),
                                Visibility(
                                  visible: widget.locality == international,
                                  maintainState: false,
                                  maintainSize: false,
                                  child: Expanded(
                                    child: Image.asset(
                                      ic_products,
                                      width: 12,
                                      height: 12,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex:
                                      widget.locality == international ? 3 : 0,
                                  child: Visibility(
                                      maintainSize: false,
                                      maintainState: false,
                                      visible: widget.locality == international,
                                      child: SearchChoices.single(
                                        displayClearIcon: false,
                                        isExpanded: true,
                                        hint:
                                            const TitleExtraSmallBoldTextWidget(
                                                title: 'Country'),
                                        items: _countries
                                            .map((value) => DropdownMenuItem(
                                                  child: Text(
                                                    value.conName ??
                                                        Utils.checkNullString(
                                                            false),
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontSize: 12.sp,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  value: value,
                                                ))
                                            .toList(),
                                        isCaseSensitiveSearch: false,
                                        onChanged: (Countries? value) {},
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          color: textColorGrey,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      )

//                                        DropdownButtonFormField(
//                                          isExpanded: true,
//                                          decoration:
//                                              const InputDecoration.collapsed(
//                                                  hintText: ''),
//                                          hint:
//                                              const TitleExtraSmallBoldTextWidget(
//                                                  title: 'Country'),
//                                          items: _countries
//                                              .map((value) => DropdownMenuItem(
//                                                    child: Text(
//                                                        value.conName ??
//                                                            Utils
//                                                                .checkNullString(
//                                                                    false),
//                                                        textAlign:
//                                                            TextAlign.center),
//                                                    value: value,
//                                                  ))
//                                              .toList(),
//                                          onChanged: (Countries? value) {
//                                            /*_createRequestModel!
//                                          .spc_origin_idfk =
//                                          value!.conId.toString();*/
//                                          },
//                                          style: TextStyle(
//                                              fontSize: 11.sp,
//                                              color: textColorGrey),
//                                        ),
                                      ),
                                ),
                                Visibility(
                                  visible: false,
                                  child: Center(
                                    child: GestureDetector(
                                      behavior: HitTestBehavior.opaque,
                                      onTap: () async {},
                                      child: Card(
                                          color: Colors.white,
                                          elevation: 1,
                                          child: Padding(
                                              padding: EdgeInsets.all(4.w),
                                              child: Icon(
                                                Icons.filter_alt_sharp,
                                                color: lightBlueTabs,
                                                size: 16.w,
                                              ))),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Material(
                        elevation: 0.2,
                        color: Colors.white,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(25),
                                topRight: Radius.circular(25))),
                        child: Column(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 8.w,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0, vertical: 4),
                                  child: Padding(
                                      padding: const EdgeInsets.only(top: 2.0),
                                      child: BlendWithImageListWidget(
                                          listItem: stocklotProvider.stocklots!,
                                          onClickCallback: (value) {
                                            stocklotProvider
                                                    .getStockLotSpecRequestModel
                                                    .stocklotParentFamilyId =
                                                stocklotProvider
                                                    .stocklots![value]
                                                    .stocklotFamilyId
                                                    .toString();
                                            stocklotProvider.getCategories(
                                                stocklotProvider
                                                    .stocklots![value]
                                                    .stocklotFamilyId
                                                    .toString());
                                            stocklotProvider.categoryId = -1;
                                            stocklotProvider
                                                .getStockLotSpecRequestModel
                                                .avalibilityId = null;
                                            stocklotProvider
                                                .getStockLotSpecRequestModel
                                                .priceTermId = null;

                                            stocklotProvider
                                                .getStockLotSpecRequestModel
                                                .stocklotFamilyId = null;
                                            stocklotProvider
                                                .setShowCategory(true);

                                            if (stocklotProvider.subFamilyKey
                                                    .currentState !=
                                                null) {
                                              stocklotProvider
                                                  .subFamilyKey
                                                  .currentState!
                                                  .checkedTile = -1;
                                            }
                                          })),
                                ),
                                Visibility(
                                  visible: stocklotProvider.showCategory,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      height: 0.04 *
                                          MediaQuery.of(context).size.height,
                                      child: SingleSelectTileRenewedWidget(
                                        key: stocklotProvider.subFamilyKey,
                                        spanCount: 2,
                                        selectedIndex:
                                            stocklotProvider.selectedIndex,
                                        listOfItems: stocklotProvider
                                            .stocklotCategories!,
                                        callback: (StockLotFamily value) {
                                          // stocklotProvider.getSubcategories(
                                          //     stocklotProvider.stocklotId
                                          //         .toString());
                                          stocklotProvider.categoryId =
                                              value.stocklotFamilyId;
                                          stocklotProvider.getSubcategories(
                                              value.stocklotFamilyId
                                                  .toString());
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: false,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: SizedBox(
                                        height: 0.04 *
                                            MediaQuery.of(context).size.height,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 2.0),
                                          child: SingleSelectTileRenewedWidget(
                                            spanCount: 2,
                                            selectedIndex: -1,
                                            listOfItems: stocklotProvider
                                                .stocklotSubcategories!,
                                            callback: (StockLotFamily value) {
                                              // stocklotCategories = value;
                                              // stocklotProvider
                                              //     .getFilteredStocklotWaste(
                                              //     value.id ?? -1);
                                              stocklotProvider.subcategoryId =
                                                  value.stocklotFamilyId;
                                            },
                                          ),
                                        )),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          color: Colors.white,
                          margin: EdgeInsets.only(top: 1.w),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: StockLotListingFuture(
                              locality: widget.locality!,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            : Container(
                color: Colors.white,
                height: 100,
              );
      }),
    );
  }
}
