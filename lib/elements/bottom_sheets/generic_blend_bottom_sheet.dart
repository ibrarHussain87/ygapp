import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';
import 'package:yg_app/elements/title_text_widget.dart';
import 'package:yg_app/helper_utils/app_colors.dart';
import 'package:yg_app/helper_utils/blend_text_form_field.dart';
import 'package:yg_app/model/blend_model.dart';
import 'package:yg_app/model/response/fabric_response/sync/fabric_sync_response.dart';
import 'package:yg_app/providers/fabric_providers/post_fabric_provider.dart';
import 'package:yg_app/providers/yarn_providers/post_yarn_provider.dart';

import '../../helper_utils/top_round_corners.dart';
import '../../locators.dart';
import '../../model/response/yarn_response/sync/yarn_sync_response.dart';
import '../blends_ratio_segment_component.dart';
import '../list_widgets/pure_blend_select_tile_widget.dart';
import '../list_widgets/single_select_tile_widget.dart';
import '../yarn_widgets/popular_blend_ratio.dart';

GlobalKey<FormState> blendedFormKey = GlobalKey<FormState>();

final ValueNotifier<int> blendTypesNotifier = ValueNotifier(1);

genericBlendBottomSheet(BuildContext context, dynamic provider,
    List<dynamic> blends, int index, Function callback) {
  List<BlendModel> values = [];
  late List<String> _natureYarnList = ["Pure", "Blended"];
  //final _yarnPostProvider = locator<PostYarnProvider>();
  PostYarnProvider? _yarnPostProvider;
  PostFabricProvider? _fabricPostProvider;
  final ValueNotifier<bool> _notifierNatureSheet = ValueNotifier(false);

  if (provider is PostYarnProvider) {
    _yarnPostProvider = provider;
    // if (_yarnPostProvider.textFieldControllers.isEmpty) {
    //   for (var i = 0; i < blends.length; i++) {
    //     _yarnPostProvider.textFieldControllers.add(TextEditingController());
    //   }
    // }
  } else if (provider is PostFabricProvider) {
    _fabricPostProvider = provider;
    // if (_fabricPostProvider.textFieldControllers.isEmpty) {
    //   for (var i = 0; i < blends.length; i++) {
    //     _fabricPostProvider.textFieldControllers.add(TextEditingController());
    //   }
    // }
  }

  showModalBottomSheet<int>(
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    context: context,
    isDismissible: false,
    builder: (context) {
      return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
        return Container(
          decoration: getRoundedTopCorners(),
          height: MediaQuery.of(context).size.height * 0.7,
          child: Form(
              key: blendedFormKey,
              child: Column(
                children: [
                  Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8, top: 8),
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            _yarnPostProvider != null
                                ? _yarnPostProvider.isBlendSelected = false
                                : _fabricPostProvider!.isBlendSelected = false;
                            Navigator.pop(context);
                          },
                          child: const Icon(Icons.close),
                        ),
                      )),
                  Center(
                    child: Text(
                      "Select Yarn Nature",
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
                  Expanded(
                    child: Visibility(
                      visible: true,
                      child: Padding(
                        padding: EdgeInsets.only(top: 8.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 18, right: 18),
                              child: SingleSelectTileWidget(
                                selectedIndex: 0,
                                spanCount: 2,
                                listOfItems: _natureYarnList.toList(),
                                callback: (String value) {
                                  if (value == "Pure") {
                                    _notifierNatureSheet.value = false;
                                  } else {
                                    _notifierNatureSheet.value = true;
                                  }
                                },
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: ValueListenableBuilder(
                                    valueListenable: _notifierNatureSheet,
                                    builder:
                                        (context, bool notifierValue, child) {
                                      return getWidget(
                                          index,
                                          blends,
                                          _yarnPostProvider ??
                                              _fabricPostProvider,
                                          values,
                                          callback,
                                          notifierValue);
                                    }),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )),
        );
      });
    },
  );
}

Column getWidget(int index, List<dynamic> blends, dynamic provider,
    List<BlendModel> values, Function callback, bool notifierValue) {
  if (!notifierValue) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Select Pure Yarn",
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontSize: 14.0.sp,
                  color: headingColor,
                  fontWeight: FontWeight.w700),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
