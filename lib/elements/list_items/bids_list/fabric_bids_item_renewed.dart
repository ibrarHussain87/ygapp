import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:yg_app/helper_utils/navigation_utils.dart';
import 'package:yg_app/model/response/list_bid_response.dart';

import '../../../helper_utils/app_colors.dart';
import '../../../helper_utils/ui_utils.dart';
import '../../../helper_utils/util.dart';
import '../../../model/response/fabric_response/fabric_specification_response.dart';
import '../../elevated_button_without_icon_widget.dart';
import '../../text_widgets.dart';
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




