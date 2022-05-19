import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/api_services/api_service_class.dart';
import 'package:yg_app/elements/network_icon_widget.dart';
import 'package:yg_app/elements/title_text_widget.dart';
import 'package:yg_app/helper_utils/util.dart';
import 'package:yg_app/locators.dart';
import 'package:yg_app/model/response/fabric_response/sync/fabric_sync_response.dart';
import 'package:yg_app/model/response/fiber_response/sync/sync_fiber_response.dart';
import 'package:yg_app/model/response/stocklot_repose/stocklot_sync/stocklot_sync_response.dart';
import 'package:yg_app/model/response/yarn_response/sync/yarn_sync_response.dart';

import 'package:yg_app/providers/yarn_providers/post_yarn_provider.dart';

class YarnSelectedBlendWidget extends StatefulWidget {
  final Function? onClickCallback;
  final List<dynamic>? listItem;

  const YarnSelectedBlendWidget(
      {Key? key, required this.listItem, required this.onClickCallback})
      : super(key: key);

  @override
  YarnSelectedBlendWidgetState createState() => YarnSelectedBlendWidgetState();
}

class YarnSelectedBlendWidgetState extends State<YarnSelectedBlendWidget> {
  final postYarnLocator = locator<PostYarnProvider>();

  @override
  void initState() {
    super.initState();
    postYarnLocator.addListener(() {
      updateUI();
    });
  }

  updateUI() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 0.06 * MediaQuery.of(context).size.height,
      child: ListView.builder(
        itemCount: widget.listItem!.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              widget.onClickCallback!(index);
            },
            child: Center(
              child: SizedBox(
                width: 0.23 * MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    NetworkImageIconWidget(
                        imageUrl: getImageUrl(/*castingCheckPos*/ index)),
                    SizedBox(
                      height: 2.h,
                    ),
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            postYarnLocator.blendList[index].toString(),
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 11.sp,
                            ),
                          ),
                          Visibility(
                              visible: (postYarnLocator
                                          .blendList[index].blendRatio != null &&
                                  postYarnLocator.blendList[index].blendRatio!= ""),
                              child: const TitleSmallTextWidget(title: ":")),
                          Visibility(
                              visible: (
                                  postYarnLocator.blendList[index].blendRatio !=
                                      null &&
                                  postYarnLocator.blendList[index].blendRatio !=
                                      ""),
                              child: TitleSmallBoldTextWidget(
                                  title:
                                      " ${postYarnLocator.blendList[index].blendRatio}%"))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // Widget buildListBody(int index) {
  //   String? name;
  //   int? castingCheckPos;
  /*   if (widget.listItem is List<FiberMaterial>) {
      name = widget.listItem!.cast<FiberMaterial>()[index].fbmName;
      castingCheckPos = 0;
    // } else */
  // if (widget.listItem is List<Blends>) {
  //   var blend = postYarnLocator.blendList[index];
  //   name = blend.bln_abrv ?? blend.blnName;
  //   // castingCheckPos = 1;
  // }
  /*else if (widget.listItem is List<Family>) {
      name = widget.listItem!.cast<Family>()[index].famName;
      castingCheckPos = 2;
    } else if (widget.listItem is List<FabricBlends>) {
      var fabricBlend = widget.listItem!.cast<FabricBlends>()[index];
      name = fabricBlend.blnAbrv ?? fabricBlend.blnName;
      castingCheckPos = 3;
    } else if (widget.listItem is List<FabricFamily>) {
      var fabricFamily = widget.listItem!.cast<FabricFamily>()[index];
      name = fabricFamily.fabricFamilyName ?? 'n/a';
      castingCheckPos = 4;
    } else {
      name = widget.listItem!.cast<StocklotCategories>()[index].category!;
      castingCheckPos = 5;
    }*/
  // return GestureDetector(
  //   behavior: HitTestBehavior.opaque,
  //   onTap: () {
  //     widget.onClickCallback!(index);
  //   },
  //   child: Center(
  //     child: SizedBox(
  //       width: 0.205 * MediaQuery.of(context).size.width,
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.center,
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         mainAxisSize: MainAxisSize.min,
  //         children: [
  //           NetworkImageIconWidget(
  //               imageUrl: getImageUrl(/*castingCheckPos*/ index)),
  //           SizedBox(
  //             height: 2.h,
  //           ),
  //           Expanded(
  //             child: Row(
  //               children: [
  //                 Text(
  //                   name ?? Utils.checkNullString(false),
  //                   textAlign: TextAlign.center,
  //                   maxLines: 1,
  //                   overflow: TextOverflow.ellipsis,
  //                   style: TextStyle(
  //                     fontSize: 11.sp,
  //                   ),
  //                 ),
  //                 TitleSmallBoldTextWidget(title: provider)
  //               ],
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   ),
  // );
  // }

  String? getImageUrl(index) {
    String url = "";
    /*  if (castingCheckPos == 0) {
      return '${ApiService.BASE_URL}${widget.listItem!.cast<FiberMaterial>()[index].icon_unselected ?? ""}';
    } else if (castingCheckPos == 1) {*/
    return widget.listItem!.cast<Blends>()[index].isSelected ?? false
        ? postYarnLocator.blendList[index].iconSelected != null
            ? ApiService.BASE_URL +
                postYarnLocator.blendList[index].iconSelected!
            : ""
        : postYarnLocator.blendList[index].iconUnselected != null
            ? ApiService.BASE_URL +
                postYarnLocator.blendList[index].iconUnselected!
            : "";
    // } else if (castingCheckPos == 2) {
    //   return '${ApiService.BASE_URL}${widget.listItem!.cast<Family>()[index].iconUnSelected ?? ""}';
    // } else if (castingCheckPos == 3) {
    //   return '${ApiService.BASE_URL}${widget.listItem!.cast<FabricBlends>()[index].iconUnselected ?? ""}';
    // } else if (castingCheckPos == 4) {
    //   return '${ApiService.BASE_URL}${widget.listItem!.cast<FabricFamily>()[index].iconUnselected ?? ""}';
    // } else {
    //   return "";
    // }
  }
}
