import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';
import 'package:yg_app/model/response/fabric_response/sync/fabric_sync_response.dart';
import 'package:yg_app/providers/fabric_providers/post_fabric_provider.dart';

import '../../helper_utils/blend_text_form_field.dart';
import '../../locators.dart';
import '../../model/blend_model.dart';
import '../text_widgets.dart';

class FabricPopularBlendRatioWidget extends StatefulWidget {
  final Function? callback;
  final Function? textFieldcallback;
  final List<dynamic> listOfItems;
  final List<BlendModel> blendsValue;
  final int selectedIndex;
  final List<TextEditingController> listController;

  const FabricPopularBlendRatioWidget({
    Key? key,
    required this.callback,
    required this.textFieldcallback,
    required this.listOfItems,
    required this.blendsValue,
    required this.listController,
    required this.selectedIndex,
  }) : super(key: key);

  @override
  FabricPopularBlendRatioWidgetState createState() =>
      FabricPopularBlendRatioWidgetState();
}

class FabricPopularBlendRatioWidgetState
    extends State<FabricPopularBlendRatioWidget> {
  var looger = Logger();
  final _fabricPostProvider = locator<PostFabricProvider>();
  FabricBlends? selectedBlend;
  int? checkedTile;

  @override
  void initState() {
    super.initState();
    checkedTile = widget.selectedIndex;
    _fabricPostProvider.addListener(updateUI);
    WidgetsBinding.instance.addPostFrameCallback((_) {
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
    var width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: width,
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        separatorBuilder: (context, index) {
          return Container(
            height: 6,
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

  Container buildGestureDetector(int index) {
    return Container(
      padding: EdgeInsets.only(right: 16.w),
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          setState(() {
            if (checkedTile != null) {
              _fabricPostProvider.textFieldControllers[checkedTile!].clear();
            }
            checkedTile = index;
          });
          selectedBlend = widget.listOfItems[index];
          widget.callback!(widget.listOfItems[index]);
        },
        child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Expanded(
            flex: 5,
            child: Row(
              children: [
                Container(
                  child: widget.listOfItems[index] == selectedBlend
                      ? const Icon(
                          Icons.radio_button_checked,
                          size: 14,
                          color: Colors.blueAccent,
                        )
                      : const Icon(
                          Icons.radio_button_off,
                          size: 14,
                          color: Colors.black87,
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 2),
                  child: TitleSmallBoldTextWidget(
                      size: 12, title: widget.listOfItems[index].toString()),
                )
              ],
            ),
          ),
          Expanded(
            flex: 5,
            child: BlendTextFormFieldWithRangeNonDecimal(
              errorText: "count",
              minMax: "1-100",
              validation:
                  _fabricPostProvider.blendList[index].isSelected ?? false,
              isEnabled:
                  _fabricPostProvider.blendList[index].isSelected ?? false,
              textEditingController:
                  _fabricPostProvider.textFieldControllers[index],
              onSaved: (input) {
                _fabricPostProvider.setBlendRatio(
                    index, widget.listController[index].text);
              },
            ),
          ),
        ]),
      ),
    );
  }
}
