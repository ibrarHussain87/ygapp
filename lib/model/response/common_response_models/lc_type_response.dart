import 'package:floor/floor.dart';

@Entity(tableName: 'lc_type')
class LcType {
  LcType({
    required this.lcId,
    required this.lcName,
    required this.lcIsActive,
    this.lcSortid,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });
  @PrimaryKey(autoGenerate: false)
  late final int lcId;
  String? lcName;
  String? lcIsActive;
  @ignore
  Null lcSortid;
  @ignore
  Null createdAt;
  @ignore
  Null updatedAt;
  @ignore
  Null deletedAt;

  LcType.fromJson(Map<String, dynamic> json){
    lcId = json['lc_id'];
    lcName = json['lc_name'];
    lcIsActive = json['lc_is_active'];
    lcSortid = null;
    createdAt = null;
    updatedAt = null;
    deletedAt = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['lc_id'] = lcId;
    _data['lc_name'] = lcName;
    _data['lc_is_active'] = lcIsActive;
    _data['lc_sortid'] = lcSortid;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['deleted_at'] = deletedAt;
    return _data;
  }

  @override
  String toString() {
    // TODO: implement toString
    return lcName??"";
  }
}