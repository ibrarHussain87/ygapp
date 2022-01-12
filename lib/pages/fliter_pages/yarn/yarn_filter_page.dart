import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/api_services/api_service_class.dart';
import 'package:yg_app/app_database/app_database_instance.dart';
import 'package:yg_app/elements/list_widgets/material_listview_widget.dart';
import 'package:yg_app/elements/title_text_widget.dart';
import 'package:yg_app/elements/yarn_widgets/listview_famiy_tile.dart';
import 'package:yg_app/helper_utils/app_constants.dart';
import 'package:yg_app/helper_utils/ui_utils.dart';
import 'package:yg_app/model/response/yarn_response/sync/yarn_sync_response.dart';
import 'package:yg_app/pages/fliter_pages/yarn/yarn_filter_body.dart';

class YarnFilterPage extends StatefulWidget {
  const YarnFilterPage({Key? key}) : super(key: key);

  @override
  _YarnFilterPageState createState() => _YarnFilterPageState();
}

class _YarnFilterPageState extends State<YarnFilterPage> {
  Future<YarnSyncResponse>? _syncFuture;

  @override
  void initState() {
    _syncFuture = ApiService.syncYarn();
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
              return YarnFilterBody(syncResponse:snapshot.data);
            } else if (snapshot.hasError) {
              return Center(
                  child: TitleSmallTextWidget(title: snapshot.error.toString()));
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


}
