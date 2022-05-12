import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/model/response/fiber_response/sync/sync_fiber_response.dart';
import 'package:yg_app/pages/post_ad_pages/packing_details_component.dart';
import 'package:yg_app/helper_utils/app_colors.dart';
import 'package:yg_app/pages/post_ad_pages/yarn_post/component/lab_parameter_body.dart';

import '../../../../helper_utils/app_constants.dart';
import 'fiber_specification_component.dart';

class FiberStepsSegments extends StatefulWidget {
  final Function? stepsCallback;
  final Map<int, String>? stepsMapping;
  // final SyncFiberResponse syncFiberResponse;
  final String? locality;
  final String? businessArea;
  final String? selectedTab;

  const FiberStepsSegments(
      {Key? key,
        // required this.syncFiberResponse,
        required this.stepsCallback,
        required this.locality,
        required this.businessArea,
        required this.selectedTab,
        this.stepsMapping})
      : super(key: key);

  @override
  _FiberStepsSegmentsState createState() => _FiberStepsSegmentsState();
}

class _FiberStepsSegmentsState extends State<FiberStepsSegments> {
  int selectedValue = 1;
  late PageController _pageController;
  late List<Widget> _samplePages;

  final GlobalKey<FiberSpecificationComponentState> _fiberSpecificationState = GlobalKey<FiberSpecificationComponentState>();
  final GlobalKey<PackagingDetailsState> _packingStateKey = GlobalKey<PackagingDetailsState>();
  final GlobalKey<LabParameterPageState> _labParameterState = GlobalKey<LabParameterPageState>();


  @override
  void initState() {
    _pageController = PageController();
    _samplePages = [
      FiberSpecificationComponent(
        key: _fiberSpecificationState,
        locality: widget.locality,
        businessArea: widget.businessArea,
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
      PackagingDetails(
        key: _packingStateKey,
        locality: widget.locality,
        businessArea: widget.businessArea,
        selectedTab: widget.selectedTab,
      ),
    ];

    super.initState();


  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Visibility(
          visible: widget.selectedTab == offering_type,
          child: Row(
            children: [
              Expanded(
                child: CupertinoSegmentedControl(
                  borderColor: Colors.grey.shade300,
                  selectedColor: darkBlueChip,
                  pressedColor: Colors.transparent,
                  groupValue: selectedValue,
                  children: {
                    1: Container(
                      padding: EdgeInsets.all(8.w),
                      child: Text(
                        "Step 1",
                        style: TextStyle(
                          fontSize: 11.sp,
                          color: selectedValue == 1
                              ? Colors.white
                              : textColorGrey,
                        ),
                      ),
                    ),
                    2: Container(
                      padding: EdgeInsets.all(8.w),
                      child: Text(
                        "Step 2",
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
                    switch (value) {
                      case 1:
                        if (selectedValue == 2) {
                          if (_packingStateKey.currentState != null &&
                              _packingStateKey.currentState!
                                  .validateAndSave()) {
                            _moveToNextPage(value);
                          }
                        }
                        break;
                      case 2:
                        if (selectedValue == 1) {
                          if(_fiberSpecificationState.currentState != null){
                            _fiberSpecificationState.currentState!.handleNextClick();
                          }
                        }
                        break;
                    }
                  },
                ),
              ),
            ],
          ),
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
        ),
      ],
    );
  }

  _moveToNextPage(value){
    setState(() {
      selectedValue = value as int;
    });
    widget.stepsCallback!(value);
    _pageController.animateToPage(selectedValue - 1,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut);
  }
}
