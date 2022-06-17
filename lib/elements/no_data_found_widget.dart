
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:yg_app/helper_utils/app_colors.dart';

class NoDataFoundWidget extends StatefulWidget {


  const NoDataFoundWidget({Key? key,}) : super(key: key);

  @override
  _NoDataFoundWidgetState createState() => _NoDataFoundWidgetState();
}

class _NoDataFoundWidgetState extends State<NoDataFoundWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SvgPicture.asset(
        "assets/ic_no_data_found.svg",
        // color: iconColor,
        fit: BoxFit.cover,
        height: 100,
        width: 100,
      ),
    );
  }
}
