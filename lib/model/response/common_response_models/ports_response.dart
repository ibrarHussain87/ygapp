import 'package:floor/floor.dart';

@Entity(tableName: 'ports')
class Ports {
  Ports({
    required this.prtId,
    required this.prtCountryIdfk,
    required this.prtName,
    required this.prtIsActive,
    this.prtSortid,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });
  @PrimaryKey(autoGenerate: false)
  late final int prtId;
  String? prtCountryIdfk;
  String? prtName;
  String? prtIsActive;
  @ignore
  Null prtSortid;
  @ignore
  Null createdAt;
  @ignore
  Null updatedAt;
  @ignore
  Null deletedAt;

  Ports.fromJson(Map<String, dynamic> json){
    prtId = json['prt_id'];
    prtCountryIdfk = json['prt_country_idfk'];
    prtName = json['prt_name'];
    prtIsActive = json['prt_is_active'];
    prtSortid = null;
    createdAt = null;
    updatedAt = null;
    deletedAt = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['prt_id'] = prtId;
    _data['prt_country_idfk'] = prtCountryIdfk;
    _data['prt_name'] = prtName;
    _data['prt_is_active'] = prtIsActive;
    _data['prt_sortid'] = prtSortid;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['deleted_at'] = deletedAt;
    return _data;
  }

  @override
  String toString() {
    // TODO: implement toString
    return prtName??"";
  }
}