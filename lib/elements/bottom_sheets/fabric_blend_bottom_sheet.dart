import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';
import 'package:yg_app/elements/blends_ratio_segment_component.dart';
import 'package:yg_app/elements/fabric_widgets/fabric_blend_ratio.dart';
import 'package:yg_app/elements/list_widgets/pure_blend_select_tile_widget.dart';
import 'package:yg_app/elements/list_widgets/single_select_tile_widget.dart';
import 'package:yg_app/elements/title_text_widget.dart';
import 'package:yg_app/elements/yarn_widgets/popular_blend_ratio.dart';
import 'package:yg_app/helper_utils/app_colors.dart';
import 'package:yg_app/helper_utils/blend_text_form_field.dart';
import 'package:yg_app/helper_utils/top_round_corners.dart';
import 'package:yg_app/locators.dart';
import 'package:yg_app/model/blend_model.dart';
import 'package:yg_app/model/response/fabric_response/sync/fabric_sync_response.dart';
import 'package:yg_app/providers/fabric_providers/post_fabric_provider.dart';



GlobalKey<FormState> blendedFormKey = GlobalKey<FormState>();

final ValueNotifier<int> blendTypesNotifier = ValueNotifier(1);
FabricBlendBottomSheet(BuildContext context, List<dynamic> blends, int index,
    Function callback) {
  List<BlendModel> values = [];
  late List<String> _natureYarnList = ["Pure", "Blended"];
  final _postFabricProvider = locator<PostFabricProvider>();
  final ValueNotifier<bool> _notifierNatureSheet = ValueNotifier(false);

  if (_postFabricProvider.textFieldControllers.isEmpty) {
    for (var i = 0; i < blends.length; i++) {
      _postFabricProvider.textFieldControllers.add(TextEditingController());
    }
  }

  showModalBottomSheet<int>(
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    context: context,
    isDismissible: false,
    builder: (context) {
      return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                decoration: getRoundedTopCorners(),
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.7,
                child: Form(
                  key: blendedFormKey,
                  child: ListView(
                    children: [
                      Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8, top: 8),
                            child: GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                _postFabricProvider.isBlendSelected = false;
                                Navigator.pop(context);
                              },
                              child: const Icon(Icons.close),
                            ),
                          )),
                      Center(
                        child: Text(
                          "Select Fabric Nature",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 16.0.sp,
                              color: headingColor,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      const Divider(),
                      const SizedBox(
                        height: 5,
                      ),
                      Visibility(
                        visible: true,
                        child: Padding(
                          padding: EdgeInsets.only(top: 8.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment
                                .start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 18, right: 18),
                                child: SingleSelectTileWidget(
                                  selectedIndex: 0,
                                  spanCount: 2,
                                  listOfItems: _natureYarnList
                                      .toList(),
                                  callback: (String value) {
                                    if (value == "Pure") {
                                      _notifierNatureSheet.value = false;
                                    } else {
                                      _notifierNatureSheet.value = true;
                                    }
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 10.0),
                                child: ValueListenableBuilder(
                                    valueListenable: _notifierNatureSheet,
                                    builder: (context,
                                        bool notifierValue, child) {
                                      return getWidget(
                                          index, blends, _postFabricProvider,
                                          values, callback, notifierValue);
                                    }
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
    },
  );
}

Column getWidget(int index, List<dynamic> blends,
    PostFabricProvider _postFabricProvider, List<BlendModel> values,
    Function callback, bool notifierValue) {
  if (!notifierValue) {
    return Column(
      children: [
        const SizedBox(height: 10,),
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Select Pure Fabric",
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontSize: 14.0.sp,
                  color: headingColor,
                  fontWeight: FontWeight.w700),
            ),
          ),
        ),
        const SizedBox(height: 10,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: PureBlendSelectTileWidget(
            selectedIndex: -1,
            spanCount: index,
            listOfItems: blends.where((element) => (element as FabricBlends).blnNature == 'Pure').toList(),
            selectedValue: (int checkedValue) {
              // checkedIndex(checkedValue);
            },
            callback: (value) {
              _postFabricProvider.selectedBlends.clear();
              if (!_postFabricProvider.selectedBlends
                  .contains(value)) {
                var blend = value as FabricBlends;
                blend.isSelected = true;
                _postFabricProvider.addSelectedBlend = blend;
              }
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 8.0),
          child: SizedBox(
              width: double.infinity,
              child: Builder(
                  builder: (BuildContext context1) {
                    return ElevatedButton(
                        child: Text("Add",
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
                                    borderRadius:
                                    BorderRadius.all(
                                        Radius.circular(8)),
                                    side: BorderSide(color: Colors
                                        .transparent)))),
                        onPressed: () {
                          if (_postFabricProvider
                              .selectedBlends.isEmpty) {
                            _postFabricProvider
                                .isBlendSelected =
                            false;
                            Fluttertoast.showToast(
                                msg:
                                "Please select a blend");
                          } else if (validateAndSaveBlend()) {
                            _postFabricProvider.isBlendSelected = true;
                            callback();
                          }
                        });
                  })),
        ),
      ],
    );
  } else {
    return Column(
      children: [
        const SizedBox(height: 10,),
        Padding(
          padding: const EdgeInsets.only(left: 18),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Select Blends",
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontSize: 14.0.sp,
                  color: headingColor,
                  fontWeight: FontWeight.w700),
            ),
          ),
        ),
        const SizedBox(height: 10,),
        Padding(
          padding: EdgeInsets.only(left: 18.w, right: 18.w),
          child: BlendsRatioSegmentComponent(
            callback: (value) {
              blendTypesNotifier.value = value;
            },
          ),
        ),
        const SizedBox(height: 12,),
        ValueListenableBuilder(
            valueListenable: blendTypesNotifier,
            builder: (context, int notifierValue, child) {
              if(notifierValue == 1){
                return getPopularBlends(index, blends, _postFabricProvider, values, callback);
              }else{
                return getCustomBlends(index, blends, _postFabricProvider, values, callback);
              }
            }
        )
      ],
    );
  }
}

