import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:yg_app/app_database/app_database_instance.dart';
import 'package:yg_app/elements/text_widgets.dart';
import 'package:yg_app/elements/yg_text_form_field.dart';
import 'package:yg_app/helper_utils/app_colors.dart';
import 'package:yg_app/locators.dart';
import 'package:yg_app/model/response/yarn_response/sync/yarn_sync_response.dart';
import 'package:yg_app/providers/yarn_providers/post_yarn_provider.dart';

import '../../helper_utils/app_constants.dart';
import '../../helper_utils/ui_utils.dart';
import '../../model/request/post_ad_request/create_request_model.dart';
import '../list_widgets/single_select_tile_widget.dart';

GlobalKey<FormState> plyFormKey = GlobalKey<FormState>();

yarnSpecsSheet(
    BuildContext context,
    YarnSetting? _yarnSetting,
    CreateRequestModel? _createRequestModel,
    Function callback,
    String _selectedFamilyId,
    List<Ply> _plyList,
    List<OrientationTable> _orientationList,
    List<DoublingMethod> _doublingMethodList,
    // List<int> _plyIdList,
    {Usage? usage}) async {
  final ValueNotifier<bool> showDoublingMethod = ValueNotifier(false);
  final _postYarnProvider = locator<PostYarnProvider>();

  if (_createRequestModel!.ys_ply_idfk != null) {
    _postYarnProvider.selectedPlyId = _createRequestModel.ys_ply_idfk;
    var dbInstance = await AppDbInstance().getDbInstance();
    List<DoublingMethod> _doublingMethodList =
    await dbInstance.doublingMethodDao.findYarnDoublingMethodWithPlyId(int.parse(_createRequestModel.ys_ply_idfk??"-1"));
    if (_doublingMethodList.isNotEmpty) {
      showDoublingMethod.value = true;
      _postYarnProvider.selectedPlyId = _createRequestModel.ys_ply_idfk;
    } else {
      showDoublingMethod.value = false;
      _createRequestModel.ys_doubling_method_idFk = null;
    }
  }

  if (_createRequestModel.ys_doubling_method_idFk != null) {
    _postYarnProvider.selectedDoublingMethodId = _createRequestModel.ys_doubling_method_idFk;
  }

  if (_createRequestModel.ys_orientation_idfk != null) {
    _postYarnProvider.selectedOrientationId = _createRequestModel.ys_orientation_idfk;
  }

  showModalBottomSheet<int>(
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    context: context,
    builder: (context) {
      return StatefulBuilder(
          builder: (BuildContext contextBuilder, StateSetter setState) {
        return SingleChildScrollView(
          child: Container(
            color: Colors.white,
            /*padding: const EdgeInsets.only(left: 15.0,right: 15.0),*/
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                left: 15.0,
                right: 15.0),
//              height: MediaQuery.of(context).size.height/1.5,
            child: Form(
              key: plyFormKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    children: [
                      Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const Icon(Icons.close),
                            ),
                          )),
                      Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Text(
                          "Enter Count Details",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 18.0.sp,
                              color: headingColor,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      const Divider(
                        color: Colors.black12,
                      ),
                      SizedBox(
                        height: 2.w,
                      ),
                      Column(
                        children: [
                          //Show Dannier
                          Visibility(
                            visible: Ui.showHide(_yarnSetting!.showDannier),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 8.w,
                                  ),
//                        Padding(
//                            padding: EdgeInsets.only(left: 4.w),
//                            child: TitleSmallBoldTextWidget(title: dannier + '*')),
                                  YgTextFormFieldWithRangeNonDecimal(
                                      onSaved: (input) => _createRequestModel
                                          .ys_dty_filament = input!,
                                      value:
                                          _createRequestModel.ys_dty_filament,
                                      // onChanged:(value) => globalFormKey.currentState!.reset(),
                                      minMax: _yarnSetting.dannierMinMax!,
                                      autoFocus: true,
                                      label: dannier,
                                      errorText: dannier),
                                ],
                                crossAxisAlignment: CrossAxisAlignment.start,
                              ),
                            ),
                          ),
                          // Show Filament
                          Visibility(
                            visible: Ui.showHide(_yarnSetting.showFilament),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 8.w,
                                  ),
//                        Padding(
//                            padding: EdgeInsets.only(left: 4.w),
//                            child: TitleSmallTextWidget(title: filament + '*')),
                                  YgTextFormFieldWithRangeNonDecimal(
                                    minMax: _yarnSetting.filamentMinMax!,
                                    onSaved: (input) => _createRequestModel
                                        .ys_fdy_filament = input!,
                                    value: _createRequestModel.ys_fdy_filament,
                                    // onChanged:(value) => globalFormKey.currentState!.reset(),
                                    errorText: filament,
                                    label: filament,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // Count
                          Visibility(
                            visible: Ui.showHide(_yarnSetting.showCount),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
//                        Padding(
//                            padding: EdgeInsets.only(left: 4.w, top: 8.w),
//                            child: TitleSmallTextWidget(title: count + '*')),
                                  SizedBox(
                                    height: 12.w,
                                  ),
                                  YgTextFormFieldWithRangeNonDecimal(
                                      errorText: count,
                                      label: count,
                                      // onChanged:(value) => globalFormKey.currentState!.reset(),
                                      value: _createRequestModel.ys_count,
                                      minMax: _yarnSetting.countMinMax!,
                                      maxLength: 3,
                                      autoFocus: true,
                                      onSaved: (input) {
                                        _createRequestModel.ys_count = input;
                                      })
                                ],
                              ),
                            ),
                          ),

                          //Show Ply
                          Visibility(
                            visible: Ui.showHide(_yarnSetting.showPly),
                            child: Padding(
                              padding: EdgeInsets.only(top: 8.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                      padding: EdgeInsets.only(
                                          left: 0.w, top: 4, bottom: 4),
                                      child: TitleSmallBoldTextWidget(
                                          title: ply + '*')),
                                  SingleSelectTileWidget(
                                    selectedIndex:
                                        _createRequestModel.ys_ply_idfk == null
                                            ? -1
                                            : _plyList
                                                .where((element) =>
                                                    element.familyId ==
                                                    _selectedFamilyId)
                                                .toList()
                                                .indexWhere((element) =>
                                                    element.plyId.toString() ==
                                                    _createRequestModel
                                                        .ys_ply_idfk),
                                    spanCount: 3,
                                    listOfItems: _plyList
                                        .where((element) =>
                                            element.familyId ==
                                            _selectedFamilyId)
                                        .toList(),
                                    callback: (Ply value) async {
                                      _createRequestModel.ys_ply_idfk =
                                          value.plyId.toString();
                                      var dbInstance =
                                          await AppDbInstance().getDbInstance();
                                      List<DoublingMethod> _doublingMethodList =
                                          await dbInstance.doublingMethodDao
                                              .findYarnDoublingMethodWithPlyId(
                                                  value.plyId!);
                                      if (_doublingMethodList.isNotEmpty) {
                                        showDoublingMethod.value = true;
                                      } else {
                                        showDoublingMethod.value = false;
                                        _createRequestModel
                                            .ys_doubling_method_idFk = null;
                                      }
                                      _postYarnProvider.selectedPlyId = value.plyId.toString();

                                      // if (!_plyIdList.contains(value.plyId)) {
                                      //   showDoublingMethod.value = true;
                                      //   /*_selectedPlyId = value.plyId.toString();*/
                                      // } else {
                                      //   showDoublingMethod.value = false;
                                      //   _createRequestModel
                                      //       .ys_doubling_method_idFk = null;
                                      // }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),

                          //Here Doubling Method
                          ValueListenableBuilder(
                              valueListenable: showDoublingMethod,
                              builder:
                                  (context, bool showDoublingMethod, child) {
                                return Visibility(
                                  visible: showDoublingMethod
                                      ? Ui.showHide(
                                          _yarnSetting.showDoublingMethod)
                                      : false,
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 8.w),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                            padding: EdgeInsets.only(
                                                left: 0.w, top: 4, bottom: 4),
                                            child:
                                                const TitleSmallBoldTextWidget(
                                                    title: "Doubling Method*")),
                                        SingleSelectTileWidget(
                                          selectedIndex: _createRequestModel
                                                      .ys_doubling_method_idFk ==
                                                  null
                                              ? -1
                                              : _doublingMethodList
                                                  .where((element) =>
                                                      element.plyId ==
                                                          _postYarnProvider.selectedPlyId)
                                                  .toList()
                                                  .indexWhere((element) =>
                                                      element.dmId.toString() ==
                                                      _createRequestModel
                                                          .ys_doubling_method_idFk),
                                          spanCount: 3,
                                          listOfItems: _doublingMethodList
                                              .where((element) =>
                                                  element.plyId ==
                                                      _postYarnProvider.selectedPlyId)
                                              .toList(),
                                          callback: (DoublingMethod value) {
                                            /*_createRequestModel.ys_doubling_method_idFk =
                                                  value.dmId.toString();*/
                                            _postYarnProvider.selectedDoublingMethodId =
                                                value.dmId.toString();
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                          //Show Orientation
                          Visibility(
                            visible: usage == null
                                ? false
                                : usage.yuName.toString().toLowerCase() !=
                                        "Knitting".toLowerCase() &&
                                    Ui.showHide(_yarnSetting.showOrientation),
                            child: Padding(
                              padding: EdgeInsets.only(top: 8.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                      padding: EdgeInsets.only(
                                          left: 0.w, top: 4, bottom: 4),
                                      child: TitleSmallBoldTextWidget(
                                          title: orientation + '*')),
                                  SingleSelectTileWidget(
                                    selectedIndex: _createRequestModel
                                                .ys_orientation_idfk ==
                                            null
                                        ? -1
                                        : _orientationList
                                            .where((element) =>
                                                element.familyId ==
                                                _selectedFamilyId)
                                            .toList()
                                            .indexWhere((element) =>
                                                element.yoId.toString() ==
                                                _createRequestModel
                                                    .ys_orientation_idfk),
                                    spanCount: 2,
                                    listOfItems: _orientationList
                                        .where((element) =>
                                            element.familyId ==
                                            _selectedFamilyId)
                                        .toList(),
                                    callback: (OrientationTable value) {
                                      /*_createRequestModel.ys_orientation_idfk =
                                              value.yoId.toString();*/
                                      _postYarnProvider.selectedOrientationId =
                                          value.yoId.toString();
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 12.w,
                  ),
                  SizedBox(
                      width: double.infinity,
                      child: Builder(builder: (BuildContext context1) {
                        return TextButton(
                            child: Text("Done",
                                style: TextStyle(
                                    /*fontFamily: 'Metropolis',*/
                                    fontSize: 14.sp)),
                            style: ButtonStyle(
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.white),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        btnColorLogin),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8)),
                                        side: BorderSide(
                                            color: Colors.transparent)))),
                            onPressed: () {
                              if (validationAllPage(
                                  _createRequestModel,
                                  _yarnSetting,
                                  contextBuilder,
                                  showDoublingMethod.value,
                                  _postYarnProvider.selectedPlyId,
                                  _postYarnProvider.selectedDoublingMethodId,
                                  _postYarnProvider.selectedOrientationId,
                                  usage)) {
                                //showDoublingMethod.dispose();
                                FocusScope.of(context).unfocus();
                                _createRequestModel.ys_ply_idfk =
                                    _postYarnProvider.selectedPlyId;
                                _createRequestModel.ys_doubling_method_idFk =
                                    _postYarnProvider.selectedDoublingMethodId;
                                _createRequestModel.ys_orientation_idfk =
                                    _postYarnProvider.selectedOrientationId;
                                callback.call();
                                Navigator.of(context).pop();
                              }
                            });
                      })),
                ],
              ),
            ),
          ),
        );
      });
    },
  );
}

