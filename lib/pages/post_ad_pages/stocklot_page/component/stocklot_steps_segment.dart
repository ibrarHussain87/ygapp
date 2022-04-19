import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/pages/post_ad_pages/stocklot_page/component/stocklot_specification_body.dart';

import '../../../../helper_utils/app_colors.dart';
import '../../packing_details_component.dart';

class StockLotStepsSegment extends StatefulWidget {
  final String? locality;
  final String? businessArea;
  final String? selectedTab;
  final Function? callback;

  const StockLotStepsSegment(
      {Key? key,
      required this.locality,
      this.businessArea,
      this.selectedTab,
      this.callback})
      : super(key: key);

  @override
  StockLotStepsSegmentState createState() => StockLotStepsSegmentState();
}

class StockLotStepsSegmentState extends State<StockLotStepsSegment> {
  int selectedValue = 1;
  late PageController _pageController;
  late List<Widget> _samplePages;

  //Packing page State
  final GlobalKey<PackagingDetailsState> _packingStateKey =
      GlobalKey<PackagingDetailsState>();

  final GlobalKey<StockLotSpecificationBodyState> stockLotSpecificationKey =
      GlobalKey<StockLotSpecificationBodyState>();

  @override
  void initState() {
    // TODO: implement initState
    _pageController = PageController();
    _samplePages = [
      StockLotSpecificationBody(
        key: stockLotSpecificationKey,
        locality: widget.locality,
        businessArea: widget.businessArea,
        selectedTab: widget.selectedTab,
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
                        color:
                            selectedValue == 1 ? Colors.white : textColorGrey,
                      ),
                    ),
                  ),
                  2: Container(
                    padding: EdgeInsets.all(8.w),
                    child: Text(
                      "Step 2",
                      style: TextStyle(
                        fontSize: 11.sp,
                        color:
                            selectedValue == 2 ? Colors.white : textColorGrey,
                      ),
                    ),
                  ),
                },
                onValueChanged: (value) {
                  _moveToNextPage(value);
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

  _moveToNextPage(value) {
    setState(() {
      selectedValue = value as int;
    });
    widget.callback!(value);
    _pageController.animateToPage(selectedValue - 1,
        duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
  }
}
