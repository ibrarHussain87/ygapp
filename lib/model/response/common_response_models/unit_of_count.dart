import 'package:floor/floor.dart';

@Entity(tableName: 'units_table')
class Units {
  Units({
    required this.untId,
    required this.untCategoryIdfk,
    required this.untName,
    required this.untIsActive,
    this.untSortid,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });
  @PrimaryKey(autoGenerate: false)
  late final int untId;
  late final String? untCategoryIdfk;
  late final String? untName;
  late final String? untIsActive;
  @ignore
  late final Null untSortid;
  @ignore
  late final Null createdAt;
  @ignore
  late final Null updatedAt;
  @ignore
  late final Null deletedAt;

  Units.fromJson(Map<String, dynamic> json){
    untId = json['unt_id'];
    untCategoryIdfk = json['unt_category_idfk'];
    untName = json['unt_name'];
    untIsActive = json['unt_is_active'];
    untSortid = null;
    createdAt = null;
    updatedAt = null;
    deletedAt = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['unt_id'] = untId;
    _data['unt_category_idfk'] = untCategoryIdfk;
    _data['unt_name'] = untName;
    _data['unt_is_active'] = untIsActive;
    _data['unt_sortid'] = untSortid;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['deleted_at'] = deletedAt;
    return _data;
  }

  @override
  String toString() {
    // TODO: implement toString
    return untName??"";
  }
}