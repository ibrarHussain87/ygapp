import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/elements/list_widgets/blend_with_image_listview_widget.dart';
import 'package:yg_app/elements/text_widgets.dart';
import 'package:yg_app/helper_utils/app_constants.dart';
import 'package:yg_app/locators.dart';
import 'package:yg_app/providers/fabric_providers/fabric_specifications_provider.dart';
import '../../../../elements/list_widgets/single_select_tile_renewed_widget.dart';

class FabricBlendFamily extends StatefulWidget {
  final Function fabricFamilyCallback;
  final Function blendCallback;
  bool showBlends;

  FabricBlendFamily(
      {Key? key,
      required this.fabricFamilyCallback,
      required this.blendCallback,this.showBlends= true})
      : super(key: key);

  @override
  _FabricBlendFamilyState createState() => _FabricBlendFamilyState();
}

class _FabricBlendFamilyState extends State<FabricBlendFamily> {
  // FabricSetting? _fabricSetting;
  bool? showBlends;
  int? selectedFamilyId;

  final GlobalKey<SingleSelectTileRenewedWidgetState> _fabricBlendKey =
      GlobalKey<SingleSelectTileRenewedWidgetState>();
  final _fabricSpecificationProvider = locator<FabricSpecificationsProvider>();

  // _getFabricDataFromDb() {
  //   AppDbInstance().getDbInstance().then((value) async {
  //     await value.fabricFamilyDao.findAllFabricFamily().then((value) {
  //       setState(() {
  //         _fabricFamily = value;
  //         selectedFamilyId = _fabricFamily!.first.fabricFamilyId;
  //       });
  //     });
  //     await value.fabricBlendsDao.findAllFabricBlends().then((value) {
  //       setState(() {
  //         _fabricBlends = value;
  //
  //       });
  //     });
  //     // await value.fabricSettingDao.findFamilyFabricSettings(_fabricFamily!.first.fabricFamilyId!)
  //     //     .then((value) => setState(() => _fabricSetting = value[0]));
  //   });
  // }

  @override
  void initState() {
    // _getFabricDataFromDb();
    super.initState();
    _fabricSpecificationProvider.getFamilyData();
    _fabricSpecificationProvider.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _fabricSpecificationProvider.fabricBlends = [];
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
                  child: TitleTextWidget(title: fabricCategory)),
              SizedBox(
                height: 0.055 * MediaQuery.of(context).size.height,
                child: BlendsWithImageListWidget(
                  selectedItem: -1,
                  listItem: _fabricSpecificationProvider.fabricFamily,
                  onClickCallback: (value) {
                    var item = _fabricSpecificationProvider.fabricFamily[value];
                    // queryFamilySettings(item.fabricFamilyId!);
                    _fabricSpecificationProvider.getFabricBlends(
                        _fabricSpecificationProvider
                            .fabricFamily[value].fabricFamilyId!);
                    widget.fabricFamilyCallback(item);
                    if (_fabricBlendKey.currentState != null) {
                      _fabricBlendKey.currentState!.checkedTile = -1;
                    }
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
          visible: _fabricSpecificationProvider.fabricBlends.isNotEmpty && widget.showBlends,
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
            child: Padding(
              padding: const EdgeInsets.only(top: 5, bottom: 5, left: 8),
              child: SingleSelectTileRenewedWidget(
                key: _fabricBlendKey,
                selectedIndex: -1,
                spanCount: 2,
                listOfItems: _fabricSpecificationProvider.fabricBlends,
                callback: (value) {
                  widget.blendCallback(value, selectedFamilyId);
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

// queryFamilySettings(int id) {
//   AppDbInstance().getDbInstance().then((value) async {
//     value.fabricSettingDao.findFamilyFabricSettings(id).then((value) {
//       setState(() {
//         selectedFamilyId = id;
//         if (value.isNotEmpty) {
//           _fabricSetting = value[0];
//         } /*else {
//           Ui.showSnackBar(context, 'No Settings Found');
//         }*/
//       });
//     });
//   });
// }
}
