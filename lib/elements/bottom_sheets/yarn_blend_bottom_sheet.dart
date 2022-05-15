import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';
import 'package:yg_app/elements/title_text_widget.dart';
import 'package:yg_app/helper_utils/app_colors.dart';
import 'package:yg_app/helper_utils/blend_text_form_field.dart';
import 'package:yg_app/model/blend_model.dart';
import 'package:yg_app/providers/yarn_providers/post_yarn_provider.dart';

import '../../locators.dart';

GlobalKey<FormState> blendedFormKey = GlobalKey<FormState>();

blendedSheet(
    BuildContext context, List<dynamic> blends, int index, Function callback) {

  List<BlendModel> values = [];
  final _yarnPostProvider = locator<PostYarnProvider>();

  if(_yarnPostProvider.textFieldControllers.isEmpty) {
    for (var i = 0; i < blends.length; i++) {
      _yarnPostProvider.textFieldControllers.add(TextEditingController());
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
        return Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height / 2,
          child: Form(
            key: blendedFormKey,
            child: Column(
              children: [
                Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 5, top: 8),
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          _yarnPostProvider.isBlendSelected = false;
                          Navigator.pop(context);
                          _yarnPostProvider.resetData();
                          _yarnPostProvider.textFieldControllers.clear();
                        },
                        child: const Icon(Icons.close),
                      ),
                    )),
                Text(
                  "Select Ratio",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: 20.0.sp,
                      color: headingColor,
                      fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  flex: 8,
                  child: BlendRatioWidget(
                    selectedIndex: index,
                    listOfItems: blends,
                    listController:_yarnPostProvider.textFieldControllers,
                    blendsValue: values,
                    callback: (value) {},
                    textFieldcallback: (value) {
                      values.clear();
                      values.add(value);
                    },
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
                              if(_yarnPostProvider.selectedBlends.isEmpty){
                                _yarnPostProvider.isBlendSelected = false;
                                Fluttertoast.showToast(msg: "Please select a blend");
                              }else if (validateAndSaveBlend()) {
                                var count = 0.0;
                                for(var element in _yarnPostProvider.blendList) {
                                  if (element.blendRatio != null && element.blendRatio != "") {
                                    count = count +
                                        double.parse(element.blendRatio!);
                                  }
                                }
                                if(count > 100){
                                  Fluttertoast.showToast(msg: "Ratio should be less then or equal to 100");
                                }else{
                                  _yarnPostProvider.isBlendSelected = true;
                                  callback();
                                  // Navigator.pop(context);
                                }

                              }
                            });
                      })),
                ),
              ],
            ),
          ),
        );
      });
    },
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
  final _yarnPostProvider = locator<PostYarnProvider>();

  @override
  void initState() {
    super.initState();
    _isChecked = List<bool>.filled(widget.listOfItems.length, false);
    _yarnPostProvider.addListener(updateUI);
    _isChecked[widget.selectedIndex] = true;
    _yarnPostProvider.blendList[widget.selectedIndex].isSelected = true;
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      // Add Your Code here.
      _yarnPostProvider.addSelectedBlend =
          _yarnPostProvider.blendList[widget.selectedIndex];
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
                child: Row(
                  children: [
                    Checkbox(
                      value: _yarnPostProvider.selectedBlends
                              .contains(widget.listOfItems[index])
                          ? true
                          : _isChecked[index],
                      onChanged: (newValue) {
                        setState(() {
                          _isChecked[index] = newValue!;
                          if (_yarnPostProvider.selectedBlends
                              .contains(widget.listOfItems[index])) {
                            _yarnPostProvider.blendList[index].isSelected =
                                false;
                            _yarnPostProvider.blendList[index].blendRatio = '';
                            _yarnPostProvider.removeSelectedBlend =
                                widget.listOfItems[index];

                            // selectedIndex.remove(index);
                            widget.listController[index].clear();
                          } else {
                            _yarnPostProvider.blendList[index].isSelected =
                                true;
                            _yarnPostProvider.addSelectedBlend =
                                widget.listOfItems[index];
                            // title.add(widget.listOfItems[index]);
                            // selectedIndex.add(index);
                          }
                        });

                        widget.callback!(_yarnPostProvider.selectedBlends);
                        looger.e(widget.listOfItems[index].toString());
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
                  validation: _yarnPostProvider.blendList[index].isSelected??false,
                  isEnabled: _yarnPostProvider.blendList[index].isSelected??false,
                  textEditingController: _yarnPostProvider.textFieldControllers[index],
                  onSaved: (input) {
                    _yarnPostProvider.setBlendRatio(index, widget.listController[index].text);
                  },
                ),
              ),
            ]),
          );
        },
      ),
    );
  }
}
