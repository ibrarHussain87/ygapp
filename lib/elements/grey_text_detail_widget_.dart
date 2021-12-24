import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/helper_utils/app_colors.dart';

class GreyTextDetailWidget extends StatelessWidget {
  final String title;
  final String? detail;

  const GreyTextDetailWidget(
      {Key? key, required this.title, required this.detail})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: tileGreyClr,
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
                    child: Expanded(
                      child: Text(
                        title,
                        maxLines: 1,
                        style: TextStyle(
                            fontSize: 8.sp,
                            fontWeight: FontWeight.normal,
                            color: textColorGreyLight),
                      ),
                    ),
                    visible: true,
                  ),
                  Expanded(
                    child: Text(
                      detail ?? "N/A",
                      maxLines: 1,
                      style: TextStyle(
                          fontSize: 8.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
                    ),
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
