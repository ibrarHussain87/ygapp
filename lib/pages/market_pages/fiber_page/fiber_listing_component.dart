import 'package:flutter/material.dart';
import 'package:yg_app/api_services/api_service_class.dart';
import 'package:yg_app/elements/list_items_widgets/fiber_market_list_item.dart';
import 'package:yg_app/helper_utils/navigation_utils.dart';
import 'package:yg_app/model/request/filter_request/fiber_filter_request.dart';
import 'package:yg_app/model/response/fiber_response/fiber_specification.dart';
import 'package:yg_app/pages/detail_pages/fiber_detail_page/main_fiber_detail_page.dart';
import 'package:yg_app/elements/title_text_widget.dart';

class FiberListingComponent extends StatefulWidget {

  final String? locality;

  const FiberListingComponent({Key? key,required this.locality}) : super(key: key);

  @override
  FiberListingComponentState createState() => FiberListingComponentState();
}

class FiberListingComponentState extends State<FiberListingComponent> {

  GetSpecificationRequestModel getRequestModel = GetSpecificationRequestModel();

  @override
  void initState() {
    getRequestModel.isOffering = "1";
    getRequestModel.categoryId = "1";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FiberSpecificationResponse>(
      future: ApiService.getFiberSpecifications(getRequestModel,widget.locality),
      builder: (BuildContext context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null) {
          return Container(
            child: snapshot.data!.data.specification.isNotEmpty
                ? ListView.builder(
              itemCount: snapshot.data!.data.specification.length,
              itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    openFiberDetailsScreen(context,snapshot.data!.data.specification[index]);
                  },
                  child: buildFiberWidget(snapshot.data!.data.specification[index])),
              // separatorBuilder: (context, index) {
              //   return Divider(
              //     height: 1,
              //     color: Colors.grey.shade400,
              //   );
              // },
            )
                : const Center(
              child: TitleSmallTextWidget(
                title: 'No Data Found',
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Center(
              child: TitleTextWidget(title: snapshot.error.toString()));
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  refreshListing(
      GetSpecificationRequestModel filterRequestModel) {
      setState(() {
        filterRequestModel.categoryId = '1';
        getRequestModel = filterRequestModel;
      });
  }
}
