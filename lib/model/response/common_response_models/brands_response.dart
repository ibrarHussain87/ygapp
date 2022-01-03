import 'package:floor/floor.dart';

@Entity(tableName: 'brands')
class Brands {
  Brands({
    required this.brdId,
    this.brdCategoryIdfk,
    required this.brdName,
    required this.brdIsActive,
    this.brdSortid,
  });
  @PrimaryKey(autoGenerate: false)
  late final int brdId;
  @ignore
  Null brdCategoryIdfk;
  String? brdName;
  String? brdIsVerified;
  String? brdFeatured;
  String? brdIcon;
  String? brdIsActive;
  @ignore
  late final Null brdSortid;

  Brands.fromJson(Map<String, dynamic> json){
    brdId = json['brd_id'];
    brdCategoryIdfk = null;
    brdName = json['brd_name'];
    brdIsVerified = json['brd_is_verified'];
    brdFeatured = json['brd_featured'];
    brdIcon = json['icon'];
    brdIsActive = json['brd_is_active'];
    brdSortid = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['brd_id'] = brdId;
    _data['brd_category_idfk'] = brdCategoryIdfk;
    _data['brd_name'] = brdName;
    _data['brd_is_verified'] = brdIsVerified;
    _data['brd_featured'] = brdFeatured;
    _data['icon'] = brdIcon;
    _data['brd_is_active'] = brdIsActive;
    _data['brd_sortid'] = brdSortid;
    return _data;
  }

  @override
  String toString() {
    // TODO: implement toString
    return brdName??"";
  }
}
