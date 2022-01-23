import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/app_database/app_database_instance.dart';
import 'package:yg_app/elements/list_widgets/cat_with_image_listview_widget.dart';
import 'package:yg_app/model/response/family_data.dart';
import 'package:yg_app/helper_utils/app_images.dart';
import 'package:yg_app/elements/list_widgets/grid_tile_more_widget.dart';
import 'package:yg_app/elements/list_widgets/single_select_tile_widget.dart';
import 'package:yg_app/model/response/fiber_response/sync/sync_fiber_response.dart';
import 'package:yg_app/model/response/yarn_response/sync/yarn_sync_response.dart';

class HomeFilterWidget extends StatefulWidget {

  final Function callback;
  const HomeFilterWidget({Key? key,required this.callback}) : super(key: key);

  @override
  _HomeFilterWidgetState createState() => _HomeFilterWidgetState();
}

class _HomeFilterWidgetState extends State<HomeFilterWidget> {

  List<FamilyData>? familyList;

  List<FiberMaterial> _fiberMaterialList = [];
  List<Family> _yarnFamilyList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    familyList = [];

    AppDbInstance.getDbInstance().then((value) async{

      familyList!.clear();
      _fiberMaterialList.clear();
      _yarnFamilyList.clear();

      _fiberMaterialList = await value.fiberMaterialDao.findAllFiberMaterials();
      _yarnFamilyList = await value.yarnFamilyDao.findAllYarnFamily();
      setState(() {
        if(_fiberMaterialList.isNotEmpty  && _fiberMaterialList.length >= 4){
          _fiberMaterialList = _fiberMaterialList.take(4).toList();
          for (var element in _fiberMaterialList) {
            familyList!.add(FamilyData(element.fbmId, element.icon_selected??"", element.icon_unselected!, element.fbmName!));
          }

        }

        if(_yarnFamilyList.isNotEmpty && _yarnFamilyList.length >= 4){
          _yarnFamilyList = _yarnFamilyList.take(4).toList()..shuffle();
          for (var element in _yarnFamilyList) {
            familyList!.add(FamilyData(element.famId!, element.iconSelected!, element.iconUnSelected!, element.famName!));
          }
        }
      });

    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white30,
      padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 16.w),
      child:  familyList!.isNotEmpty ? GridMoreWidget(
        spanCount: 4,
        callback: (value){
          widget.callback(1);
        },
        listOfItems: familyList!,
      ):Container(
        color: Colors.transparent,
        height: 100,
      )
    );
  }
}
