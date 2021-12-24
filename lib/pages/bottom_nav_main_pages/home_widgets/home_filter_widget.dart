import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/model/response/family_data.dart';
import 'package:yg_app/helper_utils/app_images.dart';
import 'package:yg_app/elements/list_widgets/grid_tile_more_widget.dart';
import 'package:yg_app/elements/list_widgets/grid_tile_widget.dart';

class HomeFilterWidget extends StatefulWidget {
  const HomeFilterWidget({Key? key}) : super(key: key);

  @override
  _HomeFilterWidgetState createState() => _HomeFilterWidgetState();
}

class _HomeFilterWidgetState extends State<HomeFilterWidget> {

  List<FamilyData> familyList = <FamilyData>[
    FamilyData(LYCRA_IMAGE, LYCRA_UNCHECK_IMAGE, 'Lycra'),
    FamilyData(
        MICRO_FIBER_IMAGE, MICRO_FIBER_UNCHECK_IMAGE, 'Micro Fiber'),
    FamilyData(MODEL_IMAGE, MODEL_UNCHECK_IMAGE, 'Model'),
    FamilyData(MODEL_IMAGE, MODEL_UNCHECK_IMAGE, 'Post Ad'),
    FamilyData(
        ORIENTATION_IMAGE, ORIENTATION_UNCHECK_IMAGE, 'Orientation'),
    FamilyData(
        POLY_COTTON_IMAGE, POLY_COTTON_UNCHECK_IMAGE, 'Poly Cotton'),
    FamilyData(
        POLY_COTTON_IMAGE, POLY_COTTON_UNCHECK_IMAGE, 'Poly Cotton'),
    FamilyData(
        POLY_COTTON_IMAGE, POLY_COTTON_UNCHECK_IMAGE, 'Poly Cotton'),
    FamilyData(
        POLY_COTTON_IMAGE, POLY_COTTON_UNCHECK_IMAGE, 'Poly Cotton'),
    FamilyData(
        POLY_COTTON_IMAGE, POLY_COTTON_UNCHECK_IMAGE, 'Poly Cotton'),
    FamilyData(
        POLY_COTTON_IMAGE, POLY_COTTON_UNCHECK_IMAGE, 'Poly Cotton'),
    FamilyData(
        POLY_COTTON_IMAGE, POLY_COTTON_UNCHECK_IMAGE, 'Poly Cotton'),
    FamilyData(
        POLY_COTTON_IMAGE, POLY_COTTON_UNCHECK_IMAGE, 'Poly Cotton'),

  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white30,
      padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 16.w),
      child: GridMoreWidget(
        spanCount: 4,
        callback: (value){},
        listOfItems: familyList,
      ),
    );
  }
}
