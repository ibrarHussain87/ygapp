import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:yg_app/Providers/stocklot_provider.dart';
import 'package:yg_app/api_services/api_service_class.dart';
import 'package:yg_app/elements/list_items/fiber_market_list_item.dart';
import 'package:yg_app/elements/list_items/fiber_market_list_item_renewed.dart';
import 'package:yg_app/elements/list_items/stocklot_product_list_items_renewed.dart';
import 'package:yg_app/elements/title_text_widget.dart';
import 'package:yg_app/helper_utils/app_constants.dart';
import 'package:yg_app/helper_utils/navigation_utils.dart';
import 'package:yg_app/helper_utils/shared_pref_util.dart';
import 'package:yg_app/model/request/stocklot_request/get_stock_lot_spec_request.dart';
import 'package:yg_app/model/request/stocklot_request/stocklot_request.dart';
import 'package:yg_app/model/response/fiber_response/fiber_specification.dart';
import 'package:yg_app/model/response/stocklot_repose/stocklot_specification_response.dart';

import '../../../elements/list_items/fiber_list_items_renewed_again.dart';

class StockLotListingBody extends StatefulWidget {
  // final List<Specification> specification;

  final String locality;

  const StockLotListingBody(
      {Key? key, required this.locality /*required this.specification*/
      })
      : super(key: key);

  @override
  StockLotListingBodyState createState() => StockLotListingBodyState();
}

class StockLotListingBodyState extends State<StockLotListingBody> {
  late StocklotProvider stocklotProvider;
  late GetStockLotSpecRequestModel getStockLotSpecRequestModel;

  @override
  void initState() {
    super.initState();
    stocklotProvider = Provider.of<StocklotProvider>(context, listen: false);

    getStockLotSpecRequestModel = GetStockLotSpecRequestModel();
    getStockLotSpecRequestModel.localInternational = widget.locality;
    getStockLotSpecRequestModel.categoryId = "5";
    getStockLotSpecRequestModel.isOffering = "1";
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (BuildContext context) {
      return FutureBuilder<StockLotSpecificationResponse>(
        future: ApiService.getStockLotSpecifications(
            getStockLotSpecRequestModel),
        builder: (BuildContext context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.data != null) {
            return Container(
              child: snapshot.data!.data!.specification!.isNotEmpty
                  ? ListView.separated(
                itemCount: snapshot.data!.data!.specification!.length,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) =>
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        // openDetailsScreen(
                        //     context,specification: specificationFiltered![index]);
                      },
                      child: StockLotListItem(specification: snapshot.data!.data!.specification![index],),
                    ),
                separatorBuilder: (context, index) {
                  return Divider(
                    height: 1,
                    color: Colors.grey.shade400,
                  );
                },
              ) : const Center(
                child: TitleSmallTextWidget(
                  title: 'No Data Found',
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
                child: TitleSmallTextWidget(title: snapshot.error.toString()));
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
    });
  }
}
