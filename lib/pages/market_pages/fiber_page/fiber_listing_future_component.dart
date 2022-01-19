import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:yg_app/api_services/api_service_class.dart';
import 'package:yg_app/elements/title_text_widget.dart';
import 'package:yg_app/model/request/filter_request/filter_request.dart';
import 'package:yg_app/model/response/fiber_response/fiber_specification.dart';
import 'package:yg_app/pages/market_pages/fiber_page/fiber_listing_body.dart';

class FiberListingComponent extends StatefulWidget {
  final String? locality;

  const FiberListingComponent({Key? key, required this.locality})
      : super(key: key);

  @override
  FiberListingComponentState createState() => FiberListingComponentState();
}

class FiberListingComponentState extends State<FiberListingComponent> {
  GetSpecificationRequestModel getRequestModel = GetSpecificationRequestModel();
  GlobalKey<FiberListingBodyState> fiberListingBodyState = GlobalKey<
      FiberListingBodyState>();

  @override
  void initState() {
    getRequestModel.isOffering = "1";
    getRequestModel.categoryId = "1";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FiberSpecificationResponse>(
      future:
      ApiService.getFiberSpecifications(getRequestModel, widget.locality),
      builder: (BuildContext context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null) {
          return Container(
            child: snapshot.data!.data.specification.isNotEmpty
                ? FiberListingBody(
              key: fiberListingBodyState,
              specification: snapshot.data!.data.specification,
            )
                : const Center(
              child: TitleSmallTextWidget(
                title: 'No Data Found',
              ),
            ),
          );
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

  refreshListing(GetSpecificationRequestModel filterRequestModel) {
    setState(() {
      filterRequestModel.categoryId = '1';
      getRequestModel = filterRequestModel;
    });
  }
}
