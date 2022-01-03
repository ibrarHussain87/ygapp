import 'package:floor/floor.dart';

@Entity(tableName: 'grade')
class Grades {
  Grades({
    required this.grdId,
    required this.grdCategoryIdfk,
    required this.grdName,
    required this.grdIsActive,
    this.grdSortid,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });
  @PrimaryKey(autoGenerate: false)
  int? grdId;
  String? familyId;
  String? grdCategoryIdfk;
  String? grdName;
  String? grdIsActive;
  @ignore
  late final Null grdSortid;
  @ignore
  late final Null createdAt;
  @ignore
  late final Null updatedAt;
  @ignore
  late final Null deletedAt;

  Grades.fromJson(Map<String, dynamic> json){
    grdId = json['grd_id'];
    familyId = json['family_id'];
    grdCategoryIdfk = json['grd_category_idfk']??"";
    grdName = json['grd_name'];
    grdIsActive = json['grd_is_active'];
    grdSortid = null;
    createdAt = null;
    updatedAt = null;
    deletedAt = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['grd_id'] = grdId;
    _data['family_id'] = familyId;
    _data['grd_category_idfk'] = grdCategoryIdfk;
    _data['grd_name'] = grdName;
    _data['grd_is_active'] = grdIsActive;
    _data['grd_sortid'] = grdSortid;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['deleted_at'] = deletedAt;
    return _data;
  }

  @override
  String toString() {
    return grdName??"";
  }
}