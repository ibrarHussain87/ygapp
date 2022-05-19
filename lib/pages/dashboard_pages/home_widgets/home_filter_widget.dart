import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:yg_app/elements/list_widgets/grid_tile_more_widget.dart';
import 'package:yg_app/providers/home_providers/family_list_provider.dart';

import '../../../locators.dart';

class HomeFilterWidget extends StatefulWidget {

  final Function callback;

  const HomeFilterWidget({Key? key, required this.callback}) : super(key: key);

  @override
  _HomeFilterWidgetState createState() => _HomeFilterWidgetState();
}

class _HomeFilterWidgetState extends State<HomeFilterWidget> {

  final _familyListProvider = locator<FamilyListProvider>();

  @override
  void initState() {
    super.initState();
    // final familyListProvider = Provider.of<FamilyListProvider>(context,listen: false);
    _familyListProvider.addListener(() {updateUI();});
    _familyListProvider.getFamilyListData();
  }

  updateUI() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    // final familyListProvider = Provider.of<FamilyListProvider>(context);
    return Container(
        color: Colors.white30,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.w),
        child: !_familyListProvider.loading ? GridMoreWidget(
          spanCount: 4,
          callback: (value) {
            widget.callback(1);
          },
          listOfItems: _familyListProvider.familyList!,
        ) : Container(
          color: Colors.transparent,
          height: 100,
        )
    );
  }
}
