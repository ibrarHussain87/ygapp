import 'package:floor/floor.dart';
import 'package:yg_app/model/response/yarn_response/sync/yarn_sync_response.dart';

@dao
abstract class YarnTypesDao{
  @Query('SELECT * FROM yarn_types_table')
  Future<List<YarnTypes>> findAllYarnTypes();

  @Query('SELECT * FROM yarn_types_table where ytId = :id')
  Future<YarnTypes?> findYarnYarnTypesWithId(int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertYarnTypes(YarnTypes colorTm);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<List<int>> insertAllYarnTypes(List<YarnTypes> colorTm);

  @Query("delete from yarn_types_table where ytId = :id")
  Future<void> deleteYarnTypes(int id);

  @Query("delete from yarn_types_table")
  Future<void> deleteAll();
}