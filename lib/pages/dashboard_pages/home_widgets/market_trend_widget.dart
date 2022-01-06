import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/elements/list_items_widgets/market_trends_item.dart';
import 'package:yg_app/elements/title_text_widget.dart';
import 'package:yg_app/helper_utils/app_constants.dart';

class MarketTrendWidget extends StatefulWidget {
  const MarketTrendWidget({Key? key}) : super(key: key);

  @override
  _MarketTrendWidgetState createState() => _MarketTrendWidgetState();
}

class _MarketTrendWidgetState extends State<MarketTrendWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.symmetric(vertical: 8.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleTextWidget(title: marketTrends),
          SizedBox(
            height: 8.w,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 10+1,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return index == 0  ? Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      TitleExtraSmallTextWidget(
                        title: 'Product',
                        color: Colors.grey.shade500,
                      ),
                      TitleExtraSmallTextWidget(
                          title: 'Last Price', color: Colors.grey.shade500),
                      TitleExtraSmallTextWidget(
                          title: 'Avg Price', color: Colors.grey.shade500),
                    ],
                  ),
                ) :MarketTrendItems(
                  index: index-1,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
