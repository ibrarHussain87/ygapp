import 'package:floor/floor.dart';

@Entity(tableName: 'fiber_certification')
class FiberCertification {
  FiberCertification({
    required this.cerId,
    required this.cerCategoryIdfk,
    required this.cerName,
    required this.cerIsActive,
    this.cerSortid,
  });
  @PrimaryKey(autoGenerate: false)
  late final int cerId;
  late final String cerCategoryIdfk;
  late final String cerName;
  late final String cerIsActive;
  @ignore
  late final Null cerSortid;

  FiberCertification.fromJson(Map<String, dynamic> json){
    cerId = json['cer_id'];
    cerCategoryIdfk = json['cer_category_idfk'];
    cerName = json['cer_name'];
    cerIsActive = json['cer_is_active'];
    cerSortid = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['cer_id'] = cerId;
    _data['cer_category_idfk'] = cerCategoryIdfk;
    _data['cer_name'] = cerName;
    _data['cer_is_active'] = cerIsActive;
    _data['cer_sortid'] = cerSortid;
    return _data;
  }

  @override
  String toString() {
    // TODO: implement toString
    return cerName;
  }
}