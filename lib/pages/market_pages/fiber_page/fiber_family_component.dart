import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/api_services/api_service_class.dart';
import 'package:yg_app/elements/list_widgets/grid_tile_widget.dart';
import 'package:yg_app/elements/list_widgets/material_listview_widget.dart';
import 'package:yg_app/elements/loading_widgets/loading_listing.dart';
import 'package:yg_app/elements/title_text_widget.dart';
import 'package:yg_app/model/response/fiber_response/sync/sync_fiber_response.dart';
import 'package:yg_app/pages/market_pages/fiber_page/nature_family_body.dart';

class FiberFamilyComponent extends StatefulWidget {
  final Function callback;

  const FiberFamilyComponent({Key? key, required this.callback})
      : super(key: key);

  @override
  FiberFamilyComponentState createState() => FiberFamilyComponentState();
}

class FiberFamilyComponentState extends State<FiberFamilyComponent> {
  SyncFiberResponse? fiberSyncResponse;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SyncFiberResponse>(
        future: ApiService.syncFiber(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            fiberSyncResponse = snapshot.data!;
            return NatureFamilyBody(syncFiberResponse: fiberSyncResponse!,callback: (value){
              widget.callback(
                fiberSyncResponse!.data.fiber.material[value]);},);
          } else if (snapshot.hasError) {
            return Center(
                child: TitleSmallTextWidget(title: snapshot.error.toString()));
          } else {
            return Container(
              child: LoadingListing(),
              height: 0.065 * MediaQuery
                  .of(context)
                  .size
                  .height,
            );
          }
        });
  }
}
