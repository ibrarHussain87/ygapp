import 'package:flutter/material.dart';
import 'package:yg_app/api_services/api_service_class.dart';
import 'package:yg_app/elements/loading_widgets/loading_listing.dart';
import 'package:yg_app/elements/title_text_widget.dart';
import 'package:yg_app/model/response/yarn_response/sync/yarn_sync_response.dart';
import 'package:yg_app/pages/market_pages/yarn_page/yarn_components/family_blend_body.dart';

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
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<YarnSyncResponse>(
      future: ApiService.syncYarn(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          return BlendFamily(
            yarnSyncResponse: snapshot.data!,
            yarnFamilyCallback: (value) {
              widget.yarnFamilyCallback(value);
            },
            blendCallback: (value) {
              widget.blendCallback(value);
            },
          );
        } else if (snapshot.hasError) {
          return TitleSmallTextWidget(title: snapshot.error.toString());
        } else {
          return SizedBox(
              height: 0.15 * MediaQuery.of(context).size.height,
              child: Column(
                children: const [
                  Expanded(child: LoadingListing()),
                  Expanded(child: LoadingListing())
                ],
              ));
        }
      },
    );
  }
}
