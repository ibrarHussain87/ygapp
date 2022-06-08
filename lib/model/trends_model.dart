import 'package:flutter/material.dart';

class TrendsModel {
  String? id;
  String? title;
  String? subTitle;
  String? percent;
  bool? isDrop;

  TrendsModel({
    @required this.id,
    @required this.title,
    @required this.subTitle,
    @required this.percent,
    @required this.isDrop
  });
}