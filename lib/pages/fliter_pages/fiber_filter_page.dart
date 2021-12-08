import 'package:flutter/material.dart';
import 'package:yg_app/api_services/api_service_class.dart';
import 'package:yg_app/model/response/fiber_response/sync/sync_fiber_response.dart';
import 'package:yg_app/widgets/title_text_widget.dart';

import 'insert_data_into_db.dart';

class FiberFilterPage extends StatefulWidget {
  const FiberFilterPage({Key? key}) : super(key: key);

  @override
  _FiberFilterPageState createState() => _FiberFilterPageState();
}

class _FiberFilterPageState extends State<FiberFilterPage> {


  @override
  void initState() {
    super.initState();
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
              return InsertFiberSyncResponseIntoDb(data:snapshot.data);
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

}
