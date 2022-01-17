import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/app_database/app_database_instance.dart';
import 'package:yg_app/elements/list_widgets/cat_with_image_listview_widget.dart';
import 'package:yg_app/elements/title_text_widget.dart';
import 'package:yg_app/elements/yarn_widgets/listview_famiy_tile.dart';
import 'package:yg_app/helper_utils/app_constants.dart';
import 'package:yg_app/helper_utils/ui_utils.dart';
import 'package:yg_app/model/response/yarn_response/sync/yarn_sync_response.dart';

class BlendFamily extends StatefulWidget {
  final YarnSyncResponse yarnSyncResponse;
  final Function yarnFamilyCallback;
  final Function blendCallback;

  const BlendFamily(
      {Key? key,
      required this.yarnSyncResponse,
      required this.yarnFamilyCallback,
      required this.blendCallback})
      : super(key: key);

  @override
  _BlendFamilyState createState() => _BlendFamilyState();
}

class _BlendFamilyState extends State<BlendFamily> {

  late YarnSetting _yarnSetting;

  int? selectedFamilyId;

  @override
  void initState() {
    _yarnSetting = widget.yarnSyncResponse.data.yarn.setting!.first;
    selectedFamilyId = widget.yarnSyncResponse.data.yarn.family!.first.famId;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(left: 8.w, right: 8.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Visibility(
                  visible: false,
                  child: TitleTextWidget(title: yarnCategory)),
              SizedBox(
                height: 0.055 * MediaQuery.of(context).size.height,
                child: FamilyTileWidget(
                  listItems: widget.yarnSyncResponse.data.yarn.family,
                  callback: (value) {
                    queryFamilySettings(widget
                        .yarnSyncResponse.data.yarn.family![value].famId!);
                    widget.yarnFamilyCallback(
                        widget.yarnSyncResponse.data.yarn.family![value]);
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
        Visibility(
          visible: Ui.showHide(_yarnSetting.showBlend),
          child: CatWithImageListWidget(
            listItem: widget.yarnSyncResponse.data.yarn.blends!
                .where((element) =>
                    element.familyIdfk == selectedFamilyId.toString())
                .toList(),
            onClickCallback: (value) {
              widget.blendCallback(widget.yarnSyncResponse.data.yarn.blends![value]);
            },
          ),
        ),
      ],
    );
  }

  queryFamilySettings(int id) {
    AppDbInstance.getDbInstance().then((value) async {
      value.yarnSettingsDao.findFamilyYarnSettings(id).then((value) {
        setState(() {
          selectedFamilyId = id;
          if (value.isNotEmpty) {
            _yarnSetting = value[0];
          }/*else {
            Ui.showSnackBar(context, 'No Settings Found');
          }*/
        });
      });
    });
  }
}
