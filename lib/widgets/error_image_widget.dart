import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ErrorImageWidget extends StatelessWidget {
  const ErrorImageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.asset(
          'images/image_not_available.png',
          height: 48.w,
          width: 48.w,
          fit: BoxFit.fill),
    );
  }
}
