import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';
import 'package:yg_app/helper_utils/app_colors.dart';
import 'package:yg_app/helper_utils/blend_text_form_field.dart';

import '../model/blend_model.dart';
import '../model/response/fabric_response/sync/fabric_sync_response.dart';

// for blend tile widget (asad_m)
class BlendedTileWidget extends StatefulWidget {
  final Function? callback;
  final Function? textFieldcallback;
  final List<dynamic> listOfItems;
  final List<TextEditingController> listController;
  final List<FabricBlends?> selectedIndex;
  final List<BlendModel> blendsValue;

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
  List<int> selectedIndex = [];
  List<FabricBlends?> title = [];
  List<BlendModel> blends = [];

  @override
  void initState() {
    blends = widget.blendsValue;
    title = widget.selectedIndex;
    super.initState();
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
      width: MediaQuery.of(context).size.width,
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
            Logger().e(widget.listOfItems[index].toString());
          },
          child: Container(
            height: 35,
            width: MediaQuery.of(context).size.width * 0.4,
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
          width: MediaQuery.of(context).size.width * 0.4,
          child: BlendTextFormFieldWithRangeNonDecimal(
              errorText: "count",
              // onChanged:(value) => globalFormKey.currentState!.reset(),
              minMax: "1-100",
              validation: title.contains(widget.listOfItems[index]),
              isEnabled: title.contains(widget.listOfItems[index]),
              textEditingController: widget.listController[index],
              onSaved: (input) {
                if (widget.listController[index].text.isNotEmpty &&
                    title.contains(widget.listOfItems[index])) {
                  if (blends.every((item) => item.id != index)) {
                    blends.add(BlendModel(
                        id: index,
                        relatedBlnId: widget.listOfItems[index].toString(),
                        ratio: widget.listController[index].text));
                  } else {
                    blends[index] = BlendModel(
                        id: index,
                        relatedBlnId: widget.listOfItems[index].toString(),
                        ratio: widget.listController[index].text);
                  }
                }

                widget.textFieldcallback!(blends);
              }),
        ),
      ]),
    );
  }
}
