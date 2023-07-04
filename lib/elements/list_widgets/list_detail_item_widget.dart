import 'package:flutter/material.dart';
import 'package:flutter_launch/flutter_launch.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yg_app/elements/bottom_sheets/phone_bottom_sheet.dart';
import 'package:yg_app/model/detail_tile_model.dart';
import 'package:yg_app/model/enum_phone.dart';

Widget listDetailItemWidget(
    BuildContext context, DetailTileModel detailSpecification) {
  double width = MediaQuery.of(context).size.width;
  return SizedBox(
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
    DetailTileModel detailSpecification, bool showCallIcon) {
  double width = MediaQuery.of(context).size.width;
  return SizedBox(
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
              Flexible(
                child: Text(
                  detailSpecification.detail,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Visibility(
                  visible: showCallIcon,
                  child: GestureDetector(
                    onTap: (){
                     // _launchCaller(detailSpecification.detail);
                      showPhoneBottomSheet(detailSpecification.detail,context);
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

void showPhoneBottomSheet(String phone, BuildContext context) {
  showBottomSheetPhone(context, (value) {
    Logger().e(value);
    if(CallEnum.Phone == value){
      _launchCaller(phone);
    }else{
      whatsAppOpen(phone);
    }
  });
}

void whatsAppOpen(String phone) async {
  await FlutterLaunch.launchWhatsapp(phone: phone, message: "");
}

_launchCaller(String phone) async {
  String url = "tel:$phone";
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
