import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImageLoadingWidget extends StatelessWidget {
  const ImageLoadingWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.asset('images/loading.gif',
          height: 56.w, width: 48.w, fit: BoxFit.fill),
    );
  }
}
