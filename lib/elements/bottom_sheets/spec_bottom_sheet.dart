import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';
import 'package:yg_app/helper_utils/app_colors.dart';

import '../../helper_utils/top_round_corners.dart';
import '../list_widgets/single_select_tile_widget.dart';
import '../list_widgets/spec_select_tile_widget.dart';


final GlobalKey<SingleSelectTileWidgetState> _specKey =
GlobalKey<SingleSelectTileWidgetState>();

specsSheet(BuildContext context,
    Function checkedIndex,
    Function callback,
    List listOfItems,
    int selectedIndex
    )
{

  // final ValueNotifier<bool> showDoublingMethod = ValueNotifier(false);
  // String? _selectedPlyId;
  // int checkedTile;
  // checkedTile = selectedIndex;


  showModalBottomSheet<int>(
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    context: context,
    builder: (context) {
      return StatefulBuilder(
          builder: (BuildContext contextBuilder, StateSetter setState) {
            return SingleChildScrollView(
              child: Container(
                decoration: getRoundedTopCorners(),
                /*padding: const EdgeInsets.only(left: 15.0,right: 15.0),*/
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                    left: 15.0,right: 15.0,),
//              height: MediaQuery.of(context).size.height/1.5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Column(
                      children: [
                        Align(
                            alignment: Alignment.topRight,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: const Icon(Icons.close),
                              ),
                            )),
                        Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Text(
                            "Select Specification",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 18.0.sp,
                                color: headingColor,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        const Divider(color: Colors.black12,),
                        SizedBox(height:2.w ,),

                      ],
                    ),
                    SizedBox(height: 12.w,),
                    SpecSelectTileWidget(
                      selectedIndex: selectedIndex,
                      key: _specKey,
                      spanCount: 2,
                      listOfItems: listOfItems,
                      selectedValue: (int checkedValue)
                      {

                        Logger().e("Calue +"+checkedValue.toString());
                        checkedIndex(checkedValue);
                      },
                      callback: (value) {

                     callback(value);
                      },
                    ),
                    SizedBox(height:10.w ,),

                  ],
                ),
              ),
            );
          });
    },
  );



}



