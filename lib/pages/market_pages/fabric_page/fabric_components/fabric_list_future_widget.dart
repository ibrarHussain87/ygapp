import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:yg_app/Providers/yarn_specifications_provider.dart';
import 'package:yg_app/api_services/api_service_class.dart';
import 'package:yg_app/elements/title_text_widget.dart';
import 'package:yg_app/helper_utils/app_constants.dart';
import 'package:yg_app/model/request/filter_request/filter_request.dart';
import 'package:yg_app/model/response/fabric_response/fabric_specification_response.dart';
import 'package:yg_app/model/response/yarn_response/yarn_specification_response.dart';
import 'package:yg_app/pages/market_pages/yarn_page/yarn_components/yarn_list_body.dart';

import '../../../../Providers/fabric_specifications_provider.dart';
import 'fabric_list_body.dart';

class FabricSpecificationListFuture extends StatefulWidget {
  final String locality;

  const FabricSpecificationListFuture({Key? key, required this.locality})
      : super(key: key);

  @override
  FabricSpecificationListFutureState createState() => FabricSpecificationListFutureState();
}

class FabricSpecificationListFutureState extends State<FabricSpecificationListFuture>{

  GetSpecificationRequestModel getRequestModel = GetSpecificationRequestModel();
  GlobalKey<FabricListBodyState> fabricListBodyState = GlobalKey<FabricListBodyState>();

  @override
  void initState() {
    getRequestModel.locality = widget.locality;
    getRequestModel.categoryId = 3.toString();
    final fabricSpecificationsProvider = Provider.of<FabricSpecificationsProvider>(context, listen: false);
    fabricSpecificationsProvider.setRequestParams(getRequestModel, widget.locality);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final fabricSpecificationsProvider = Provider.of<FabricSpecificationsProvider>(context);
    return FutureBuilder<FabricSpecificationResponse>(
      future:fabricSpecificationsProvider.getFabrics(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null) {
          return snapshot.data!.data!=null
              ? FabricListBody(
                  key: fabricListBodyState,
                  specification: fabricSpecificationsProvider.fabricSpecificationResponse!.data!.specification!)
              : const Center(
                  child: TitleSmallTextWidget(title: "No Data Found"));
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
      data.categoryId = YARN_CATEGORY_ID.toString();
      getRequestModel = data;
    });
  }
}
