import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/elements/text_widgets.dart';
import 'package:yg_app/helper_utils/app_colors.dart';

class MarketTrendItems extends StatefulWidget {
  final int? index;

  const MarketTrendItems({Key? key, required this.index}) : super(key: key);

  @override
  _MarketTrendItemsState createState() => _MarketTrendItemsState();
}

class _MarketTrendItemsState extends State<MarketTrendItems> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.index!.isEven ? Colors.grey.shade100 : Colors.white,
      padding: EdgeInsets.all(8.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text.rich(
              TextSpan(
                  children: [
                    TextSpan(
                      text: "Cotton ",
                      style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600, fontFamily: "Metropolis"),
                    ),
                    TextSpan(
                      text: "/PP",
                      style: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w400, fontFamily: "Metropolis",color: Colors.grey.shade700),
                    ),
                  ]
              )
          ),
          Text(
            "\$425.21",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11.sp,
                fontWeight: FontWeight.w500, fontFamily: "Metropolis"),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              const TitleSmallTextWidget(
                title: '\$120.98',
              ),
              SizedBox(
                width: 1.w,
              ),
              Text(
                ' +7.87 %',
                style: TextStyle(color: redClr, fontSize: 9.sp),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
