import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TitleTextWidget extends StatelessWidget {
  final String? title;

  const TitleTextWidget({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title!,
      style: TextStyle(
          color: Colors.black,
          fontSize: 12.sp,
          fontWeight: FontWeight.bold),
    );
  }
}

class TitleSmallTextWidget extends StatelessWidget {
  final String? title;

  const TitleSmallTextWidget({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 2.w),
      child: Text(
        title!,
        style: TextStyle(
            color: Colors.black87,
            fontSize: 11.sp,
            fontWeight: FontWeight.w500),
      ),
    );
  }
}