import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/utils/colors.dart';

class GreyTextDetailWidget extends StatelessWidget {

  String title;
  String? detail;

  GreyTextDetailWidget({Key? key,required this.title,required this.detail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.tileGreyClr,
          borderRadius: BorderRadius.all(Radius.circular(4.w))),
      child: Padding(
        padding: EdgeInsets.all(6.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'images/ic_weight.png',
              width: 10.w,
              height: 10.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 8.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Visibility(
                    child: Text(
                      title,
                      maxLines: 2,
                      style: TextStyle(
                          fontSize: 9.sp,
                          fontWeight: FontWeight.normal,
                          color:
                          AppColors.textColorGreyLight),
                    ),
                    visible: true,
                  ),
                  Text(
                    detail??"N/A",
                    maxLines: 2,
                    style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.black),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
