import 'package:flutter/material.dart';

class ServicesModel {
  String? id;
  String? complaintNo;
  String? subType;
  String? type;
  String? status;
  String? date;
  String? time;

  ServicesModel({
    @required this.id,
    @required this.complaintNo,
    @required this.type,
    @required this.subType,
    @required this.status,
    @required this.date,
    @required this.time,
  });
}