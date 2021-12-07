import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/api_services/api_service_class.dart';
import 'package:yg_app/model/response/list_bidder_response.dart';
import 'package:yg_app/pages/detail_pages/fiber_detail_page/list_bidder_components/list_bidder_body.dart';
import 'package:yg_app/utils/app_images.dart';
import 'package:yg_app/utils/colors.dart';
import 'package:yg_app/utils/progress_dialog_util.dart';
import 'package:yg_app/utils/show_messgae_util.dart';
import 'package:yg_app/widgets/list_widgets/brand_text.dart';
import 'package:yg_app/widgets/title_text_widget.dart';

class BidderListPage extends StatefulWidget {
  final String materialId;
  final int specId;

  const BidderListPage(
      {Key? key, required this.materialId, required this.specId})
      : super(key: key);

  @override
  _BidderListPageState createState() => _BidderListPageState();
}

class _BidderListPageState extends State<BidderListPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder<ListBiddersResponse>(
        future: ApiService.getListBidders(
            widget.materialId, widget.specId.toString()),
        builder: (BuildContext context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.data!.data.isNotEmpty) {
            return ListView.builder(
                itemCount: snapshot.data!.data.length,
                itemBuilder: (context, index) {
                  return ListBidderBody(listBiddersData: snapshot.data!.data[index]);
                });
          } else if (snapshot.hasError) {
            return Center(
                child: TitleTextWidget(title: snapshot.error.toString()));
          } else if (snapshot.connectionState == ConnectionState.done &&
              snapshot.data!.data.isEmpty) {
            return const Center(
                child: TitleTextWidget(title: 'No data found!!'));
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }


}
