import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/elements/grey_border_items.dart';
import 'package:yg_app/helper_utils/app_colors.dart';
import 'package:yg_app/helper_utils/app_constants.dart';

class OfferingRequirementSegmentComponent extends StatefulWidget {
  final Function callback;

  const OfferingRequirementSegmentComponent({Key? key, required this.callback})
      : super(key: key);

  @override
  OfferingRequirementSegmentComponentState createState() =>
      OfferingRequirementSegmentComponentState();
}

class OfferingRequirementSegmentComponentState
    extends State<OfferingRequirementSegmentComponent> {
  int selectedValue = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration:myBoxDecoration(radius: 8,color:Colors.grey.shade400,width: 0.5),
      margin: EdgeInsets.symmetric(horizontal: 16.w,vertical: 8.w),
      child: CustomSlidingSegmentedControl(
        initialValue: selectedValue,
        isStretch: true,
        fromMax: true,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        thumbDecoration: BoxDecoration(
          /*color: lightBlueTabs,*/
          gradient:LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.bottomRight,
              colors: <Color>[appBarColor2,appBarColor1]),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.3),
              blurRadius: 4.0,
              spreadRadius: 1.0,
              offset: const Offset(
                0.0,
                2.0,
              ),
            ),
          ],
        ),
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInToLinear,
        children: {
          1: Container(
            /*width: width*0.23,*/
            child: Center(
              child: Text(
                offering,
                style: TextStyle(
                  fontSize: 11.sp,
                  color: selectedValue == 1
                      ? Colors.white
                      : textColorGrey,
                ),
              ),
            ),
          ),
          2: Container(
            /*width: width*0.23,*/
            child: Center(
              child: Text(
                requirement,
                style: TextStyle(
                  fontSize: 11.sp,
                  color: selectedValue == 2
                      ? Colors.white
                      : textColorGrey,
                ),
              ),
            ),
          ),
        },
        onValueChanged: (value) {
          setState(() {
            selectedValue = value as int;
          });
          widget.callback(value == 1 ? 1 : 0);
        },
      ),
    );
  }
}
