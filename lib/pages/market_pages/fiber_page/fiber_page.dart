import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:search_choices/search_choices.dart';
import 'package:yg_app/elements/bottom_sheets/offering_requirment_bottom_sheet.dart';
import 'package:yg_app/elements/list_widgets/cat_with_image_listview_widget.dart';
import 'package:yg_app/elements/list_widgets/single_select_tile_renewed_widget.dart';
import 'package:yg_app/elements/loading_widgets/loading_listing.dart';
import 'package:yg_app/elements/title_text_widget.dart';
import 'package:yg_app/helper_utils/navigation_utils.dart';
import 'package:yg_app/locators.dart';
import 'package:yg_app/model/request/filter_request/filter_request.dart';
import 'package:yg_app/model/response/fiber_response/fiber_specification.dart';
import 'package:yg_app/model/response/fiber_response/sync/sync_fiber_response.dart';
import 'package:yg_app/pages/fliter_pages/fiber_filter_view.dart';
import 'package:yg_app/pages/market_pages/common_components/offering_requirment__segment_component.dart';
import 'package:yg_app/pages/market_pages/fiber_page/fiber_family_component.dart';
import 'package:yg_app/pages/market_pages/fiber_page/fiber_listing_body.dart';
import 'package:yg_app/pages/market_pages/fiber_page/fiber_listing_future_component.dart';
import 'package:yg_app/pages/post_ad_pages/fiber_post/fiber_post_page.dart';
import 'package:yg_app/helper_utils/app_colors.dart';
import 'package:yg_app/helper_utils/app_constants.dart';
import 'package:yg_app/providers/fiber_specification_provider.dart';

import '../../../app_database/app_database_instance.dart';
import '../../../helper_utils/app_images.dart';
import '../../../helper_utils/util.dart';
import '../../../model/response/common_response_models/countries_response.dart';

class FiberPage extends StatefulWidget {
  final String locality;

  const FiberPage({Key? key, required this.locality}) : super(key: key);

  @override
  _FiberPageState createState() => _FiberPageState();
}

class _FiberPageState extends State<FiberPage> {
  final _fiberSpecificationProvider = locator<FiberSpecificationProvider>();
  List<Specification> _specifications = [];

