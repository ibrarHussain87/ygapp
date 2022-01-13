import 'package:floor/floor.dart';
import 'package:yg_app/model/response/common_response_models/certification_response.dart';
import 'package:yg_app/model/response/common_response_models/unit_of_count.dart';
import 'package:yg_app/model/response/yarn_response/sync/yarn_sync_response.dart';

@dao
abstract class DyingMethodDao{
  @Query('SELECT * FROM dying_method')
  Future<List<DyingMethod>> findAllDyingMethod();

  @Query('SELECT * FROM dying_method where ydmId = :id')
  Future<DyingMethod?> findYarnDyingMethodWithId(int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertDyingMethod(DyingMethod dyingMethod);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<List<int>> insertAllDyingMethod(List<DyingMethod> dyingMethod);

  @Query("delete from dying_method where ydmId = :id")
  Future<void> deleteDyingMethod(int id);

  @Query("delete * from dying_method")
  Future<void> deleteAll();
}