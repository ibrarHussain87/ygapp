import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/elements/network_icon_widget.dart';
import 'package:yg_app/elements/title_text_widget.dart';
import 'package:yg_app/locators.dart';
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
                                          .blendList[index].blendRatio !=
                                      null &&
                                  postYarnLocator.blendList[index].blendRatio !=
                                      ""),
                              child: const TitleSmallTextWidget(title: ":")),
                          Visibility(
                              visible: (postYarnLocator
                                          .blendList[index].blendRatio !=
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

  String? getImageUrl(index) {
    return widget.listItem!.cast<Blends>()[index].isSelected ?? false
        ? postYarnLocator.blendList[index].iconSelected != null
            ? postYarnLocator.blendList[index].iconSelected!
            : ""
        : postYarnLocator.blendList[index].iconUnselected != null
            ? postYarnLocator.blendList[index].iconUnselected!
            : "";
  }
}