  @override
  void initState() {
    super.initState();
    _fiberSpecificationProvider.addListener(() {
      updateUI();
    });
    _fiberSpecificationProvider.getSpecificationRequestModel.isOffering = "1";
    _fiberSpecificationProvider.getSpecificationRequestModel.categoryId = "1";
    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      _fiberSpecificationProvider.getFiberDataFromDb();
      _fiberSpecificationProvider.getCountries();
      if (widget.locality == international) {
        await _fiberSpecificationProvider
            .getFibersInternational(widget.locality);
      } else {
        await _fiberSpecificationProvider.getFibers(widget.locality);
      }
      _specifications =
          _fiberSpecificationProvider.getSpecificationList(widget.locality);
    });
  }

  updateUI() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: bodyContent(),
    );
  }

  bodyContent() {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showBottomSheetOR(context, (value) {
              openFiberPostPage(context, widget.locality, 'Fiber', value);
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
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16, right: 16),
                        child: (!_fiberSpecificationProvider.isLoading)
                            ? Container(
                                color: Colors.white,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 8.w,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                            height: 0.04 *
                                                MediaQuery.of(context)
                                                    .size
                                                    .height,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 2.0),
                                              child:
                                                  SingleSelectTileRenewedWidget(
                                                spanCount: 2,
                                                selectedIndex: 0,
                                                listOfItems:
                                                    _fiberSpecificationProvider
                                                        .fiberFamily,
                                                callback: (FiberFamily value) {
                                                  _fiberSpecificationProvider
                                                      .getFiberBlends(
                                                          value.fiberFamilyId);
                                                },
                                              ),
                                            )),
                                        SizedBox(
                                          height: 8.w,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 8.w,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: BlendsWithImageListWidget(
                                            selectedItem: -1,
                                            listItem:
                                                _fiberSpecificationProvider
                                                    .fiberBlends,
                                            onClickCallback: (index) {
                                              _fiberSpecificationProvider
                                                  .fiberBlends[index];
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            : SizedBox(
                                child: const LoadingListing(),
                                height:
                                    0.065 * MediaQuery.of(context).size.height,
                              ) /*FiberFamilyComponent(
                          key: familySateFiber,
                          callback: (FiberBlends value) {
                            fiberListingState.currentState!.refreshListing(
                                GetSpecificationRequestModel(fiberMaterialId: [value.blnId!]));
                          },
                        )*/
                        ,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Row(
                          children: [
                            Expanded(
                              flex: widget.locality == international ? 8 : 10,
                              child: OfferingRequirementSegmentComponent(
                                callback: (value) {
                                  // fiberListingState.currentState!
                                  //     .refreshListing(
                                  //         GetSpecificationRequestModel(
                                  //             isOffering: value.toString()));
                                },
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
                              flex: widget.locality == international ? 3 : 0,
                              child: Visibility(
                                  maintainSize: false,
                                  maintainState: false,
                                  visible: widget.locality == international,
                                  child: /*_fiberSpecificationProvider
                                              .countries !=
                                          null
                                      ?*/
                                      SearchChoices.single(
                                    displayClearIcon: false,
                                    isExpanded: true,
                                    hint: const TitleExtraSmallBoldTextWidget(
                                        title: 'Country'),
                                    items: _fiberSpecificationProvider.countries
                                        .map((value) => DropdownMenuItem(
                                              child: Text(
                                                value.conName ??
                                                    Utils.checkNullString(
                                                        false),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 12.sp,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              value: value,
                                            ))
                                        .toList(),
                                    isCaseSensitiveSearch: false,
                                    onChanged: (Countries? value) {
                                      // fiberListingState
                                      //     .currentState!
                                      //     .fiberListingBodyState
                                      //     .currentState!
                                      //     .filterListSearch(
                                      //         value!.conName.toString());
                                    },
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: textColorGrey,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  )
                                  /*: DropdownButtonFormField<String>(
                                          isExpanded: true,
                                          decoration:
                                              const InputDecoration.collapsed(
                                                  hintText: ''),
                                          hint:
                                              const TitleExtraSmallBoldTextWidget(
                                                  title: 'Country'),
                                          iconSize: 20,
                                          items: [
                                            DropdownMenuItem(
                                              child: Text(
                                                Utils.checkNullString(false),
                                                textAlign: TextAlign.start,
                                                maxLines: 1,
                                                overflow: TextOverflow.fade,
                                                softWrap: false,
                                                style: TextStyle(
                                                  fontSize: 12.sp,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ),
                                          ],
                                          onChanged: (newValue) {},
                                          validator: (value) => value == null
                                              ? 'Please select country name'
                                              : null,
                                        )*/

//                                DropdownButtonFormField(
//                                  isExpanded: true,
//                                  decoration: const InputDecoration.collapsed(hintText: ''),
//                                  hint: const TitleExtraSmallBoldTextWidget(title: 'Country'),
//                                  items: _countries
//                                      .map((value) =>
//                                      DropdownMenuItem(
//                                        child: Text(
//                                            value.conName ??
//                                                Utils.checkNullString(false),
//                                            textAlign: TextAlign
//                                                .center),
//                                        value: value,
//                                      ))
//                                      .toList(),
//                                  onChanged: (Countries? value) {
//                                    /*_createRequestModel!
//                                      .spc_origin_idfk =
//                                      value!.conId.toString();*/
//                                    fiberListingState.currentState!.fiberListingBodyState.currentState!.filterListSearch(value!.conName.toString());
//                                  },
//                                  style: TextStyle(
//                                      fontSize: 11.sp,
//                                      color: textColorGrey),
//                                ),
                                  ),
                            ),
                            Visibility(
                              visible: false,
                              child: Center(
                                child: GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: () async {
                                    // if (familySateFiber
                                    //         .currentState!.fiberSyncResponse !=
                                    //     null) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              FiberFilterView()),
                                    ).then((value) {
                                      //Getting result from filter
                                      if (value != null) {
                                        // fiberListingState.currentState!
                                        //     .refreshListing(value);
                                      }
                                    });
                                    // } else {
                                    //   Fluttertoast.showToast(msg: "Please wait...");
                                    // }
                                  },
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
                    child: !_fiberSpecificationProvider.isLoading
                        ? FiberListingBody(
                            specification: _specifications,
                          )
                        : const Center(
                            child: SpinKitWave(
                              color: Colors.green,
                              size: 24.0,
                            ) /*FiberListingComponent(
                         locality: widget.locality)*/
                            ,
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
