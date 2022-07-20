import 'package:floor/floor.dart';
import 'package:yg_app/model/response/common_response_models/commodity_rates_response.dart';

@dao
abstract class CommodityRatesDao{
  @Query('SELECT * FROM commodity_rates')
  Future<List<CommodityRates>> findAllCommodityRates();

  @Query('SELECT * FROM commodity_rates where cmdrateId = :id')
  Future<CommodityRates?> findCommodityRateWithId(int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertCommodityRate(CommodityRates brands);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<List<int>> insertAllCommodityRates(List<CommodityRates> brands);

  @Query("delete from commodity_rates where cmdrateId = :id")
  Future<void> deleteBrand(int id);

  @Query("delete from commodity_rates")
  Future<void> deleteAll();
}