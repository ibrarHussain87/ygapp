import 'package:floor/floor.dart';

@Entity(tableName: 'lc_type')
class LcTypeModel {
  LcTypeModel({
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
  late final String lcName;
  late final String lcIsActive;
  @ignore
  late final Null lcSortid;
  @ignore
  late final Null createdAt;
  @ignore
  late final Null updatedAt;
  @ignore
  late final Null deletedAt;

  LcTypeModel.fromJson(Map<String, dynamic> json){
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
    return lcName;
  }
}