import 'package:flutter/material.dart';
import 'package:yg_app/elements/list_items_widgets/fiber_market_list_item.dart';
import 'package:yg_app/helper_utils/navigation_utils.dart';
import 'package:yg_app/model/response/fiber_response/fiber_specification.dart';

class FiberListingBody extends StatefulWidget {
  final List<Specification> specification;

  const FiberListingBody({Key? key, required this.specification})
      : super(key: key);

  @override
  FiberListingBodyState createState() => FiberListingBodyState();
}

class FiberListingBodyState extends State<FiberListingBody> {

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
    specification = widget.specification;
    specificationFiltered = specification;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: specificationFiltered!.length,
      itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            openFiberDetailsScreen(
                context, specificationFiltered![index]);
          },
          child: buildFiberWidget(specificationFiltered![index])),
      // separatorBuilder: (context, index) {
      //   return Divider(
      //     height: 1,
      //     color: Colors.grey.shade400,
      //   );
      // },
    );
  }
}
