import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/utils/colors.dart';

InputDecoration textFormFieldDec(String hintLabel) {
  return InputDecoration(
      labelText: hintLabel,
      labelStyle: TextStyle(
          fontSize: 12.sp
      ),

      border: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.textColorGrey)));
}


BoxDecoration getOfferingDec(Color lightBlueTabs){
  return BoxDecoration(
      color: lightBlueTabs,
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(6.w),
          bottomLeft: Radius.circular(6.w)));
}

BoxDecoration getRequirementDec(Color lightBlueTabs){
  return BoxDecoration(
      color: lightBlueTabs,
      borderRadius: BorderRadius.only(
          topRight: Radius.circular(6.w),
          bottomRight: Radius.circular(6.w)));
}