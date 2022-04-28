import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';
import 'package:yg_app/api_services/api_service_class.dart';
import 'package:yg_app/helper_utils/app_colors.dart';
import 'package:yg_app/helper_utils/app_constants.dart';
import 'package:yg_app/helper_utils/blend_text_form_field.dart';
import 'package:yg_app/helper_utils/blended_single_tile.dart';
import 'package:yg_app/helper_utils/fabric_bottom_sheet.dart';
import 'package:yg_app/model/blend_model.dart';
import 'package:yg_app/model/response/yarn_response/sync/yarn_sync_response.dart';

List<TextEditingController> textFieldControllers = [];
GlobalKey<FormState> blendedFormKey = GlobalKey<FormState>();

blendedSheet(BuildContext context, List<dynamic> blends, int index, Function callback) {
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
        return NatureFabricSheet(
          child: SingleChildScrollView(
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
                  BlendedTileWidget(
                    selectedIndex: index,
                    listOfItems: blends,
                    listController: textFieldControllers,
                    blendsValue: values,
                    callback: (value) {

                    },
                    textFieldcallback: (value) {
                      values.clear();
                      values.add(value);
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.all(16.w),
                    child: SizedBox(
                        width: double.infinity,
                        child: Builder(builder: (BuildContext context1) {
                          return ElevatedButton(
                              child: Text("Add",
                                  style: TextStyle(
                                      fontFamily: 'Metropolis',
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
                                if (validateAndSaveBlend()) {
                                  var result = 0;
                                  for(var elements in values){
                                    result = result + int.parse(elements.ratio!);
                                  }
                                  if(result > 100){
                                    Fluttertoast.showToast(
                                        msg:blend_message,
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1);
                                  }else{
                                    callback(values);
                                  }
                                }
                              });
                        })),
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

bool validateAndSaveBlend() {
  final form = blendedFormKey.currentState;
  if (form!.validate()) {
    form.save();
    return true;
  }
  return false;
}



class BlendedTileWidget extends StatefulWidget {
  final Function? callback;
  final Function? textFieldcallback;
  final List<dynamic> listOfItems;
  final List<TextEditingController> listController;
  final List<BlendModel> blendsValue;
  final int selectedIndex;

  const BlendedTileWidget({
    Key? key,
    required this.callback,
    required this.textFieldcallback,
    required this.listOfItems,
    required this.listController,
    required this.blendsValue,
    required this.selectedIndex,
  }) : super(key: key);

  @override
  BlendedTileWidgetState createState() => BlendedTileWidgetState();
}

class BlendedTileWidgetState extends State<BlendedTileWidget> {
  var looger = Logger();
  var width;

  List<int> selectedIndex = [];
  List<dynamic> title = [];
  List<BlendModel> blends = [];

  @override
  void initState() {
    blends = widget.blendsValue;
    title.add(widget.listOfItems[widget.selectedIndex]);
    super.initState();
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
            height: 10,
          );
        },
        scrollDirection: Axis.vertical,
        itemCount: widget.listOfItems.length,
        itemBuilder: (context, index) {
          return buildGrid(index);
        },
      ),
    );
  }

  Widget buildGrid(int index) {
    return SizedBox(
      width: width,
      child: Row(children: [
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            setState(() {
              if (title.contains(widget.listOfItems[index])) {
                title.remove(widget.listOfItems[index]);
                selectedIndex.remove(index);
                widget.listController[index].clear();
              } else {
                title.add(widget.listOfItems[index]);
                selectedIndex.add(index);
              }

            });
            widget.callback!(title);
            looger.e(widget.listOfItems[index].toString());
          },
          child: Container(
            height: 35,
            width: width * 0.4,
            decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.transparent,
                ),
                color: title.contains(widget.listOfItems[index])
                    ? lightBlueTabs.withOpacity(0.1)
                    : Colors.grey.shade200,
                borderRadius: BorderRadius.all(Radius.circular(24.w))),
            child: Center(
              child: Text(
                widget.listOfItems[index].toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 11.sp,
                    color: title.contains(widget.listOfItems[index])
                        ? lightBlueTabs
                        : Colors.black54),
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 30,
        ),
        SizedBox(
          width: width * 0.4,
          child: BlendTextFormFieldWithRangeNonDecimal(
              errorText: "count",
              minMax: "1-100",
              validation: title.contains(widget.listOfItems[index]),
              isEnabled: title.contains(widget.listOfItems[index]),
              textEditingController: widget.listController[index],
              onSaved: (input) {
                if (widget.listController[index].text.isNotEmpty &&
                    title.contains(widget.listOfItems[index])) {
                  if(widget.listOfItems[index] is Blends) {
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
  }
}

