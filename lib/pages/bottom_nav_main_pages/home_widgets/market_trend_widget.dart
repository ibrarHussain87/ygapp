import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/list_items_widgets/market_trends_item.dart';
import 'package:yg_app/utils/colors.dart';
import 'package:yg_app/utils/strings.dart';
import 'package:yg_app/widgets/title_text_widget.dart';

class MarketTrendWidget extends StatefulWidget {
  const MarketTrendWidget({Key? key}) : super(key: key);

  @override
  _MarketTrendWidgetState createState() => _MarketTrendWidgetState();
}

class _MarketTrendWidgetState extends State<MarketTrendWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleTextWidget(title: AppStrings.marketTrends),
        SizedBox(
          height: 8.w,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(child: TitleExtraSmallTextWidget(title: 'Product',color: Colors.grey.shade500,),flex: 2,),
            Expanded(child: TitleExtraSmallTextWidget(title: 'Last Price',color: Colors.grey.shade500),flex: 1,),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TitleExtraSmallTextWidget(title: 'Avg price',color: Colors.grey.shade500),flex: 1,),

                ],
              ),
              flex: 1,
            ),
          ],
        ),
        Expanded(
          child: ListView.builder(
            itemCount: 30,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return MarketTrendItems(index: index,);
            },
          ),
        ),
      ],
    );
  }
}
