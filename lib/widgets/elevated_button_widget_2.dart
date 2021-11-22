import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/utils/colors.dart';

class ElevatedButtonWithoutIcon extends StatefulWidget {

  Function? callback;
  Color? color;
  String? btnText;

  ElevatedButtonWithoutIcon({Key? key,required this.callback,required this.color,required this.btnText}) : super(key: key);

  @override
  _ElevatedButtonWithoutIconState createState() => _ElevatedButtonWithoutIconState();
}

class _ElevatedButtonWithoutIconState extends State<ElevatedButtonWithoutIcon> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        child: Expanded(child: Center(child: Text(widget.btnText!, style: TextStyle(fontSize: 14.sp))),flex: 9,),
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
