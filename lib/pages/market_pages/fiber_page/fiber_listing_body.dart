import 'package:flutter/material.dart';
import 'package:yg_app/elements/list_items/fiber_market_list_item.dart';
import 'package:yg_app/elements/list_items/fiber_market_list_item_renewed.dart';
import 'package:yg_app/helper_utils/app_constants.dart';
import 'package:yg_app/helper_utils/navigation_utils.dart';
import 'package:yg_app/helper_utils/shared_pref_util.dart';
import 'package:yg_app/model/response/fiber_response/fiber_specification.dart';

class FiberListingBody extends StatefulWidget {
  final List<Specification> specification;

  const FiberListingBody({Key? key, required this.specification})
      : super(key: key);

  @override
  FiberListingBodyState createState() => FiberListingBodyState();
}

class FiberListingBodyState extends State<FiberListingBody> {

  late String? userId;

  filterListSearch(value) {
    setState(() {
      specificationFiltered = specification!
          .where(
              (element) => (element.material.toString().toLowerCase().contains(value) || element.grade.toString().contains(value)))
          .toList();
    });
  }

  List<Specification>? specification;
  List<Specification>? specificationFiltered;

  @override
  void initState() {
    setInitialData();
    super.initState();
  }

  void setInitialData() async {
    specification = widget.specification;
    specificationFiltered = specification;
    userId = await SharedPreferenceUtil.getStringValuesSF(USER_ID_KEY);
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: specificationFiltered!.length,
      itemBuilder: (context, index) => GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            openDetailsScreen(
                context,specification: specificationFiltered![index]);
          },
          child: buildFiberRenewedWidget(specificationFiltered![index],context,userId!)),
      // separatorBuilder: (context, index) {
      //   return Divider(
      //     height: 1,
      //     color: Colors.grey.shade400,
      //   );
      // },
    );
  }
}
