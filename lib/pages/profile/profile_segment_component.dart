import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/helper_utils/app_colors.dart';
import 'package:yg_app/helper_utils/app_constants.dart';
import 'package:yg_app/pages/profile/update_profile/profile_brands_info.dart';
import 'package:yg_app/pages/profile/update_profile/profile_business_info.dart';
import 'package:yg_app/pages/profile/update_profile/profile_personal_info.dart';

class ProfileSegmentComponent extends StatefulWidget {
  final Function? stepsCallback;
  final Map<int, String>? stepsMapping;
  final String? selectedTab;

  const ProfileSegmentComponent(
      {Key? key,
      required this.stepsCallback,
      required this.selectedTab,
      this.stepsMapping})
      : super(key: key);

  @override
  ProfileSegmentComponentState createState() => ProfileSegmentComponentState();
}

class ProfileSegmentComponentState extends State<ProfileSegmentComponent> {
  int selectedValue = 1;
  late PageController _pageController;
  late List<Widget> _samplePages;

  final GlobalKey<ProfilePersonalInfoPageState> _personalInfoState =
      GlobalKey<ProfilePersonalInfoPageState>();
  final GlobalKey<ProfileBusinessInfoPageState> _businessInfoKey =
      GlobalKey<ProfileBusinessInfoPageState>();
  final GlobalKey<ProfileBrandsInfoPageState> _brandsState =
      GlobalKey<ProfileBrandsInfoPageState>();

  @override
  void initState() {
    _pageController = PageController();

    _samplePages = [
      ProfilePersonalInfoPage(
        key: _personalInfoState,
        selectedTab: widget.selectedTab,
        callback: (value) {
          setState(() {
            selectedValue++;
          });
          widget.stepsCallback!(value);
          _pageController.animateToPage(selectedValue - 1,
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut);
        },
      ),
      ProfileBusinessInfoPage(
        key: _businessInfoKey,
        selectedTab: widget.selectedTab,
        callback: (value) {
          setState(() {
            selectedValue++;
          });
          widget.stepsCallback!(value);
          _pageController.animateToPage(selectedValue - 1,
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut);
        },
      ),
      ProfileBrandsInfoPage(
        key: _brandsState,
        selectedTab: widget.selectedTab,
        callback: (value) {
          setState(() {
            selectedValue++;
          });
          widget.stepsCallback!(value);
          _pageController.animateToPage(selectedValue - 1,
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut);
        },
      ),
    ];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: tabBackground),
                padding: const EdgeInsets.all(0),
                child: Padding(
                  padding: const EdgeInsets.all(7),
                  child: CustomSlidingSegmentedControl<int>(
                    initialValue: selectedValue,
                    children: {
                      1: Container(
                        height: 45,
                        /*width: width*0.23,*/
                        padding: EdgeInsets.all(5.w),
                        child: Center(
                          child: Text(
                            "Personal Info",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: selectedValue == 1
                                  ? Colors.white
                                  : textColorGrey,
                            ),
                          ),
                        ),
                      ),
                      2: Container(
                        height: 45,
                        /*width: width*0.23,*/
                        padding: EdgeInsets.all(5.w),
                        child: Center(
                          child: Text(
                            "Business Info",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: selectedValue == 2
                                  ? Colors.white
                                  : textColorGrey,
                            ),
                          ),
                        ),
                      ),
                      3: Container(
                        width: /*width*0.23*/ width / 5,
                        height: 45,
                        padding: EdgeInsets.all(5.w),
                        child: Center(
                          child: Text(
                            "Brands",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: selectedValue == 3
                                  ? Colors.white
                                  : textColorGrey,
                            ),
                          ),
                        ),
                      ),
                    },
                    decoration: BoxDecoration(
                      color: tabBackground,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    thumbDecoration: BoxDecoration(
                      /*color: lightBlueTabs,*/
                      gradient:LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.bottomRight,
                          colors: <Color>[appBarColor2,appBarColor1]),
                      borderRadius: BorderRadius.circular(5),
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
                      switch (value) {
                        case 1:
                          if (selectedValue == 3) {
                            if (_brandsState.currentState != null) {
                              _moveToNextPage(value);
                            }
                          }

                          if (selectedValue == 2) {
                            if (_businessInfoKey.currentState != null) {
                              _moveToNextPage(value);
                            }
                          }
                          break;
                        case 2:
                          if (selectedValue == 1) {
                            if (_personalInfoState.currentState != null) {
                              _personalInfoState.currentState!
                                  .handleNextClick();
                            }
                          }

                          if (selectedValue == 3) {
                            if (_brandsState.currentState != null) {
                              _moveToNextPage(value);
                            }
                          }
                          break;

                        case 3:
                          if (selectedValue == 2) {
                            if (_businessInfoKey.currentState != null) {
                              _businessInfoKey.currentState!.handleNextClick();
                            }
                          }
                          if (selectedValue == 1) {
                            if (_personalInfoState.currentState != null) {
//                   _businessInfoKey.currentState!.handleNextClick();
                              _moveToNextPage(value);
                            }
                          }
                      }
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
        Expanded(
          child: PageView.builder(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _samplePages.length,
            itemBuilder: (BuildContext context, int index) {
              return _samplePages[index % _samplePages.length];
            },
          ),
        )
      ],
    );
  }

  _moveToNextPage(value) {
    setState(() {
      selectedValue = value as int;
    });
    widget.stepsCallback!(value);
    _pageController.animateToPage(selectedValue - 1,
        duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
  }
}
