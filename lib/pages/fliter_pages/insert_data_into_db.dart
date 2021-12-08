import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/app_database/app_database.dart';
import 'package:yg_app/model/response/fiber_response/sync/sync_fiber_response.dart';
import 'package:yg_app/pages/fliter_pages/fiber_view_filter.dart';
import 'package:yg_app/pages/post_ad_pages/fiber_post/component/fiber_specification_component.dart';
import 'package:yg_app/utils/colors.dart';
import 'package:yg_app/utils/constants.dart';
import 'package:yg_app/widgets/decoration_widgets.dart';
import 'package:yg_app/widgets/elevated_button_widget_2.dart';
import 'package:yg_app/widgets/filter_widget/filter_grid_tile_widget.dart';
import 'package:yg_app/widgets/filter_widget/filter_material_listview.dart';
import 'package:yg_app/widgets/filter_widget/filter_range_slider.dart';
import 'package:yg_app/widgets/title_text_widget.dart';

class InsertFiberSyncResponseIntoDb extends StatefulWidget {

  final SyncFiberResponse? data;

  const InsertFiberSyncResponseIntoDb({Key? key,required this.data}) : super(key: key);

  @override
  _InsertFiberSyncResponseIntoDbState createState() => _InsertFiberSyncResponseIntoDbState();
}

class _InsertFiberSyncResponseIntoDbState extends State<InsertFiberSyncResponseIntoDb> {



  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<int>>(
      future: getDbInstance().then((value) async {
        await value.gradesDao
            .insertAllGrades(widget.data!.data.fiber.grades);
        await value.fiberMaterialDao
            .insertAllFiberMaterials(widget.data!.data.fiber.material);
        return value.fiberSettingDao
            .insertAllFiberSettings(widget.data!.data.fiber.settings);
      }),
      builder: (BuildContext context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null) {
          return /* listOfSettings.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : */
            FiberFilterView(syncFiberResponse: widget.data!);
        } else if (snapshot.hasError) {
          return Center(
              child: TitleTextWidget(title: snapshot.error.toString()));
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }



  Future<AppDatabase> getDbInstance() async {
    var databaseInstance;
    final database = $FloorAppDatabase
        .databaseBuilder(AppConstants.APP_DATABASE_NAME)
        .build();
    await database.then((value) => {databaseInstance = value});

    return databaseInstance;
  }
}
