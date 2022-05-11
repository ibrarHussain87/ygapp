import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:yg_app/Providers/stocklot_provider.dart';
import 'package:yg_app/api_services/api_service_class.dart';
import 'package:yg_app/elements/list_items/fiber_market_list_item.dart';
import 'package:yg_app/elements/list_items/fiber_market_list_item_renewed.dart';
import 'package:yg_app/elements/list_items/stocklot_list_items.dart';
import 'package:yg_app/elements/title_text_widget.dart';
import 'package:yg_app/helper_utils/app_constants.dart';
import 'package:yg_app/helper_utils/navigation_utils.dart';
import 'package:yg_app/helper_utils/shared_pref_util.dart';
import 'package:yg_app/model/request/stocklot_request/get_stock_lot_spec_request.dart';
import 'package:yg_app/model/request/stocklot_request/stocklot_request.dart';
import 'package:yg_app/model/response/fiber_response/fiber_specification.dart';
import 'package:yg_app/model/response/stocklot_repose/stocklot_specification_response.dart';

import '../../../elements/list_items/fiber_list_items_renewed_again.dart';

class StockLotListingFuture extends StatefulWidget {
  // final List<Specification> specification;

  final String locality;

  const StockLotListingFuture(
      {Key? key, required this.locality /*required this.specification*/
      })
      : super(key: key);

  @override
  StockLotListingFutureState createState() => StockLotListingFutureState();
}

class StockLotListingFutureState extends State<StockLotListingFuture> {
  late StocklotProvider stocklotProvider;
  GetStockLotSpecRequestModel getStockLotSpecRequestModel =
      GetStockLotSpecRequestModel();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    stocklotProvider = Provider.of<StocklotProvider>(context, listen: true);
    getStockLotSpecRequestModel.localInternational = widget.locality;
    getStockLotSpecRequestModel.categoryId = "5";
    getStockLotSpecRequestModel.isOffering = stocklotProvider.isOffering;
    getStockLotSpecRequestModel.stocklotFamilyId =
        stocklotProvider.categoryId != -1
            ? stocklotProvider.categoryId.toString()
            : stocklotProvider.getStockLotSpecRequestModel.stocklotFamilyId;

    getStockLotSpecRequestModel.avalibilityId =
        stocklotProvider.getStockLotSpecRequestModel.avalibilityId;
    getStockLotSpecRequestModel.avalibilityId =
        stocklotProvider.getStockLotSpecRequestModel.priceTermId;
    return FutureBuilder<StockLotSpecificationResponse>(
            future: ApiService.getStockLotSpecifications(getStockLotSpecRequestModel),
            builder: (BuildContext context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.data != null) {
                if (widget.locality == international) {
                  stocklotProvider.internationSpecList.clear();
                  if (snapshot.data!.data != null) {
                    stocklotProvider.internationSpecList
                        .addAll(snapshot.data!.data!.specification!);
                  } else {
                    stocklotProvider.internationSpecList = [];
                  }
                } else {
                  stocklotProvider.localSpecList.clear();
                  if (snapshot.data!.data != null) {
                    stocklotProvider.localSpecList
                        .addAll(snapshot.data!.data!.specification!);
                  } else {
                    stocklotProvider.localSpecList = [];
                  }
                }
                return Container(
                  child: snapshot.data!.data != null
                      ?  ListView.separated(
                    itemCount: widget.locality == international
                        ? stocklotProvider.internationSpecList.length
                        : stocklotProvider.localSpecList.length,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) => GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        openDetailsScreen(context,
                            specObj: widget.locality == international
                                ? stocklotProvider
                                .internationSpecList[index]
                                : stocklotProvider.localSpecList[index]);
                      },
                      child: StockLotListItem(
                        specification: widget.locality == international
                            ? stocklotProvider.internationSpecList[index]
                            : stocklotProvider.localSpecList[index],
                      ),
                    ),
                    separatorBuilder: (context, index) {
                      return Divider(
                        height: 1,
                        color: Colors.grey.shade400,
                      );
                    },
                  )
                      : const Center(
                          child: TitleSmallTextWidget(
                            title: 'No Data Found',
                          ),
                        ),
                );
              } else if (snapshot.hasError) {
                return Center(
                    child:
                        TitleSmallTextWidget(title: snapshot.error.toString()));
              } else {
                return const Center(
                  child: SpinKitWave(
                    color: Colors.green,
                    size: 24.0,
                  ),
                );
              }
            },
          );
  }

  checkList(String locality){
    if(locality == international){
      if(stocklotProvider.internationSpecList.isNotEmpty) {
        return true;
      }else {
        return false;
      }
    }else{
      if(stocklotProvider.localSpecList.isNotEmpty) {
        return true;
      }else {
        return false;
      }
    }
  }
}
