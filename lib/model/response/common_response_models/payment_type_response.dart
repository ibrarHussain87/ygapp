import 'package:floor/floor.dart';

@Entity(tableName: 'payment_type')
class PaymentType {
  PaymentType({
    required this.payId,
    required this.payName,
    required this.payIsActive,
    this.paySortid,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });
  @PrimaryKey(autoGenerate: false)
  late final String payId;
  late final String payName;
  late final String payIsActive;
  @ignore
  late final Null paySortid;
  @ignore
  late final Null createdAt;
  @ignore
  late final Null updatedAt;
  @ignore
  late final Null deletedAt;

  PaymentType.fromJson(Map<String, dynamic> json){
    payId = json['pay_id'];
    payName = json['pay_name'];
    payIsActive = json['pay_is_active'];
    paySortid = null;
    createdAt = null;
    updatedAt = null;
    deletedAt = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['pay_id'] = payId;
    _data['pay_name'] = payName;
    _data['pay_is_active'] = payIsActive;
    _data['pay_sortid'] = paySortid;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['deleted_at'] = deletedAt;
    return _data;
  }

  @override
  String toString() {
    // TODO: implement toString
    return payName;
  }
}