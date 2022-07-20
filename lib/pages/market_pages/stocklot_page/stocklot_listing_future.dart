import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:yg_app/api_services/api_service_class.dart';
import 'package:yg_app/elements/list_items/stocklot_list_items.dart';
import 'package:yg_app/elements/no_data_found_widget.dart';
import 'package:yg_app/elements/text_widgets.dart';
import 'package:yg_app/helper_utils/navigation_utils.dart';
import 'package:yg_app/model/response/stocklot_repose/stocklot_specification_response.dart';
import 'package:yg_app/providers/stocklot_providers/stocklot_specification_provider.dart';

import '../../../locators.dart';

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
  final stockLotSpecificationProvider =
      locator<StockLotSpecificationProvider>();

  @override
  void initState() {
    super.initState();
    stockLotSpecificationProvider.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<StockLotSpecificationResponse>(
      future: ApiService().getStockLotSpecifications(
          stockLotSpecificationProvider.getStockLotSpecRequestModel),
      builder: (BuildContext context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null) {
          return Container(
            child: snapshot.data!.data != null
                ? Container(
                    child: snapshot.data!.data!.specification!.isNotEmpty
                        ? ListView.builder(
                            itemCount:
                                snapshot.data!.data!.specification!.length,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) => GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                openDetailsScreen(context,
                                    specObj: snapshot
                                        .data!.data!.specification![index]);
                              },
                              child: StockLotListItem(
                                specification:
                                    snapshot.data!.data!.specification![index],
                              ),
                            ),
                          )
                        : const Center(
                            child: NoDataFoundWidget(),
                          ),
                  )
                : Center(
                    child: TitleSmallTextWidget(
                        title: snapshot.data!.message.toString())),
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
  }
}
