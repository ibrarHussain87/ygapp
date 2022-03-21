import 'package:floor/floor.dart';
import 'package:yg_app/model/response/common_response_models/certification_response.dart';
import 'package:yg_app/model/response/common_response_models/unit_of_count.dart';

import '../../model/response/sync/sync_response.dart';

@dao
abstract class StocklotCategoriesDao{
  @Query('SELECT * FROM stocklot_categories_table')
  Future<List<StocklotCategories>> findAllStocklotCategories();

  @Query('SELECT * FROM stocklot_categories_table where id = :id')
  Future<StocklotCategories?> findStocklotCategoriesWithId(int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertStocklotCategories(StocklotCategories stocklotCategories);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<List<int>> insertAllStocklotCategories(List<StocklotCategories> stocklotCategories);

  @Query("delete from stocklot_categories_table where id = :id")
  Future<void> deleteStocklotCategories(int id);

  @Query("delete from stocklot_categories_table")
  Future<void> deleteAll();
}