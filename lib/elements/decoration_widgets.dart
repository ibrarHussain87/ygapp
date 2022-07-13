
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:yg_app/helper_utils/app_colors.dart';

BoxDecoration myBoxDecoration({double? radius, Color? color, double? width}) {
  return BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(radius ?? 0),
    border: Border.all(
      color: color ?? Colors.grey, //                   <--- border color
      width: width ?? 5.0,
    ),
  );
}

InputDecoration textFormFieldDec(String hintLabel) {
  return InputDecoration(
      labelText: hintLabel,
      labelStyle: TextStyle(fontSize: 12.sp),
      border: UnderlineInputBorder(
          borderSide: BorderSide(color: textColorGrey)));
}

// New decoration design for login
InputDecoration textFormFieldSignIn(String hintLabel,String title) {
  return InputDecoration(
//    labelText: title,

      contentPadding:const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      label: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(title,style: TextStyle(color: formFieldLabel),),
        ],
      ),
      floatingLabelBehavior:FloatingLabelBehavior.always ,
      hintText: hintLabel,
      hintStyle: TextStyle(fontSize: 10.sp,fontWeight: FontWeight.w500,color:hintColorGrey),
      border: OutlineInputBorder(
          borderRadius:const BorderRadius.all(
            Radius.circular(5.0),
          ),
          borderSide: BorderSide(color: signInBorderColor)
      )
  );
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
InputDecoration textFieldDecoration(String hintLabel,String title,bool isMandatory) {
  return InputDecoration(
      contentPadding:const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      label: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(title,style: const TextStyle(color: Colors.black,fontSize: 13),),
          Visibility(visible:isMandatory,child: const Text("*", style: TextStyle(color: Colors.red))),
        ],
      ),
      floatingLabelBehavior:FloatingLabelBehavior.always ,
      hintText: hintLabel,
      hintStyle: TextStyle(fontSize: 13.sp,fontWeight: FontWeight.w500,color:newColorGrey),
      border: OutlineInputBorder(
          borderRadius:const BorderRadius.all(
            Radius.circular(5.0),
          ),
          borderSide: BorderSide(color: newColorGrey)
      )
  );
}

InputDecoration dropDownDecoration(String hintLabel,String title) {
  return InputDecoration(
//    labelText: title,
      contentPadding:const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      label: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(title,style: const TextStyle(color:Colors.black,fontSize: 13),),
          /*const Text("*", style: TextStyle(color: Colors.red)),*/
        ],
      ),
      floatingLabelBehavior:FloatingLabelBehavior.always ,
      hintText: hintLabel,
      hintStyle: TextStyle(fontSize: 10.sp,fontWeight: FontWeight.w500,color:newColorGrey),
      border: OutlineInputBorder(
          borderRadius:const BorderRadius.all(
            Radius.circular(5.0),
          ),
          borderSide: BorderSide(color: newColorGrey)
      )
  );
}


InputDecoration textFormWhatsAppProfile(String hintLabel,String title) {
  return InputDecoration(
//    labelText: title,

      contentPadding:const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      label: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(title,style: const TextStyle(color: Colors.black,fontSize: 13),),
          /*const Text("*", style: TextStyle(color: Colors.red)),*/
        ],
      ),
      floatingLabelBehavior:FloatingLabelBehavior.always ,
      prefixText: hintLabel,
      prefixStyle: TextStyle(fontSize: 13.sp,fontWeight: FontWeight.w500,color: Colors.black87),

      border: OutlineInputBorder(
          borderRadius:const BorderRadius.all(
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
      borderRadius: const BorderRadius.all(Radius.circular(20)),
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

// created by (asad_m)

InputDecoration ygTextFieldDecoration(String hintLabel,String title,bool mandatoryField) {
  return InputDecoration(
      hintStyle: TextStyle(fontSize: 11.sp,),
      filled: true,
      fillColor: Colors.white,
      isDense: true,
      counterText: "",
      contentPadding: EdgeInsets.only(left: 16.w, right: 16.w,top: 12.w,bottom: 12.w),
      label: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(title,style:TextStyle(
              color: Colors.black87,
              fontSize: 14.sp,
              /**/
              fontWeight: FontWeight.w500),),
           Text(mandatoryField ? "*" : "", style: TextStyle(color: Colors.red, fontSize: 16.sp,
            /**/
               fontWeight: FontWeight.w500)),
        ],
      ),
      floatingLabelBehavior:FloatingLabelBehavior.always ,
      hintText: hintLabel,
//      hintStyle: TextStyle(fontSize: 10.sp,fontWeight: FontWeight.w500,color:hintColorGrey),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5.0.w),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5.0.w),
        borderSide: BorderSide(color: lightBlueTabs),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5.0.w),
        borderSide: const BorderSide(color: Colors.red),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5.0.w),
        borderSide: const BorderSide(color: Colors.red),
      ),
      disabledBorder:OutlineInputBorder(
        borderRadius: BorderRadius.circular(5.0.w),
        borderSide: BorderSide(color: Colors.grey.shade300),
      )
  );
}

/////////////////////

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
      borderSide: const BorderSide(color: Colors.red),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(24.0.w),
      borderSide: const BorderSide(color: Colors.red),
    ),
    disabledBorder:OutlineInputBorder(
      borderRadius: BorderRadius.circular(24.0.w),
      borderSide: BorderSide(color: Colors.grey.shade300),
    )
  );
}

InputDecoration customCornerDecoration(String hint,double corners) {
  return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(fontSize: 11.sp,),
      filled: true,
      fillColor: Colors.white,
      contentPadding: EdgeInsets.only(left: 16.w, right: 16.w,top: 12.w,bottom: 12.w),
      isDense: true,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(corners.w),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(corners.w),
        borderSide: BorderSide(color: lightBlueTabs),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(corners.w),
        borderSide: const BorderSide(color: Colors.red),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(corners.w),
        borderSide: const BorderSide(color: Colors.red),
      ),
      disabledBorder:OutlineInputBorder(
        borderRadius: BorderRadius.circular(corners.w),
        borderSide: BorderSide(color: Colors.grey.shade300),
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
      borderSide: const BorderSide(color: Colors.red),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(24.0.w),
      borderSide: const BorderSide(color: Colors.red),
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
        borderSide: const BorderSide(color: Colors.red),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(24.0.w),
        borderSide: const BorderSide(color: Colors.red),
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
        borderSide: const BorderSide(color: Colors.red),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4.0.w),
        borderSide: const BorderSide(color: Colors.red),
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
        borderSide: const BorderSide(color: Colors.red),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4.0.w),
        borderSide: const BorderSide(color: Colors.red),
      )
  );
}
