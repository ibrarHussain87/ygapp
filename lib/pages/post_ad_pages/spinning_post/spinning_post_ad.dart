import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/model/response/family_data.dart';
import 'package:yg_app/utils/colors.dart';
import 'package:yg_app/utils/images.dart';
import 'package:yg_app/utils/strings.dart';
import 'package:yg_app/widgets/grid_widget.dart';
import 'package:yg_app/widgets/list_widget_colored.dart';
import 'package:yg_app/widgets/steps_segments_widget.dart';

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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: AppColors.lightBlueTabs, //change your color here
          ),
          elevation: 4,
          title: Text('Spinning Post Ad',style: TextStyle(color: AppColors.lightBlueTabs,fontSize: 13.sp),),
          backgroundColor: Colors.white,
        ),
        body: Column(
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
    );
  }


}
