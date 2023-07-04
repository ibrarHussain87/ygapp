import 'package:floor/floor.dart';

/// grd_id : 1
/// family_id : "4"
/// blend_id : "0"
/// grd_name : "AA"
/// grd_is_active : "1"
/// grd_sortid : null

@Entity(tableName: 'yarn_grades')
class YarnGrades {
  YarnGrades({
    required this.grdId,
    required this.familyId,
    required this.blendId,
    required this.grdName,
    required this.grdIsActive,
    required this.grdSortid,
  });
  @PrimaryKey(autoGenerate: false)
  int? grdId;
  String? familyId;
  String? blendId;
  String? grdCategoryIdfk;
  String? grdName;
  String? grdIsActive;
  String? grdSortid;

  YarnGrades.fromJson(Map<String, dynamic> json){
    grdId = json['grd_id'];
    familyId = json['family_id'];
    blendId = json['blend_id'];
    grdName = json['grd_name'];
    grdIsActive = json['grd_is_active'];
    grdSortid = json['grd_sortid'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['grd_id'] = grdId;
    _data['family_id'] = familyId;
    _data['grd_name'] = grdName;
    _data['grd_is_active'] = grdIsActive;
    _data['grd_sortid'] = grdSortid;
    return _data;
  }

  @override
  String toString() {
    return grdName??"";
  }
}
