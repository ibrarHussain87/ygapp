import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:yg_app/model/request/post_ad_request/fiber_request.dart';
import 'package:yg_app/model/response/yarn_response/sync/yarn_sync_response.dart';
import 'package:yg_app/pages/post_ad_pages/spinning_post/component/yarn_steps_segments.dart';
import 'package:yg_app/helper_utils/app_constants.dart';
import 'package:yg_app/elements/list_widgets/list_widget_colored.dart';
import 'package:yg_app/elements/list_widgets/material_listview_widget.dart';
import 'package:yg_app/elements/title_text_widget.dart';
import 'package:yg_app/elements/yarn_widgets/listview_famiy_tile.dart';

class FamilyBlendAdsBody extends StatefulWidget {
  final YarnSyncResponse yarnSyncResponse;
  final String? locality;
  final String? businessArea;
  final String? selectedTab;

  const FamilyBlendAdsBody(
      {Key? key,
      required this.yarnSyncResponse,
      required this.selectedTab,
      required this.locality,
      required this.businessArea})
      : super(key: key);

  @override
  _FamilyBlendAdsBodyState createState() => _FamilyBlendAdsBodyState();
}

class _FamilyBlendAdsBodyState extends State<FamilyBlendAdsBody> {


  //Steps Segment State
  GlobalKey<YarnStepsSegmentsState> yarnStepStateKey =
      GlobalKey<YarnStepsSegmentsState>();

  late CreateRequestModel _createRequestModel;

  @override
  Widget build(BuildContext context) {
    _createRequestModel = Provider.of<CreateRequestModel>(context);
    _createRequestModel.ys_family_idfk = widget.yarnSyncResponse.data.yarn.family[0].famId.toString();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(top: 16.w, left: 16.w, right: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleTextWidget(title: yarnCategory),
              SizedBox(
                height: 8.w,
              ),
              SizedBox(
                height: 0.055*MediaQuery.of(context).size.height,
                child: FamilyTileWidget(
                  listItems: widget.yarnSyncResponse.data.yarn.family,
                  callback: (value) {
                    //Family Id
                    _createRequestModel.ys_family_idfk = widget.yarnSyncResponse.data.yarn.family[value].famId.toString();
                  },
                ),
              ),
              SizedBox(
                height: 8.w,
              ),
            ],
          ),
        ),
        Padding(
            padding: EdgeInsets.only(left: 16.w, bottom: 8.w),
            child: TitleTextWidget(title: blend)),
        MaterialListviewWidget(
          listItem: widget.yarnSyncResponse.data.yarn.blends,
          onClickCallback: (value) {
            yarnStepStateKey.currentState!.onClickBlend(value);
          },
        ),
        Expanded(
          child: YarnStepsSegments(
            key: yarnStepStateKey,
            yarnSyncResponse: widget.yarnSyncResponse,
            selectedTab: widget.selectedTab,
            businessArea: widget.businessArea,
            locality: widget.locality,
          ),
        )
      ],
    );
  }
}
