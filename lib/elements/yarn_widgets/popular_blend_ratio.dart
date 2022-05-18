import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';

import '../../helper_utils/blend_text_form_field.dart';
import '../../locators.dart';
import '../../model/blend_model.dart';
import '../../model/response/yarn_response/sync/yarn_sync_response.dart';
import '../../providers/yarn_providers/post_yarn_provider.dart';
import '../title_text_widget.dart';

class PopularBlendRatioWidget extends StatefulWidget {
  final Function? callback;
  final Function? textFieldcallback;
  final List<dynamic> listOfItems;
  final List<BlendModel> blendsValue;
  final int selectedIndex;
  final List<TextEditingController> listController;


  const PopularBlendRatioWidget({
    Key? key,
    required this.callback,
    required this.textFieldcallback,
    required this.listOfItems,
    required this.blendsValue,
    required this.listController,
    required this.selectedIndex,
  }) : super(key: key);

  @override
  PopularBlendRatioWidgetState createState() => PopularBlendRatioWidgetState();
}

class PopularBlendRatioWidgetState extends State<PopularBlendRatioWidget> {
  var looger = Logger();
  var width;
  final _yarnPostProvider = locator<PostYarnProvider>();
  Blends? selectedBlend;
  int? checkedTile;

  @override
  void initState() {
    super.initState();
    checkedTile = widget.selectedIndex;
    _yarnPostProvider.addListener(updateUI);
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
          return buildGestureDetector(index);
        },
      ),
    );
  }

  GestureDetector buildGestureDetector(int index) {
    bool checked = index == checkedTile;
    return GestureDetector(
          onTap: (){
            setState(() {
              checkedTile = index;
            });
            selectedBlend = widget.listOfItems[index];
            widget.callback!(widget.listOfItems[index]);
          },
          child: Padding(
            padding: EdgeInsets.only(right: 16.w),
            child:
            Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
              Expanded(
                flex: 5,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          checkedTile = index;
                        });
                        selectedBlend = widget.listOfItems[index];
                        widget.callback!(widget.listOfItems[index]);
                      },
                      child: Container(
                        child: widget.listOfItems[index] == selectedBlend ?
                        const Icon(Icons.radio_button_checked,
                          size: 14,
                          color: Colors.blueAccent,
                        ):
                        const Icon(Icons.radio_button_off,
                          size: 14,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10,top: 2),
                      child: TitleSmallBoldTextWidget(
                          title: widget.listOfItems[index].toString()),
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 5,
                child: BlendTextFormFieldWithRangeNonDecimal(
                  errorText: "count",
                  minMax: "1-100",
                  validation: _yarnPostProvider.blendList[index].isSelected ??
                      false,
                  isEnabled: _yarnPostProvider.blendList[index].isSelected ??
                      false,
                  textEditingController: _yarnPostProvider
                      .textFieldControllers[index],
                  onSaved: (input) {
                    _yarnPostProvider.setBlendRatio(
                        index, widget.listController[index].text);
                  },
                ),
              ),
            ]),
          ),
        );
  }
}