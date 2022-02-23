import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yg_app/helper_utils/util.dart';
import 'package:yg_app/pages/detail_pages/detail_page/detail_tab.dart';

Widget listDetailItemWidget(
    BuildContext context, GridTileModel detailSpecification) {
  double width = MediaQuery.of(context).size.width;
  return Container(
    width: width,
    child: Row(
      children: [
        Expanded(
          child: Text(
            detailSpecification.title,
            style: TextStyle(
                color: Colors.black,
                fontSize: 12.sp,
                fontWeight: FontWeight.w600),
          ),
          flex: 6,
        ),
        Expanded(
          child: Text(
            detailSpecification.detail,
            style: TextStyle(
                color: Colors.black,
                fontSize: 12.sp,
                fontWeight: FontWeight.w400),
          ),
          flex: 4,
        ),
      ],
    ),
  );
}

Widget listItemContactCard(BuildContext context,
    GridTileModel detailSpecification, bool showCallIcon) {
  double width = MediaQuery.of(context).size.width;
  return Container(
    width: width,
    child: Row(
      children: [
        Expanded(
          child: Text(
            detailSpecification.title,
            style: TextStyle(
                color: Colors.black,
                fontSize: 12.sp,
                fontWeight: FontWeight.w600),
          ),
          flex: 5,
        ),
        Expanded(
          child: Row(
            children: [
              Text(
                detailSpecification.detail,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                width: 10,
              ),
              Visibility(
                  visible: showCallIcon,
                  child: GestureDetector(
                    onTap: (){
                      _launchCaller(detailSpecification.detail);
                    },
                    child: const Icon(
                      Icons.call,
                      size: 12,
                    ),
                  ))
            ],
          ),
          flex: 5,
        ),
      ],
    ),
  );
}

_launchCaller(String phone) async {
  String url = "tel:$phone";
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