//<<<<<<< HEAD
        Expanded(
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: PureBlendSelectTileWidget(
                  selectedIndex: -1,
                  spanCount: index,
                  listOfItems: provider is PostYarnProvider
                      ? blends
                          .where((element) =>
                              (element as Blends).bln_nature == 'Pure')
                          .toList()
                      : blends
                          .where((element) =>
                              (element as FabricBlends).blnNature == 'Pure')
                          .toList(),
                  selectedValue: (int checkedValue) {
                    // checkedIndex(checkedValue);
                  },
                  callback: (value) {
                    provider.selectedBlends.clear();
                    if (!provider.selectedBlends.contains(value)) {
                      if (provider is PostYarnProvider) {
                        var blend = value as Blends;
                        blend.isSelected = true;
                        provider.addSelectedBlend = blend;
                      } else if (provider is PostFabricProvider) {
                        var blend = value as FabricBlends;
                        blend.isSelected = true;
                        provider.addSelectedBlend = blend;
                      }
                    }
                    // perform button add action here
                    if (provider.selectedBlends.isEmpty) {
                      provider.isBlendSelected = false;
                      Fluttertoast.showToast(msg: "Please select a blend");
                    } else if (validateAndSaveBlend()) {
                      provider.isBlendSelected = true;
                      callback();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
        Visibility(
          visible: false /*button not need in this case*/,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: SizedBox(
                width: double.infinity,
                child: Builder(builder: (BuildContext context1) {
                  return ElevatedButton(
                      child: Text("Add",
                          style: TextStyle(
                              /*fontFamily: 'Metropolis',*/
                              fontSize: 14.sp)),
                      style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(btnColorLogin),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  const RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                      side: BorderSide(
                                          color: Colors.transparent)))),
                      onPressed: () {
                        if (provider.selectedBlends.isEmpty) {
                          provider.isBlendSelected = false;
                          Fluttertoast.showToast(msg: "Please select a blend");
                        } else if (validateAndSaveBlend()) {
                          provider.isBlendSelected = true;
                          callback();
                        }
                      });
                })),
          ),
        ),
      ],
    );
  } else {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
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
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: EdgeInsets.only(left: 18.w, right: 18.w),
          child: BlendsRatioSegmentComponent(
            callback: (value) {
              blendTypesNotifier.value = value;
            },
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        Expanded(
          child: ValueListenableBuilder(
              valueListenable: blendTypesNotifier,
              builder: (context, int notifierValue, child) {
                if (notifierValue == 1) {
                  //  createTextControllers(blends);
                  List<dynamic> filteredList = [];
                  if(provider is PostYarnProvider){
                    filteredList = blends.cast<Blends>().where((element) => element.bln_nature != "Pure").toList();
                  }else if(provider is PostFabricProvider){
                    filteredList = blends.cast<FabricBlends>().where((element) => element.blnNature != "Pure").toList();
                  }
                  return getPopularBlends(
                      index, filteredList, provider, values, callback);
                } else {
                  //   createTextControllers(blends.where((element) => (element as Blends).bln_nature == 'Pure').toList());

                  return getCustomBlends(
                      index, blends, provider, values, callback);
                }
              }),
        )
      ],
    );
  }
}

/*void createTextControllers(List<dynamic> blends) {
  var _yarnPostProvider = locator<PostYarnProvider>();
  _yarnPostProvider.textFieldControllers.clear();
  if (_yarnPostProvider.textFieldControllers.isEmpty) {
    for (var i = 0; i < blends.length; i++) {
      _yarnPostProvider.textFieldControllers.add(TextEditingController());
    }
  }
}*/

