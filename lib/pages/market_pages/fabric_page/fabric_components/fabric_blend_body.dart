import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/app_database/app_database_instance.dart';
import 'package:yg_app/elements/list_widgets/cat_with_image_listview_widget.dart';
import 'package:yg_app/elements/title_text_widget.dart';
import 'package:yg_app/helper_utils/app_constants.dart';
import 'package:yg_app/helper_utils/ui_utils.dart';

import '../../../../elements/list_widgets/single_select_tile_renewed_widget.dart';
import '../../../../model/response/fabric_response/sync/fabric_sync_response.dart';

class FabricBlendFamily extends StatefulWidget {
  final Function fabricFamilyCallback;
  final Function blendCallback;

  const FabricBlendFamily(
      {Key? key,
      required this.fabricFamilyCallback,
      required this.blendCallback})
      : super(key: key);

  @override
  _FabricBlendFamilyState createState() => _FabricBlendFamilyState();
}

class _FabricBlendFamilyState extends State<FabricBlendFamily> {

  FabricSetting? _fabricSetting;
  int? selectedFamilyId;
  List<FabricFamily>? _fabricFamily;
  List<FabricBlends>? _fabricBlends;

  final GlobalKey<SingleSelectTileWidgetState> _fabricBlendKey =
  GlobalKey<SingleSelectTileWidgetState>();

  _getYarnDataFromDb() {
    AppDbInstance.getDbInstance().then((value) async {
      await value.fabricFamilyDao.findAllFabricFamily().then((value) {
        setState(() {
          _fabricFamily = value;
        });
      });
      await value.fabricBlendsDao.findAllFabricBlends().then((value) {
        setState(() {
          _fabricBlends = value;
        });
      });
      await value.fabricSettingDao.findFamilyFabricSettings(_fabricFamily!.first.fabricFamilyId!)
          .then((value) => setState(() => _fabricSetting = value[0]));
    });
  }

  @override
  void initState() {
    _getYarnDataFromDb();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return (_fabricSetting != null && _fabricFamily != null && _fabricBlends != null)
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(left: 8.w, right: 8.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Visibility(
                        visible: false,
                        child: TitleTextWidget(title: fabricCategory)),
                    SizedBox(
                      height: 0.055 * MediaQuery.of(context).size.height,
                      child:CatWithImageListWidget(
                        selectedItem: -1,
                        listItem: _fabricFamily,
                        onClickCallback: (value) {
                          var item = _fabricFamily![value];
                          queryFamilySettings(item.fabricFamilyId!);
                          widget.fabricFamilyCallback(item);
                          if(_fabricBlendKey.currentState!= null) _fabricBlendKey.currentState!.checkedTile = -1;
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
                visible: Ui.showHide(_fabricSetting!.showBlend),
                child:
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.05,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5,bottom: 5,left: 8),
                    child: SingleSelectTileRenewedWidget(
                      key: _fabricBlendKey,
                      selectedIndex: -1,
                      spanCount: 2,
                      listOfItems: _fabricBlends!
                          .where((element) =>
                      element.familyIdfk == selectedFamilyId.toString())
                          .toList(),
                      callback: (value) {
                        widget.blendCallback(value, selectedFamilyId);
                      },
                    ),
                  ),
                ),
              ),
            ],
          )
        : Container();
  }

  queryFamilySettings(int id) {
    AppDbInstance.getDbInstance().then((value) async {
      value.fabricSettingDao.findFamilyFabricSettings(id).then((value) {
        setState(() {
          selectedFamilyId = id;
          if (value.isNotEmpty) {
            _fabricSetting = value[0];
          } /*else {
            Ui.showSnackBar(context, 'No Settings Found');
          }*/
        });
      });
    });
  }
}
