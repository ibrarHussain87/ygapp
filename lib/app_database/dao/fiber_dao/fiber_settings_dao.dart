import 'package:floor/floor.dart';
import 'package:yg_app/model/response/fiber_response/sync/sync_fiber_response.dart';

@dao
abstract class FiberSettingDao {
  @Query('SELECT * FROM fiber_setting')
  Future<List<FiberSettings>> findAllFiberSettings();

  @Query('SELECT * FROM fiber_setting where fbsFiberMaterialIdfk = :id')
  Future<List<FiberSettings>> findFiberSettings(int id);

  @Insert(onConflict: OnConflictStrategy.replace)  Future<void> insertFiberSetting(FiberSettings fiberSettings);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<List<int>> insertAllFiberSettings(List<FiberSettings> fiberSettings);

  @Query("delete from fiber_setting where id = :id")
  Future<void> deleteFiberSetting(int id);

  @Query("delete from fiber_setting")
  Future<void> deleteAll();
}
