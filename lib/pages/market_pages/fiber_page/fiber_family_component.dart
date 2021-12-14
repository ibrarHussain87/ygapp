import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/api_services/api_service_class.dart';
import 'package:yg_app/model/response/fiber_response/sync/sync_fiber_response.dart';
import 'package:yg_app/utils/app_images.dart';
import 'package:yg_app/widgets/material_listview_widget.dart';
import 'package:yg_app/widgets/title_text_widget.dart';

class FiberFamilyComponent extends StatefulWidget {

  final Function callback;

  const FiberFamilyComponent({Key? key,required this.callback}) : super(key: key);

  @override
  _FiberFamilyComponentState createState() => _FiberFamilyComponentState();
}

class _FiberFamilyComponentState extends State<FiberFamilyComponent> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SyncFiberResponse>(
        future: ApiService.syncFiber(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Visibility(
                  visible: false,
                  child: Padding(
                      padding:
                          EdgeInsets.only(bottom: 4.w, left: 16.w, right: 16.w),
                      child: const TitleTextWidget(
                        title: 'Fiber Material',
                      )),
                ),
                MaterialListviewWidget(
                  listItem: snapshot.data!.data.fiber.material,
                  onClickCallback: (index) {
                    widget.callback(snapshot.data!.data.fiber.material[index]);
                  },
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Center(
                child: TitleSmallTextWidget(title: snapshot.error.toString()));
          } else {
            return Container(
              padding: EdgeInsets.only(left: 8.w,right: 8.w),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.w),
                child: Image.asset(
                  AppImages.loading,
                  height: 0.07 * MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.fill,
                ),
              ),
            );
          }
        });
  }
}
