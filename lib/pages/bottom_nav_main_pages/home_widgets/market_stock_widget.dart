import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/utils/colors.dart';
import 'package:yg_app/utils/strings.dart';
import 'package:yg_app/widgets/title_text_widget.dart';

class MarketStockWidget extends StatefulWidget {
  const MarketStockWidget({Key? key}) : super(key: key);

  @override
  _MarketStockWidgetState createState() => _MarketStockWidgetState();
}

class _MarketStockWidgetState extends State<MarketStockWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 48.h,
        padding: EdgeInsets.only(left: 16.w,right: 16.w,top: 8.w,bottom: 8.w),
        color: AppColors.bgWhiteMarketTrend,
        child: ListView.builder(
          itemCount: 3,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.all(4.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [
                      Text('US Cottom', style: TextStyle(
                          color: Colors.black, fontSize: 12.sp),),
                      SizedBox(width: 4.w,),
                      Text('+7.87 %', style: TextStyle(
                          color: AppColors.redClr, fontSize: 9.sp),),
                    ],
                  ),
                  TitleTextWidget(title: '425.31')
                ],
              )
              ,
            );
          },
        ));
  }
}
