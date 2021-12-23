import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/utils/colors.dart';

class GreyTextWidget extends StatelessWidget {

  final String title;

  const GreyTextWidget({Key? key,required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.tileGreyClr,
          borderRadius: BorderRadius.all(Radius.circular(2.w))),
      child: Padding(
        padding: EdgeInsets.only(
            left: 8.w, right: 8.w, top: 4.w, bottom: 4.w),
        child: Center(
          child: Text.rich( TextSpan(
            children: [
              TextSpan(
                text: title.split(' ')[0],
                style: TextStyle(
                    fontSize: 9.sp, color: Colors.black,
                  fontWeight: FontWeight.bold
                ),
              ),

              TextSpan(
                text:" "+title.split(' ')[1],
                style: TextStyle(
                    fontSize: 9.sp, color: Colors.black),
              ),
            ]
          )),
        ),
      ),
    );
  }
}
