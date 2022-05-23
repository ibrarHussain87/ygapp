import 'package:floor/floor.dart';
import 'package:yg_app/model/response/yarn_response/sync/yarn_sync_response.dart';

@dao
abstract class TwistDirectionDao{
  @Query('SELECT * FROM twist_direction')
  Future<List<TwistDirection>> findAllTwistDirection();

  @Query('SELECT * FROM twist_direction where familyId = :id')
  Future<List<TwistDirection>> findYarnTwistDirectionWithFamilyId(int id);

  @Query('SELECT * FROM twist_direction where ytdId = :id')
  Future<TwistDirection?> findYarnTwistDirectionWithId(int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertTwistDirection(TwistDirection colorTm);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<List<int>> insertAllTwistDirection(List<TwistDirection> colorTm);

  @Query("delete from twist_direction where ytdId = :id")
  Future<void> deleteTwistDirection(int id);

  @Query("delete from twist_direction")
  Future<void> deleteAll();
}