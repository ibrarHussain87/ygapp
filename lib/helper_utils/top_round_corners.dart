import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

BoxDecoration getRoundedTopCorners(){
  return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(topLeft:Radius.circular(14.w),topRight:Radius.circular(14.w) )
  );
}