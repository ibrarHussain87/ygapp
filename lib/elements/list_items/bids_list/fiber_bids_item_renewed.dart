import 'package:flutter/material.dart';
import 'package:yg_app/model/response/fiber_response/fiber_specification.dart';
import 'package:yg_app/model/response/list_bid_response.dart';

import '../fiber_list_items_renewed_again.dart';

class FiberBidItemRenewed extends StatelessWidget {
  final BidData? bidData;

  const FiberBidItemRenewed({Key? key, required this.bidData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Specification _specification = bidData!.specification! as Specification;

    return buildFiberRenewedAgainWidget(
        _specification,
        context,
        showCount: false,showDetailsButton: true,bidData: bidData
    );
  }
}
