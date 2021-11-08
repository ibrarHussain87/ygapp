import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/utils/colors.dart';

class StepsSegmentWidget extends StatefulWidget {

  Function? stepsCallback;
  Map<int, String>? stepsMapping;

  StepsSegmentWidget(
      {Key? key, required this.stepsCallback, required this.stepsMapping})
      : super(key: key);

  @override
  _StepsSegmentWidgetState createState() => _StepsSegmentWidgetState();
}

class _StepsSegmentWidgetState extends State<StepsSegmentWidget> {
  String? selectedValue = "1";

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CupertinoSegmentedControl(
        borderColor: AppColors.textColorGreyLight,
        selectedColor: AppColors.lightBlueTabs,
        groupValue: selectedValue,
        pressedColor: AppColors.lightBlueTabs,
        children: {
          "1": Container(

            padding: EdgeInsets.all(8),
            child: Text(
              "Step 1",
              style: TextStyle(
                fontSize: 11.sp,
                color: selectedValue == "1" ? Colors.white : AppColors
                    .lightBlueTabs,

              ),
            ),
          ),
          "2": Container(

            padding: EdgeInsets.all(8),
            child: Text(
              "Step 2",
              style: TextStyle(
                fontSize: 11.sp,
                color: selectedValue == "2" ? Colors.white : AppColors
                    .lightBlueTabs,

              ),
            ),
          ),
          "3": Container(
            padding: EdgeInsets.all(8),
            child: Text(
              "Step 3",
              style: TextStyle(
                fontSize: 11.sp,
                color: selectedValue == "3" ? Colors.white : AppColors
                    .lightBlueTabs,

              ),
            ),
          ),
        },
        onValueChanged: (value) {
          setState(() {
            selectedValue = value as String?;
          });
          widget.stepsCallback!(value);
          print(value);
        },
      ),
    );
  }

}
