import 'package:floor/floor.dart';
import 'package:yg_app/model/response/yarn_response/sync/yarn_sync_response.dart';

@dao
abstract class DoublingMethodDao{
  @Query('SELECT * FROM doubling_method')
  Future<List<DoublingMethod>> findAllDoublingMethod();

  @Query('SELECT * FROM doubling_method where plyId = :id')
  Future<List<DoublingMethod>> findYarnDoublingMethodWithPlyId(int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertDoublingMethod(DoublingMethod colorTm);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<List<int>> insertAllDoublingMethod(List<DoublingMethod> colorTm);

  @Query("delete from doubling_method where yctmId = :id")
  Future<void> deleteDoublingMethod(int id);

  @Query("delete from doubling_method")
  Future<void> deleteAll();
}