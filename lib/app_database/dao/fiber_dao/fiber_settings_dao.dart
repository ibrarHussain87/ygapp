import 'package:floor/floor.dart';
import 'package:yg_app/model/response/sync/fiber_sync_response/sync_fiber_response.dart';

@dao
abstract class FiberSettingDao {
  @Query('SELECT * FROM fiber_setting')
  Future<List<FiberSettings>> findAllFiberSettings();

  @Insert(onConflict: OnConflictStrategy.replace)  Future<void> insertFiberSetting(FiberSettings fiberSettings);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<List<int>> insertAllFiberSettings(List<FiberSettings> fiberSettings);

  @Query("delete from fiber_setting where id = :id")
  Future<void> deleteFiberSetting(int id);

  @delete
  Future<int> deleteAll(List<FiberSettings> list);
}
