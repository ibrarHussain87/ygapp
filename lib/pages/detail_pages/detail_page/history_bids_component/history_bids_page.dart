import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:yg_app/elements/no_data_found_widget.dart';
import 'package:yg_app/model/response/list_bid_response.dart';
import 'package:yg_app/pages/detail_pages/detail_page/history_bids_component/history_bids_body.dart';

import '../../../../api_services/api_service_class.dart';
import '../../../../elements/text_widgets.dart';
import '../../../../helper_utils/app_constants.dart';
import '../../../../helper_utils/shared_pref_util.dart';

class HistoryOfBidsPage extends StatefulWidget {

  final String specId;
  final String catId;

  const HistoryOfBidsPage({Key? key,required this.specId,required this.catId}) : super(key: key);

  @override
  _HistoryOfBidsPageState createState() => _HistoryOfBidsPageState();
}

class _HistoryOfBidsPageState extends State<HistoryOfBidsPage> {

  String? userId;

  @override
  void initState() {
    _getUserId().then((value) => setState(() => userId = value));

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder<ListBidResponse>(
        future: ApiService().getBidsHistory(
            widget.specId.toString(),widget.catId.toString()),
        builder: (BuildContext context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done && snapshot.data!= null && snapshot.data!.data!.isNotEmpty) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                  itemCount: snapshot.data!.data!.length,
                  itemBuilder: (context, index) {
                    return HistoryOfBidsBody(bidData: snapshot.data!.data![index]);
                  }),
            );
          } else if (snapshot.hasError) {
            return Center(
                child: TitleSmallTextWidget(title: snapshot.error.toString()));
          } else if (snapshot.connectionState == ConnectionState.done &&
              snapshot.data!.data!.isEmpty) {
            return const Center(
                child: NoDataFoundWidget());
          } else {
            return const Center(
              child: SpinKitWave(
                color: Colors.green,
                size: 24.0,
              ),
            );
          }
        },
      ),
    );
  }
  Future<String?> _getUserId() async{
    return await SharedPreferenceUtil.getStringValuesSF(USER_ID_KEY);
  }

}
