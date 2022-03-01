import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:yg_app/elements/elevated_button_widget.dart';
import 'package:yg_app/elements/list_widgets/single_select_tile_widget.dart';
import 'package:yg_app/elements/title_text_widget.dart';
import 'package:yg_app/helper_utils/app_colors.dart';
import 'package:yg_app/model/request/post_ad_request/create_request_model.dart';
import 'package:yg_app/pages/post_ad_pages/stocklot_page/component/stocklot_specification_body.dart';
import 'package:yg_app/pages/post_ad_pages/stocklot_page/component/stocklot_steps_segment.dart';

class CreateStockLotPage extends StatefulWidget {
  final String? locality;
  final String? businessArea;
  final String? selectedTab;

  const CreateStockLotPage(
      {Key? key, required this.locality, this.businessArea, this.selectedTab})
      : super(key: key);

  @override
  _CreateStockLotPageState createState() => _CreateStockLotPageState();
}

class _CreateStockLotPageState extends State<CreateStockLotPage> {
  CreateRequestModel? _createRequestModel;
  final GlobalKey<StockLotStepsSegmentState> _stockLotStepSegment = GlobalKey();

  final GlobalKey<StockLotSpecificationBodyState> stockLotSpecificationKey =
  GlobalKey<StockLotSpecificationBodyState>();


  @override
  void initState() {
    // TODO: implement initState
    _createRequestModel = CreateRequestModel();
    _createRequestModel!.spc_category_idfk = "1";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Provider(
      create: (_) => _createRequestModel,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 8.w, right: 8.w,top: 16.w,bottom: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                TitleMediumTextWidget(title: "Category"),
                SizedBox(
                  height: 8.h,
                ),
                SingleSelectTileWidget(
                  spanCount: 3,
                  listOfItems: ['Waste', 'Left Over', 'Rejection'],
                  selectedIndex: 0,
                  callback: (value) {
                    _stockLotStepSegment.currentState!.stockLotSpecificationKey.currentState!.onCatChange(value);
                  },
                )
              ],
            ),
          ),
          Expanded(
            child: /*StockLotSpecificationBody(
              key: stockLotSpecificationKey,
              locality: widget.locality,
              businessArea: widget.businessArea,
              selectedTab: widget.selectedTab,
            )*/StockLotStepsSegment(
              key: _stockLotStepSegment,
              businessArea: widget.businessArea,
              locality: widget.locality,
              selectedTab: widget.selectedTab,
              callback: (value) {},
            ),
          ),
        ],
      ),
    )));
  }
}
