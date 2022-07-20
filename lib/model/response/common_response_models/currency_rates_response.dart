import 'package:floor/floor.dart';

@Entity(tableName: 'currency_rates')
class CurrencyRates {
  @PrimaryKey(autoGenerate: false)
  late final int exrateId;
  String? exrateAmount;
  String? exrateFrom;
  String? exrateTo;
  String? exrateRate;
  String? exrateDate;

  CurrencyRates({
    required this.exrateId,
    required this.exrateAmount,
    required this.exrateFrom,
    required this.exrateTo,
    required this.exrateRate,
    required this.exrateDate,
  });



  CurrencyRates.fromJson(Map<String, dynamic> json) {
    exrateId = json['exrate_id'];
    exrateAmount = json['exrate_amount'];
    exrateFrom = json['exrate_from'];
    exrateTo = json['exrate_to'];
    exrateRate = json['exrate_rate'];
    exrateDate = json['exrate_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['exrate_id'] = exrateId;
    data['exrate_amount'] = exrateAmount;
    data['exrate_from'] = exrateFrom;
    data['exrate_to'] = exrateTo;
    data['exrate_rate'] = exrateRate;
    data['exrate_date'] = exrateDate;
    return data;
  }
}
