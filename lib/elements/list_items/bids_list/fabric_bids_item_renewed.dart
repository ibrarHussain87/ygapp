import 'package:flutter/material.dart';
import 'package:yg_app/model/response/list_bid_response.dart';

import '../../../model/response/fabric_response/fabric_specification_response.dart';
import '../fabric_list_items_renewed_again.dart';

class FabricBidsItemRenewed extends StatelessWidget {

  final BidData bidData;

  const FabricBidsItemRenewed({Key? key, required this.bidData}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    FabricSpecification fabricSpecification = bidData.specification as FabricSpecification;

    return buildFabricRenewedAgainWidget(
        fabricSpecification,
        context,showCounts: false,showDetailsButton: true,bidData: bidData
    );
  }


}




