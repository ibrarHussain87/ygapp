import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/helper_utils/app_colors.dart';
import 'package:yg_app/helper_utils/app_constants.dart';

class ProfileSegmentComponent extends StatefulWidget {
  final Function callback;

  const ProfileSegmentComponent({Key? key, required this.callback})
      : super(key: key);

  @override
  ProfileSegmentComponentState createState() =>
      ProfileSegmentComponentState();
}

class ProfileSegmentComponentState
    extends State<ProfileSegmentComponent> {
  int selectedValue = 1;

//  Edit profile page State


  @override
  void initState() {

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
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
        children: {
          1: Container(

            padding: EdgeInsets.all(10.w),
            child: Text(
              personal,
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

            padding: EdgeInsets.all(10.w),
            child: Text(
              business,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 11.sp,
                color: selectedValue == 2
                    ? Colors.white
                    : textColorGrey,
              ),
            ),
          ),
          3: Container(
            width: width/5.5,
            padding: EdgeInsets.all(10.w),
            child: Text(
              brands,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 11.sp,
                color: selectedValue == 3
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
          color: lightBlueTabs,
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
//          setState(() {
//            selectedValue = value;
//          });
//          widget.callback(value == 1 ? 1 : 0);
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
