import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/model/response/fabric_response/sync/fabric_sync_response.dart';

import '../../helper_utils/blend_text_form_field.dart';
import '../../model/blend_model.dart';
import '../../model/response/yarn_response/sync/yarn_sync_response.dart';
import '../../providers/fabric_providers/post_fabric_provider.dart';
import '../../providers/yarn_providers/post_yarn_provider.dart';
import '../text_widgets.dart';

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
  // var width;
  // final _yarnPostProvider = locator<PostYarnProvider>();
  late PostYarnProvider? yarnProvider;
  late PostFabricProvider? fabricProvider;
  dynamic selectedBlend;
  int? checkedTile;

  @override
  void initState() {
    super.initState();
    checkedTile = widget.selectedIndex;
    if (widget.provider is PostYarnProvider) {
      yarnProvider = widget.provider;
      yarnProvider!.textFieldControllers.clear();
      if (yarnProvider!.textFieldControllers.isEmpty) {
        for (var i = 0; i < widget.listOfItems.length; i++) {
          yarnProvider!.textFieldControllers.add(TextEditingController());
        }
      }
      yarnProvider!.addListener(updateUI);
    } else if (widget.provider is PostFabricProvider) {
      fabricProvider = widget.provider;
      fabricProvider!.textFieldControllers.clear();
      if (fabricProvider!.textFieldControllers.isEmpty) {
        for (var i = 0; i < widget.listOfItems.length; i++) {
          fabricProvider!.textFieldControllers.add(TextEditingController());
        }
      }
      fabricProvider!.addListener(updateUI);
    }
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
              widget.provider is PostYarnProvider
                  ? yarnProvider!.textFieldControllers[checkedTile!].clear()
                  : fabricProvider!.textFieldControllers[checkedTile!]
                      .clear();
            }
            checkedTile = index;
          });
          selectedBlend = widget.listOfItems[checkedTile!];
          widget.callback!(widget.listOfItems[checkedTile!]);
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
                      size: 12,
                      title: getBlendAbrv(widget.listOfItems[index])),
                )
              ],
            ),
          ),
          Expanded(
            flex: 5,
            child: BlendTextFormFieldWithRangeNonDecimal(
              errorText: "count",
              minMax: "1-100",
              validation: (widget.provider is PostYarnProvider)
                  ? widget.listOfItems.cast<Blends>()[index].isSelected!
                  : widget.listOfItems
                      .cast<FabricBlends>()[index]
                      .isSelected!,
              isEnabled: (widget.provider is PostYarnProvider)
                  ? widget.listOfItems.cast<Blends>()[index].isSelected!
                  : widget.listOfItems
                      .cast<FabricBlends>()[index]
                      .isSelected!,
              textEditingController: widget.provider is PostYarnProvider
                  ? yarnProvider!.textFieldControllers[index]
                  : fabricProvider!.textFieldControllers[index],
              onSaved: (input) {
                if (widget.provider is PostYarnProvider) {
                  yarnProvider!.selectedBlends
                          .cast<Blends>()
                          .first
                          .blendRatio =
                      yarnProvider!.textFieldControllers[checkedTile!].text;
                } else {
                  fabricProvider!.selectedBlends
                          .cast<FabricBlends>()
                          .first
                          .blendRatio =
                      fabricProvider!.textFieldControllers[checkedTile!].text;
                }
              },
            ),
          ),
        ]),
      ),
    );
  }

  String? getBlendAbrv(listOfItem) {
    if (listOfItem is Blends) {
      return listOfItem.bln_abrv;
    }
    if (listOfItem is FabricBlends) {
      return listOfItem.blnAbrv;
    }
    return null;
  }
}