Column getPopularBlends(int index, List<dynamic> blends, dynamic provider,
    List<BlendModel> values, Function callback) {

  return Column(
    children: [
      Expanded(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
        child: PopularBlendRatioWidget(
          selectedIndex: index,
          listOfItems: blends,
          listController: provider.textFieldControllers,
          blendsValue: values,
          callback: (value) {
            if (provider is PostYarnProvider) {
              if (provider.selectedBlends.isNotEmpty) {
                var blend = provider.selectedBlends.first as Blends;
                blend.isSelected = false;
                blend.blendRatio = null;
                provider.removeSelectedBlend = blend;
              }
              if (!provider.selectedBlends.contains(value)) {
                var blend = value as Blends;
                blend.isSelected = true;
                provider.addSelectedBlend = blend;
              }
            } else if (provider is PostFabricProvider) {
              if (provider.selectedBlends.isNotEmpty) {
                var blend = provider.selectedBlends.first as FabricBlends;
                blend.isSelected = false;
                blend.blendRatio = null;
                provider.removeSelectedBlend = blend;
              }
              if (!provider.selectedBlends.contains(value)) {
                var blend = value as FabricBlends;
                blend.isSelected = true;
                provider.addSelectedBlend = blend;
              }
            }
          },
          textFieldcallback: (value) {
            values.clear();
            values.add(value);
          },
          provider: provider,
        ),
      )),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: SizedBox(
            width: double.infinity,
            child: Builder(builder: (BuildContext context1) {
              return ElevatedButton(
                  child: Text("Add",
                      style: TextStyle(
                          /*fontFamily: 'Metropolis',*/
                          fontSize: 14.sp)),
                  style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(btnColorLogin),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              side: BorderSide(color: Colors.transparent)))),
                  onPressed: () {
                    if (provider is PostYarnProvider) {
                      if (provider.selectedBlends.isEmpty) {
                        provider.isBlendSelected = false;
                        Fluttertoast.showToast(msg: "Please select a blend");
                      } else if (validateAndSaveBlend()) {
                        bool addRatio = true;

                        var count = 0.0;
                        if (provider.selectedBlends.length == 1) {
                          if (int.parse((provider.selectedBlends.first as Blends).blendRatio!) >=
                              100) {
                            addRatio = false;
                            Fluttertoast.showToast(
                                msg: "Ratio should be less then 100");
                          } else {
                            addRatio = true;
                          }
                        }
                        if (addRatio) {
                          for (var element in provider.blendList) {
                            if (element.blendRatio != null &&
                                element.blendRatio != "") {
                              count = count + double.parse(element.blendRatio!);
                            }
                          }
                          if (count > 100) {
                            Fluttertoast.showToast(
                                msg:
                                    "Ratio should be less then or equal to 100");
                          } else {
                            provider.isBlendSelected = true;
                            callback();
                            // Navigator.pop(context);
                          }
                        }
                      }
                    } else if (provider is PostFabricProvider) {
                      if (provider.selectedBlends.isEmpty) {
                        provider.isBlendSelected = false;
                        Fluttertoast.showToast(msg: "Please select a blend");
                      } else if (validateAndSaveBlend()) {
                        var count = 0.0;

                        bool addRatio = true;

                        if (provider.selectedBlends.length == 1) {
                          if (int.parse((provider.selectedBlends.first
                                      as FabricBlends)
                                  .blendRatio!) >=
                              100) {
                            addRatio = false;
                            Fluttertoast.showToast(
                                msg: "Ratio should be less then 100");
                          } else {
                            addRatio = true;
                          }
                        }

                        if (addRatio) {
                          for (var element in provider.blendList) {
                            if (element.blendRatio != null &&
                                element.blendRatio != "") {
                              count = count + double.parse(element.blendRatio!);
                            }
                          }
                          if (count > 100) {
                            Fluttertoast.showToast(
                                msg:
                                    "Ratio should be less then or equal to 100");
                          } else {
                            provider.isBlendSelected = true;
                            callback();
                            // Navigator.pop(context);
                          }
                        }
                      }
                    }
                  });
            })),
      ),
    ],
  );
}

