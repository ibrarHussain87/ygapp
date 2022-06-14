
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:search_choices/search_choices.dart';
import 'package:yg_app/elements/bottom_sheets/offering_requirment_bottom_sheet.dart';
import 'package:yg_app/elements/list_widgets/blend_with_image_listview_widget.dart';
import 'package:yg_app/elements/list_widgets/single_select_tile_renewed_widget.dart';
import 'package:yg_app/elements/loading_widgets/loading_listing.dart';
import 'package:yg_app/elements/text_widgets.dart';
import 'package:yg_app/helper_utils/app_colors.dart';
import 'package:yg_app/helper_utils/app_constants.dart';
import 'package:yg_app/helper_utils/navigation_utils.dart';
import 'package:yg_app/locators.dart';
import 'package:yg_app/model/response/fiber_response/fiber_specification.dart';
import 'package:yg_app/model/response/fiber_response/sync/sync_fiber_response.dart';
import 'package:yg_app/pages/market_pages/common_components/offering_requirment__segment_component.dart';
import 'package:yg_app/pages/market_pages/fiber_page/fiber_listing_body.dart';
import 'package:yg_app/providers/fiber_providers/fiber_specification_provider.dart';
import 'package:yg_app/providers/specification_local_filter_provider.dart';

import '../../../helper_utils/app_images.dart';
import '../../../helper_utils/util.dart';
import '../../../model/response/common_response_models/countries_response.dart';

class FiberPage extends StatefulWidget {
  final String locality;

  const FiberPage({Key? key, required this.locality}) : super(key: key);

  @override
  FiberPageState createState() => FiberPageState();
}

class FiberPageState extends State<FiberPage> {
  final _fiberSpecificationProvider = locator<FiberSpecificationProvider>();
  final _specificationLocalFilterProvider = locator<SpecificationLocalFilterProvider>();

  @override
  void initState() {
    super.initState();
    _fiberSpecificationProvider.addListener(() {
      updateUI();
    });
    _fiberSpecificationProvider.specificationRequestModel.isOffering = "1";
    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      _fiberSpecificationProvider.fiberSyncDataForMarketPage();
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
          width: MediaQuery.of(context).size.width,
          color: bgColor,
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: OfferingRequirementSegmentComponent(
                      callback: (value) {
                        _fiberSpecificationProvider
                            .specificationRequestModel
                            .isOffering = value.toString();
                        _fiberSpecificationProvider.notifyUI();
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
                        child: SearchChoices.single(
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
                            _specificationLocalFilterProvider
                                .fiberFilterListSearch(
                                value!.conName.toString());
                          },
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: textColorGrey,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )),
                  ),
                ],
              ),
              Material(
                elevation: 0.2,
                color: Colors.white,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25))),
                child: Container(
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
                                                      .blendWidgetKey
                                                      .currentState!
                                                      .checkedIndex = -1;
                                                  _fiberSpecificationProvider
                                                      .onClickFamily(value);
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
                                            key: _fiberSpecificationProvider
                                                .blendWidgetKey,
                                            selectedItem: -1,
                                            listItem:
                                                _fiberSpecificationProvider
                                                    .fiberBlends,
                                            onClickCallback: (index) {
                                              _fiberSpecificationProvider
                                                      .specificationRequestModel
                                                      .fbBlendIdfk =
                                                  [_fiberSpecificationProvider
                                                      .fiberBlends[index]
                                                      .blnId!];
                                              _fiberSpecificationProvider
                                                  .notifyUI();
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 8.w,
                                    ),
                                  ],
                                ),
                              )
                            : SizedBox(
                                child: const LoadingListing(),
                                height:
                                    0.065 * MediaQuery.of(context).size.height,
                              ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.white,
                    margin: EdgeInsets.only(top: 1.w),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: FutureBuilder<FiberSpecificationResponse>(
                        future: _fiberSpecificationProvider
                            .getFibers(widget.locality),
                        builder: (BuildContext context, snapshot) {
                          if (snapshot.connectionState ==
                                  ConnectionState.done &&
                              snapshot.data != null) {
                            return Container(
                              child: snapshot
                                      .data!.data.specification.isNotEmpty
                                  ? FiberListingBody(
                                      specification: _fiberSpecificationProvider
                                          .fiberSpecificationResponse!
                                          .data
                                          .specification,
                                    )
                                  : const Center(
                                      child: TitleSmallTextWidget(
                                        title: 'No Data Found',
                                      ),
                                    ),
                            );
                          } else if (snapshot.hasError) {
                            return Center(
                                child: TitleSmallTextWidget(
                                    title: snapshot.error.toString()));
                          } else {
                            return const Center(
                              child: SpinKitWave(
                                color: Colors.green,
                                size: 24.0,
                              ),
                            );
                          }
                        },
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
