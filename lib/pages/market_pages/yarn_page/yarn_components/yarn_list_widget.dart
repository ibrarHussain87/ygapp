import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yg_app/api_services/api_service_class.dart';
import 'package:yg_app/model/request/filter_request/fiber_filter_request.dart';
import 'package:yg_app/model/response/yarn_response/yarn_specification_response.dart';
import 'package:yg_app/elements/title_text_widget.dart';
import 'package:yg_app/elements/list_items_widgets/yarn_list_items.dart';

class YarnSpecificationList extends StatefulWidget {
  final String locality;

  const YarnSpecificationList({Key? key, required this.locality})
      : super(key: key);

  @override
  YarnSpecificationListState createState() => YarnSpecificationListState();
}

class YarnSpecificationListState extends State<YarnSpecificationList> {
  GetSpecificationRequestModel getRequestModel = GetSpecificationRequestModel();

  @override
  void initState() {
    getRequestModel.locality = widget.locality;
    getRequestModel.categoryId = 2.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<GetYarnSpecificationResponse>(
      future: ApiService.getYarnSpecifications(getRequestModel, widget.locality),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null) {
          return ListView.builder(
            itemCount: snapshot.data!.data.specification.length,
              itemBuilder: (context, index) {
            return buildYarnWidget(snapshot.data!.data.specification[index]);
          });
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

  searchData(GetSpecificationRequestModel data){
    setState(() {
      data.categoryId = '2';
      getRequestModel = data;

    });
  }
}
