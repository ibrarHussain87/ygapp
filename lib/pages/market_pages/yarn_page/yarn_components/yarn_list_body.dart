import 'package:flutter/material.dart';
import 'package:yg_app/elements/list_items/yarn_list_items_renewed.dart';
import 'package:yg_app/elements/list_items/yarn_market_list_items.dart';
import 'package:yg_app/elements/title_text_widget.dart';
import 'package:yg_app/helper_utils/app_constants.dart';
import 'package:yg_app/helper_utils/navigation_utils.dart';
import 'package:yg_app/helper_utils/shared_pref_util.dart';
import 'package:yg_app/helper_utils/util.dart';
import 'package:yg_app/model/response/yarn_response/yarn_specification_response.dart';

import '../../../../elements/list_items/yarn_list_items_renewed_again.dart';
import '../../../detail_pages/detail_page/detail_page_renewed.dart';

class YarnListBody extends StatefulWidget {
  final List<YarnSpecification> specification;

  const YarnListBody({Key? key, required this.specification}) : super(key: key);

  @override
  YarnListBodyState createState() => YarnListBodyState();
}

class YarnListBodyState extends State<YarnListBody> {
  filterListSearch(value) {
    setState(() {
      _yarnFilteredSpecification = _specification!
          .where((element) =>
              (element.yarnFamily.toString().toLowerCase().contains(value) ||
                  element.yarnBlend.toString().contains(value)))
          .toList();
    });
  }

  List<YarnSpecification>? _specification;
  List<YarnSpecification>? _yarnFilteredSpecification;
  bool isResume = false;

  @override
  void initState() {
    _specification = widget.specification;
    _yarnFilteredSpecification = _specification;
    setState(() {
      isResume = true;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _yarnFilteredSpecification!.isNotEmpty
        ? ListView.builder(
            itemCount: _yarnFilteredSpecification!.length,
            /*separatorBuilder: (context, index) {
              return Divider(
                height: 1,
                color: Colors.grey.shade400,
              );
            },*/
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailRenewedPage(
                          specification: null,
                          yarnSpecification: _yarnFilteredSpecification![index],
                          isFromBid: null,
                        ),
                      ),
                    ).then((value) {
                      setState(() {
                        isResume = true;
                      });
                    });

                    // openDetailsScreen(context,
                    //     yarnSpecification: _yarnFilteredSpecification![index]);
                  },
                  child: buildYarnRenewedAgainWidget(
                    _yarnFilteredSpecification![index],
                    context,
                  ));
            })
        : const Center(
            child: TitleSmallTextWidget(
              title: "No Data Found!!",
            ),
          );
  }
}
