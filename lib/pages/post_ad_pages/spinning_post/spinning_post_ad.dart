import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yg_app/api_services/api_service_class.dart';
import 'package:yg_app/app_database/app_database_instance.dart';
import 'package:yg_app/model/request/post_ad_request/fiber_request.dart';
import 'package:yg_app/model/response/yarn_response/sync/yarn_sync_response.dart';
import 'package:yg_app/pages/post_ad_pages/spinning_post/component/yarn_family_blend_body.dart';
import 'package:yg_app/pages/post_ad_pages/spinning_post/component/yarn_steps_segments.dart';
import 'package:yg_app/widgets/title_text_widget.dart';

class SpinningPostAdPage extends StatefulWidget {
  final String? locality;
  final String? businessArea;
  final String? selectedTab;

  const SpinningPostAdPage(
      {Key? key,
      required this.businessArea,
      required this.selectedTab,
      required this.locality})
      : super(key: key);

  @override
  _SpinningPostAdPageState createState() => _SpinningPostAdPageState();
}

class _SpinningPostAdPageState extends State<SpinningPostAdPage> {
  CreateRequestModel? _fiberRequestModel;
  Future<YarnSyncResponse>? _syncFuture;

  @override
  void initState() {
    _fiberRequestModel = CreateRequestModel();
    _syncFuture = ApiService.SyncYarn();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: FutureBuilder<YarnSyncResponse>(
          future: _syncFuture,
          builder: (context, snapshot) {
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

  Widget insertIntoDB(YarnSyncResponse? data) {
    return FutureBuilder<List<int>>(
      future: AppDbInstance.getDbInstance().then((value) async {
        await value.gradesDao.insertAllGrades(data!.data.yarn.grades);
        return value.yarnSettingsDao
            .insertAllYarnSettings(data.data.yarn.setting);
      }),
      builder: (BuildContext context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null) {
          return Provider(
              create: (_) => _fiberRequestModel,
              child: FamilyBlendBody(
                yarnSyncResponse: data!,
                locality: widget.locality,
                businessArea: widget.businessArea,
                selectedTab: widget.selectedTab,
              ));
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
}
