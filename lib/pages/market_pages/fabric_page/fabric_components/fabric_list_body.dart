import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:yg_app/elements/list_items/yarn_list_items_renewed.dart';
import 'package:yg_app/elements/list_items/yarn_market_list_items.dart';
import 'package:yg_app/elements/title_text_widget.dart';
import 'package:yg_app/helper_utils/app_constants.dart';
import 'package:yg_app/helper_utils/navigation_utils.dart';
import 'package:yg_app/helper_utils/shared_pref_util.dart';
import 'package:yg_app/helper_utils/util.dart';
import 'package:yg_app/model/response/yarn_response/yarn_specification_response.dart';

import '../../../../elements/list_items/fabric_list_items_renewed_again.dart';
import '../../../../elements/list_items/yarn_list_items_renewed_again.dart';
import '../../../../model/response/fabric_response/fabric_specification_response.dart';
import '../../../detail_pages/detail_page/detail_page_renewed.dart';

class FabricListBody extends StatefulWidget {

  final List<FabricSpecification> specification;

  const FabricListBody({Key? key, required this.specification}) : super(key: key);

  @override
  FabricListBodyState createState() => FabricListBodyState();
}

class FabricListBodyState extends State<FabricListBody> {

  filterListSearch(value) {
    setState(() {
      _fabricFilteredSpecification = _specification!
          .where((element) =>
              (element.fabricFamily.toString().toLowerCase().contains(value) || element.fabricCountry.toString().toLowerCase().contains(value.toString().toLowerCase()) ||
                  element.fabricBlend.toString().contains(value)))
          .toList();
    });
  }

  List<FabricSpecification>? _specification;
  List<FabricSpecification>? _fabricFilteredSpecification;
  bool isResume = false;

  @override
  void initState() {
    _specification = widget.specification;
    _fabricFilteredSpecification = _specification;
    setState(() {
      isResume = true;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _fabricFilteredSpecification!.isNotEmpty
        ? ListView.builder(
            itemCount: _fabricFilteredSpecification!.length,
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
                    openDetailsScreen(context,
                        specObj: _fabricFilteredSpecification![index]);
                   // Fluttertoast.showToast(msg: 'Coming soon');
                  },
                  child: buildFabricRenewedAgainWidget(
                    _fabricFilteredSpecification![index],
                    context,showCounts: false
                  ));
            })
        : const Center(
            child: TitleSmallTextWidget(
              title: "No Data Found!!",
            ),
          );
  }
}
