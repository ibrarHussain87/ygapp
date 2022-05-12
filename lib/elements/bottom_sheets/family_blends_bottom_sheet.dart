import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/elements/list_widgets/cat_with_image_listview_widget.dart';
import 'package:yg_app/helper_utils/app_colors.dart';

import '../list_widgets/family_blends_select_tile_widget.dart';
import '../list_widgets/family_select_tile_widget.dart';
import '../list_widgets/single_select_tile_widget.dart';
import '../list_widgets/spec_select_tile_widget.dart';


final GlobalKey<SingleSelectTileWidgetState> _specKey =
GlobalKey<SingleSelectTileWidgetState>();

familyBlendsSheet(BuildContext context,
    Function checkedIndex,
    Function callback,
    List listOfItems,
    int selectedIndex,
    String title
    )
{

  final ValueNotifier<bool> showDoublingMethod = ValueNotifier(false);
  String? _selectedPlyId;
  int checkedTile;
  checkedTile = selectedIndex ?? 0;


  showModalBottomSheet<int>(
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    context: context,
    builder: (context) {
      print("LIST"+listOfItems.toString());
      return StatefulBuilder(
          builder: (BuildContext contextBuilder, StateSetter setState) {
            return SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(15.w))
                ),
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
                            "Select $title Blends",
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
                    FamilyBlendsSelectTileWidget(
                      selectedIndex: selectedIndex,
                      key: _specKey,
                      spanCount: 3,
                      listOfItems: listOfItems,
                      selectedValue: (int checkedValue)
                      {

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



