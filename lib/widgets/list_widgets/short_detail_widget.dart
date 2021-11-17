import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/utils/colors.dart';

class ShortDetailWidget extends StatefulWidget {

  String? title;

  ShortDetailWidget({Key? key,required this.title}) : super(key: key);

  @override
  _ShortDetailWidgetState createState() => _ShortDetailWidgetState();
}

class _ShortDetailWidgetState extends State<ShortDetailWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 4.w,right: 8.w,bottom: 4.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'images/ic_weight.png',
            width: 9.w,
            height: 9.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 4.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Visibility(
                  child: Text(
                    'Weight per Bag',
                    style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.normal,
                        color:
                        AppColors.textColorGreyLight),
                  ),
                  visible: false,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    widget.title??"N/A",
                    style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.black),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
