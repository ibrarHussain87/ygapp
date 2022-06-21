import 'package:flutter/material.dart';

class NotificationsModel {
  String? id;
  String? title;
  String? subTitle;
  String? image;
  String? date;
  int? count;

  NotificationsModel({
    @required this.id,
    @required this.title,
    @required this.subTitle,
    @required this.image,
    @required this.date,
    @required this.count,
  });
}