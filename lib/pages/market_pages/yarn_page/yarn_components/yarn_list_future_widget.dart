import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yg_app/api_services/api_service_class.dart';
import 'package:yg_app/elements/title_text_widget.dart';
import 'package:yg_app/helper_utils/app_constants.dart';
import 'package:yg_app/model/request/filter_request/fiber_filter_request.dart';
import 'package:yg_app/model/response/yarn_response/yarn_specification_response.dart';
import 'package:yg_app/pages/market_pages/yarn_page/yarn_components/yarn_list_body.dart';

class YarnSpecificationListFuture extends StatefulWidget {
  final String locality;

  const YarnSpecificationListFuture({Key? key, required this.locality})
      : super(key: key);

  @override
  YarnSpecificationListFutureState createState() =>
      YarnSpecificationListFutureState();
}

class YarnSpecificationListFutureState
    extends State<YarnSpecificationListFuture> {
  GetSpecificationRequestModel getRequestModel = GetSpecificationRequestModel();
  GlobalKey<YarnListBodyState> yarnListBodyState =
      GlobalKey<YarnListBodyState>();

  @override
  void initState() {
    getRequestModel.locality = widget.locality;
    getRequestModel.categoryId = 2.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<GetYarnSpecificationResponse>(
      future:
          ApiService.getYarnSpecifications(getRequestModel, widget.locality),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null) {
          return snapshot.data!.data!=null
              ? YarnListBody(
                  key: yarnListBodyState,
                  specification: snapshot.data!.data!.specification!)
              : const Center(
                  child: TitleSmallTextWidget(title: "No Data Found"));
        } else if (snapshot.hasError) {
          return Center(
              child: TitleSmallTextWidget(title: snapshot.error.toString()));
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  searchData(GetSpecificationRequestModel data) {
    setState(() {
      data.categoryId = YARN_CATEGORY_ID.toString();
      getRequestModel = data;
    });
  }
}
