import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/helper_utils/app_colors.dart';

class BlendsRatioSegmentComponent extends StatefulWidget {
  final Function callback;

  const BlendsRatioSegmentComponent({Key? key, required this.callback,}) : super(key: key);

  @override
  BlendsRatioSegmentComponentState createState() =>
      BlendsRatioSegmentComponentState();
}

class BlendsRatioSegmentComponentState
    extends State<BlendsRatioSegmentComponent> {
  int selectedValue = 1;

//  Edit profile page State


  @override
  void initState() {

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery.of(context).size.width;
    // double height = MediaQuery.of(context).size.height;
    return Container(
      width: double.infinity,
      height: 38,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: tabBackground
      ),
      padding: const EdgeInsets.all(0),
      child:
      CustomSlidingSegmentedControl<int>(
        initialValue: selectedValue,
        isStretch: true,
        children: {
          1: Container(
            padding: EdgeInsets.all(5.w),
            child: Text(
              'Popular',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 11.sp,
                color: selectedValue == 1
                    ? Colors.white
                    : textColorGrey,
              ),
            ),
          ),
          2: Container(
            padding: EdgeInsets.all(5.w),
            child: Text(
              'Custom',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 11.sp,
                color: selectedValue == 2
                    ? Colors.white
                    : textColorGrey,
              ),
            ),
          ),
        },

        decoration: BoxDecoration(
          color:tabBackground,
          borderRadius: BorderRadius.circular(8),
        ),
        thumbDecoration: BoxDecoration(
          color: darkBlueChip,
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
    onValueChanged: (value) {
          _moveToNextPage(value);
        },
      ),
    );
  }

  _moveToNextPage(value) {
    setState(() {
      selectedValue = value as int;
    });
    widget.callback(value);
  }
}
