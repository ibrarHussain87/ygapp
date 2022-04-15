import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:yg_app/model/response/fiber_response/sync/sync_fiber_response.dart';
import 'package:yg_app/pages/post_ad_pages/packing_details_component.dart';
import 'package:yg_app/helper_utils/app_colors.dart';
import 'package:yg_app/pages/post_ad_pages/yarn_post/component/lab_parameter_body.dart';

import '../../../../Providers/post_fabric_provider.dart';
import 'fabric_packing_details_component.dart';
import 'fabric_specification_component.dart';

class FabricStepsSegments extends StatefulWidget {

  final Function? stepsCallback;
  final Map<int, String>? stepsMapping;
  final String? locality;
  final String? businessArea;
  final String? selectedTab;

  const FabricStepsSegments(
      {Key? key,
        // required this.syncFiberResponse,
        required this.stepsCallback,
        required this.locality,
        required this.businessArea,
        required this.selectedTab,
        this.stepsMapping})
      : super(key: key);

  @override
  _FabricStepsSegmentsState createState() => _FabricStepsSegmentsState();
}

class _FabricStepsSegmentsState extends State<FabricStepsSegments> {

  int selectedValue = 1;
  late PageController _pageController;
  late List<Widget> _samplePages;

  final GlobalKey<FabricSpecificationComponentState> _fiberSpecificationState = GlobalKey<FabricSpecificationComponentState>();
  final GlobalKey<FabricPackagingDetailsState> _packingStateKey = GlobalKey<FabricPackagingDetailsState>();
  final GlobalKey<LabParameterPageState> _labParameterState = GlobalKey<LabParameterPageState>();


  @override
  void initState() {
    _pageController = PageController();

    _samplePages = [
      FabricSpecificationComponent(
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
      FabricPackagingDetails(
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
    final postFabricProvider = Provider.of<PostFabricProvider>(context);

    return /*postFabricProvider.updateSegments == true ? */Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Expanded(
              child: CupertinoSegmentedControl(
                borderColor: Colors.grey.shade300,
                selectedColor: lightBlueTabs,
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
                  /*if(_fiberSpecificationState.currentState!.validationAllPage()){
                    _moveToNextPage(value);
                  }else if(_labParameterState.currentState!.validateAndSave()){
                    _moveToNextPage(value);
                  }*/
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
                        /*if (_fiberSpecificationState.currentState != null &&
                            _fiberSpecificationState.currentState!
                                .validationAllPage()) {
                          _moveToNextPage(value);
                        }*/
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
    ) /*: Container()*/;
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
