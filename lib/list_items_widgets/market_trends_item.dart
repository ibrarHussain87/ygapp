import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/utils/colors.dart';
import 'package:yg_app/widgets/title_text_widget.dart';

class MarketTrendItems extends StatefulWidget {

  final int? index;

  const MarketTrendItems({Key? key,required this.index}) : super(key: key);

  @override
  _MarketTrendItemsState createState() => _MarketTrendItemsState();
}

class _MarketTrendItemsState extends State<MarketTrendItems> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.index!.isEven ? Colors.grey.shade300 : Colors.white,
      padding: EdgeInsets.all(4.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          const Expanded(child: TitleExtraSmallTextWidget(title: '20/S CDD YARN COTTON PP'),flex: 2,),
          const Expanded(child: TitleExtraSmallTextWidget(title: "\$ 425.21"),flex: 1,),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.max,
              children: [
                const Expanded(
                  child: TitleExtraSmallTextWidget(title: '\$120.98',),flex: 1,),
                SizedBox(width: 1.w,),
                Expanded(
                  child: Text('+7.87 %', style: TextStyle(
                      color: AppColors.redClr, fontSize: 7.sp),),
                ),
              ],
            ),
            flex: 1,
          ),
        ],
      ),
    );
  }
}
