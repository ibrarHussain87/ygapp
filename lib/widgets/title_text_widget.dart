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
          fontSize: 14.sp,
          fontFamily: 'Metropolis',
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
            fontFamily: 'Metropolis',
            fontWeight: FontWeight.w500),
      ),
    );
  }

}

class TitleExtraSmallTextWidget extends StatelessWidget {

  final String? title;
  final Color? color;

  const TitleExtraSmallTextWidget({Key? key, required this.title,this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 2.w),
      child: Text(
        title!,
        style: TextStyle(
            color: color ?? Colors.black87,
            fontSize: 9.sp,
            fontFamily: 'Metropolis',
            fontWeight: FontWeight.w500),
      ),
    );
  }

}

class TitleCustomSizeTextWidget extends StatelessWidget {

  final String? title;
  final double? sizeText;

  const TitleCustomSizeTextWidget({Key? key, required this.title,required this.sizeText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 2.w),
      child: Text(
        title!,
        style: TextStyle(
            color: Colors.black87,
            fontSize: sizeText!.sp,
            fontFamily: 'Metropolis',
            fontWeight: FontWeight.w500),
      ),
    );
  }

}