
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/helper_utils/app_colors.dart';

class BgLightBlueNormalTextWidget extends StatelessWidget {
  final String title;
  final Color? color;

  const BgLightBlueNormalTextWidget({
    Key? key,
    required this.title,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: tileGreyClr,
          borderRadius: BorderRadius.all(Radius.circular(2.w))),
      child: Padding(
        padding: EdgeInsets.only(left: 4.w, right: 4.w, top: 5.w, bottom: 4.w),
        child: Center(
          child: Text(
            title,
            overflow: TextOverflow.fade,
            maxLines: 1,
            softWrap: false,
            style: TextStyle(
                fontSize: 9.sp,
                color: color ?? Colors.black,
                fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
