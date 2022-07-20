import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';
import 'package:yg_app/elements/bottom_sheets/spec_bottom_sheet.dart';
import 'package:yg_app/helper_utils/app_colors.dart';

import '../text_widgets.dart';

class SingleSelectTileWidget extends StatefulWidget {
  final Function? callback;
  final List<dynamic> listOfItems;
  final int? spanCount;
  final int? selectedIndex;

  const SingleSelectTileWidget({
    Key? key,
    this.spanCount,
    required this.callback,
    required this.listOfItems,
    this.selectedIndex,
  }) : super(key: key);

  @override
  SingleSelectTileWidgetState createState() => SingleSelectTileWidgetState();
}

class SingleSelectTileWidgetState extends State<SingleSelectTileWidget> {
  int? checkedTile;
  late double aspectRatio;
  var looger = Logger();
  final ValueNotifier<String> dropdownValue = ValueNotifier('');

  int selectedIndex = -1;

  @override
  void initState() {
    checkedTile = widget.selectedIndex ?? 0;
    if (widget.spanCount == 2) {
      aspectRatio = 4.5;
    } else if (widget.spanCount == 3) {
      aspectRatio = 2.9;
    } else {
      aspectRatio = 2.2;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.listOfItems.length < 5
        ? GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 6,
                mainAxisSpacing: 8,
                crossAxisCount: widget.listOfItems.length < 3
                    ? 2
                    : widget.spanCount != null
                        ? widget.spanCount!
                        : 3,
                childAspectRatio: widget.listOfItems.length < 3
                    ? 4.4
                    : widget.spanCount != null
                        ? aspectRatio
                        : 2.9),
            itemCount: widget.listOfItems.length,
            itemBuilder: (context, index) {
              return buildGrid(index);
            },
          )
        : buildDropDownContainer(widget.listOfItems);
  }

  Widget buildGrid(int index) {
    bool checked = index == checkedTile;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        setState(() {
          checkedTile = index;
        });
        widget.callback!(widget.listOfItems[index]);
        looger.e(widget.listOfItems[index].toString());
      },
      child: widget.listOfItems.length < 3
          ? buildRoundedContainer(checked, index)
          : buildSquareContainer(checked, index),
    );
  }

  GestureDetector buildDropDownContainer(List listOfItems) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        FocusScope.of(context).unfocus();
        specsSheet(context, (int checkedIndex) {
          selectedIndex = checkedIndex;
        }, (value) {
          dropdownValue.value = value.toString();
          Navigator.of(context).pop();
          widget.callback!(value);
        }, listOfItems, selectedIndex);
      },
      child: SizedBox(
        width: double.maxFinite,
        child: Row(
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 0.w, right: 0.w, top: 2.w),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black12),
                    borderRadius: const BorderRadius.all(Radius.circular(6))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.only(top: 5.w, left: 8.w, bottom: 5.w),
                      child: ValueListenableBuilder(
                          valueListenable: dropdownValue,
                          builder: (context, String showDoublingMethod, child) {
                            return Padding(
                              padding:
                                  EdgeInsets.only(left: 6.w, top: 6, bottom: 6),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TitleMediumTextWidget(
                                    title: dropdownValue.value != ''
                                        ? dropdownValue.value.toString()
                                        : 'Select',
                                    color: Colors.black54,
                                    weight: FontWeight.normal,
                                  )
                                ],
                              ),
                            );
                          }),
                    ),
                    Container(
                      margin:
                          const EdgeInsets.only(top: 5, right: 6, bottom: 4),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.keyboard_arrow_down_outlined,
                        size: 24,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container buildSquareContainer(bool checked, int index) {
    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.transparent,
          ),
          color: checked ? darkBlueChip : lightBlueChip,
          borderRadius: BorderRadius.all(Radius.circular(5.w))),
      child: Row(
        children: [
          Expanded(
            child: Text(
              widget.listOfItems[index].toString(),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              softWrap: false,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w600,
                  color: checked ? Colors.white : darkBlueChip),
            ),
          )
        ],
      ),
    );
  }

  Container buildRoundedContainer(bool checked, int index) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.transparent,
          ),
          color: checked ? darkBlueChip : lightBlueChip,
          borderRadius: BorderRadius.all(Radius.circular(25.w))),
      child: Row(
        children: [
          Visibility(
            visible: checked,
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 4, bottom: 4, right: 4, left: 0),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.check,
                  color: darkBlueChip,
                  size: 18,
                ),
              ),
            ),
          ),
          /*Visibility(
            visible: checked,
              child: const SizedBox(width: 5,)
          ),*/
          Expanded(
            child: Text(
              widget.listOfItems[index].toString(),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              softWrap: false,
              textAlign: checked ? TextAlign.start : TextAlign.center,
              style: TextStyle(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w600,
                  color: checked ? Colors.white : darkBlueChip),
            ),
          )
        ],
      ),
    );
  }

  resetWidget() {
    setState(() {
      checkedTile = -1;
    });
  }
}
