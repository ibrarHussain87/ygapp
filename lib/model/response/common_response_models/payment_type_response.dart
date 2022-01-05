import 'package:floor/floor.dart';

@Entity(tableName: 'payment_type')
class PaymentType {
  PaymentType({
    required this.payId,
    required this.payName,
    required this.payPriceTerrmIdfk,
    required this.payIsActive,
    this.paySortid,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });
  @PrimaryKey(autoGenerate: false)
  late final String? payId;
  String? payPriceTerrmIdfk;
  String? payName;
  String? payIsActive;
  @ignore
  Null paySortid;
  @ignore
  Null createdAt;
  @ignore
  Null updatedAt;
  @ignore
  Null deletedAt;

  PaymentType.fromJson(Map<String, dynamic> json){
    payId = json['pay_id'];
    payPriceTerrmIdfk = json['pay_price_terrm_idfk'];
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
    _data['pay_price_terrm_idfk'] = payPriceTerrmIdfk;
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
    return payName??"";
  }
}