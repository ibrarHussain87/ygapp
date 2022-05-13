import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';
import 'package:yg_app/elements/list_widgets/single_select_tile_widget.dart';
import 'package:yg_app/helper_utils/app_colors.dart';
import 'package:yg_app/helper_utils/fabric_bottom_sheet.dart';
import 'package:yg_app/model/response/yarn_response/sync/yarn_sync_response.dart';

import '../../app_database/app_database_instance.dart';
import '../../helper_utils/app_constants.dart';
import '../../locators.dart';
import '../../providers/post_yarn_provider.dart';
import '../bottom_sheets/family_blends_bottom_sheet.dart';
import '../title_text_widget.dart';

class FamilySelectTileWidget extends StatefulWidget {
  final Function? callback;
  final Function? selectedValue;
  final List<dynamic> listOfItems;
  final int? spanCount;
  final int? selectedIndex;

  const FamilySelectTileWidget(
      {Key? key,
        required this.spanCount,
        required this.callback,
        required this.selectedValue,
        required this.listOfItems,
        this.selectedIndex,
      })
      : super(key: key);

  @override
  FamilySelectTileWidgetState createState() => FamilySelectTileWidgetState();
}

class FamilySelectTileWidgetState extends State<FamilySelectTileWidget> {
  int? checkedTile;
  late double aspectRatio;
  var looger = Logger();
  List<Blends> _blendsList=[];
  final _postYarnProvider = locator<PostYarnProvider>();

  @override
  void initState() {
    print("Index"+widget.selectedIndex.toString());
    AppDbInstance().getYarnBlendData()
        .then((value) => setState(() => _blendsList = value));
    _postYarnProvider.yarnBlendsList=_blendsList;
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
    return  GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: 16,
          mainAxisSpacing: 2,
          crossAxisCount: 1,
          childAspectRatio: 7.5),
      itemCount: widget.listOfItems.length,
      itemBuilder: (context, index) {
        return  buildGrid(index);
      },
    );
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
        widget.selectedValue!(checkedTile);

        looger.e(widget.listOfItems[index].toString());
      },
      child: buildContainer(checked, index),
    );
  }


  Container buildContainer(bool checked, int index) {
    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.transparent,
          ),
//          color: checked
//              ? darkBlueChip
//              : lightBlueChip,
//          borderRadius: BorderRadius.all(Radius.circular(5.w))
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 8,
                child: Text(
                  widget.listOfItems[index].toString(),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  softWrap: false,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w600,
                      color:Colors.black87),
//                      color: checked ? Colors.white : darkBlueChip),
                ),
              ),
              Expanded(
                child:GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                    widget.callback!(widget.listOfItems[index]);
                  },
                  child: const Icon(Icons.arrow_forward_ios_outlined,
                    size: 14,

                    color: Colors.black87,
                  ),
                ),
              ),
            ],
          ),
          const Divider(color: Colors.black12,),
        ],

      ),
    );
  }


  resetWidget(){
    setState(() {
      checkedTile = 0;

    });
  }
}
