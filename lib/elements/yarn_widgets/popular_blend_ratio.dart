import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';

import '../../helper_utils/blend_text_form_field.dart';
import '../../locators.dart';
import '../../model/blend_model.dart';
import '../../model/response/yarn_response/sync/yarn_sync_response.dart';
import '../../providers/fabric_providers/post_fabric_provider.dart';
import '../../providers/yarn_providers/post_yarn_provider.dart';
import '../title_text_widget.dart';

class PopularBlendRatioWidget extends StatefulWidget {
  final Function? callback;
  final Function? textFieldcallback;
  final List<dynamic> listOfItems;
  final List<BlendModel> blendsValue;
  final int selectedIndex;
  final List<TextEditingController> listController;
  final dynamic provider;


  const PopularBlendRatioWidget({
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
  PopularBlendRatioWidgetState createState() => PopularBlendRatioWidgetState();
}

class PopularBlendRatioWidgetState extends State<PopularBlendRatioWidget> {
  var looger = Logger();
  var width;
 // final _yarnPostProvider = locator<PostYarnProvider>();
  late PostYarnProvider? yarnProvider;
  late PostFabricProvider? fabricProvider;
  dynamic selectedBlend;
  int? checkedTile;

  @override
  void initState() {
    super.initState();
    checkedTile = widget.selectedIndex;
    if(widget.provider is PostYarnProvider){
      yarnProvider = widget.provider;
      yarnProvider!.addListener(updateUI);
    }else if(widget.provider is PostFabricProvider){
      fabricProvider = widget.provider;
      fabricProvider!.addListener(updateUI);
    }
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
    bool checked = index == checkedTile;
    return Container(
      child: Padding(
        padding: EdgeInsets.only(right: 16.w),
        child:
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: (){
            setState(() {
             if(checkedTile != null){
               widget.provider is PostYarnProvider ?
               yarnProvider!.textFieldControllers[checkedTile!].clear():
               fabricProvider!.textFieldControllers[checkedTile!].clear();
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
                  Padding(
                    padding: const EdgeInsets.only(left: 10,top: 2),
                    child: TitleSmallBoldTextWidget(
                      size: 12,
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
                validation: widget.provider.blendList[index].isSelected ??
                    false,
                isEnabled: widget.provider.blendList[index].isSelected ??
                    false,
                textEditingController: widget.provider
                    .textFieldControllers[index],
                onSaved: (input) {
                  widget.provider.setBlendRatio(
                      index, widget.listController[index].text);
                },
              ),
            ),
          ]),
        ),
      ),
    );
  }
}