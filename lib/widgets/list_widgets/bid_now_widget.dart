import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/utils/colors.dart';

class BidNowWidget extends StatelessWidget {

  String title;

  BidNowWidget({Key? key,required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.btnGreen,
          borderRadius:
          BorderRadius.all(Radius.circular(2.w))),
      child: Padding(
        padding: EdgeInsets.only(top: 3.w,bottom: 3.w),
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
