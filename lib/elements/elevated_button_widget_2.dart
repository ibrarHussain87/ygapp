import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ElevatedButtonWithoutIcon extends StatefulWidget {
  final Function callback;
  final Color? color;
  final String? btnText;
  final String? textColor;
  final double? textSize;

  const ElevatedButtonWithoutIcon(
      {Key? key,
      required this.callback,
      required this.color,
      required this.btnText,
      this.textColor,
      this.textSize,
      })
      : super(key: key);

  @override
  _ElevatedButtonWithoutIconState createState() =>
      _ElevatedButtonWithoutIconState();
}

class _ElevatedButtonWithoutIconState extends State<ElevatedButtonWithoutIcon> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
        child: Center(
            child: Text(widget.btnText!,
                style: TextStyle(
                    fontSize: widget.textSize ?? 12.sp,
                    height: 1.1,
                    color: widget.textColor == null
                        ? Colors.white
                        : Colors.black))),
        style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            backgroundColor: MaterialStateProperty.all<Color>(widget.color!),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    side: BorderSide(color: Colors.transparent)))),
        onPressed: () {
          widget.callback();
        });
  }
}
