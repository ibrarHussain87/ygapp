import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:yg_app/helper_utils/app_colors.dart';

InputDecoration textFormFieldDec(String hintLabel) {
  return InputDecoration(
      labelText: hintLabel,
      labelStyle: TextStyle(fontSize: 12.sp),
      border: UnderlineInputBorder(
          borderSide: BorderSide(color: textColorGrey)));
}

InputDecoration textFormFieldDecSignup(String hintLabel,String assetName) {
  return InputDecoration(
      hintText: "Enter Here",
      hintStyle: TextStyle(fontSize: 10.sp,fontWeight: FontWeight.w400,color: Colors.black87),
      prefixIcon: IconButton(
        padding: EdgeInsets.all(0.w),
        onPressed: (){

        },
        icon: SvgPicture.asset(
          assetName,
          color: iconColor,
            fit: BoxFit.cover,
            height: 16,
          width: 16,
        ),
      ),
      border: UnderlineInputBorder(
          borderSide: BorderSide(color: textColorGrey)));
}

InputDecoration textFormFieldDecProfile(String hintLabel,String assetName) {
  return InputDecoration(
      hintText: hintLabel,
      hintStyle: TextStyle(fontSize: 10.sp,fontWeight: FontWeight.w400,color: Colors.black87),
      prefixIcon: IconButton(
        padding: EdgeInsets.all(0.w),
        onPressed: (){

        },
        icon: SvgPicture.asset(
          assetName,
          color: iconColor,
          fit: BoxFit.cover,
          height: 16,
          width: 16,
        ),
      ),
      border: UnderlineInputBorder(
          borderSide: BorderSide(color: textColorGrey)));
}

//////////Edit profile
InputDecoration textFieldProfile(String hintLabel,String title) {
  return InputDecoration(
//    labelText: title,

      contentPadding:const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      label: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(title,style: TextStyle(color: formFieldLabel),),
          const Text("*", style: TextStyle(color: Colors.red)),
        ],
      ),
      floatingLabelBehavior:FloatingLabelBehavior.always ,
      hintText: hintLabel,
      hintStyle: TextStyle(fontSize: 10.sp,fontWeight: FontWeight.w500,color:hintColorGrey),
//      prefixIcon: IconButton(
//        padding: EdgeInsets.all(0.w),
//        onPressed: (){
//
//        },
//        icon: SvgPicture.asset(
//          assetName,
//          color: iconColor,
//          fit: BoxFit.cover,
//          height: 16,
//          width: 16,
//        ),
//      ),
      border: OutlineInputBorder(
          borderRadius:BorderRadius.all(
            Radius.circular(5.0),
          ),
          borderSide: BorderSide(color: newColorGrey)));
}

InputDecoration dropDownProfile(String hintLabel,String title) {
  return InputDecoration(
//    labelText: title,
      contentPadding:const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      label: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(title,style: TextStyle(color: formFieldLabel),),
          const Text("*", style: TextStyle(color: Colors.red)),
        ],
      ),
      floatingLabelBehavior:FloatingLabelBehavior.always ,
      hintText: hintLabel,
      hintStyle: TextStyle(fontSize: 10.sp,fontWeight: FontWeight.w500,color:hintColorGrey),

      border: OutlineInputBorder(
          borderRadius:BorderRadius.all(
            Radius.circular(5.0),
          ),
          borderSide: BorderSide(color: newColorGrey)));
}


InputDecoration textFormWhatsAppProfile(String hintLabel,String title) {
  return InputDecoration(
//    labelText: title,

      contentPadding:const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      label: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(title,style: TextStyle(color: formFieldLabel),),
          const Text("*", style: TextStyle(color: Colors.red)),
        ],
      ),
      floatingLabelBehavior:FloatingLabelBehavior.always ,
      prefixText: hintLabel,
      prefixStyle: TextStyle(fontSize: 10.sp,fontWeight: FontWeight.w500,color: Colors.black87),

      border: OutlineInputBorder(
          borderRadius:BorderRadius.all(
            Radius.circular(5.0),
          ),
          borderSide: BorderSide(color: newColorGrey)));
}

//////////////////////////

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
        color: textColorBlue,
        width: 3,
      ));
}

OutlineInputBorder myfocusborder() {
  return OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(24.w)),
      borderSide: BorderSide(
        color: textColorBlue,
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
      borderSide: BorderSide(color: lightBlueTabs),
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
      borderSide: BorderSide(color: lightBlueTabs),
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
        borderSide: BorderSide(color: lightBlueTabs),
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
InputDecoration borderDecoration(String hint) {
  return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(fontSize: 11.sp,),
      filled: true,
      fillColor: Colors.white,
      // contentPadding: EdgeInsets.only(left: 16.w, right: 16.w,top: 12.w,bottom: 12.w),
      isDense: true,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4.0.w),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4.0.w),
        borderSide: BorderSide(color: lightBlueTabs),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4.0.w),
        borderSide: BorderSide(color: Colors.red),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4.0.w),
        borderSide: BorderSide(color: Colors.red),
      )
  );
}

InputDecoration roundedDescriptionDecorationUpdated(String hint) {
  return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(fontSize: 11.sp,),
      filled: true,
      fillColor: Colors.white,
      // contentPadding: EdgeInsets.only(left: 16.w, right: 16.w,top: 12.w,bottom: 12.w),
      isDense: true,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4.0.w),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4.0.w),
        borderSide: BorderSide(color: lightBlueTabs),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4.0.w),
        borderSide: BorderSide(color: Colors.red),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4.0.w),
        borderSide: BorderSide(color: Colors.red),
      )
  );
}
