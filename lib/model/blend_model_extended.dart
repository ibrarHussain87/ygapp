import 'package:flutter/material.dart';

import 'blend_model.dart';

class BlendModelExtended extends BlendModel {

  String? default_bln_id;
  String? bln_name;

  BlendModelExtended({
    @required this.default_bln_id,
    @required this.bln_name,
  });

  Map<String,String> toJson(){
    Map<String, String> map = {
      'default_bln_id':default_bln_id!,
      'bln_name':bln_name!,
    };
    return map;
  }
}