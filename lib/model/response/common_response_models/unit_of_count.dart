import 'package:floor/floor.dart';

@Entity(tableName: 'units_table')
class Units {
  Units({
    required this.untId,
    required this.untCategoryIdfk,
    required this.unt_family_idfk,
    required this.untName,
    required this.untIsActive,
    this.untSortid,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });
  @PrimaryKey(autoGenerate: false)
  late final int untId;
  String? untCategoryIdfk;
  String? unt_family_idfk;
  String? untName;
  String? untIsActive;
  @ignore
  Null untSortid;
  @ignore
  Null createdAt;
  @ignore
  Null updatedAt;
  @ignore
  Null deletedAt;

  Units.fromJson(Map<String, dynamic> json){
    untId = json['unt_id'];
    untCategoryIdfk = json['unt_category_idfk'];
    unt_family_idfk = json['unt_family_idfk'];
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
    _data['unt_family_idfk'] = unt_family_idfk;
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