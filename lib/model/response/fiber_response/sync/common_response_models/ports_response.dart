import 'package:floor/floor.dart';

@Entity(tableName: 'ports')
class PortsModel {
  PortsModel({
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
  late final String prtCountryIdfk;
  late final String prtName;
  late final String prtIsActive;
  @ignore
  late final Null prtSortid;
  @ignore
  late final Null createdAt;
  @ignore
  late final Null updatedAt;
  @ignore
  late final Null deletedAt;

  PortsModel.fromJson(Map<String, dynamic> json){
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
    return prtName;
  }
}