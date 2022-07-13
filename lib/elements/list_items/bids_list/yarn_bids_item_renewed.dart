import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:yg_app/helper_utils/navigation_utils.dart';
import 'package:yg_app/model/response/list_bid_response.dart';
import 'package:yg_app/model/response/yarn_response/yarn_specification_response.dart';

import '../../../helper_utils/app_colors.dart';
import '../../../helper_utils/ui_utils.dart';
import '../../../helper_utils/util.dart';
import '../../elevated_button_without_icon_widget.dart';
import '../../list_widgets/bg_light_blue_normal_text_widget.dart';
import '../../list_widgets/short_detail_renewed_widget.dart';
import '../../text_widgets.dart';
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




