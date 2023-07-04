import 'package:flutter/material.dart';
import 'package:yg_app/model/response/list_bid_response.dart';
import 'package:yg_app/model/response/stocklot_repose/stocklot_specification_response.dart';

import '../stocklot_list_items.dart';

class StockLotBidsItemRenewed extends StatelessWidget {
  final BidData bidData;

  const StockLotBidsItemRenewed({Key? key, required this.bidData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    StockLotSpecification stockLotSpecification =
        bidData.specification as StockLotSpecification;

    return StockLotListItem(specification: stockLotSpecification,showDetailsButton: true,bidData: bidData);
  }

}
