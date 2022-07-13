import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:search_choices/search_choices.dart';
import 'package:yg_app/elements/bottom_sheets/offering_requirment_bottom_sheet.dart';
import 'package:yg_app/elements/custom_header.dart';
import 'package:yg_app/helper_utils/app_colors.dart';
import 'package:yg_app/helper_utils/app_constants.dart';
import 'package:yg_app/helper_utils/navigation_utils.dart';
import 'package:yg_app/locators.dart';
import 'package:yg_app/model/request/filter_request/filter_request.dart';
import 'package:yg_app/model/response/yarn_response/sync/yarn_sync_response.dart';
import 'package:yg_app/pages/market_pages/common_components/offering_requirment__segment_component.dart';
import 'package:yg_app/pages/market_pages/yarn_page/yarn_components/yarn_list_future_widget.dart';
import 'package:yg_app/providers/yarn_providers/post_yarn_provider.dart';
import 'package:yg_app/providers/yarn_providers/yarn_specifications_provider.dart';

import '../../../app_database/app_database_instance.dart';
import '../../../elements/text_widgets.dart';
import '../../../helper_utils/app_images.dart';
import '../../../helper_utils/util.dart';
import '../../../model/response/common_response_models/countries_response.dart';
import '../../fliter_pages/yarn/yarn_filter_page.dart';
import 'yarn_components/family_blend_body.dart';

class YarnPage extends StatefulWidget {
  final String? locality;

  const YarnPage({Key? key, required this.locality}) : super(key: key);

  @override
  YarnPageState createState() => YarnPageState();
}

class YarnPageState extends State<YarnPage> {
  ValueNotifier<bool> isDialOpen = ValueNotifier(false);
  final GlobalKey<YarnSpecificationListFutureState> yarnSpecificationListState =
  GlobalKey<YarnSpecificationListFutureState>();
  final _postYarnProvider = locator<PostYarnProvider>();
  final _yarnSpecificationProvider = locator<YarnSpecificationsProvider>();

  @override
  void initState() {
    super.initState();
    _postYarnProvider.getBlendsData();
    _postYarnProvider.getCountries();
    _yarnSpecificationProvider.addListener(() {
      setState(() {});
    });
  }

  updateUI() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar:
        appBar(context, yarn, isFilterVisible: true, filterCallback: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const YarnFilterBody()),
          ).then((value) {
            _yarnSpecificationProvider.setRequestParams(value, widget.locality!);
          });
        }),
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.grey.shade100,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showBottomSheetOR(context, (value) {
              _postYarnProvider.resetData();
              _postYarnProvider.selectedYarnFamily = null;
              openYarnPostPage(context, widget.locality, yarn, value);
            });
          },
          child: const Icon(Icons.add),
          backgroundColor: Colors.blueAccent,
          heroTag: null,
        ),
        body: Container(
          color: bgColor,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Row(
                  children: [
                    Expanded(
                      flex: widget.locality == international ? 8 : 10,
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 6.w),
                        child: OfferingRequirementSegmentComponent(
                          callback: (value) {
                            yarnSpecificationListState.currentState!.searchData(
                                GetSpecificationRequestModel(
                                    isOffering: value.toString()));
                          },
                        ),
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
                          child: _postYarnProvider.countries != null
                              ? SearchChoices.single(
                            displayClearIcon: false,
                            isExpanded: true,
                            hint: const TitleExtraSmallBoldTextWidget(
                                title: 'Country'),
                            items: _postYarnProvider.countries
                                .map((value) =>
                                DropdownMenuItem(
                                  child: Text(
                                    value.conName ??
                                        Utils.checkNullString(false),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  value: value,
                                ))
                                .toList(),
                            isCaseSensitiveSearch: false,
                            onChanged: (Countries? value) {
                              yarnSpecificationListState.currentState!
                                  .yarnListBodyState.currentState!
                                  .filterListSearch(
                                  value!.conName.toString());
                            },
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: textColorGrey,
                              overflow: TextOverflow.ellipsis,
                            ),
                          )
                              : DropdownButtonFormField<String>(
                            isExpanded: true,
                            decoration: const InputDecoration.collapsed(
                                hintText: ''),
                            hint: const TitleExtraSmallBoldTextWidget(
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
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ],
                            onChanged: (newValue) {},
                            validator: (value) =>
                            value == null
                                ? 'Please select country name'
                                : null,
                          )

//                                DropdownButtonFormField(
//                                  isExpanded: true,
//                                  decoration: const InputDecoration.collapsed(hintText: ''),
//                                  hint: const TitleExtraSmallBoldTextWidget(title:'Country'),
//                                  items: _countries
//                                      .map((value) =>
//                                      DropdownMenuItem(
//                                        child: Expanded(
//                                          child: Text(
//                                              value.conName ??
//                                                  Utils.checkNullString(false),
//                                              textAlign: TextAlign.start,
//                                            maxLines: 1,
//                                            overflow: TextOverflow.fade,
//                                            softWrap: false,),
//                                        ),
//                                        value: value,
//                                      ))
//                                      .toList(),
//                                  onChanged: (Countries? value) {
//                                    /*_createRequestModel!
//                                        .spc_origin_idfk =
//                                        value!.conId.toString();*/
//                                    yarnSpecificationListState.currentState!.yarnListBodyState.currentState!.filterListSearch(value!.conName.toString());
//                                  },
//                                  style: TextStyle(
//                                      fontSize: 11.sp,
//                                      color: textColorGrey),
//                                ),
                      ),
                    ),
                    Visibility(
                      visible: false,
                      child: Expanded(
                        flex: 1,
                        child: Center(
                          child: Card(
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
              Material(
                elevation: 0.2,
                color: Colors.white,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25))),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  /*decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0.0, 1.0.w), //(x,y)
                      blurRadius: 2.0.w,
                    ),
                  ], color: Colors.white),*/
                  child: Column(
                    children: [
                      // YarnFamilyBlendListingBody(
                      //   blendCallback: (Blends? blend) {
                      //     var model = GetSpecificationRequestModel();
                      //     model.ysBlendIdFk = [blend!.blnId!];
                      //     yarnSpecificationListState.currentState!
                      //         .searchData(model);
                      //   },
                      //   yarnFamilyCallback: (Family? yarnFamily) {
                      //     var model = GetSpecificationRequestModel();
                      //     model.ysFamilyIdFk = [yarnFamily!.famId!];
                      //     yarnSpecificationListState.currentState!
                      //         .searchData(model);
                      //   },
                      // ),
                      const SizedBox(
                        height: 8,
                      ),
                      BlendFamily(
                        // yarnSyncResponse: snapshot.data!,
                        yarnFamilyCallback: (Family yarnFamily) {
                          var model = GetSpecificationRequestModel();
                          model.ysFamilyIdFk = [yarnFamily.famId!];
                          yarnSpecificationListState.currentState!
                              .searchData(model);
                        },
                        blendCallback: (Blends blend, int familyId) {
                          var model = GetSpecificationRequestModel();
                          model.ysBlendIdFk = [blend.blnId!];
                          model.ysFamilyIdFk = [familyId];
                          yarnSpecificationListState.currentState!
                              .searchData(model);
                        },
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
                    child: YarnSpecificationListFuture(
                      key: yarnSpecificationListState,
                      locality: widget.locality!,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

/* String getRelatedId(Blends blend) {
    List<BlendModelExtended> blendModelArrayList = json.decode(blend.bln_ratio_json!);
    Logger().e(blendModelArrayList.first.default_bln_id);
    return blendModelArrayList.first.default_bln_id.toString();
  }*/
}
