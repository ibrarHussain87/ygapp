import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:yg_app/app_database/app_database_instance.dart';
import 'package:yg_app/model/request/post_ad_request/fiber_request.dart';
import 'package:yg_app/model/response/yarn_response/sync/yarn_sync_response.dart';
import 'package:yg_app/helper_utils/app_colors.dart';
import 'package:yg_app/helper_utils/numeriacal_range_text_field.dart';
import 'package:yg_app/helper_utils/shared_pref_util.dart';

import 'package:yg_app/helper_utils/string_util.dart';
import 'package:yg_app/helper_utils/app_constants.dart';
import 'package:yg_app/helper_utils/ui_utils.dart';
import 'package:yg_app/elements/decoration_widgets.dart';
import 'package:yg_app/elements/elevated_button_widget.dart';
import 'package:yg_app/elements/list_widgets/grid_tile_widget.dart';
import 'package:yg_app/elements/title_text_widget.dart';

class YarnSpecificationComponent extends StatefulWidget {

  final YarnSyncResponse yarnSyncResponse;
  final String? locality;
  final String? businessArea;
  final String? selectedTab;
  final Function? callback;

  const YarnSpecificationComponent(
      {Key? key,
      this.callback,
      required this.yarnSyncResponse,
      required this.locality,
      required this.businessArea,
      required this.selectedTab})
      : super(key: key);

  @override
  YarnSpecificationComponentState createState() =>
      YarnSpecificationComponentState();
}

