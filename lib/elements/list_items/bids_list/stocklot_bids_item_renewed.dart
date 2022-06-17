import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:yg_app/helper_utils/navigation_utils.dart';
import 'package:yg_app/model/response/list_bid_response.dart';
import 'package:yg_app/model/response/stocklot_repose/stocklot_specification_response.dart';

import '../../../helper_utils/app_colors.dart';
import '../../../helper_utils/app_images.dart';
import '../../../helper_utils/ui_utils.dart';
import '../../../helper_utils/util.dart';
import '../../elevated_button_without_icon_widget.dart';
import '../../list_widgets/short_detail_renewed_widget.dart';
import '../../text_widgets.dart';
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
