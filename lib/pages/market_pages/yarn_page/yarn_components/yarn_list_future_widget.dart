import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:yg_app/elements/no_data_found_widget.dart';
import 'package:yg_app/elements/text_widgets.dart';
import 'package:yg_app/helper_utils/app_constants.dart';
import 'package:yg_app/model/request/filter_request/filter_request.dart';
import 'package:yg_app/model/response/yarn_response/yarn_specification_response.dart';
import 'package:yg_app/pages/market_pages/yarn_page/yarn_components/yarn_list_body.dart';
import 'package:yg_app/providers/yarn_providers/yarn_specifications_provider.dart';

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
  late YarnSpecificationsProvider yarnSpecificationsProvider;

  @override
  void initState() {
    yarnSpecificationsProvider =
        Provider.of<YarnSpecificationsProvider>(context, listen: false);
    getRequestModel.locality = widget.locality;
    getRequestModel.categoryId = 2.toString();
    getRequestModel.isOffering = "1";
    yarnSpecificationsProvider.setRequestParams(
        getRequestModel, widget.locality);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final yarnSpecificationsProvider =
        Provider.of<YarnSpecificationsProvider>(context);
    return FutureBuilder<GetYarnSpecificationResponse>(
      future: yarnSpecificationsProvider.getYarns(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null) {
          return snapshot.data!.data != null
              ? Container(
                  child: snapshot.data!.data!.specification!.isNotEmpty
                      ? YarnListBody(
                          key: yarnListBodyState,
                          specification: yarnSpecificationsProvider
                              .yarnSpecificationResponse!.data!.specification!)
                      : const NoDataFoundWidget(),
                )
              : Center(
                  child: TitleSmallTextWidget(
                      title: snapshot.data!.message.toString()));
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

  searchData(GetSpecificationRequestModel data) {
    setState(() {
      data.categoryId = yarnCategoryId.toString();
      getRequestModel = data;
      yarnSpecificationsProvider.setRequestParams(
          getRequestModel, widget.locality);
    });
  }
}
