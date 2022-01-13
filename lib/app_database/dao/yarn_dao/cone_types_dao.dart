import 'package:floor/floor.dart';
import 'package:yg_app/model/response/yarn_response/sync/yarn_sync_response.dart';

@dao
abstract class ConeTypeDao{
  @Query('SELECT * FROM corn_type')
  Future<List<ConeType>> findAllConeType();

  @Query('SELECT * FROM corn_type where yctId = :id')
  Future<ConeType?> findYarnConeTypeWithId(int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertConeType(ConeType colorTm);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<List<int>> insertAllConeType(List<ConeType> colorTm);

  @Query("delete from corn_type where yctId = :id")
  Future<void> deleteConeType(int id);

  @Query("delete * from corn_type")
  Future<void> deleteAll();
}