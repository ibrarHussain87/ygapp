import 'package:flutter/material.dart';
import 'package:yg_app/elements/list_items/bids_list/fabric_bids_item.dart';
import 'package:yg_app/elements/list_items/bids_list/fiber_bids_item.dart';
import 'package:yg_app/elements/list_items/bids_list/stocklot_bids_item.dart';
import 'package:yg_app/elements/list_items/bids_list/yarn_bids_item.dart';
import 'package:yg_app/model/response/list_bid_response.dart';


class BidsListItem extends StatefulWidget {

  final BidData bidData;

  const BidsListItem(
      {Key? key,required this.bidData})
      : super(key: key);

  @override
  _BidsListItemState createState() => _BidsListItemState();
}

class _BidsListItemState extends State<BidsListItem> {
  @override
  Widget build(BuildContext context) {
    if (widget.bidData.categoryId == "1") {
      return FiberBidItem(bidData: widget.bidData);
    } else if (widget.bidData.categoryId == "2"){
      return YarnBidsItem(bidData: widget.bidData);
    }else if (widget.bidData.categoryId == "3"){
      return FabricBidsItem(bidData: widget.bidData);
    }else{
      return StockLotBidsItem(bidData: widget.bidData);
    }
  }
}
