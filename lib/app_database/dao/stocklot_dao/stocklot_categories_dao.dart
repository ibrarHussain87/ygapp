import 'package:floor/floor.dart';
import 'package:yg_app/model/response/stocklot_repose/stocklot_sync/stocklot_sync_response.dart';


@dao
abstract class StocklotFamilyDao{
  @Query('SELECT * FROM stocklots_family')
  Future<List<StockLotFamily>> findAllStocklotCategories();

  @Query('SELECT * FROM stocklots_family where stocklotFamilyParentId IS NULL')
  Future<List<StockLotFamily>> findParentStocklot();

  @Query('SELECT * FROM stocklots_family where stocklotFamilyParentId = :id')
  Future<StockLotFamily?> findStocklotCategoriesWithId(int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertStocklotCategories(StockLotFamily stocklotCategories);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<List<int>> insertAllStocklotCategories(List<StockLotFamily> stocklotCategories);

  @Query("delete from stocklots_family where stocklotFamilyParentId = :id")
  Future<void> deleteStocklotCategories(int id);

  @Query("delete from stocklots_family")
  Future<void> deleteAll();
}