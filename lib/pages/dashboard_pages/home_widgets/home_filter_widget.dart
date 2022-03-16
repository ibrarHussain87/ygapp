import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:yg_app/Providers/family_list_provider.dart';
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

  @override
  void initState() {
    super.initState();
    final familyListProvider = Provider.of<FamilyListProvider>(context,listen: false);
    familyListProvider.getFamilyListData();
  }

  @override
  Widget build(BuildContext context) {
    final familyListProvider = Provider.of<FamilyListProvider>(context);
    return Container(
      color: Colors.white30,
      padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 16.w),
      child:  familyListProvider.familyList!.isNotEmpty ? GridMoreWidget(
        spanCount: 4,
        callback: (value){
          widget.callback(1);
        },
        listOfItems: familyListProvider.familyList!,
      ):Container(
        color: Colors.transparent,
        height: 100,
      )
    );
  }
}
