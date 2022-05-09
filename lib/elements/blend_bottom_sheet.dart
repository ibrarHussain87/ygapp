import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';
import 'package:yg_app/elements/title_text_widget.dart';
import 'package:yg_app/helper_utils/app_colors.dart';
import 'package:yg_app/helper_utils/app_constants.dart';
import 'package:yg_app/helper_utils/blend_text_form_field.dart';
import 'package:yg_app/helper_utils/fabric_bottom_sheet.dart';
import 'package:yg_app/model/blend_model.dart';
import 'package:yg_app/model/response/yarn_response/sync/yarn_sync_response.dart';
import 'package:yg_app/providers/post_yarn_provider.dart';

import '../locators.dart';

List<TextEditingController> textFieldControllers = [];
GlobalKey<FormState> blendedFormKey = GlobalKey<FormState>();

blendedSheet(
    BuildContext context, List<dynamic> blends, int index, Function callback) {
  List<BlendModel> values = [];
  if (textFieldControllers.isEmpty) {
    for (var i = 0; i < blends.length; i++) {
      textFieldControllers.add(TextEditingController());
    }
  }

  showModalBottomSheet<int>(
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    context: context,
    builder: (context) {
      return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
        return Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height / 2,
          child: Column(
            children: [
              Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 5, top: 8),
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        Navigator.pop(context);
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
                  listController: textFieldControllers,
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
                                  /*fontFamily: 'Metropolis',*/ fontSize: 14.sp)),
                          style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  btnColorLogin),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  const RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                      side: BorderSide(
                                          color: Colors.transparent)))),
                          onPressed: () {
                            if (validateAndSaveBlend()) {
                              var result = 0;
                              for (var elements in values) {
                                result = result + int.parse(elements.ratio!);
                              }
                              if (result > 100) {
                                Fluttertoast.showToast(
                                    msg: blend_message,
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1);
                              } else {
                                callback(values);
                              }
                            }
                          });
                    })),
              ),
            ],
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
  final List<TextEditingController> listController;
  final List<BlendModel> blendsValue;
  final int selectedIndex;

  const BlendRatioWidget({
    Key? key,
    required this.callback,
    required this.textFieldcallback,
    required this.listOfItems,
    required this.listController,
    required this.blendsValue,
    required this.selectedIndex,
  }) : super(key: key);

  @override
  BlendRatioWidgetState createState() => BlendRatioWidgetState();
}

class BlendRatioWidgetState extends State<BlendRatioWidget> {
  var looger = Logger();
  var width;

  List<int> selectedIndex = [];
  // List<dynamic> title = [];
  List<BlendModel> blends = [];
  List<bool> _isChecked = [];
  final _yarnPostProvider = locator<PostYarnProvider>();


  @override
  void initState() {
    blends = widget.blendsValue;
    _yarnPostProvider.selectedBlends.add(widget.listOfItems[widget.selectedIndex]);
    _isChecked = List<bool>.filled(widget.listOfItems.length, false);
    _isChecked[widget.selectedIndex] = _yarnPostProvider.selectedBlends.contains(widget.listOfItems[widget.selectedIndex]);
    super.initState();
    _yarnPostProvider.addListener(updateUI);
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
                      value: _yarnPostProvider.selectedBlends.contains(widget.listOfItems[index])
                          ? true
                          : _isChecked[index],
                      onChanged: (newValue) {
                        setState(() {
                          _isChecked[index] = newValue!;
                          if (_yarnPostProvider.selectedBlends.contains(widget.listOfItems[index])) {
                            _yarnPostProvider.removeSelectedBlend = widget.listOfItems[index];
                            selectedIndex.remove(index);
                            widget.listController[index].clear();
                          } else {
                            _yarnPostProvider.addSelectedBlend = widget.listOfItems[index];
                            // title.add(widget.listOfItems[index]);
                            selectedIndex.add(index);
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
                  validation: _yarnPostProvider.selectedBlends.contains(widget.listOfItems[index]),
                  isEnabled: _yarnPostProvider.selectedBlends.contains(widget.listOfItems[index]),
                  textEditingController: widget.listController[index],
                  onSaved: (input) {
                    if (widget.listController[index].text.isNotEmpty &&
                        _yarnPostProvider.selectedBlends.contains(widget.listOfItems[index])) {
                      if (widget.listOfItems[index] is Blends) {
                        var blendModel = BlendModel(
                            id: widget.listOfItems.cast<Blends>()[index].blnId,
                            title: widget.listOfItems[index].toString(),
                            ratio: widget.listController[index].text);
                        widget.textFieldcallback!(blendModel);
                      }
                    }
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
