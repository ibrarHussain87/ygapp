import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/model/request/post_ad_request/fiber_request.dart';
import 'package:yg_app/model/response/fiber_response/sync/fiber_sync_response/sync_fiber_response.dart';
import 'package:yg_app/pages/post_ad_pages/packing_details_component.dart';
import 'package:yg_app/utils/colors.dart';

import 'fiber_specification_component.dart';

class FiberStepsSegments extends StatefulWidget {

  final Function? stepsCallback;
  final Map<int, String>? stepsMapping;
  final SyncFiberResponse syncFiberResponse;
  final String? locality;
  final String? businessArea;
  final String? selectedTab;

  const FiberStepsSegments({Key? key,
    required this.syncFiberResponse,
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
  late SyncFiberResponse _syncFiberResponse;

  @override
  void initState() {
    _syncFiberResponse = widget.syncFiberResponse;
    _pageController = PageController();

    _samplePages = [
      FiberSpecificationComponent(
        syncFiberResponse: widget.syncFiberResponse,
        locality: widget.locality,
        businessArea: widget.businessArea,
        selectedTab: widget.selectedTab,
        callback: (value) {
          setState(() {
            selectedValue++;
          });
          widget.stepsCallback!(value);
          _pageController.animateToPage(selectedValue - 1,
              duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
        },
      ),
      PackagingDetails(
        // requestModel: _fiberRequestModel,
          locality: widget.locality,
          businessArea: widget.businessArea,
          selectedTab: widget.selectedTab,
          syncFiberResponse: widget.syncFiberResponse),
    ];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Expanded(
              child: CupertinoSegmentedControl(
                borderColor: Colors.black38,
                selectedColor: AppColors.lightBlueTabs,
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
                            : AppColors.textColorGrey,
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
                            : AppColors.textColorGrey,
                      ),
                    ),
                  ),
                },
                onValueChanged: (value) {
                  setState(() {
                    selectedValue = value as int;
                  });
                  widget.stepsCallback!(value);
                  _pageController.animateToPage(selectedValue - 1,
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeInOut);
                },
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
        ),
      ],
    );
  }
}
