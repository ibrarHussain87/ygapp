import 'package:floor/floor.dart';

@Entity(tableName: 'packing')
class Packing {
  Packing({
    required this.pacId,
    required this.pacName,
    required this.pacIsActive,
    this.pacSortid,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });
  @PrimaryKey(autoGenerate: false)
  late final int pacId;
  String? pacName;
  String? pacIsActive;
  @ignore
  Null pacSortid;
  @ignore
  Null createdAt;
  @ignore
  Null updatedAt;
  @ignore
  Null deletedAt;

  Packing.fromJson(Map<String, dynamic> json){
    pacId = json['pac_id'];
    pacName = json['pac_name'];
    pacIsActive = json['pac_is_active'];
    pacSortid = null;
    createdAt = null;
    updatedAt = null;
    deletedAt = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['pac_id'] = pacId;
    _data['pac_name'] = pacName;
    _data['pac_is_active'] = pacIsActive;
    _data['pac_sortid'] = pacSortid;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['deleted_at'] = deletedAt;
    return _data;
  }

  @override
  String toString() {
    // TODO: implement toString
    return pacName??"";
  }
}