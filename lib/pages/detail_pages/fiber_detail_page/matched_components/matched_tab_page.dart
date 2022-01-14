import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/api_services/api_service_class.dart';
import 'package:yg_app/model/matched_response.dart';
import 'package:yg_app/model/response/list_bidder_response.dart';
import 'package:yg_app/pages/detail_pages/fiber_detail_page/list_bidder_components/list_bidder_body.dart';
import 'package:yg_app/helper_utils/app_images.dart';
import 'package:yg_app/helper_utils/app_colors.dart';
import 'package:yg_app/helper_utils/progress_dialog_util.dart';
import 'package:yg_app/elements/list_widgets/brand_text.dart';
import 'package:yg_app/elements/title_text_widget.dart';
import 'package:yg_app/pages/market_pages/fiber_page/fiber_listing_body.dart';
import 'package:yg_app/pages/market_pages/yarn_page/yarn_components/yarn_list_body.dart';

class MatchedPage extends StatefulWidget {
  final String catId;
  final int specId;

  const MatchedPage(
      {Key? key, required this.catId, required this.specId})
      : super(key: key);

  @override
  _MatchedPageState createState() => _MatchedPageState();
}

class _MatchedPageState extends State<MatchedPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder<MatchedResponse>(
        future: ApiService.getMatched(
            widget.catId, widget.specId.toString()),
        builder: (BuildContext context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done && snapshot.data!=null) {
            if(widget.catId == "1" && snapshot.data!.data!.fiber!=null){
              return Padding(
                padding: const EdgeInsets.only(top:8.0,left: 8.0,right: 8.0),
                child: FiberListingBody(specification: snapshot.data!.data!.fiber!),
              );
            }else if(widget.catId == "2" && snapshot.data!.data!.yarnSpecification!=null){
              return Padding(
                padding: const EdgeInsets.only(top:8.0,left: 8.0,right: 8.0),
                child: YarnListBody(specification: snapshot.data!.data!.yarnSpecification!),
              );
            }else{
              return const Center(
                  child: TitleSmallTextWidget(title: 'No data found!!'));
            }
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
    );
  }


}
