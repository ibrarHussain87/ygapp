import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_broadcast_receiver/flutter_broadcast_receiver.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:yg_app/api_services/api_service_class.dart';
import 'package:yg_app/app_database/app_database_instance.dart';
import 'package:yg_app/elements/title_text_widget.dart';
import 'package:yg_app/helper_utils/app_constants.dart';
import 'package:yg_app/model/request/post_ad_request/create_request_model.dart';
import 'package:yg_app/model/response/fiber_response/sync/sync_fiber_response.dart';
import 'package:yg_app/pages/post_ad_pages/fabric_post/component/fabric_nature_material_component.dart';
import 'package:yg_app/pages/post_ad_pages/fiber_post/component/fiber_nature_material_component.dart';
import 'package:yg_app/pages/post_ad_pages/fiber_post/component/fiber_steps_segments.dart';

import '../../../Providers/post_fabric_provider.dart';
import 'component/fabric_steps_segments.dart';

class FabricPostPage extends StatefulWidget {
  final String? locality;
  final String? businessArea;
  final String? selectedTab;

  const FabricPostPage(
      {Key? key, required this.locality, this.businessArea, this.selectedTab})
      : super(key: key);

  @override
  _FabricPostPageState createState() => _FabricPostPageState();
}

class _FabricPostPageState extends State<FabricPostPage> {

  CreateRequestModel? _createRequestModel;

  @override
  void initState() {
    _createRequestModel = CreateRequestModel();
    final postFabricProvider =
        Provider.of<PostFabricProvider>(context, listen: false);
    postFabricProvider.getSyncData();
    super.initState();
  }

  @override
  void dispose() {
    //Dispose broadcast
    /*BroadcastReceiver().unsubscribe(segmentIndexBroadcast);
    BroadcastReceiver().unsubscribe(requestModelBroadCast);*/
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final postFabricProvider = Provider.of<PostFabricProvider>(context);
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            body: setFabricBody(postFabricProvider)));
  }

  Widget setFabricBody(PostFabricProvider postFabricProvider) {
    if (postFabricProvider.dataSynced) {
      return getView(postFabricProvider);
    } else {
      return const Center(
          child: TitleSmallTextWidget(title: 'Something went wrong'));
    }
  }

  Widget getView(PostFabricProvider postFabricProvider) {
    int selectedSegment = 1;
    return Padding(
      padding: EdgeInsets.only(left: 8.w, right: 8.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          FabricNatureMaterialComponent(
              natureList: postFabricProvider.fabricFamilyList,
              materialList: postFabricProvider.fabricBlendsList),
          Visibility(
            visible: widget.businessArea == offering_type,
              child: const SizedBox(height: 20,)
          ),
          Expanded(
            child: FabricStepsSegments(
              // syncFiberResponse: data,
              locality: widget.locality,
              businessArea: widget.businessArea,
              selectedTab: widget.selectedTab,
              stepsCallback: (value) {
                if (value is int) {
                  selectedSegment = value;
                  /*BroadcastReceiver().publish<int>(segmentIndexBroadcast,
                      arguments: selectedSegment);*/
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
