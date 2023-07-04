import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/elements/text_widgets.dart';
import 'package:yg_app/helper_utils/app_colors.dart';

class MarketStockWidget extends StatefulWidget {
  const MarketStockWidget({Key? key}) : super(key: key);

  @override
  _MarketStockWidgetState createState() => _MarketStockWidgetState();
}

class _MarketStockWidgetState extends State<MarketStockWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 8.w),
        height: 0.057 * MediaQuery.of(context).size.height,
        child: Center(
          child: ListView.builder(
            itemCount: 3,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(left:12.w,right: 12.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'US Cotton',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              ),
                        ),
                        SizedBox(
                          width: 1.w,
                        ),
                        Text(
                          '+7.87%',
                          textAlign: TextAlign.end,
                          style: TextStyle(
                              color: redClr,
                              fontSize: 9.sp,
                              ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top:4.0.w),
                      child: const TitleTextWidget(title: '425.31',color: Colors.red,),
                    )
                  ],
                ),
              );
            },
          ),
        ));
  }
}