bool validateAndSavePly() {
  final form = plyFormKey.currentState;
  if (form!.validate()) {
    form.save();
    return true;
  }
  return false;
}

bool validationAllPage(
    CreateRequestModel createRequestModel,
    YarnSetting yarnSetting,
    BuildContext context,
    bool _showDoublingMethod,
    String? selectedPlyId,
    String? selectedDoublingMethodId,
    String? selectedOrientationId,
    Usage? usage) {
  if (validateAndSavePly()) {
    if ((selectedPlyId == null || selectedPlyId == '') &&
        Ui.showHide(yarnSetting.showPly)) {
      Fluttertoast.showToast(msg: 'Please Select Ply');
      //  Ui.showSnackBar(context, 'Please Select Ply');
      return false;
    } else if ((selectedDoublingMethodId == null ||
            selectedDoublingMethodId == '') &&
        _showDoublingMethod &&
        Ui.showHide(yarnSetting.showDoublingMethod)) {
      Fluttertoast.showToast(msg: 'Please Select Doubling Method');
      //  Ui.showSnackBar(context, 'Please Select Doubling Method');
      return false;
    } else if ((selectedOrientationId == null || selectedOrientationId == '') &&
        Ui.showHide(yarnSetting.showOrientation) &&
        (usage != null &&
            usage.yuName.toString().toLowerCase() !=
                "Knitting".toLowerCase())) {
      Fluttertoast.showToast(msg: 'Please Select Orientation');
      //  Ui.showSnackBar(context, 'Please Select Orientation');
      return false;
    } else {
      return true;
    }
  }
  return false;
}
