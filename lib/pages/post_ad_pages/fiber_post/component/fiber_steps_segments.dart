import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/model/request/login_request/fiber_request.dart';
import 'package:yg_app/model/response/sync/fiber_sync_response/sync_fiber_response.dart';
import 'package:yg_app/pages/post_ad_pages/packing_details_component.dart';
import 'package:yg_app/utils/colors.dart';

import 'fiber_specification_component.dart';

class FiberStepsSagments extends StatefulWidget {

  Function? stepsCallback;
  Map<int, String>? stepsMapping;
  SyncFiberResponse syncFiberResponse;

  FiberStepsSagments(
      {Key? key, required this.syncFiberResponse, required this.stepsCallback})
      : super(key: key);

  @override
  _FiberStepsSagmentsState createState() => _FiberStepsSagmentsState();
}

class _FiberStepsSagmentsState extends State<FiberStepsSagments> {

  int selectedValue = 1;
  late PageController _pageController;
  late List<Widget> _samplePages;
  late SyncFiberResponse _syncFiberResponse;
  FiberRequestModel? _fiberRequestModel;

  @override
  void initState() {

    _syncFiberResponse = widget.syncFiberResponse;
    _pageController = PageController();

    _samplePages = [
      FiberSpecificationComponent(
        syncFiberResponse: widget.syncFiberResponse,
        callback: (value) {
          setState(() {
            selectedValue++;
            _fiberRequestModel = value;
          });
          widget.stepsCallback!(value);
          _pageController.animateToPage(selectedValue - 1,
              duration: Duration(milliseconds: 400),
              curve: Curves.easeInOut);
        },
      ),
      PackingDetails(requestModel :_fiberRequestModel,syncFiberResponse:widget.syncFiberResponse),
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
                      duration: Duration(milliseconds: 400),
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
