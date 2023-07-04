import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:yg_app/elements/no_data_found_widget.dart';
import 'package:yg_app/elements/text_widgets.dart';
import 'package:yg_app/helper_utils/app_constants.dart';
import 'package:yg_app/model/response/fabric_response/fabric_specification_response.dart';

import '../../../../model/request/filter_request/fabric_filter_request.dart';
import '../../../../providers/fabric_providers/fabric_specifications_provider.dart';
import 'fabric_list_body.dart';

class FabricSpecificationListFuture extends StatefulWidget {
  final String locality;

  const FabricSpecificationListFuture({Key? key, required this.locality})
      : super(key: key);

  @override
  FabricSpecificationListFutureState createState() =>
      FabricSpecificationListFutureState();
}

class FabricSpecificationListFutureState
    extends State<FabricSpecificationListFuture> {
  FabricSpecificationRequestModel getRequestModel =
      FabricSpecificationRequestModel();
  GlobalKey<FabricListBodyState> fabricListBodyState =
      GlobalKey<FabricListBodyState>();
  late FabricSpecificationsProvider fabricSpecificationsProvider;

  @override
  void initState() {
    getRequestModel.locality = widget.locality;
    getRequestModel.category_id = 3.toString();
    getRequestModel.is_offering = "1";
    fabricSpecificationsProvider =
        Provider.of<FabricSpecificationsProvider>(context, listen: false);
    fabricSpecificationsProvider.setRequestParams(
        getRequestModel, widget.locality);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final fabricSpecificationsProvider =
        Provider.of<FabricSpecificationsProvider>(context);
    return FutureBuilder<FabricSpecificationResponse>(
      future: fabricSpecificationsProvider.getFabrics(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null) {
          return snapshot.data!.data != null
              ? Container(
                  child: snapshot.data!.data!.specification!.isNotEmpty
                      ? FabricListBody(
                          key: fabricListBodyState,
                          specification: fabricSpecificationsProvider
                              .fabricSpecificationResponse!
                              .data!
                              .specification!)
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

  searchData(FabricSpecificationRequestModel data) {
    setState(() {
      data.category_id = fabricCategoryId.toString();
      getRequestModel = data;
      fabricSpecificationsProvider.setRequestParams(
          getRequestModel, widget.locality);
    });
  }
}
