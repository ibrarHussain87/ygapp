import 'package:floor/floor.dart';

@Entity(tableName: 'delivery_period')
class DeliveryPeriod {
  DeliveryPeriod({
    required this.dprId,
    required this.dprCategoryIdfk,
    required this.dprName,
    required this.dprIsActive,
    this.dprSortid,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });
  @PrimaryKey(autoGenerate: false)
  late final int dprId;
  late final String dprCategoryIdfk;
  late final String dprName;
  late final String dprIsActive;
  @ignore
  late final Null dprSortid;
  @ignore
  late final Null createdAt;
  @ignore
  late final Null updatedAt;
  @ignore
  late final Null deletedAt;

  DeliveryPeriod.fromJson(Map<String, dynamic> json){
    dprId = json['dpr_id'];
    dprCategoryIdfk = json['dpr_category_idfk'];
    dprName = json['dpr_name'];
    dprIsActive = json['dpr_is_active'];
    dprSortid = null;
    createdAt = null;
    updatedAt = null;
    deletedAt = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['dpr_id'] = dprId;
    _data['dpr_category_idfk'] = dprCategoryIdfk;
    _data['dpr_name'] = dprName;
    _data['dpr_is_active'] = dprIsActive;
    _data['dpr_sortid'] = dprSortid;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['deleted_at'] = deletedAt;
    return _data;
  }

  @override
  String toString() {
    // TODO: implement toString
    return dprName;
  }
}