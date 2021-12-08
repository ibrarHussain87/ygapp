import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/utils/colors.dart';

InputDecoration textFormFieldDec(String hintLabel) {
  return InputDecoration(
      labelText: hintLabel,
      labelStyle: TextStyle(fontSize: 12.sp),
      border: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.textColorGrey)));
}

BoxDecoration getOfferingDec(Color lightBlueTabs) {
  return BoxDecoration(
      color: lightBlueTabs,
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(6.w), bottomLeft: Radius.circular(6.w)));
}

BoxDecoration getRequirementDec(Color lightBlueTabs) {
  return BoxDecoration(
      color: lightBlueTabs,
      borderRadius: BorderRadius.only(
          topRight: Radius.circular(6.w), bottomRight: Radius.circular(6.w)));
}

OutlineInputBorder myinputborder() {
  //return type is OutlineInputBorder
  return OutlineInputBorder(
      //Outline border type for TextFeild
      borderRadius: BorderRadius.all(Radius.circular(20)),
      borderSide: BorderSide(
        color: AppColors.textColorBlue,
        width: 3,
      ));
}

OutlineInputBorder myfocusborder() {
  return OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(24.w)),
      borderSide: BorderSide(
        color: AppColors.textColorBlue,
        width: 3,
      ));
}

InputDecoration roundedTextFieldDecoration(String hint) {
  return InputDecoration(
    hintText: hint,
    hintStyle: TextStyle(fontSize: 11.sp,),
    filled: true,
    fillColor: Colors.white,
    contentPadding: EdgeInsets.only(left: 16.w, right: 16.w,top: 12.w,bottom: 12.w),
    isDense: true,
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(24.0.w),
      borderSide: BorderSide(color: Colors.grey.shade300),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(24.0.w),
      borderSide: BorderSide(color: AppColors.lightBlueTabs),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(24.0.w),
      borderSide: BorderSide(color: Colors.red),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(24.0.w),
      borderSide: BorderSide(color: Colors.red),
    )
  );
}

InputDecoration roundedTFDGrey(String hint) {
  return InputDecoration(
    hintText: hint,
    hintStyle: TextStyle(fontSize: 11.sp,),
    filled: true,
    fillColor: Colors.white,
    contentPadding: EdgeInsets.only(left: 16.w, right: 16.w,top: 12.w,bottom: 12.w),
    isDense: true,
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(24.0.w),
      borderSide: BorderSide(color: Colors.grey.shade300),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(24.0.w),
      borderSide: BorderSide(color: AppColors.lightBlueTabs),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(24.0.w),
      borderSide: BorderSide(color: Colors.red),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(24.0.w),
      borderSide: BorderSide(color: Colors.red),
    )
  );
}

InputDecoration roundedDescriptionDecoration(String hint) {
  return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(fontSize: 11.sp,),
      filled: true,
      fillColor: Colors.white,
      // contentPadding: EdgeInsets.only(left: 16.w, right: 16.w,top: 12.w,bottom: 12.w),
      isDense: true,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(24.0.w),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(24.0.w),
        borderSide: BorderSide(color: AppColors.lightBlueTabs),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(24.0.w),
        borderSide: BorderSide(color: Colors.red),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(24.0.w),
        borderSide: BorderSide(color: Colors.red),
      )
  );
}
