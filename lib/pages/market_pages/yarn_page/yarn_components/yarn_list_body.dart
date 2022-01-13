import 'package:flutter/material.dart';
import 'package:yg_app/elements/list_items_widgets/yarn_list_items.dart';
import 'package:yg_app/elements/title_text_widget.dart';
import 'package:yg_app/helper_utils/navigation_utils.dart';
import 'package:yg_app/model/response/yarn_response/yarn_specification_response.dart';

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

  @override
  void initState() {
    _specification = widget.specification;
    _yarnFilteredSpecification = _specification;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _yarnFilteredSpecification!.isNotEmpty
        ? ListView.builder(
            itemCount: _yarnFilteredSpecification!.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                  onTap: () {
                    openDetailsScreen(context,
                        yarnSpecification: _yarnFilteredSpecification![index]);
                  },
                  child: buildYarnWidget(_yarnFilteredSpecification![index]));
            })
        : const Center(
            child: TitleSmallTextWidget(
              title: "No Data Found!!",
            ),
          );
  }
}
