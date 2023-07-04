import 'package:floor/floor.dart';

@Entity(tableName: 'commodity_rates')
class CommodityRates {
  @PrimaryKey(autoGenerate: false)
  late final int cmdrateId;
  String? cmdrateName;
  String? cmdrateRate;
  String? cmdrateDate;

  CommodityRates({
    required this.cmdrateId,
    this.cmdrateName,
    required this.cmdrateRate,
    required this.cmdrateDate,
  });


  CommodityRates.fromJson(Map<String, dynamic> json) {
    cmdrateId = json['cmdrate_id'];
    cmdrateName = json['cmdrate_name'];
    cmdrateRate = json['cmdrate_rate'];
    cmdrateDate = json['cmdrate_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cmdrate_id'] = cmdrateId;
    data['cmdrate_name'] = cmdrateName;
    data['cmdrate_rate'] = cmdrateRate;
    data['cmdrate_date'] = cmdrateDate;
    return data;
  }
}