import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/elements/list_widgets/cat_with_image_listview_widget.dart';
import 'package:yg_app/elements/list_widgets/single_select_tile_widget.dart';
import 'package:yg_app/helper_utils/app_constants.dart';
import 'package:yg_app/locators.dart';
import 'package:yg_app/model/response/fiber_response/sync/sync_fiber_response.dart';
import 'package:yg_app/pages/post_ad_pages/fiber_post/component/fiber_steps_segments.dart';
import 'package:yg_app/providers/post_fiber_provider.dart';

class FiberPostPage extends StatefulWidget {
  final String? locality;
  final String? businessArea;
  final String? selectedTab;

  const FiberPostPage(
      {Key? key, required this.locality, this.businessArea, this.selectedTab})
      : super(key: key);

  @override
  _FiberPostPageState createState() => _FiberPostPageState();
}

class _FiberPostPageState extends State<FiberPostPage> {

  final _fiberPostProvider = locator<PostFiberProvider>();

  @override
  void initState() {
    super.initState();
    _fiberPostProvider.addListener(() {
      updateUI();
    });
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _fiberPostProvider.getFiberSyncedData();
    });
  }

  updateUI() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: !_fiberPostProvider.isLoading ? Padding(
            padding: EdgeInsets.only(left: 8.w, right: 8.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10,),
                        SingleSelectTileWidget(
                            spanCount: 2,
                            callback: (FiberFamily value) {
                              _fiberPostProvider.createRequestModel.spc_nature_idfk = value.fiberFamilyId.toString();
                              _fiberPostProvider.getFiberBlends(value.fiberFamilyId);
                            },
                            listOfItems: _fiberPostProvider.fiberFamilyList)
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                            padding: EdgeInsets.only(left: 8,right: 8,top: 15),
                            child: Divider()
                        ),
                        BlendsWithImageListWidget(
                          // key: _catWithImageListState,
                          listItem: _fiberPostProvider.fiberBlendsList,
                          onClickCallback: (index) {
                            _fiberPostProvider.createRequestModel.spc_fiber_family_idfk =
                                _fiberPostProvider.fiberBlendsList[index].blnId.toString();
                            _fiberPostProvider.selectedBlendId = _fiberPostProvider.fiberBlendsList[index].blnId.toString();
                            _fiberPostProvider.fiberSettingSelectedBlend();
                          },
                        ),
                        const Padding(
                            padding: EdgeInsets.only(left: 8,right: 8,),
                            child: Divider()
                        ),
                      ],
                    ),
                  ],
                ),
                Visibility(
                  visible: widget.selectedTab == offering_type,
                  child: const SizedBox(
                    height: 8,
                  ),
                ),
                Expanded(
                  child: FiberStepsSegments(
                    // syncFiberResponse: data,
                    locality: widget.locality,
                    businessArea: widget.businessArea,
                    selectedTab: widget.selectedTab,
                    stepsCallback: (value) {
                      // if (value is int) {
                      //   selectedSegment = value;
                      //   BroadcastReceiver().publish<int>(segmentIndexBroadcast,
                      //       arguments: selectedSegment);
                      // }
                    },
                  ),
                ),
              ],
            ),
          ):Container()),
    );
  }
}
