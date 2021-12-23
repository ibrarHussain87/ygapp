import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/pages/fliter_pages/fiber_filter_view.dart';
import 'package:yg_app/utils/colors.dart';
import 'package:yg_app/utils/strings.dart';

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
      padding: EdgeInsets.only(top: 4.w, right: 4.w),
      child: Row(
        children: [
          Expanded(
            child: CupertinoSegmentedControl(
              borderColor: Colors.grey.shade300,
              selectedColor: AppColors.lightBlueTabs,
              pressedColor: Colors.transparent,
              groupValue: selectedValue,
              children: {
                1: Container(
                  padding: EdgeInsets.all(8.w),
                  child: Text(
                    AppStrings.offering,
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: selectedValue == 1
                          ? Colors.white
                          : AppColors.textColorGrey,
                    ),
                  ),
                ),
                2: Container(
                  padding: EdgeInsets.all(8.w),
                  child: Text(
                    AppStrings.requirement,
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: selectedValue == 2
                          ? Colors.white
                          : AppColors.textColorGrey,
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
          ),
        ],
      ),
    );
  }
}