Column getPopularBlends(int index, List<dynamic> blends,
    PostFabricProvider _postFabricProvider, List<BlendModel> values,
    Function callback) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14,vertical: 4),
        child: FabricPopularBlendRatioWidget(
          selectedIndex: index,
          listOfItems: blends,
          listController: _postFabricProvider
              .textFieldControllers,
          blendsValue: values,
          callback: (value) {
            if(_postFabricProvider.selectedBlends.isNotEmpty){
              var blend = _postFabricProvider.selectedBlends.first as FabricBlends;
              blend.isSelected = false;
              blend.blendRatio = null;
              _postFabricProvider.removeSelectedBlend = blend;
            }
            if (!_postFabricProvider.selectedBlends
                .contains(value)) {
              var blend = value as FabricBlends;
              blend.isSelected = true;
              _postFabricProvider.addSelectedBlend = blend;
            }
          },
          textFieldcallback: (value) {
            values.clear();
            values.add(value);
          },
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 8.0),
        child: SizedBox(
            width: double.infinity,
            child: Builder(
                builder: (BuildContext context1) {
                  return ElevatedButton(
                      child: Text("Add",
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
                                  borderRadius:
                                  BorderRadius.all(
                                      Radius.circular(8)),
                                  side: BorderSide(
                                      color: Colors.transparent)))),
                      onPressed: () {
                        if (_postFabricProvider
                            .selectedBlends.isEmpty) {
                          _postFabricProvider
                              .isBlendSelected =
                          false;
                          Fluttertoast.showToast(
                              msg:
                              "Please select a blend");
                        } else if (validateAndSaveBlend()) {
                          var count = 0.0;
                          for (var element
                          in _postFabricProvider
                              .blendList) {
                            if (element.blendRatio !=
                                null &&
                                element.blendRatio !=
                                    "") {
                              count = count +
                                  double.parse(element
                                      .blendRatio!);
                            }
                          }
                          if (count > 100) {
                            Fluttertoast.showToast(
                                msg:
                                "Ratio should be less then or equal to 100");
                          } else {
                            _postFabricProvider.isBlendSelected =
                            true;
                            callback();
                            // Navigator.pop(context);
                          }
                        }
                      });
                })),
      ),
    ],
  );
}

Column getCustomBlends(int index, List<dynamic> blends,
    PostFabricProvider _postFabricProvider, List<BlendModel> values,
    Function callback) {
  return Column(
    children: [
      BlendRatioWidget(
        selectedIndex: index,
        listOfItems: blends.where((element) => (element as FabricBlends).blnNature == 'Pure').toList(),
        listController: _postFabricProvider
            .textFieldControllers,
        blendsValue: values,
        callback: (value) {},
        textFieldcallback: (value) {
          values.clear();
          values.add(value);
        },
      ),
      Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 8.0),
        child: SizedBox(
            width: double.infinity,
            child: Builder(
                builder: (BuildContext context1) {
                  return ElevatedButton(
                      child: Text("Add",
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
                                  borderRadius:
                                  BorderRadius.all(
                                      Radius.circular(8)),
                                  side: BorderSide(
                                      color: Colors.transparent)))),
                      onPressed: () {
                        if (_postFabricProvider
                            .selectedBlends.isEmpty) {
                          _postFabricProvider
                              .isBlendSelected =
                          false;
                          Fluttertoast.showToast(
                              msg:
                              "Please select a blend");
                        } else if (validateAndSaveBlend()) {
                          var count = 0.0;
                          for (var element
                          in _postFabricProvider
                              .blendList) {
                            if (element.blendRatio !=
                                null &&
                                element.blendRatio !=
                                    "") {
                              count = count +
                                  double.parse(element
                                      .blendRatio!);
                            }
                          }
                          if (count > 100) {
                            Fluttertoast.showToast(
                                msg:
                                "Ratio should be less then or equal to 100");
                          } else {
                            _postFabricProvider
                                .isBlendSelected =
                            true;
                            callback();
                            // Navigator.pop(context);
                          }
                        }
                      });
                })),
      ),
    ],
  );
}

