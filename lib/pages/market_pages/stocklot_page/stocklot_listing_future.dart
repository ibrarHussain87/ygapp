import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:yg_app/providers/stocklot_providers/stocklot_provider.dart';
import 'package:yg_app/api_services/api_service_class.dart';
import 'package:yg_app/elements/list_items/stocklot_list_items.dart';
import 'package:yg_app/elements/title_text_widget.dart';
import 'package:yg_app/helper_utils/app_constants.dart';
import 'package:yg_app/helper_utils/navigation_utils.dart';
import 'package:yg_app/model/response/stocklot_repose/stocklot_specification_response.dart';


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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    stocklotProvider = Provider.of<StocklotProvider>(context, listen: true);
    stocklotProvider.getStockLotSpecRequestModel.localInternational = widget.locality;
    stocklotProvider.getStockLotSpecRequestModel.categoryId = "5";
    stocklotProvider.getStockLotSpecRequestModel.isOffering = stocklotProvider.isOffering;
    stocklotProvider.getStockLotSpecRequestModel.stocklotFamilyId =
        stocklotProvider.categoryId != -1
            ? stocklotProvider.categoryId.toString()
            : stocklotProvider.getStockLotSpecRequestModel.stocklotFamilyId;
    stocklotProvider.getStockLotSpecRequestModel.avalibilityId =
        stocklotProvider.getStockLotSpecRequestModel.avalibilityId;
    stocklotProvider.getStockLotSpecRequestModel.priceTermId =
        stocklotProvider.getStockLotSpecRequestModel.priceTermId;
    return FutureBuilder<StockLotSpecificationResponse>(
            future: ApiService.getStockLotSpecifications(stocklotProvider.getStockLotSpecRequestModel),
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
                      ?  ListView.builder(
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
//                    separatorBuilder: (context, index) {
//                      return Divider(
//                        height: 1,
//                        color: Colors.grey.shade400,
//                      );
//                    },
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
