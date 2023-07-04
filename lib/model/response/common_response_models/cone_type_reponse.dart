import 'package:floor/floor.dart';

@Entity(tableName: "cone_type")
class ConeType {
  @PrimaryKey(autoGenerate: false)
  int? yctId;
  String? familyId;
  String? ctCategoryIdfk;
  String? yctName;
  String? yctDescription;
  String? yctIsActive;
  String? yctSortid;

  ConeType(
      {this.yctId,
        this.familyId,
        this.yctName,
        this.yctDescription,
        this.yctIsActive,
        this.yctSortid});

  ConeType.fromJson(Map<String, dynamic> json) {
    yctId = json['ct_id'];
    ctCategoryIdfk = json['ct_category_idfk'];
    familyId = json['ct_family_idfk'];
    yctName = json['ct_name'];
    yctDescription = json['ct_description'];
    yctIsActive = json['ct_is_active'];
    yctSortid = json['ct_sortid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['yct_id'] = yctId;
    data['family_id'] = familyId;
    data['ct_category_idfk'] = ctCategoryIdfk;
    data['yct_name'] = yctName;
    data['yct_description'] = yctDescription;
    data['yct_is_active'] = yctIsActive;
    data['yct_sortid'] = yctSortid;
    return data;
  }

  @override
  String toString() {
    // TODO: implement toString
    return yctName?? "";
  }
}