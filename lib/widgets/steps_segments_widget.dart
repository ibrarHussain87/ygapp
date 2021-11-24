import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/pages/bottom_nav_main_pages/yg_services.dart';
import 'package:yg_app/pages/post_ad_pages/spinning_post/component/lab_parameter_body.dart';
import 'package:yg_app/pages/post_ad_pages/spinning_post/component/specification_body.dart';
import 'package:yg_app/utils/colors.dart';

class StepsSegmentWidget extends StatefulWidget {
  Function? stepsCallback;
  Map<int, String>? stepsMapping;

  StepsSegmentWidget({Key? key, required this.stepsCallback}) : super(key: key);

  @override
  _StepsSegmentWidgetState createState() => _StepsSegmentWidgetState();
}

class _StepsSegmentWidgetState extends State<StepsSegmentWidget> {
  int? selectedValue = 1;
  final PageController _pageController = PageController();
  final List<Widget> _samplePages = [
    SpecificationComponent(callback: (value){
      print(value);
    },),
    const LabParameterPage(),
    const YGServices()
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Expanded(
              child: CupertinoSegmentedControl(
                borderColor: AppColors.textColorGreyLight,
                selectedColor: AppColors.lightBlueTabs,
                groupValue: selectedValue,
                pressedColor: AppColors.lightBlueTabs,
                children: {
                  1: Container(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      "Step 1",
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: selectedValue == 1
                            ? Colors.white
                            : AppColors.lightBlueTabs,
                      ),
                    ),
                  ),
                  2: Container(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      "Step 2",
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: selectedValue == 2
                            ? Colors.white
                            : AppColors.lightBlueTabs,
                      ),
                    ),
                  ),
                  3: Container(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      "Step 3",
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: selectedValue == 3
                            ? Colors.white
                            : AppColors.lightBlueTabs,
                      ),
                    ),
                  ),
                },
                onValueChanged: (value) {
                  setState(() {
                    selectedValue = value as int?;
                  });
                  widget.stepsCallback!(value);
                  _pageController.animateToPage(selectedValue! - 1,
                      duration: Duration(milliseconds: 400),
                      curve: Curves.easeInOut);
                  print(value);
                },
              ),
            )
          ],
        ),
        Expanded(
          child: PageView.builder(
            controller: _pageController,
            physics: NeverScrollableScrollPhysics(),
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
