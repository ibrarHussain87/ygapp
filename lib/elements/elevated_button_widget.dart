import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/helper_utils/app_colors.dart';

class ElevatedButtonWithIcon extends StatefulWidget {

  final Function? callback;
  final Color? color;
  final String? btnText;

  const ElevatedButtonWithIcon({Key? key,required this.callback,required this.color,required this.btnText}) : super(key: key);

  @override
  _ElevatedButtonWithIconState createState() => _ElevatedButtonWithIconState();
}

class _ElevatedButtonWithIconState extends State<ElevatedButtonWithIcon> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        child: Row(
          children: [
            Expanded(child: Center(child: Text(widget.btnText!.toUpperCase(), style: TextStyle(fontSize: 14.sp))),flex: 9,),
            const Icon(
              Icons.navigate_next,
              color: Colors.white,
            ),
          ],
        ),
        style: ButtonStyle(
            foregroundColor:
            MaterialStateProperty.all<Color>(Colors.white),
            backgroundColor:
            MaterialStateProperty.all<Color>(widget.color!),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    side: BorderSide(color: Colors.transparent)))),
        onPressed: () {
          widget.callback!();
        });
  }
}