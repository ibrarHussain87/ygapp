import 'package:floor/floor.dart';
import 'package:yg_app/model/response/common_response_models/currency_rates_response.dart';

@dao
abstract class CurrencyRatesDao{
  @Query('SELECT * FROM currency_rates')
  Future<List<CurrencyRates>> findAllCurrencyRates();

  @Query('SELECT * FROM currency_rates where exrateId = :id')
  Future<CurrencyRates?> findCurrencyRateWithId(int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertCurrencyRate(CurrencyRates brands);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<List<int>> insertAllCurrencyRates(List<CurrencyRates> currencyRates);

  @Query("delete from currency_rates where exrateId = :id")
  Future<void> deleteCurrencyRate(int id);

  @Query("delete from currency_rates")
  Future<void> deleteAll();
}