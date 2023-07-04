
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ElevatedButtonWithIcon extends StatefulWidget {
  final Function? callback;
  final Color? color;
  final String? btnText;
  final IconData? icons;

  const ElevatedButtonWithIcon(
      {Key? key,
      required this.callback,
      required this.color,
      required this.btnText,
      this.icons})
      : super(key: key);

  @override
  _ElevatedButtonWithIconState createState() => _ElevatedButtonWithIconState();
}

class _ElevatedButtonWithIconState extends State<ElevatedButtonWithIcon> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Align(
                alignment: Alignment.center,
                child: Text(widget.btnText!.toUpperCase(),
                    style: TextStyle(fontSize: 14.sp))),
            Align(
              alignment: Alignment.centerRight,
              child: Icon(
                widget.icons ?? Icons.navigate_next,
                color: Colors.white,
                size: 24,
              ),
            ),
          ],
        ),
        style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            backgroundColor: MaterialStateProperty.all<Color>(widget.color!),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    side: BorderSide(color: Colors.transparent)))),
        onPressed: () {
          widget.callback!();
        });
  }
}
