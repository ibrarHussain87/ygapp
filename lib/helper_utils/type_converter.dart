import 'dart:convert';

import 'package:floor/floor.dart';
import 'package:yg_app/model/response/login/login_response.dart';

class JsonConverter extends TypeConverter<BusinessInfo,String >  {
  @override
  BusinessInfo decode(String  databaseValue) {
    return BusinessInfo.fromJson(json.decode(databaseValue) as Map<String,dynamic>);
  }

  @override
  String encode(BusinessInfo value) {
    return json.encode(value.toJson());
  }
}