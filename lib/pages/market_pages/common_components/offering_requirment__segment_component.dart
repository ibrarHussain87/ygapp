import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
      color: Colors.white,
      padding: EdgeInsets.only(top: 4.w,left: 10),
      child: CupertinoSegmentedControl(
        borderColor: Colors.grey.shade300,
        selectedColor: darkBlueChip,
        pressedColor: Colors.transparent,
        groupValue: selectedValue,
        padding: const EdgeInsets.all(0),
        children: {
          1: Container(
            padding: EdgeInsets.all(10.w),
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
          2: Container(
            padding: EdgeInsets.all(10.w),
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
