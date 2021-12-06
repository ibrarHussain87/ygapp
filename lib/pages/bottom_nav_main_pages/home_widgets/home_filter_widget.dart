import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/model/response/family_data.dart';
import 'package:yg_app/utils/app_images.dart';
import 'package:yg_app/widgets/grid_tile_more_widget/grid_tile_widget.dart';
import 'package:yg_app/widgets/grid_tile_widget.dart';

class HomeFilterWidget extends StatefulWidget {
  const HomeFilterWidget({Key? key}) : super(key: key);

  @override
  _HomeFilterWidgetState createState() => _HomeFilterWidgetState();
}

class _HomeFilterWidgetState extends State<HomeFilterWidget> {

  List<FamilyData> familyList = <FamilyData>[
    FamilyData(AppImages.cottonImage, AppImages.cottonGreyImage, 'Cotton'),
    FamilyData(
        AppImages.syentheticIcon, AppImages.syentheticGreyIcon, 'Syenthatic'),
    FamilyData(AppImages.homeIcon, AppImages.homeGreyIcon, 'Syenthatic'),
    FamilyData(AppImages.postAdIcon, AppImages.postAdGreyIcon, 'Syenthatic'),
    FamilyData(
        AppImages.ygServicesIcon, AppImages.ygServicesGreyIcon, 'Syenthatic'),
    FamilyData(
        AppImages.ygServicesIcon, AppImages.ygServicesGreyIcon, 'Syenthatic'),
    FamilyData(
        AppImages.ygServicesIcon, AppImages.ygServicesGreyIcon, 'Syenthatic'),
    FamilyData(
        AppImages.ygServicesIcon, AppImages.ygServicesGreyIcon, 'Syenthatic'),
    FamilyData(
        AppImages.ygServicesIcon, AppImages.ygServicesGreyIcon, 'Syenthatic'),
    FamilyData(
        AppImages.ygServicesIcon, AppImages.ygServicesGreyIcon, 'Syenthatic'),
    FamilyData(
        AppImages.ygServicesIcon, AppImages.ygServicesGreyIcon, 'Syenthatic')
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 8.w, right: 8.w,top: 16.w),
      child: GridMoreWidget(
        spanCount: 4,
        callback: (value){

        },
        listOfItems: familyList,
      ),
    );
  }
}
