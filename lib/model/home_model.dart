import 'package:flutter/material.dart';

class HomeModel {
  String? id;
  String? title;
  String? subTitle;
  String? image;
  bool? isDisable;

  HomeModel({
    @required this.id,
    @required this.title,
    @required this.subTitle,
    @required this.image,
    @required this.isDisable
  });
}