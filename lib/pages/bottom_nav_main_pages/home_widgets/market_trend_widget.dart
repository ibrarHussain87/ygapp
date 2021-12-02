import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    return Container(
      padding: EdgeInsets.only(left:16.w,top: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleTextWidget(title: AppStrings.marketTrends),
          SizedBox(
            height: 8.w,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.all(4.w),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: TitleSmallTextWidget(title: '20/S CDD YARN COTTOM PP'),flex: 2,),
                      TitleSmallTextWidget(title: "\$ 425.21"),
                      SizedBox(width: 8.w,),
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              flex:1,
                              child: Text('\$120.98', style: TextStyle(
                                  color: Colors.black, fontSize: 12.sp),),
                            ),
                            SizedBox(width: 1.w,),
                            Expanded(
                              child: Text('+7.87 %', style: TextStyle(
                                  color: AppColors.redClr, fontSize: 9.sp),),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
