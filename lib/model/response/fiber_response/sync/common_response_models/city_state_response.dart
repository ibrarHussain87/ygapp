
import 'package:floor/floor.dart';

@Entity(tableName: 'city_state')
class CityState {
  CityState({
    required this.id,
    required this.countryId,
    required this.name,
    required this.code,
  });
  @primaryKey
  late final int id;
  late final String countryId;
  late final String name;
  late final String code;

  CityState.fromJson(Map<String, dynamic> json){
    id = json['id'];
    countryId = json['country_id'];
    name = json['name'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['country_id'] = countryId;
    _data['name'] = name;
    _data['code'] = code;
    return _data;
  }

  @override
  String toString() {
    // TODO: implement toString
    return name;
  }
}
