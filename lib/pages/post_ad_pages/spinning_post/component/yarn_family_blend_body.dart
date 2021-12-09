import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/model/response/yarn_response/sync/yarn_sync_response.dart';
import 'package:yg_app/pages/post_ad_pages/spinning_post/component/yarn_steps_segments.dart';
import 'package:yg_app/utils/strings.dart';
import 'package:yg_app/widgets/list_widget_colored.dart';
import 'package:yg_app/widgets/material_listview_widget.dart';
import 'package:yg_app/widgets/title_text_widget.dart';
import 'package:yg_app/widgets/yarn_widgets/listview_famiy_tile.dart';

class FamilyBlendBody extends StatefulWidget {
  final YarnSyncResponse yarnSyncResponse;
  final String? locality;
  final String? businessArea;
  final String? selectedTab;

  const FamilyBlendBody(
      {Key? key,
      required this.yarnSyncResponse,
      required this.selectedTab,
      required this.locality,
      required this.businessArea})
      : super(key: key);

  @override
  _FamilyBlendBodyState createState() => _FamilyBlendBodyState();
}

class _FamilyBlendBodyState extends State<FamilyBlendBody> {
  GlobalKey<YarnStepsSegmentsState> yarnStepStateKey =
      GlobalKey<YarnStepsSegmentsState>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(top: 16.w, left: 16.w, right: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleTextWidget(title: AppStrings.yarnCategory),
              SizedBox(
                height: 8.w,
              ),
              SizedBox(
                height: 0.055*MediaQuery.of(context).size.height,
                child: FamilyTileWidget(
                  listItems: widget.yarnSyncResponse.data.yarn.family,
                  callback: (value) {},
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
            child: TitleTextWidget(title: AppStrings.blend)),
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
