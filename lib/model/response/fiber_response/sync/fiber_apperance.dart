import 'package:floor/floor.dart';

@Entity(tableName: 'fiber_appearance')
class FiberAppearance {
  FiberAppearance({
    required this.aprId,
    required this.aprCategoryIdfk,
    required this.aprName,
    required this.aprIsActive,
    this.aprSortid,
  });

  @PrimaryKey(autoGenerate: false)
  int? aprId;
  String? aprCategoryIdfk;
  String? aprName;
  String? aprIsActive;
  @ignore
  Null aprSortid;

  FiberAppearance.fromJson(Map<String, dynamic> json){

    aprId = json['apr_id'];
    aprCategoryIdfk = json['apr_category_idfk'];
    aprName = json['apr_name'];
    aprIsActive = json['apr_is_active'];
    aprSortid = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['apr_id'] = aprId;
    _data['apr_category_idfk'] = aprCategoryIdfk;
    _data['apr_name'] = aprName;
    _data['apr_is_active'] = aprIsActive;
    _data['apr_sortid'] = aprSortid;
    return _data;
  }

  @override
  String toString() {
    return aprName??"";
  }
}