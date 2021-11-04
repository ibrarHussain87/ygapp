import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yg_app/utils/colors.dart';

InputDecoration textFormFieldDec(String hintLabel) {
  return InputDecoration(
      labelText: hintLabel,
      // hintText: hintLabel,
      // hintStyle: TextStyle(fontSize: 12.0, color: AppColors.textColorGrey),
      border: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.textColorGrey)));
}


BoxDecoration getOfferingDec(Color lightBlueTabs){
  return BoxDecoration(
      color: lightBlueTabs,
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(6),
          bottomLeft: Radius.circular(6)));
}

BoxDecoration getRequirementDec(Color lightBlueTabs){
  return BoxDecoration(
      color: lightBlueTabs,
      borderRadius: BorderRadius.only(
          topRight: Radius.circular(6),
          bottomRight: Radius.circular(6)));
}