import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/api_services/api_service_class.dart';
import 'package:yg_app/model/response/yarn_response/sync/yarn_sync_response.dart';
import 'package:yg_app/helper_utils/app_constants.dart';
import 'package:yg_app/elements/loading_widgets/loading_listing.dart';
import 'package:yg_app/elements/list_widgets/material_listview_widget.dart';
import 'package:yg_app/elements/title_text_widget.dart';
import 'package:yg_app/elements/yarn_widgets/listview_famiy_tile.dart';

class YarnFamilyBlendListingBody extends StatefulWidget {
  final Function yarnFamilyCallback;
  final Function blendCallback;

  const YarnFamilyBlendListingBody(
      {Key? key, required this.yarnFamilyCallback, required this.blendCallback})
      : super(key: key);

  @override
  _YarnFamilyBlendListingBodyState createState() =>
      _YarnFamilyBlendListingBodyState();
}

class _YarnFamilyBlendListingBodyState
    extends State<YarnFamilyBlendListingBody> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<YarnSyncResponse>(
      future: ApiService.syncYarn(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(left: 8.w, right: 8.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Visibility(visible:false,child: TitleTextWidget(title: yarnCategory)),
                    // SizedBox(
                    //   height: 8.w,
                    // ),
                    SizedBox(
                      height: 0.055 * MediaQuery.of(context).size.height,
                      child: FamilyTileWidget(
                        listItems: snapshot.data!.data.yarn.family,
                        callback: (value) {
                          widget.yarnFamilyCallback(
                              snapshot.data!.data.yarn.family[value]);
                        },
                      ),
                    ),
                    SizedBox(
                      height: 8.w,
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: false,
                child: Padding(
                    padding: EdgeInsets.only(left: 16.w, bottom: 8.w),
                    child: TitleTextWidget(title: blend)),
              ),
              MaterialListviewWidget(
                listItem: snapshot.data!.data.yarn.blends,
                onClickCallback: (value) {
                  widget.blendCallback(snapshot.data!.data.yarn.blends[value]);
                },
              ),
            ],
          );
        } else if (snapshot.hasError) {
          return TitleSmallTextWidget(title: snapshot.error.toString());
        } else {
          return SizedBox(
              height: 0.15 * MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  Expanded(child: LoadingListing()),
                  Expanded(child: LoadingListing())
                ],
              ));
        }
      },
    );
  }
}
