import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/api_services/api_service_class.dart';
import 'package:yg_app/model/response/fiber_response/sync/sync_fiber_response.dart';
import 'package:yg_app/widgets/loading_widgets/loading_listing.dart';
import 'package:yg_app/widgets/material_listview_widget.dart';
import 'package:yg_app/widgets/title_text_widget.dart';

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
            return Container(
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Visibility(
                    visible: false,
                    child: Padding(
                        padding: EdgeInsets.only(left: 16.w, right: 16.w),
                        child: const TitleTextWidget(
                          title: 'Fiber Material',
                        )),
                  ),
                  MaterialListviewWidget(
                    listItem: snapshot.data!.data.fiber.material,
                    onClickCallback: (index) {
                      widget
                          .callback(snapshot.data!.data.fiber.material[index]);
                    },
                  ),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
                child: TitleSmallTextWidget(title: snapshot.error.toString()));
          } else {
            return Container(
              child: LoadingListing(),
              height: 0.065 * MediaQuery.of(context).size.height,
            );
          }
        });
  }
}
