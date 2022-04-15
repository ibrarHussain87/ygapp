import 'package:flutter/material.dart';
import 'package:flutter_broadcast_receiver/flutter_broadcast_receiver.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/api_services/api_service_class.dart';
import 'package:yg_app/elements/network_icon_widget.dart';
import 'package:yg_app/elements/yarn_widgets/listview_famiy_tile.dart';
import 'package:yg_app/helper_utils/app_constants.dart';
import 'package:yg_app/helper_utils/util.dart';
import 'package:yg_app/model/response/fiber_response/sync/sync_fiber_response.dart';
import 'package:yg_app/model/response/stocklot_repose/stocklot_sync/stocklot_sync_response.dart';
import 'package:yg_app/model/response/yarn_response/sync/yarn_sync_response.dart';

class CatWithImageListWidget extends StatefulWidget {
  final Function? onClickCallback;
  final List<dynamic>? listItem;
  final int? selectedItem;

  const CatWithImageListWidget(
      {Key? key, required this.listItem, required this.onClickCallback,this.selectedItem})
      : super(key: key);

  @override
  CatWithImageListWidgetState createState() => CatWithImageListWidgetState();
}

class CatWithImageListWidgetState extends State<CatWithImageListWidget> {
  late int checkedIndex;
  int _selectedSegmentIndex = 1;
  bool disableClick = false;
  bool isGlobalParam = true;

  @override
  void initState() {
    checkedIndex = widget.selectedItem ?? 0;
    BroadcastReceiver().subscribe<int> // Data Type returned from publisher
      (segmentIndexBroadcast, (index) {
      setState(() {
        _selectedSegmentIndex = index;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if(isGlobalParam){
      checkedIndex = widget.selectedItem ?? 0;
    }
    return SizedBox(
      height: 0.06 * MediaQuery.of(context).size.height,
      child: ListView.builder(
        itemCount: widget.listItem!.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return buildListBody(index);
        },
      ),
    );
  }

  Widget buildListBody(int index) {
    bool checked = index == checkedIndex;
    String? name;
    int? castingCheckPos;
    if (widget.listItem is List<FiberMaterial>) {
      name = widget.listItem!.cast<FiberMaterial>()[index].fbmName;
      castingCheckPos = 0;
    } else if (widget.listItem is List<Blends>) {
      var blend = widget.listItem!.cast<Blends>()[index];
      name = blend.bln_abrv ?? blend.blnName;
      castingCheckPos = 1;
    }else if (widget.listItem is List<Family>) {
      name = widget.listItem!.cast<Family>()[index].famName;
      castingCheckPos = 2;
    }else{
      name = widget.listItem!.cast<StocklotCategories>()[index].category!;
      castingCheckPos =3;
    }
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        if(!disableClick){
          setState(() {
            if (_selectedSegmentIndex == 1) {
              checkedIndex = index;
              isGlobalParam = false;
            }
          });
          widget.onClickCallback!(index);
        }
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
                imageUrl: getImageUrl(checked,castingCheckPos,index)
              ),
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

  String? getImageUrl(bool checked,int castingCheckPos,index) {
    String url= "";
    if(checked == true){
      if(castingCheckPos == 0){
        return '${ApiService.BASE_URL}${widget.listItem!.cast<FiberMaterial>()[index].icon_selected??""}';
      }else if(castingCheckPos == 1){
        if(widget.listItem!.cast<Blends>()[index].iconSelected != null){
          return ApiService.BASE_URL + widget.listItem!.cast<Blends>()[index].iconSelected!;
        }else{
          return "";
        }
      }else if(castingCheckPos == 2){
        return '${ApiService.BASE_URL}${widget.listItem!.cast<Family>()[index].iconSelected??""}';
      }else{
        return "";
      }
    }else{
      if(castingCheckPos == 0){
        return '${ApiService.BASE_URL}${widget.listItem!.cast<FiberMaterial>()[index].icon_unselected??""}';
      }else if(castingCheckPos == 1){
        if(widget.listItem!.cast<Blends>()[index].iconUnselected != null){
          return ApiService.BASE_URL + widget.listItem!.cast<Blends>()[index].iconUnselected!;
        }else{
          return "";
        }
      }else if(castingCheckPos == 2){
        return '${ApiService.BASE_URL}${widget.listItem!.cast<Family>()[index].iconUnSelected??""}';
      }else{
        return "";
      }
    }
  }
}
