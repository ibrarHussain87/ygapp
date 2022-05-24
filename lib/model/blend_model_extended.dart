import 'package:flutter/material.dart';

import 'blend_model.dart';

class BlendModelExtended{

  String? default_bln_id;
  String? bln_name;
  String? bln_id;
  String? related_bln_id;
  String? percentage;

  BlendModelExtended({
    @required this.default_bln_id,
    @required this.bln_name,
    @required this.bln_id,
    @required this.related_bln_id,
    @required this.percentage,
  });

  @override
  Map<String,dynamic> toJson(){
    Map<String, dynamic> map = {
      'bln_id':bln_id.toString(),
      'related_bln_id':related_bln_id!,
      'percentage':percentage ,
      'default_bln_id':default_bln_id!,
      'bln_name':bln_name!,
    };
    return map;
  }

  BlendModelExtended.fromJson(Map<String, dynamic> json) {
    default_bln_id = json['default_bln_id'];
    bln_id = json['bln_id'];
    percentage = json['percentage'];
    related_bln_id = json['related_bln_id'];
    bln_name = json['bln_name'];

  }
}