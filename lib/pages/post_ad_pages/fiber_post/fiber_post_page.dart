import 'package:flutter/material.dart';
import 'package:yg_app/api_services/api_service_class.dart';
import 'package:yg_app/model/response/sync/sync_fiber_response.dart';
import 'package:yg_app/utils/progress_dialog_util.dart';
import 'package:yg_app/widgets/title_text_widget.dart';

class FiberPostPage extends StatefulWidget {

  final String? businessArea;
  final String? selectedTab;

  const FiberPostPage({Key? key,required this.businessArea,this.selectedTab}) : super(key: key);

  @override
  _FiberPostPageState createState() => _FiberPostPageState();
}

class _FiberPostPageState extends State<FiberPostPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: FutureBuilder<SyncFiberResponse>(
          future: ApiService.SyncFiber(),
           builder: (BuildContext context,snapshot){
              if (snapshot.connectionState == ConnectionState.done &&
                 snapshot.data != null) {
               return getView();
             } else if (snapshot.hasError) {
               return Text(snapshot.error.toString());
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

  Widget getView(){
    return SingleChildScrollView(
      child: Column(
        children: [
          TileTextWidget(title: 'Fiber Material',),
        ],
      ),
    );
  }
}


