import 'package:floor/floor.dart';
import 'package:yg_app/model/response/common_response_models/certification_response.dart';
import 'package:yg_app/model/response/common_response_models/unit_of_count.dart';
import 'package:yg_app/model/response/yarn_response/sync/yarn_sync_response.dart';

@dao
abstract class OrientationDao{
  @Query('SELECT * FROM orientation_table')
  Future<List<OrientationTable>> findAllOrientation();

  @Query('SELECT * FROM orientation_table where yoId = :id')
  Future<OrientationTable?> findYarnOrientationWithId(int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertOrientation(OrientationTable orientation);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<List<int>> insertAllOrientation(List<OrientationTable> orientation);

  @Query("delete from orientation_table where yoId = :id")
  Future<void> deleteOrientation(int id);

  @Query("delete from orientation_table")
  Future<void> deleteAll();
}