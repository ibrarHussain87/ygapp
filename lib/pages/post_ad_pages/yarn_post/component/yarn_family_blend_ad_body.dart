import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:yg_app/app_database/app_database_instance.dart';
import 'package:yg_app/elements/list_widgets/cat_with_image_listview_widget.dart';
import 'package:yg_app/elements/title_text_widget.dart';
import 'package:yg_app/elements/yarn_widgets/listview_famiy_tile.dart';
import 'package:yg_app/helper_utils/app_constants.dart';
import 'package:yg_app/helper_utils/ui_utils.dart';
import 'package:yg_app/model/request/post_ad_request/create_request_model.dart';
import 'package:yg_app/model/response/yarn_response/sync/yarn_sync_response.dart';
import 'package:yg_app/pages/post_ad_pages/yarn_post/component/yarn_steps_segments.dart';

class FamilyBlendAdsBody extends StatefulWidget {
  // final YarnSyncResponse yarnSyncResponse;
  final String? locality;
  final String? businessArea;
  final String? selectedTab;

  const FamilyBlendAdsBody(
      {Key? key,
      // required this.yarnSyncResponse,
      required this.selectedTab,
      required this.locality,
      required this.businessArea})
      : super(key: key);

  @override
  _FamilyBlendAdsBodyState createState() => _FamilyBlendAdsBodyState();
}

class _FamilyBlendAdsBodyState extends State<FamilyBlendAdsBody> {
  //Globel Keys
  GlobalKey<YarnStepsSegmentsState> yarnStepStateKey =
      GlobalKey<YarnStepsSegmentsState>();

  final GlobalKey<FamilyTileWidgetState> _familyTileKey =
      GlobalKey<FamilyTileWidgetState>();
  final GlobalKey<CatWithImageListWidgetState> _blendTileKey =
      GlobalKey<CatWithImageListWidgetState>();

  late CreateRequestModel _createRequestModel;
  late YarnSetting _yarnSetting;
  late String? selectedFamilyId;
  late List<Family> _familyList;
  late List<Blends> _blendsList;

  _getSyncedData() async {
    await AppDbInstance.getYarnFamilyData().then((value) => setState(() {
          _familyList = value;
          selectedFamilyId =
              value.first.famId.toString();
        }));
    await AppDbInstance.getYarnBlendData()
        .then((value) => setState(() => _blendsList = value));
    await AppDbInstance.getYarnSettings().then((value) {
      setState(() {
        _yarnSetting = value.first;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    _getSyncedData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _createRequestModel = Provider.of<CreateRequestModel>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(top: 16.w, left: 16.w, right: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Visibility(
                  visible: false,
                  child: TitleTextWidget(title: yarnCategory)
              ),
              SizedBox(
                height: 10.w,
              ),
              SizedBox(
                height: 0.055 * MediaQuery.of(context).size.height,
                child: FamilyTileWidget(
                  key: _familyTileKey,
                  listItems: _familyList,
                  callback: (Family value) {
                    //Family Id
                    setState(() {
                      selectedFamilyId = value.famId.toString();
                    });
                    _createRequestModel.ys_family_idfk = selectedFamilyId;
                    queryFamilySettings(value.famId!);
                    yarnStepStateKey.currentState!.onClickFamily(value.famId);
                  },
                ),
              ),
              SizedBox(
                height: 15.w,
              ),
            ],
          ),
        ),
        Visibility(
          visible: Ui.showHide(_yarnSetting.showBlend),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Visibility(
                visible: false,
                child: Padding(
                    padding: EdgeInsets.only(left: 16.w, bottom: 8.w),
                    child: TitleTextWidget(title: blend)),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.w),
                child: CatWithImageListWidget(
                  selectedItem: -1,
                  key: _blendTileKey,
                  listItem: _blendsList
                      .where(
                          (element) => element.familyIdfk == selectedFamilyId)
                      .toList(),
                  onClickCallback: (value) {
                    yarnStepStateKey.currentState!.onClickBlend(value);
                  },
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20,),
        Expanded(
          child: Provider(
            create: (_) => _yarnSetting,
            child: YarnStepsSegments(
              key: yarnStepStateKey,
              // yarnSyncResponse: widget.yarnSyncResponse,
              selectedTab: widget.selectedTab,
              businessArea: widget.businessArea,
              locality: widget.locality,
              callback: (int step) {
                if (step > 1) {
                  if (_familyTileKey.currentState != null) {
                    _familyTileKey.currentState!.disableClick = true;
                  }
                  if (_blendTileKey.currentState != null) {
                    _blendTileKey.currentState!.disableClick = true;
                  }
                }
              },
            ),
          ),
        )
      ],
    );
  }

  queryFamilySettings(int id) {
    AppDbInstance.getDbInstance().then((value) async {
      value.yarnSettingsDao.findFamilyYarnSettings(id).then((value) {
        setState(() {
          if (value.isNotEmpty) {
            _yarnSetting = value[0];
          }
          // } else {
          //   Ui.showSnackBar(context, 'No Settings Found');
          // }
        });
      });
    });
  }
}
