import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/model/response/family_data.dart';
import 'package:yg_app/pages/local_market_pages/fiber_page.dart';
import 'package:yg_app/pages/local_market_pages/product_weaving.dart';
import 'package:yg_app/pages/local_market_pages/spinning_page.dart';
import 'package:yg_app/pages/local_market_pages/stock_lot.dart';
import 'package:yg_app/pages/main_page.dart';
import 'package:yg_app/pages/main_pages/home_page.dart';
import 'package:yg_app/pages/main_pages/international_page.dart';
import 'package:yg_app/pages/main_pages/yg_services.dart';
import 'package:yg_app/utils/colors.dart';
import 'package:yg_app/utils/images.dart';
import 'package:yg_app/utils/strings.dart';
import 'package:yg_app/widgets/grid_widget.dart';
import 'package:yg_app/widgets/list_widget_colored.dart';
import 'package:yg_app/widgets/steps_segments.dart';

class SpinningPostAdPage extends StatefulWidget {
  const SpinningPostAdPage(
      {Key? key, required this.businessArea, required this.selectedTab})
      : super(key: key);
  final String businessArea;
  final String selectedTab;

  @override
  _SpinningPostAdPageState createState() => _SpinningPostAdPageState();
}

class _SpinningPostAdPageState extends State<SpinningPostAdPage> {

  Map<int,String> stepsMap = {1: 'Step 1', 2:'Step 2',3: 'Step 3'};
  List<FamilyData> familyList = <FamilyData>[
    FamilyData(AppImages.cottonImage, AppImages.cottonGreyImage, 'Cotton'),
    FamilyData(
        AppImages.syentheticIcon, AppImages.syentheticGreyIcon, 'Syenthatic'),
    FamilyData(AppImages.homeIcon, AppImages.homeGreyIcon, 'Syenthatic'),
    FamilyData(AppImages.postAdIcon, AppImages.postAdGreyIcon, 'Syenthatic'),
    FamilyData(
        AppImages.ygServicesIcon, AppImages.ygServicesGreyIcon, 'Syenthatic')
  ];
  PageController _pageController = new PageController();
  List<Widget> _samplePages = [FiberPage(),InternationalPage(),YGServices()];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Visibility(
                visible: false,
                child: Padding(
                  padding: EdgeInsets.only(
                    top: 8.w,
                    left: 24.w,
                    right: 24.w,
                  ),
                  child: Text(
                    AppStrings.family,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 16.w, left: 8.w, right: 8.w),
                child: GridWidet(
                  familyList: familyList,
                  callback: (index) {
                    print(familyList[index]);
                  },
                ),
              ),
              Visibility(
                visible: false,
                child: Padding(
                  padding: EdgeInsets.only(left: 24.w, right: 24.w),
                  child: Text(
                    AppStrings.blend,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 8.w, right: 8.w),
                child: SizedBox(
                  height: 32.h,
                  child: ListViewWidgetColored(
                    //just for dummy
                    listItems: familyList,
                    callback: (index) {},
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(top: 8.w),
                  child: StepsSegmentWidget(
                    stepsCallback: (value) {
                    }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
