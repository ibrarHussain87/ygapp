import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/model/response/fiber_response/fiber_specification.dart';
import 'package:yg_app/model/response/list_bid_response.dart';

import '../../../helper_utils/app_colors.dart';
import '../../../helper_utils/navigation_utils.dart';
import '../../../helper_utils/ui_utils.dart';
import '../../../helper_utils/util.dart';
import '../../elevated_button_without_icon_widget.dart';
import '../../list_widgets/bg_light_blue_normal_text_widget.dart';
import '../../list_widgets/short_detail_renewed_widget.dart';
import '../../text_widgets.dart';
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
