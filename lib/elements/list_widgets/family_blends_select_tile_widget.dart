import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';
import 'package:yg_app/elements/list_widgets/single_select_tile_widget.dart';
import 'package:yg_app/helper_utils/app_colors.dart';
import 'package:yg_app/helper_utils/fabric_bottom_sheet.dart';
import 'package:yg_app/model/response/fabric_response/sync/fabric_sync_response.dart';
import 'package:yg_app/model/response/yarn_response/sync/yarn_sync_response.dart';

import '../../api_services/api_service_class.dart';
import '../../helper_utils/app_constants.dart';
import '../../helper_utils/util.dart';
import '../../model/response/fiber_response/sync/sync_fiber_response.dart';
import '../../model/response/stocklot_repose/stocklot_sync/stocklot_sync_response.dart';
import '../network_icon_widget.dart';
import '../title_text_widget.dart';

class FamilyBlendsSelectTileWidget extends StatefulWidget {
  final Function? callback;
  final Function? selectedValue;
  final List<dynamic> listOfItems;
  final int? spanCount;
  final int? selectedIndex;

  const FamilyBlendsSelectTileWidget({
    Key? key,
    required this.spanCount,
    required this.callback,
    required this.selectedValue,
    required this.listOfItems,
    this.selectedIndex,
  }) : super(key: key);

  @override
  FamilyBlendsSelectTileWidgetState createState() =>
      FamilyBlendsSelectTileWidgetState();
}

class FamilyBlendsSelectTileWidgetState
    extends State<FamilyBlendsSelectTileWidget> {
  int? checkedTile;
  late double aspectRatio;
  var looger = Logger();

  @override
  void initState() {
    print("Index" + widget.selectedIndex.toString());
    checkedTile = widget.selectedIndex ?? 0;
    if (widget.spanCount == 2) {
      aspectRatio = 4.5;
    } else if (widget.spanCount == 3) {
      aspectRatio = 1.9;
    } else {
      aspectRatio = 2.2;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: widget.spanCount! == 2 ? 16 : 6,
          mainAxisSpacing: 8,
          crossAxisCount: widget.spanCount!,
          childAspectRatio: aspectRatio),
      itemCount: widget.listOfItems.length,
      itemBuilder: (context, index) {
        return buildGrid(index);
      },
    );
  }

  Widget buildGrid(int index) {
    bool checked = index == checkedTile;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        print("Tap");
        setState(() {
          checkedTile = index;
        });
        widget.callback!(widget.listOfItems[index]);
        widget.selectedValue!(checkedTile);

        looger.e(widget.listOfItems[index].toString());
      },
      child: buildListBody(index),
    );
  }

  Widget buildListBody(int index) {
    bool checked = index == checkedTile;
    String? name;
    int? castingCheckPos;
    if (widget.listOfItems is List<FiberFamily>) {
      name = widget.listOfItems.cast<FiberFamily>()[index].fiberFamilyName;
      castingCheckPos = 0;
    } else if (widget.listOfItems is List<Blends>) {
      var blend = widget.listOfItems.cast<Blends>()[index];
      name = blend.bln_abrv ?? blend.blnName;
      castingCheckPos = 1;
    } else if (widget.listOfItems is List<Family>) {
      name = widget.listOfItems.cast<Family>()[index].famName;
      castingCheckPos = 2;
    } else if (widget.listOfItems is List<FabricBlends>) {
      var fabricBlend = widget.listOfItems.cast<FabricBlends>()[index];
      name = fabricBlend.blnAbrv ?? fabricBlend.blnName;
      castingCheckPos = 3;
    } else if (widget.listOfItems is List<FabricFamily>) {
      var fabricFamily = widget.listOfItems.cast<FabricFamily>()[index];
      name = fabricFamily.fabricFamilyName ?? 'n/a';
      castingCheckPos = 4;
    } else {
      name = widget.listOfItems.cast<StockLotFamily>()[index].stocklotFamilyName!;
      castingCheckPos = 5;
    }
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        widget.selectedValue!(index);
        widget.callback!(widget.listOfItems[index]);
      },
      child: Center(
        child: SizedBox(
          width: 0.205 * MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              NetworkImageIconWidget(
                  imageUrl: getImageUrl(checked, castingCheckPos, index)),
              SizedBox(
                height: 2.h,
              ),
              Expanded(
                child: Text(
                  name ?? Utils.checkNullString(false),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 11.sp,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String? getImageUrl(bool checked, int castingCheckPos, index) {
    String url = "";
    if (checked == true) {
      if (castingCheckPos == 0) {
        return '${ApiService.BASE_URL}${widget.listOfItems.cast<FiberFamily>()[index].iconSelected ?? ""}';
      } else if (castingCheckPos == 1) {
        if (widget.listOfItems.cast<Blends>()[index].iconSelected != null) {
          return ApiService.BASE_URL +
              widget.listOfItems.cast<Blends>()[index].iconSelected!;
        } else {
          return "";
        }
      } else if (castingCheckPos == 2) {
        return '${ApiService.BASE_URL}${widget.listOfItems.cast<Family>()[index].iconSelected ?? ""}';
      } else if (castingCheckPos == 3) {
        return '${ApiService.BASE_URL}${widget.listOfItems.cast<FabricBlends>()[index].iconSelected ?? ""}';
      } else if (castingCheckPos == 4) {
        return '${ApiService.BASE_URL}${widget.listOfItems.cast<FabricFamily>()[index].iconSelected ?? ""}';
      } else {
        return "";
      }
    } else {
      if (castingCheckPos == 0) {
        return '${ApiService.BASE_URL}${widget.listOfItems.cast<FiberFamily>()[index].iconUnselected ?? ""}';
      } else if (castingCheckPos == 1) {
        if (widget.listOfItems.cast<Blends>()[index].iconUnselected != null) {
          return ApiService.BASE_URL +
              widget.listOfItems.cast<Blends>()[index].iconUnselected!;
        } else {
          return "";
        }
      } else if (castingCheckPos == 2) {
        return '${ApiService.BASE_URL}${widget.listOfItems.cast<Family>()[index].iconUnSelected ?? ""}';
      } else if (castingCheckPos == 3) {
        return '${ApiService.BASE_URL}${widget.listOfItems.cast<FabricBlends>()[index].iconUnselected ?? ""}';
      } else if (castingCheckPos == 4) {
        return '${ApiService.BASE_URL}${widget.listOfItems.cast<FabricFamily>()[index].iconUnselected ?? ""}';
      } else {
        return "";
      }
    }
  }

  resetWidget() {
    setState(() {
      checkedTile = 0;
    });
  }
}
