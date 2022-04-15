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
  late PageController _pageController;
  late List<Widget> _samplePages;

//  Edit profile page State


  @override
  void initState() {
    // TODO: implement initState
    _pageController = PageController();

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
//      color: tabBackground,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: tabBackground
      ),
      padding: EdgeInsets.only(top: 3.w,left: 3.w,right: 3.w,bottom: 3.w),
      child:
//      CupertinoSegmentedControl(
//        borderColor: Colors.grey.shade300,
//        selectedColor: lightBlueTabs,
//        unselectedColor: tabBackground,
//        pressedColor: Colors.transparent,
//        groupValue: selectedValue,
//        padding: const EdgeInsets.all(0),
//        children: {
//          1: Container(
//
//            padding: EdgeInsets.all(10.w),
//            child: Text(
//              personal,
//              style: TextStyle(
//                fontSize: 11.sp,
//                color: selectedValue == 1
//                    ? Colors.white
//                    : textColorGrey,
//              ),
//            ),
//          ),
//          2: Container(
//            padding: EdgeInsets.all(10.w),
//            child: Text(
//              business,
//              style: TextStyle(
//                fontSize: 11.sp,
//                color: selectedValue == 2
//                    ? Colors.white
//                    : textColorGrey,
//              ),
//            ),
//          ),
//          3: Container(
//            padding: EdgeInsets.all(10.w),
//            child: Text(
//              brands,
//              style: TextStyle(
//                fontSize: 11.sp,
//                color: selectedValue == 3
//                    ? Colors.white
//                    : textColorGrey,
//              ),
//            ),
//          ),
//        },
//        onValueChanged: (value) {
//          setState(() {
//            selectedValue = value as int;
//          });
//          widget.callback(value == 1 ? 1 : 0);
//        },
//      ),
      CustomSlidingSegmentedControl<int>(

        initialValue: selectedValue,
        children: {
          1: Container(

            padding: EdgeInsets.all(10.w),
            child: Text(
              personal,
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
              style: TextStyle(
                fontSize: 11.sp,
                color: selectedValue == 2
                    ? Colors.white
                    : textColorGrey,
              ),
            ),
          ),
          3: Container(
            padding: EdgeInsets.all(10.w),
            child: Text(
              brands,
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
    _pageController.animateToPage(selectedValue - 1,
        duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
  }
}
