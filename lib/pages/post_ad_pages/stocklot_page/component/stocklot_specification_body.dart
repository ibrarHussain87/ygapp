import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/pages/post_ad_pages/packing_details_component.dart';

import '../../../../elements/elevated_button_widget.dart';
import '../../../../elements/list_widgets/single_select_tile_widget.dart';
import '../../../../elements/title_text_widget.dart';
import '../../../../helper_utils/app_colors.dart';

class StockLotSpecificationBody extends StatefulWidget {
  final String? locality;
  final String? businessArea;
  final String? selectedTab;

  const StockLotSpecificationBody(
      {Key? key, required this.locality, this.businessArea, this.selectedTab})
      : super(key: key);

  @override
  StockLotSpecificationBodyState createState() =>
      StockLotSpecificationBodyState();
}

class StockLotSpecificationBodyState extends State<StockLotSpecificationBody> {
  bool showWaste = true;
  bool showStockLot = false;
  bool showYarnWaste = false;
  bool showFiberWaste = false;
  bool showYarnLO = false;
  bool showFabricsLO = false;
  bool showApearalsLO = false;
  List<String> _stockLotList = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 8.w, horizontal: 16.w),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 8.h,
                  ),

                  //Waste
                  Visibility(
                    visible: showWaste,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TitleMediumTextWidget(title: "Waste"),
                        SizedBox(
                          height: 4.h,
                        ),
                        SingleSelectTileWidget(
                          spanCount: 3,
                          listOfItems: [
                            'Cotton Waste',
                            'Yarn Waste',
                            'Fabric Waste'
                          ],
                          selectedIndex: -1,
                          callback: (value) {
                            setState(() {
                              if(value == "Yarn Waste"){
                                showYarnWaste = true;
                                showFiberWaste = false;
                              }else if(value == "Fabric Waste"){
                                showYarnWaste = false;
                                showFiberWaste = true;
                              }else{
                                showYarnWaste = false;
                                showFiberWaste = false;
                              }
                            });

                          },
                        )
                      ],
                    ),
                  ),

                  //Yarn Waste
                  Visibility(
                    visible: showYarnWaste,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: 4.h,
                        ),
                        TitleMediumTextWidget(title: "Yarn Waste"),
                        SizedBox(
                          height: 4.h,
                        ),
                        SingleSelectTileWidget(
                          spanCount: 3,
                          listOfItems: [
                            'Card Fly',
                            'Nimafill',
                            'Hard Waste',
                            'Lacrean',
                            'Comber Nail',
                            'Guter'
                          ],
                          selectedIndex: -1,
                          callback: (value) {},
                        )
                      ],
                    ),
                  ),

                  //Fiber Waste
                  Visibility(
                    visible: showFiberWaste,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: 4.h,
                        ),
                        TitleMediumTextWidget(title: "Fabric Waste"),
                        SizedBox(
                          height: 4.h,
                        ),
                        SingleSelectTileWidget(
                          spanCount: 3,
                          listOfItems: [
                            'Strips (Kanari)',
                            'Cut Piece',
                            'Hard Waste',
                            'Paper Cone',
                            'Stoper',
                            'Polybag',
                            'Carton'
                          ],
                          selectedIndex: -1,
                          callback: (value) {},
                        )
                      ],
                    ),
                  ),

                  //Stock Lot
                  Visibility(
                      visible: showStockLot,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: 4.h,
                          ),
                          TitleMediumTextWidget(title: "Stock Lot"),
                          SizedBox(
                            height: 4.h,
                          ),
                          SingleSelectTileWidget(
                            spanCount: 3,
                            listOfItems: _stockLotList,
                            selectedIndex: -1,
                            callback: (value) {
                              setState(() {
                                if(value == "Yarn"){
                                  showYarnLO = true;
                                  showFabricsLO = false;
                                  showApearalsLO = false;
                                }else if(value == "Fabrics"){
                                  showYarnLO = false;
                                  showFabricsLO = true;
                                  showApearalsLO = false;
                                }else{
                                  showYarnLO = false;
                                  showFabricsLO = false;
                                  showApearalsLO = true;
                                }
                              });
                            },
                          )
                        ],
                      )),

                  //Yarn Left Over
                  Visibility(
                      visible: showYarnLO,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: 4.h,
                          ),
                          TitleMediumTextWidget(title: "Yarn"),
                          SizedBox(
                            height: 4.h,
                          ),
                          SingleSelectTileWidget(
                            spanCount: 3,
                            listOfItems: [
                              'Gerige Yarn',
                              'Dyed Yarn',
                              'Bleached Yarn'
                            ],
                            selectedIndex: -1,
                            callback: (value) {},
                          )
                        ],
                      )),

                  //Fabrics Left Over
                  Visibility(
                      visible: showFabricsLO,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: 4.h,
                          ),
                          TitleMediumTextWidget(title: "Fabric"),
                          SizedBox(
                            height: 4.h,
                          ),
                          SingleSelectTileWidget(
                            spanCount: 2,
                            listOfItems: [
                              'Gerige Fabrics',
                              'Dyed Fabrics',
                              'Rejected Fabrics',
                              'Bleached'
                            ],
                            selectedIndex: -1,
                            callback: (value) {},
                          )
                        ],
                      )),

                  //Apperals Left Over
                  Visibility(
                      visible: showApearalsLO,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: 4.h,
                          ),
                          TitleMediumTextWidget(title: "Appearls"),
                          SizedBox(
                            height: 4.h,
                          ),
                          SingleSelectTileWidget(
                            spanCount: 2,
                            listOfItems: [
                              'Home Apperals',
                              'Garments',
                            ],
                            selectedIndex: -1,
                            callback: (value) {},
                          )
                        ],
                      )),
                ],
              ),
            ),
            flex: 9,
          ),
          // PackagingDetails(locality: widget.locality, businessArea: widget.businessArea, selectedTab: widget.selectedTab)
          ElevatedButtonWithIcon(callback: (){}, color: Colors.green, btnText: "Next")
        ],
      ),
    );
  }

  onCatChange(String value) {
    setState(() {
      if (value == 'Waste') {
        showWaste = true;
        showStockLot = false;
        _hideChildContent();
      } else if (value == "Left Over") {
        _stockLotList = ['Yarn', 'Fabrics', 'Apperals'];
        showStockLot = true;
        showWaste = false;
        _hideChildContent();
      } else {
        _stockLotList = ['Fabrics', 'Apperals'];
        showStockLot = true;
        showWaste = false;
        _hideChildContent();
      }
    });
  }

  _hideChildContent(){
    showFabricsLO = false;
    showApearalsLO = false;
    showYarnWaste = false;
    showFiberWaste = false;
    showYarnLO = false;
  }
}
