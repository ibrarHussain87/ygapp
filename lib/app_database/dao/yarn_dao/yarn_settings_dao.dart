import 'package:floor/floor.dart';
import 'package:yg_app/model/response/yarn_response/sync/yarn_sync_response.dart';

@dao
abstract class YarnSettingDao {
  @Query('SELECT * FROM yarn_settings')
  Future<List<YarnSetting>> findAllYarnSettings();

  @Query('SELECT * FROM yarn_settings where ysBlendIdfk = :id')
  Future<List<YarnSetting>> findYarnSettings(int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertYarnSetting(YarnSetting yarnSettings);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<List<int>> insertAllYarnSettings(List<YarnSetting> fiberSettings);

  @Query("delete from yarn_settings where id = :id")
  Future<void> deleteYarnSetting(int id);

  @delete
  Future<int> deleteAll(List<YarnSetting> list);
}