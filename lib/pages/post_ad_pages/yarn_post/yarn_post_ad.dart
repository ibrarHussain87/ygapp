import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:yg_app/api_services/api_service_class.dart';
import 'package:yg_app/app_database/app_database_instance.dart';
import 'package:yg_app/model/request/post_ad_request/create_request_model.dart';
import 'package:yg_app/model/response/yarn_response/sync/yarn_sync_response.dart';
import 'package:yg_app/elements/title_text_widget.dart';

import 'component/yarn_family_blend_ad_body.dart';

class YarnPostAdPage extends StatefulWidget {
  final String? locality;
  final String? businessArea;
  final String? selectedTab;

  const YarnPostAdPage(
      {Key? key,
      required this.businessArea,
      required this.selectedTab,
      required this.locality})
      : super(key: key);

  @override
  _YarnPostAdPageState createState() => _YarnPostAdPageState();
}

class _YarnPostAdPageState extends State<YarnPostAdPage> {
  CreateRequestModel? _createRequestModel;
//  Future<YarnSyncResponse>? _syncFuture;

  @override
  void initState() {
    _createRequestModel = CreateRequestModel();
//    _syncFuture = ApiService.syncYarn();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: /*FutureBuilder<YarnSyncResponse>(
          future: _syncFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.data != null) {
              return insertIntoDB(snapshot.data);
            } else if (snapshot.hasError) {
              return Center(
                  child: TitleSmallTextWidget(title: snapshot.error.toString()));
            } else {
              return const Center(
                child: SpinKitWave(
                    color: Colors.green,
                    size: 24.0,
                  ),
              );
            }
          },
        )*/ Provider(
            create: (_) => _createRequestModel,
            child: FamilyBlendAdsBody(
              // yarnSyncResponse: data!,
              locality: widget.locality,
              businessArea: widget.businessArea,
              selectedTab: widget.selectedTab,
            )),
      ),
    );
  }

  Widget insertIntoDB(YarnSyncResponse? data) {
    return FutureBuilder<List<int>>(
      future: AppDbInstance.getDbInstance().then((value) async {
        await value.yarnGradesDao.insertAllGrades(data!.data.yarn.grades!);
        await value.yarnFamilyDao.insertAllYarnFamily(data.data.yarn.family!);
        await value.yarnBlendDao.insertAllYarnBlend(data.data.yarn.blends!);
        return value.yarnSettingsDao
            .insertAllYarnSettings(data.data.yarn.setting!);
      }),
      builder: (BuildContext context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null) {
          return Provider(
              create: (_) => _createRequestModel,
              child: FamilyBlendAdsBody(
                // yarnSyncResponse: data!,
                locality: widget.locality,
                businessArea: widget.businessArea,
                selectedTab: widget.selectedTab,
              ));
        } else if (snapshot.hasError) {
          return Center(
              child: TitleSmallTextWidget(title: snapshot.error.toString()));
        } else {
          return const Center(
            child: SpinKitWave(
                    color: Colors.green,
                    size: 24.0,
                  ),
          );
        }
      },
    );
  }
}
