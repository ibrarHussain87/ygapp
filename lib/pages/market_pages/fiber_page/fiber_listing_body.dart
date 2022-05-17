import 'package:flutter/material.dart';
import 'package:yg_app/helper_utils/navigation_utils.dart';
import 'package:yg_app/locators.dart';
import 'package:yg_app/model/response/fiber_response/fiber_specification.dart';
import 'package:yg_app/providers/specification_local_filter_provider.dart';

import '../../../elements/list_items/fiber_list_items_renewed_again.dart';

class FiberListingBody extends StatefulWidget {
  final List<Specification> specification;

  const FiberListingBody({Key? key, required this.specification})
      : super(key: key);

  @override
  FiberListingBodyState createState() => FiberListingBodyState();
}

class FiberListingBodyState extends State<FiberListingBody> {

  final _specificationLocalFilterProvider = locator<SpecificationLocalFilterProvider>();

  @override
  void initState() {
    _specificationLocalFilterProvider.fiberSpecification = widget.specification;
    _specificationLocalFilterProvider.fiberSpecificationFiltered = widget.specification;
    super.initState();
    _specificationLocalFilterProvider.addListener(() {updateUI();});
  }

  updateUI(){
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _specificationLocalFilterProvider.fiberSpecificationFiltered!.length,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) => GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            openDetailsScreen(context,
                specification: _specificationLocalFilterProvider.fiberSpecificationFiltered![index]);
          },
          child: buildFiberRenewedAgainWidget(
            _specificationLocalFilterProvider.fiberSpecificationFiltered![index],
            context,
            showCount: false
          )),
    );
  }
}
