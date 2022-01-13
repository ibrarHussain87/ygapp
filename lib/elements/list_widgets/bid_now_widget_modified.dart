import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/helper_utils/app_colors.dart';

class BidNowWidgetModified extends StatelessWidget {

  String title;

  BidNowWidgetModified({Key? key,required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: btnGreen,
          borderRadius:
          BorderRadius.all(Radius.circular(2.w))),
      child: Padding(
        padding: EdgeInsets.only(top: 6.w,bottom: 6.w),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
                fontSize: 11.sp, color: Colors.white,fontWeight: FontWeight.w400),
          ),
        ),
      ),
    );
  }
}
