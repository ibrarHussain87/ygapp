import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/elements/bottom_sheets/offering_requirment_bottom_sheet.dart';
import 'package:yg_app/elements/elevated_button_without_icon_widget.dart';
import 'package:yg_app/elements/list_items/stocklot_list_items.dart';
import 'package:yg_app/elements/list_widgets/blend_with_image_listview_widget.dart';
import 'package:yg_app/elements/list_widgets/single_select_tile_renewed_widget.dart';
import 'package:yg_app/elements/no_data_found_widget.dart';
import 'package:yg_app/elements/text_widgets.dart';
import 'package:yg_app/helper_utils/app_constants.dart';
import 'package:yg_app/helper_utils/navigation_utils.dart';
import 'package:yg_app/locators.dart';
import 'package:yg_app/model/response/stocklot_repose/stocklot_specification_response.dart';
import 'package:yg_app/model/response/stocklot_repose/stocklot_sync/stocklot_sync_response.dart';
import 'package:yg_app/pages/market_pages/common_components/offering_requirment__segment_component.dart';
import 'package:yg_app/providers/stocklot_providers/stocklot_specification_provider.dart';

class StocklotProductPage extends StatefulWidget {
  final List<StockLotSpecification?>? specification;

  const StocklotProductPage({Key? key, required this.specification})
      : super(key: key);

  @override
  StocklotProductPageState createState() => StocklotProductPageState();
}

class StocklotProductPageState extends State<StocklotProductPage> {
  var stocklotProvider = locator<StockLotSpecificationProvider>();

  filterListSearch(value) {
    setState(() {
      _filteredSpecification = _specification!
          .where((element) => (element!.stocklotParentFamilyName
              .toString()
              .toLowerCase()
              .contains(value)))
          .toList();
    });
  }

  // List<StockLotFamily> stocklotFamilyList = [];
  List<StockLotSpecification?>? _specification;
  List<StockLotSpecification?>? _filteredSpecification;
  String isOffering = "1";

  @override
  void initState() {
    _specification = widget.specification;
    _filteredSpecification = _specification!
        .where((element) => element!.isOffering == isOffering)
        .toList();
    super.initState();
    stocklotProvider.getStockLotData();

    stocklotProvider.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding:
                EdgeInsets.only(left: 16.0, right: 16.0, top: 8.w, bottom: 8.w),
            child: Row(
              children: [
                Expanded(
                  flex: 7,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TitleTextWidget(title: "Add New"),
                      SizedBox(
                        height: 4.w,
                      ),
                      const TitleExtraSmallTextWidget(
                          title: "You are currently seeing your requirment")
                    ],
                  ),
                ),

                Expanded(
                    flex: 3,
                    child: ElevatedButtonWithoutIcon(
                      callback: () {
                        showBottomSheetOR(context, (value) {
                          openStockLotPostPage(
                              context, local, 'Stocklot', value);
                        });
                      },
                      btnText: "Post Offer",
                      color: Colors.green,
                    ))
              ],
            ),
          ),
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4),
            child: Padding(
                padding: const EdgeInsets.only(top: 2.0),
                child: BlendWithImageListWidget(
                    listItem: stocklotProvider.stockLots!,
                    onClickCallback: (value) {
                      setState(() {
                        _filteredSpecification = _specification!
                            .where((element) =>
                                element!.stocklotCategoryId.toString() ==
                                stocklotProvider
                                    .stockLots![value].stocklotFamilyId
                                    .toString())
                            .toList();
                      });
                      // stocklotProvider.getStockLotCategoriesData(
                      //     stocklotProvider.stocklots![value].stocklotFamilyId!);
                    })),
          ),
          Container(
            color: Colors.white,
            padding: const EdgeInsets.only(
              bottom: 8.0,
            ),
            child: Center(
              child: OfferingRequirementSegmentComponent(
                callback: (value) {
                  setState(() {
                    isOffering = value.toString();
                    _filteredSpecification = _specification!
                        .where((element) =>
                            element!.isOffering.toString() == value.toString())
                        .toList();
                  });
                },
              ),
            ),
          ),
          Expanded(
              child: Container(
                  color: Colors.white,
                  child: _filteredSpecification!.isNotEmpty
                      ? ListView.builder(
                          itemCount: _filteredSpecification!.length,
                          itemBuilder: (context, index) => GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                openDetailsScreen(context,
                                    specObj: _filteredSpecification![index]!);
                              },
                              child: StockLotListItem(
                                  specification:
                                      _filteredSpecification![index]!,
                                  showCount: true)),
                        )
                      : const NoDataFoundWidget()))
        ],
      ),
    );
  }
}
