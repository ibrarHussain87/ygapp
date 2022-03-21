import 'package:floor/floor.dart';
import 'package:yg_app/model/response/common_response_models/certification_response.dart';

import '../../model/response/sync/sync_response.dart';

@dao
abstract class StocklotDao{
  @Query('SELECT * FROM stocklots_table')
  Future<List<Stocklots>> findAllStocklots();

  @Query('SELECT * FROM stocklots_table where id = :id')
  Future<Stocklots?> findStocklotsWithId(int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertStocklots(Stocklots stocklots);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<List<int>> insertAllStocklots(List<Stocklots> stocklots);

  @Query("delete from stocklots_table where id = :id")
  Future<void> deleteStocklots(int id);

  @Query("delete from stocklots_table")
  Future<void> deleteAll();
}