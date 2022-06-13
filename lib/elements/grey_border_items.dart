

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

BoxDecoration myBoxDecoration({double? radius, Color? color,double? width}) {
  return BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(radius??0),
    border: Border.all(
      color: color??Colors.grey, //                   <--- border color
      width:width?? 5.0,
    ),
  );
}