bool validateAndSaveBlend() {
  final form = blendedFormKey.currentState;
  if (form!.validate()) {
    form.save();
    return true;
  }
  return false;
}

class BlendRatioWidget extends StatefulWidget {
  final Function? callback;
  final Function? textFieldcallback;
  final List<dynamic> listOfItems;
  final List<BlendModel> blendsValue;
  final int selectedIndex;
  final List<TextEditingController> listController;


  const BlendRatioWidget({
    Key? key,
    required this.callback,
    required this.textFieldcallback,
    required this.listOfItems,
    required this.blendsValue,
    required this.listController,
    required this.selectedIndex,
  }) : super(key: key);

  @override
  BlendRatioWidgetState createState() => BlendRatioWidgetState();
}

class BlendRatioWidgetState extends State<BlendRatioWidget> {
  var looger = Logger();
  var width;
  List<bool> _isChecked = [];
  final _postFabricProvider = locator<PostFabricProvider>();

  @override
  void initState() {
    super.initState();
    _isChecked = List<bool>.filled(widget.listOfItems.length, false);
    _postFabricProvider.addListener(updateUI);
    /*_isChecked[widget.selectedIndex] = true;
    _yarnPostProvider.blendList[widget.selectedIndex].isSelected = true;*/
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      // Add Your Code here.
      /*_yarnPostProvider.addSelectedBlend =
      _yarnPostProvider.blendList[widget.selectedIndex];*/
    });
  }

  void updateUI() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery
        .of(context)
        .size
        .width;
    return SizedBox(
      width: width,
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        separatorBuilder: (context, index) {
          return Container(
            height: 2,
          );
        },
        scrollDirection: Axis.vertical,
        itemCount: widget.listOfItems.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(right: 16.w),
            child:
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: (){
                handleClick(index, !_isChecked[index]);
              },
              child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                Expanded(
                  flex: 5,
                  child: Row(
                    children: [
                      Checkbox(
                        value: _postFabricProvider.selectedBlends
                            .contains(widget.listOfItems[index])
                            ? true
                            : _isChecked[index],
                        onChanged: (newValue) {
                          handleClick(index, newValue);
                        },
                      ),
                      TitleSmallBoldTextWidget(
                          title: widget.listOfItems[index].toString())
                    ],
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: BlendTextFormFieldWithRangeNonDecimal(
                    errorText: "count",
                    minMax: "1-100",
                    validation: _postFabricProvider.blendList[index].isSelected ??
                        false,
                    isEnabled: _postFabricProvider.blendList[index].isSelected ??
                        false,
                    textEditingController: _postFabricProvider
                        .textFieldControllers[index],
                    onSaved: (input) {
                      _postFabricProvider.setBlendRatio(
                          index, widget.listController[index].text);
                    },
                  ),
                ),
              ]),
            ),
          );
        },
      ),
    );
  }

  void handleClick(int index, bool? newValue) {
    setState(() {
      _isChecked[index] = newValue!;
      if (_postFabricProvider.selectedBlends
          .contains(widget.listOfItems[index])) {
        _postFabricProvider.blendList[index].isSelected =
        false;
        _postFabricProvider.blendList[index].blendRatio = '';
        _postFabricProvider.removeSelectedBlend =
        widget.listOfItems[index];
        _postFabricProvider.textFieldControllers[index].clear();
        // selectedIndex.remove(index);
        widget.listController[index].clear();
      } else {
        _postFabricProvider.blendList[index].isSelected =
        true;
        _postFabricProvider.addSelectedBlend =
        widget.listOfItems[index];
        // title.add(widget.listOfItems[index]);
        // selectedIndex.add(index);
      }
    });

    widget.callback!(_postFabricProvider.selectedBlends);
    looger.e(widget.listOfItems[index].toString());
  }
}