class YarnSpecificationComponentState extends State<YarnSpecificationComponent>
    with AutomaticKeepAliveClientMixin {

  final GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  // DateTime selectedDate = DateTime.now();
  late YarnSetting _yarnSetting;
  late CreateRequestModel _createRequestModel;
  int selectedBlend = 1;
  bool showPatternCharc = true;
  late List<PatternCharectristic> _patternCharactristicList;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    _yarnSetting = widget.yarnSyncResponse.data.yarn.setting.first;
    _patternCharactristicList = widget.yarnSyncResponse.data.yarn.patternCharectristic.where((element) => element.ypcPatternIdfk == widget.yarnSyncResponse.data.yarn.pattern[0].ypId.toString()).toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _createRequestModel = Provider.of<CreateRequestModel>(context);
    _initGridValues();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      key: scaffoldKey,
      body: Provider(
        create: (_) => _yarnSetting,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 9,
              child: Padding(
                padding: EdgeInsets.only(top: 16.w, left: 24.w, right: 24.w),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 8.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TitleTextWidget(
                              title: specifications,
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 2.w),
                              child: Text(
                                selectSpecifications,
                                style: TextStyle(
                                    fontSize: 11.sp,
                                    color: Colors.grey.shade600),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Form(
                        key: globalFormKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 8.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                      padding: EdgeInsets.only(left: 8.w),
                                      child: TitleSmallTextWidget(
                                          title: grades)),
                                  GridTileWidget(
                                    spanCount: 3,
                                    listOfItems: widget
                                        .yarnSyncResponse.data.yarn.grades,
                                    callback: (value) {
                                      _createRequestModel.spc_grade_idfk =
                                          widget.yarnSyncResponse.data.yarn
                                              .grades[value].grdId
                                              .toString();
                                    },
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 8.w,
                            ),
                            Row(
                              children: [
                                Visibility(
                                  visible: Ui.showHide(_yarnSetting.showRatio),
                                  child: Expanded(
                                    child: Column(
                                      children: [
                                        Padding(
                                            padding: EdgeInsets.only(left: 4.w),
                                            child: TitleSmallTextWidget(
                                                title: ratio)),
                                        TextFormField(
                                            keyboardType: TextInputType.number,
                                            cursorColor:
                                                lightBlueTabs,
                                            style: TextStyle(fontSize: 11.sp),
                                            textAlign: TextAlign.center,
                                            cursorHeight: 16.w,
                                            onSaved: (input) =>
                                                _createRequestModel.ys_ratio =
                                                    input!,
                                            validator: (input) {
                                              if (input == null ||
                                                  input.isEmpty) {
                                                return "Enter ${ratio}";
                                              }
                                              return null;
                                            },
                                            decoration:
                                                roundedTextFieldDecoration(
                                                    ratio)),
                                      ],
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: (Ui.showHide(_yarnSetting.showRatio) &&
                                          Ui.showHide(_yarnSetting.showCount))
                                      ? 16.w
                                      : 0,
                                ),
                                Visibility(
                                  visible: Ui.showHide(_yarnSetting.showCount),
                                  child: Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                            padding: EdgeInsets.only(left: 4.w),
                                            child: TitleSmallTextWidget(
                                                title: count)),
                                        TextFormField(
                                            keyboardType: TextInputType.number,
                                            cursorColor:
                                                lightBlueTabs,
                                            style: TextStyle(fontSize: 11.sp),
                                            textAlign: TextAlign.center,
                                            cursorHeight: 16.w,
                                            onSaved: (input) =>
                                                _createRequestModel.ys_count =
                                                    input!,
                                            validator: (input) {
                                              if (input == null ||
                                                  input.isEmpty) {
                                                return "Enter ${count}";
                                              }
                                              return null;
                                            },
                                            decoration:
                                                roundedTextFieldDecoration(
                                                    count)),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Visibility(
                              visible: true,
                              child: Padding(
                                padding: EdgeInsets.only(top: 8.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.only(left: 8.w),
                                        child: TitleSmallTextWidget(
                                            title:
                                                yarnTexturedType)),
                                    GridTileWidget(
                                      spanCount: 3,
                                      listOfItems: widget
                                          .yarnSyncResponse.data.yarn.grades,
                                      callback: (value) {
                                        // _fiberRequestModel.type =
                                        //     widget.yarnSyncResponse.data.yarn
                                        //         .grades[value].grdId
                                        //         .toString();
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 8.w,
                            ),
                            Row(
                              children: [
                                Visibility(
                                  visible:
                                      Ui.showHide(_yarnSetting.showDannier),
                                  child: Expanded(
                                    child: Column(
                                      children: [
                                        Padding(
                                            padding: EdgeInsets.only(left: 4.w),
                                            child: TitleSmallTextWidget(
                                                title: dannier)),
                                        TextFormField(
                                            keyboardType: TextInputType.text,
                                            cursorColor:
                                                lightBlueTabs,
                                            style: TextStyle(fontSize: 11.sp),
                                            textAlign: TextAlign.center,
                                            cursorHeight: 16.w,
                                            onSaved: (input) =>
                                                _createRequestModel
                                                    .ys_dty_filament = input!,
                                            validator: (input) {
                                              if (input == null ||
                                                  input.isEmpty) {
                                                return "Enter ${dannier}";
                                              }
                                              return null;
                                            },
                                            inputFormatters: [
                                              NumericalRangeFormatter(
                                                  min: StringUtils.splitMin(
                                                      _yarnSetting
                                                          .dannierMinMax),
                                                  max: StringUtils.splitMax(
                                                      _yarnSetting
                                                          .dannierMinMax))
                                            ],
                                            decoration:
                                                roundedTextFieldDecoration(
                                                    dannier)),
                                      ],
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width:
                                      (Ui.showHide(_yarnSetting.showDannier) &&
                                              Ui.showHide(
                                                  _yarnSetting.showFilament))
                                          ? 16.w
                                          : 0,
                                ),
                                Visibility(
                                  visible:
                                      Ui.showHide(_yarnSetting.showFilament),
                                  child: Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                            padding: EdgeInsets.only(left: 4.w),
                                            child: TitleSmallTextWidget(
                                                title: filament)),
                                        TextFormField(
                                            keyboardType: TextInputType.text,
                                            cursorColor:
                                                lightBlueTabs,
                                            style: TextStyle(fontSize: 11.sp),
                                            textAlign: TextAlign.center,
                                            cursorHeight: 16.w,
                                            onSaved: (input) =>
                                                _createRequestModel
                                                    .ys_fdy_filament = input!,
                                            validator: (input) {
                                              if (input == null ||
                                                  input.isEmpty) {
                                                return "Enter ${filament}";
                                              }
                                              return null;
                                            },
                                            inputFormatters: [
                                              NumericalRangeFormatter(
                                                  min: StringUtils.splitMin(
                                                      _yarnSetting
                                                          .filamentMinMax),
                                                  max: StringUtils.splitMax(
                                                      _yarnSetting
                                                          .filamentMinMax))
                                            ],
                                            decoration:
                                                roundedTextFieldDecoration(
                                                    filament)),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 8.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                      padding: EdgeInsets.only(left: 8.w),
                                      child: TitleSmallTextWidget(
                                          title: ply)),
                                  GridTileWidget(
                                    spanCount: 4,
                                    listOfItems:
                                        widget.yarnSyncResponse.data.yarn.ply,
                                    callback: (value) {
                                      _createRequestModel.ys_ply_idfk = widget
                                          .yarnSyncResponse
                                          .data
                                          .yarn
                                          .ply[value]
                                          .plyId
                                          .toString();
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 8.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                      padding: EdgeInsets.only(left: 8.w),
                                      child: TitleSmallTextWidget(
                                          title: orientation)),
                                  GridTileWidget(
                                    spanCount: 2,
                                    listOfItems: widget
                                        .yarnSyncResponse.data.yarn.orientation,
                                    callback: (value) {
                                      _createRequestModel.ys_orientation_idfk =
                                          widget.yarnSyncResponse.data.yarn
                                              .orientation[value].yoId
                                              .toString();
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Visibility(
                              visible: true,
                              child: Padding(
                                padding: EdgeInsets.only(top: 8.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.only(left: 8.w),
                                        child: TitleSmallTextWidget(
                                            title: usage)),
                                    GridTileWidget(
                                      spanCount: 2,
                                      listOfItems: widget
                                          .yarnSyncResponse.data.yarn.usage,
                                      callback: (value) {
                                        _createRequestModel.ys_usage_idfk =
                                            widget.yarnSyncResponse.data.yarn
                                                .usage[value].yuId
                                                .toString();
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Visibility(
                              visible: true,
                              child: Padding(
                                padding: EdgeInsets.only(top: 8.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.only(left: 8.w),
                                        child: TitleSmallTextWidget(
                                            title: pattern)),
                                    GridTileWidget(
                                      spanCount: 3,
                                      listOfItems: widget
                                          .yarnSyncResponse.data.yarn.pattern,
                                      callback: (value) {
                                        if(widget.yarnSyncResponse.data.yarn.pattern[value].ypId == 1 ||
                                            widget.yarnSyncResponse.data.yarn.pattern[value].ypId == 4){
                                          setState(() {
                                            showPatternCharc = true;
                                            _patternCharactristicList = widget.yarnSyncResponse.data.yarn.patternCharectristic.where((element) => element.ypcPatternIdfk == widget.yarnSyncResponse.data.yarn.pattern[value].ypId.toString()).toList();
                                          });
                                        }else{
                                          setState(() {
                                            showPatternCharc = false;
                                            _createRequestModel.ys_pattern_charectristic_idfk = null;
                                          });
                                        }
                                        _createRequestModel.ys_pattern_idfk =
                                            widget.yarnSyncResponse.data.yarn
                                                .pattern[value].ypId
                                                .toString();
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Visibility(
                              visible: showPatternCharc,
                              child: Padding(
                                padding: EdgeInsets.only(top: 8.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.only(left: 8.w),
                                        child: TitleSmallTextWidget(
                                            title: patternChar)),
                                    GridTileWidget(
                                      spanCount: 4,
                                      listOfItems: _patternCharactristicList,
                                      callback: (value) {
                                        _createRequestModel
                                                .ys_pattern_charectristic_idfk =
                                            widget.yarnSyncResponse.data.yarn
                                                .patternCharectristic[value].ypcId
                                                .toString();
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Visibility(
                              visible: true,
                              child: Padding(
                                padding: EdgeInsets.only(top: 8.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.only(left: 8.w),
                                        child: TitleSmallTextWidget(
                                            title: twistDirection)),
                                    GridTileWidget(
                                      spanCount: 2,
                                      listOfItems: widget.yarnSyncResponse.data
                                          .yarn.twistDirection,
                                      callback: (value) {
                                        _createRequestModel
                                                .ys_twist_direction_idfk =
                                            widget.yarnSyncResponse.data.yarn
                                                .twistDirection[value].ytdId
                                                .toString();
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Visibility(
                              visible: true,
                              child: Padding(
                                padding: EdgeInsets.only(top: 8.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.only(left: 8.w),
                                        child: TitleSmallTextWidget(
                                            title: spunTech)),
                                    GridTileWidget(
                                      spanCount: 4,
                                      listOfItems: widget.yarnSyncResponse.data
                                          .yarn.spunTechnique,
                                      callback: (value) {
                                        _createRequestModel
                                                .ys_spun_technique_idfk =
                                            widget.yarnSyncResponse.data.yarn
                                                .spunTechnique[value].ystId
                                                .toString();
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Visibility(
                              visible: Ui.showHide(_yarnSetting.showQlt),
                              child: Padding(
                                padding: EdgeInsets.only(top: 8.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.only(left: 8.w),
                                        child: TitleSmallTextWidget(
                                            title: quality)),
                                    GridTileWidget(
                                      spanCount: 2,
                                      listOfItems: widget
                                          .yarnSyncResponse.data.yarn.quality,
                                      callback: (value) {
                                        _createRequestModel.ys_qlt = widget
                                            .yarnSyncResponse
                                            .data
                                            .yarn
                                            .quality[value]
                                            .yqId
                                            .toString();
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Visibility(
                              visible: true,
                              child: Padding(
                                padding: EdgeInsets.only(top: 8.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.only(left: 8.w),
                                        child: TitleSmallTextWidget(
                                            title: certification)),
                                    GridTileWidget(
                                      spanCount: 4,
                                      listOfItems: widget.yarnSyncResponse.data
                                          .yarn.certification,
                                      callback: (value) {
                                        _createRequestModel.spc_grade_idfk =
                                            widget.yarnSyncResponse.data.yarn
                                                .certification[value].cerId
                                                .toString();
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Visibility(
                              visible: true,
                              child: Padding(
                                padding: EdgeInsets.only(top: 8.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.only(left: 8.w),
                                        child: TitleSmallTextWidget(
                                            title: colorTreatmentMethod)),
                                    GridTileWidget(
                                      spanCount: 3,
                                      listOfItems: widget.yarnSyncResponse.data
                                          .yarn.colorTreatmentMethod,
                                      callback: (value) {
                                        _createRequestModel.spc_grade_idfk =
                                            widget
                                                .yarnSyncResponse
                                                .data
                                                .yarn
                                                .colorTreatmentMethod[value]
                                                .yctmId
                                                .toString();
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 8.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                      padding: EdgeInsets.only(left: 8.w),
                                      child: TitleSmallTextWidget(
                                          title: dyingMethod)),
                                  GridTileWidget(
                                    spanCount: 2,
                                    listOfItems: widget
                                        .yarnSyncResponse.data.yarn.dyingMethod,
                                    callback: (value) {
                                      _createRequestModel.ys_dying_method_idfk =
                                          widget.yarnSyncResponse.data.yarn
                                              .dyingMethod[value].ydmId
                                              .toString();
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Visibility(
                              visible: true,
                              child: Padding(
                                padding: EdgeInsets.only(top: 8.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.only(left: 8.w),
                                        child: TitleSmallTextWidget(
                                            title: apperance)),
                                    GridTileWidget(
                                      spanCount: 2,
                                      listOfItems: widget
                                          .yarnSyncResponse.data.yarn.apperance,
                                      callback: (value) {
                                        _createRequestModel.ys_apperance_idfk =
                                            widget.yarnSyncResponse.data.yarn
                                                .apperance[value].aprId
                                                .toString();
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 8.w,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.all(8.w),
                child: SizedBox(
                  width: double.maxFinite,
                  child: ElevatedButtonWithIcon(
                    callback: () async {
                      if (validateAndSave()) {
                        widget.callback!(1);
                      }
                    },
                    color: btnColorLogin,
                    btnText: "Next",
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  querySettings(int id) {
    AppDbInstance.getDbInstance().then((value) async {

      value.yarnSettingsDao
          .findYarnSettings(widget.yarnSyncResponse.data.yarn.blends[id].blnId)
          .then((value) {
        setState(() {
          selectedBlend = id;
          if (value.isNotEmpty) {
            _yarnSetting = value[0];
          } else {
            Ui.showSnackBar(context, 'No Settings Found');
          }
        });
      });
    });
  }

  _initGridValues() async {

    var userID =
        await SharedPreferenceUtil.getStringValuesSF(USER_ID_KEY);
    _createRequestModel.ys_user_idfk = userID.toString();

    //Category Id
    _createRequestModel.spc_category_idfk = widget
        .yarnSyncResponse
        .data
        .yarn
        .blends[selectedBlend]
        .blnCategoryIdfk
        .toString();

    //Selected Blend Id
    _createRequestModel.ys_blend_idfk = widget
        .yarnSyncResponse
        .data
        .yarn
        .blends[selectedBlend]
        .blnId
        .toString();

    if (widget.yarnSyncResponse.data.yarn.grades.isNotEmpty) {
      _createRequestModel.ys_grade_idfk =
          widget.yarnSyncResponse.data.yarn.grades.first.grdId.toString();
    }

    if (widget.yarnSyncResponse.data.yarn.ply.isNotEmpty) {
      _createRequestModel.ys_ply_idfk =
          widget.yarnSyncResponse.data.yarn.ply.first.plyId.toString();
    }

    if (widget.yarnSyncResponse.data.yarn.orientation.isNotEmpty) {
      _createRequestModel.ys_orientation_idfk =
          widget.yarnSyncResponse.data.yarn.orientation.first.yoId.toString();
    }

    if (widget.yarnSyncResponse.data.yarn.usage.isNotEmpty) {
      _createRequestModel.ys_usage_idfk =
          widget.yarnSyncResponse.data.yarn.usage.first.yuId.toString();
    }

    if (widget.yarnSyncResponse.data.yarn.pattern.isNotEmpty) {
      _createRequestModel.ys_pattern_idfk =
          widget.yarnSyncResponse.data.yarn.pattern.first.ypId.toString();
    }

    if(showPatternCharc) {
      if (widget.yarnSyncResponse.data.yarn.patternCharectristic.isNotEmpty) {
        _createRequestModel.ys_pattern_charectristic_idfk = widget
            .yarnSyncResponse.data.yarn.patternCharectristic.first.ypcId
            .toString();
      }
    }

    if (widget.yarnSyncResponse.data.yarn.twistDirection.isNotEmpty) {
      _createRequestModel.ys_twist_direction_idfk = widget
          .yarnSyncResponse.data.yarn.twistDirection.first.ytdId
          .toString();
    }

    if (widget.yarnSyncResponse.data.yarn.spunTechnique.isNotEmpty) {
      _createRequestModel.ys_spun_technique_idfk = widget
          .yarnSyncResponse.data.yarn.spunTechnique.first.ystId
          .toString();
    }

    if (widget.yarnSyncResponse.data.yarn.colorTreatmentMethod.isNotEmpty) {
      _createRequestModel.ys_color_treatment_method_idfk = widget
          .yarnSyncResponse.data.yarn.colorTreatmentMethod.first.yctmId
          .toString();
    }

    if (widget.yarnSyncResponse.data.yarn.dyingMethod.isNotEmpty) {
      _createRequestModel.ys_dying_method_idfk =
          widget.yarnSyncResponse.data.yarn.dyingMethod.first.ydmId.toString();
    }

    if (widget.yarnSyncResponse.data.yarn.apperance.isNotEmpty) {
      _createRequestModel.ys_apperance_idfk =
          widget.yarnSyncResponse.data.yarn.apperance.first.aprId.toString();
    }
  }

  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
