import 'package:flutter/material.dart';

class BlendModel {
  int? id;
  String? relatedBlnId;
  String? ratio;

  BlendModel({
    @required this.id,
    @required this.relatedBlnId,
    @required this.ratio,
  });

  Map<String,String> toJson(){
    Map<String, String> map = {
      'bln_id':id.toString(),
      'related_bln_id':relatedBlnId!,
      'percentage':ratio!,
    };
    return map;
  }
}