import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../bottom_sheets/spec_bottom_sheet.dart';
import '../title_text_widget.dart';

buildDynamicContainer(BuildContext context,List listOfItems) {
   Container(
    width: double.maxFinite,
    color: Colors.black87,
    child: Row(
      children: [
        Expanded(
          child: Container(
            margin: EdgeInsets.only(left: 0.w, right: 0.w,top: 2.w),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black12),
                borderRadius: const BorderRadius.all(
                    Radius.circular(6))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [

                Padding(
                  padding: EdgeInsets.only(
                      top: 5.w,
                      left: 8.w,
                      bottom: 5.w),
                  child:Padding(
                    padding: EdgeInsets.only(left: 6.w, top: 6, bottom: 6),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TitleMediumTextWidget(
                          title:'Select',
                          color: Colors.black54,
                          weight: FontWeight.normal,
                        )
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    specsSheet(context,(int checkedIndex){

                    } , (value){
                      Navigator.of(context).pop();
                    }, listOfItems,-1);
                  },
                  child: Container(
                    margin: const EdgeInsets.only(
                        top: 5, right: 6, bottom: 4),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.keyboard_arrow_down_outlined,
                      size: 24,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

      ],
    ),
  );
}