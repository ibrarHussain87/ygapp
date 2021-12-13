import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/utils/app_images.dart';

class LoadingListing extends StatelessWidget {
  const LoadingListing({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Padding(
            padding: EdgeInsets.only(left: 16.w, right: 16.w),
            child: Image.asset(
              AppImages.loading,
              width: 64.w,
              height: 64.w,
            ));
      },
      itemCount: 4,
      scrollDirection: Axis.horizontal,
    );
  }
}