Column getCustomBlends(int index, List<dynamic> blends, dynamic provider,
    List<BlendModel> values, Function callback) {

  return Column(
    children: [
      Expanded(
        child: BlendRatioWidget(
          selectedIndex: index,
          listOfItems: provider is PostYarnProvider
              ? blends
                  .where((element) => (element as Blends).bln_nature == 'Pure')
                  .toList()
              : blends
                  .where((element) =>
                      (element as FabricBlends).blnNature == 'Pure')
                  .toList(),
          listController: provider.textFieldControllers,
          blendsValue: values,
          callback: (value) {
            Logger().e('check blend list');
          },
          textFieldcallback: (value) {
            values.clear();
            values.add(value);
          },
          provider: provider,
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: SizedBox(
            width: double.infinity,
            child: Builder(builder: (BuildContext context1) {
              return ElevatedButton(
                  child: Text("Add",
                      style: TextStyle(
                          /*fontFamily: 'Metropolis',*/
                          fontSize: 14.sp)),
                  style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(btnColorLogin),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              side: BorderSide(color: Colors.transparent)))),
                  onPressed: () {
                    if (provider is PostYarnProvider) {
                      if (provider.selectedBlends.isEmpty) {
                        provider.isBlendSelected = false;
                        Fluttertoast.showToast(msg: "Please select a blend");
                      } else if (validateAndSaveBlend()) {
                        var count = 0.0;
                        bool addRatio = true;
                        if (provider.selectedBlends.length == 1) {
                          if (int.parse(
                                  (provider.selectedBlends.first as Blends)
                                      .blendRatio!) >=
                              100) {
                            addRatio = false;
                            Fluttertoast.showToast(
                                msg: "Ratio should be less then 100");
                          } else {
                            addRatio = true;
                          }
                        }
                        if (addRatio) {
                          for (var element in provider.selectedBlends) {
                            if (element.blendRatio != null &&
                                element.blendRatio != "") {
                              count = count + double.parse(element.blendRatio!);
                            }
                          }
                          if (count > 100) {
                            Fluttertoast.showToast(
                                msg:
                                    "Ratio should be less then or equal to 100");
                          } else {
                            provider.isBlendSelected = true;
                            callback();
                            // Navigator.pop(context);
                          }
                        }
                      }
                    } else if (provider is PostFabricProvider) {
                      if (provider.selectedBlends.isEmpty) {
                        provider.isBlendSelected = false;
                        Fluttertoast.showToast(msg: "Please select a blend");
                      } else if (validateAndSaveBlend()) {
                        var count = 0.0;
                        bool addRatio = true;
                        if (provider.selectedBlends.length == 1) {
                          if (int.parse(
                                  (provider.selectedBlends.first as FabricBlends)
                                      .blendRatio!) >=
                              100) {
                            addRatio = false;
                            Fluttertoast.showToast(
                                msg: "Ratio should be less then 100");
                          } else {
                            addRatio = true;
                          }
                        }
                        if (addRatio) {
                          for (var element in provider.selectedBlends) {
                            if (element.blendRatio != null &&
                                element.blendRatio != "") {
                              count = count + double.parse(element.blendRatio!);
                            }
                          }
                          if (count > 100) {
                            Fluttertoast.showToast(
                                msg:
                                    "Ratio should be less then or equal to 100");
                          } else {
                            provider.isBlendSelected = true;
                            callback();
                            // Navigator.pop(context);
                          }
                        }
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
  final dynamic provider;

  const BlendRatioWidget({
    Key? key,
    required this.callback,
    required this.textFieldcallback,
    required this.listOfItems,
    required this.blendsValue,
    required this.listController,
    required this.selectedIndex,
    required this.provider,
  }) : super(key: key);

  @override
  BlendRatioWidgetState createState() => BlendRatioWidgetState();
}

class BlendRatioWidgetState extends State<BlendRatioWidget> {
  var looger = Logger();
  var width;
  List<bool> _isChecked = [];

  //final _yarnPostProvider = locator<PostYarnProvider>();
  late PostYarnProvider yarnProvider;
  late PostFabricProvider fabricProvider;
  late dynamic provider;

  @override
  void initState() {
    super.initState();
    _isChecked = List<bool>.filled(widget.listOfItems.length, false);
    provider = widget.provider;
    if (provider is PostYarnProvider) {
      yarnProvider = provider;
      yarnProvider.textFieldControllers.clear();
      if (yarnProvider.textFieldControllers.isEmpty) {
        for (var i = 0; i <  widget.listOfItems.length; i++) {
          yarnProvider.textFieldControllers.add(TextEditingController());
        }
      }
      yarnProvider.addListener(updateUI);
    } else if (provider is PostFabricProvider) {
      fabricProvider = provider;
      fabricProvider.textFieldControllers.clear();
      if (fabricProvider.textFieldControllers.isEmpty) {
        for (var i = 0; i <  widget.listOfItems.length; i++) {
          fabricProvider.textFieldControllers.add(TextEditingController());
        }
      }
      fabricProvider.addListener(updateUI);
    }
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
    width = MediaQuery.of(context).size.width;
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
                Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
              Expanded(
                flex: 5,
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    handleClick(index, !_isChecked[index], provider);
                  },
                  child: Row(
                    children: [
                      Checkbox(
                        value: provider is PostYarnProvider
                            ? yarnProvider.selectedBlends
                                    .contains(widget.listOfItems[index])
                                ? true
                                : _isChecked[index]
                            : fabricProvider.selectedBlends
                                    .contains(widget.listOfItems[index])
                                ? true
                                : _isChecked[index],
                        onChanged: (newValue) {
                          handleClick(index, newValue, provider);
                        },
                      ),
                      TitleSmallBoldTextWidget(
                          title: widget.listOfItems[index].toString())
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: BlendTextFormFieldWithRangeNonDecimal(
                  errorText: "count",
                  minMax: "1-100",
                  validation: (widget.provider is PostYarnProvider) ? widget.listOfItems.cast<Blends>()[index].isSelected! :  widget.listOfItems.cast<FabricBlends>()[index].isSelected!,
                  isEnabled: (widget.provider is PostYarnProvider) ? widget.listOfItems.cast<Blends>()[index].isSelected! :  widget.listOfItems.cast<FabricBlends>()[index].isSelected!,
                  textEditingController: provider is PostYarnProvider
                      ? yarnProvider.textFieldControllers[index]
                      : fabricProvider.textFieldControllers[index],
                  onSaved: (input) {
                    // Logger().e('Org blends ${_yarnPostProvider.selectedBlends.length}');
                    Logger().e('${widget.listOfItems.length}');
                    /*_yarnPostProvider.textFieldControllers.clear();
                    for (var element in widget.listOfItems) {
                      _yarnPostProvider.textFieldControllers.add(TextEditingController());
                    }*/
                    provider is PostYarnProvider
                        ? yarnProvider.blendList
                            .where((element) => (element).bln_nature == 'Pure')
                            .toList()
                            .forEach((element1) {
                            if (element1.isSelected ?? false) {
                              int myIndex = yarnProvider.blendList
                                  .where((element) =>
                                      (element).bln_nature == 'Pure')
                                  .toList()
                                  .indexWhere(
                                      (element2) => element2 == element1);
                              element1.blendRatio =
                                  widget.listController[myIndex].text;
                            }
                          })
                        : fabricProvider.blendList
                            .where((element) => (element).blnNature == 'Pure')
                            .toList()
                            .forEach((element1) {
                            if (element1.isSelected ?? false) {
                              int myIndex = fabricProvider.blendList
                                  .where((element) =>
                                      (element).blnNature == 'Pure')
                                  .toList()
                                  .indexWhere(
                                      (element2) => element2 == element1);
                              element1.blendRatio =
                                  widget.listController[myIndex].text;
                            }
                          });
                    /*_yarnPostProvider.setBlendRatio(
                        index, widget.listController[index].text);*/
                  },
                ),
              ),
            ]),
          );
        },
      ),
    );
  }

  void handleClick(int index, bool? newValue, dynamic provider) {
    if (provider is PostYarnProvider) {
      setState(() {
        _isChecked[index] = newValue!;
        if (provider.selectedBlends.contains(widget.listOfItems[index])) {
          int blendIndex = provider.selectedBlends
              .indexWhere((element) => element == widget.listOfItems[index]);
          //int blendMainIndex = _yarnPostProvider.blendList.indexWhere((element) => element == widget.listOfItems[index]);
          provider.selectedBlends[blendIndex].isSelected = false;
          provider.selectedBlends[blendIndex].blendRatio = '';
          /*_yarnPostProvider.blendList[blendMainIndex].isSelected = false;
        _yarnPostProvider.blendList[blendMainIndex].blendRatio = '';*/
          provider.removeSelectedBlend = widget.listOfItems[index];
          provider.textFieldControllers[index].clear();
          widget.listController[index].clear();
        } else {
          Blends blend = widget.listOfItems[index];
          blend.isSelected = true;
          provider.addSelectedBlend = blend;
        }
      });

      widget.callback!(provider.selectedBlends);
      looger.e(widget.listOfItems[index].toString());
    } else if (provider is PostFabricProvider) {
      setState(() {
        _isChecked[index] = newValue!;
        if (provider.selectedBlends.contains(widget.listOfItems[index])) {
          int blendIndex = provider.selectedBlends
              .indexWhere((element) => element == widget.listOfItems[index]);
          //int blendMainIndex = _yarnPostProvider.blendList.indexWhere((element) => element == widget.listOfItems[index]);
          provider.selectedBlends[blendIndex].isSelected = false;
          provider.selectedBlends[blendIndex].blendRatio = '';
          /*_yarnPostProvider.blendList[blendMainIndex].isSelected = false;
        _yarnPostProvider.blendList[blendMainIndex].blendRatio = '';*/
          provider.removeSelectedBlend = widget.listOfItems[index];
          provider.textFieldControllers[index].clear();
          widget.listController[index].clear();
        } else {
          FabricBlends blend = widget.listOfItems[index];
          blend.isSelected = true;
          provider.addSelectedBlend = blend;
        }
      });

      widget.callback!(provider.selectedBlends);
      looger.e(widget.listOfItems[index].toString());
    }
  }
}
