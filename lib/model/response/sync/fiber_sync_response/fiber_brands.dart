import 'package:floor/floor.dart';

@Entity(tableName: 'fiber_brand')
class FiberBrands {
  FiberBrands({
    required this.brdId,
    this.brdCategoryIdfk,
    required this.brdName,
    required this.brdIsActive,
    this.brdSortid,
  });
  @PrimaryKey(autoGenerate: false)
  late final int brdId;
  @ignore
  late final Null brdCategoryIdfk;
  late final String brdName;
  late final String brdIsActive;
  @ignore
  late final Null brdSortid;

  FiberBrands.fromJson(Map<String, dynamic> json){
    brdId = json['brd_id'];
    brdCategoryIdfk = null;
    brdName = json['brd_name'];
    brdIsActive = json['brd_is_active'];
    brdSortid = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['brd_id'] = brdId;
    _data['brd_category_idfk'] = brdCategoryIdfk;
    _data['brd_name'] = brdName;
    _data['brd_is_active'] = brdIsActive;
    _data['brd_sortid'] = brdSortid;
    return _data;
  }

  @override
  String toString() {
    // TODO: implement toString
    return brdName;
  }
}
