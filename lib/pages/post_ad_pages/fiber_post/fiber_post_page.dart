import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_broadcast_receiver/flutter_broadcast_receiver.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stylish_dialog/stylish_dialog.dart';
import 'package:yg_app/api_services/api_service_class.dart';
import 'package:yg_app/app_database/app_database.dart';
import 'package:yg_app/model/response/sync/fiber_sync_response/sync_fiber_response.dart';
import 'package:yg_app/pages/post_ad_pages/fiber_post/component/fiber_steps_segments.dart';
import 'package:yg_app/utils/constants.dart';
import 'package:yg_app/utils/strings.dart';
import 'package:yg_app/widgets/listview_image_filter_widget.dart';
import 'package:yg_app/widgets/title_text_widget.dart';

class FiberPostPage extends StatefulWidget {

  final String? businessArea;
  final String? selectedTab;

  const FiberPostPage({Key? key, required this.businessArea, this.selectedTab})
      : super(key: key);

  @override
  _FiberPostPageState createState() => _FiberPostPageState();
}

class _FiberPostPageState extends State<FiberPostPage> {

  @override
  void dispose() {
    //Dispose broadcast
    BroadcastReceiver().unsubscribe(AppStrings.materialIndexBroadcast);
    BroadcastReceiver().unsubscribe(AppStrings.segmentIndexBroadcast);
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: FutureBuilder<SyncFiberResponse>(
          future: ApiService.SyncFiber(),
          builder: (BuildContext context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.data != null) {
              return insertIntoDB(snapshot.data);
            } else if (snapshot.hasError) {
              return Center(
                  child: TitleTextWidget(title: snapshot.error.toString()));
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }

  Widget insertIntoDB(SyncFiberResponse? data) {
    return FutureBuilder<List<int>>(
      future: getDbInstance().then((value) async {
        // await value.fiberSettingDao.deleteAll(data!.data.fiber.settings);
        return value.fiberSettingDao
            .insertAllFiberSettings(data!.data.fiber.settings);
      }),
      builder: (BuildContext context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null) {
          return getView(data!);
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

  Widget getView(SyncFiberResponse data) {

    int selectedSegment = 1;

    return Padding(
      padding: EdgeInsets.only(left: 8.w, right: 8.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
              padding: EdgeInsets.only(
                  top: 16.w, left: 16.w, right: 16.w, bottom: 16.w),
              child: TitleTextWidget(
                title: 'Fiber Material',
              )),
          SizedBox(
            height: 64.w,
            child: ListViewImageFilterWidget(
              listItem: data.data.fiber.material,
              onClickCallback: (index) {
                /// Publishing Event
                  BroadcastReceiver()
                      .publish<int>(
                      AppStrings.materialIndexBroadcast, arguments: index);
              },
            ),
          ),
          Expanded(
            child: FiberStepsSagments(
              syncFiberResponse: data,
              stepsCallback: (value) {
                  selectedSegment = value as int;
                  BroadcastReceiver()
                      .publish<int>(
                      AppStrings.segmentIndexBroadcast, arguments: selectedSegment);
              },
            ),
          ),
        ],
      ),
    );
  }
}


Future<AppDatabase> getDbInstance() async {
  var databaseInstance;
  final database =
      $FloorAppDatabase.databaseBuilder(AppConstants.APP_DATABASE_NAME).build();
  await database.then((value) => {databaseInstance = value});

  return databaseInstance;
}
