import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:yg_app/elements/title_text_widget.dart';

class YGServices extends StatefulWidget {
  const YGServices({Key? key}) : super(key: key);

  @override
  _YGServicesState createState() => _YGServicesState();
}

class _YGServicesState extends State<YGServices> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 84.w,
              padding: const EdgeInsets.symmetric(horizontal: 24,vertical: 24),
                color: Colors.green,
                child: const SpinKitPouringHourGlass(
                  color: Colors.white,
                )),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: TitleExtraSmallTextWidget(title: "Coming Soon.."),
            ),
          ],
        ),
      ),
    );
  }
}
