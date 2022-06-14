import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/helper_utils/app_colors.dart';

class BidNowWidget extends StatelessWidget {

  final String title;
  final double? size;
  final double? padding;
  final Color? color;

  const BidNowWidget({Key? key,required this.title,this.size,this.padding,this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: color?? greenButtonColor,
          borderRadius:
          BorderRadius.all(Radius.circular(2.w))),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical:3.w,horizontal: padding??3.w),
        child: Center(
          child: FittedBox(
            child: Text(
              title,
              style: TextStyle(
                  fontSize: size??11.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.w400),
            ),
          ),
        ),
      ),
    );
  }
}
