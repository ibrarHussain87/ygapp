import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/app_database/app_database_instance.dart';
import 'package:yg_app/elements/title_text_widget.dart';
import 'package:yg_app/helper_utils/app_colors.dart';
import 'package:yg_app/helper_utils/navigation_utils.dart';
import 'package:yg_app/helper_utils/util.dart';
import 'package:yg_app/model/response/common_response_models/countries_response.dart';
import 'package:yg_app/pages/market_pages/common_components/offering_requirment__segment_component.dart';
import 'package:yg_app/pages/market_pages/stocklot_page/stocklot_listing_body.dart';

import '../../../elements/offering_requirment_bottom_sheet.dart';
import '../../../helper_utils/app_constants.dart';
import '../../../helper_utils/app_images.dart';

class StockLotPage extends StatefulWidget {
  final String? locality;

  const StockLotPage({Key? key, required this.locality}) : super(key: key);

  @override
  StockLotPageState createState() => StockLotPageState();
}

class StockLotPageState extends State<StockLotPage> {
  List<Countries> _countries = [];

  @override
  void initState() {
    AppDbInstance.getOriginsData()
        .then((value) => setState(() => _countries = value));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showBottomSheetOR(context, (value) {
              openStockLotPostPage(context, widget.locality, "StockLot", value);
            });
          },
          child: const Icon(Icons.add),
          backgroundColor: Colors.blueAccent,
          heroTag: null,
        ),
        body: Container(
          color: Colors.grey.shade100,
          child: Material(
            elevation: 5,
            color: Colors.white,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25))),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  /*decoration:  BoxDecoration(boxShadow: [
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(0.0, 1.0.w), //(x,y)
                      blurRadius: 2.0.w,
                    ),
                  ],
                      */ /*color: Colors.white*/ /*
                  ),*/
                  child: Column(
                    children: [
                      // Padding(
                      //   padding: const EdgeInsets.only(left: 16,right: 16),
                      //   child: FiberFamilyComponent(
                      //     key: familySateFiber,
                      //     callback: (FiberMaterial value) {
                      //       fiberListingState.currentState!.refreshListing(
                      //           GetSpecificationRequestModel(fiberMaterialId: [value.fbmId]));
                      //     },
                      //   ),
                      // ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Row(
                          children: [
                            Expanded(
                              flex: widget.locality == international ? 8 : 10,
                              child: OfferingRequirementSegmentComponent(
                                callback: (value) {},
                              ),
                            ),
                            Visibility(
                              visible: widget.locality == international,
                              maintainState: false,
                              maintainSize: false,
                              child: Expanded(
                                child: Image.asset(
                                  ic_products,
                                  width: 12,
                                  height: 12,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: widget.locality == international ? 2 : 0,
                              child: Visibility(
                                maintainSize: false,
                                maintainState: false,
                                visible: widget.locality == international,
                                child: DropdownButtonFormField(
                                  isExpanded: true,
                                  decoration: const InputDecoration.collapsed(
                                      hintText: ''),
                                  hint: const TitleExtraSmallBoldTextWidget(
                                      title: 'Country'),
                                  items: _countries
                                      .map((value) => DropdownMenuItem(
                                            child: Text(
                                                value.conName ??
                                                    Utils.checkNullString(
                                                        false),
                                                textAlign: TextAlign.center),
                                            value: value,
                                          ))
                                      .toList(),
                                  onChanged: (Countries? value) {
                                    /*_createRequestModel!
                                      .spc_origin_idfk =
                                      value!.conId.toString();*/
                                  },
                                  style: TextStyle(
                                      fontSize: 11.sp, color: textColorGrey),
                                ),
                              ),
                            ),
                            Visibility(
                              visible: false,
                              child: Center(
                                child: GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: () async {},
                                  child: Card(
                                      color: Colors.white,
                                      elevation: 1,
                                      child: Padding(
                                          padding: EdgeInsets.all(4.w),
                                          child: Icon(
                                            Icons.filter_alt_sharp,
                                            color: lightBlueTabs,
                                            size: 16.w,
                                          ))),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(top: 8.w),
                    child: StockLotListingBody(),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
