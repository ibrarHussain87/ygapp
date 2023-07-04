import 'package:flutter/material.dart';
import 'package:yg_app/model/response/list_bid_response.dart';
import 'package:yg_app/model/response/yarn_response/yarn_specification_response.dart';

import '../yarn_list_items_renewed_again.dart';

class YarnBidsItemRenewed extends StatelessWidget {
  final BidData bidData;

  const YarnBidsItemRenewed({Key? key, required this.bidData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    YarnSpecification yarnSpecification =
        bidData.specification as YarnSpecification;
    return Column(
      children: [
        buildYarnRenewedAgainWidget(yarnSpecification, context, showCount: false,showDetailsButton: true,bidData: bidData),
      ],
    );
  }


}




