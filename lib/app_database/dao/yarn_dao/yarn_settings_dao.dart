import 'package:floor/floor.dart';
import 'package:yg_app/model/response/yarn_response/sync/yarn_sync_response.dart';

@dao
abstract class YarnSettingDao {
  @Query('SELECT * FROM yarn_settings')
  Future<List<YarnSetting>> findAllYarnSettings();

  @Query('SELECT * FROM yarn_settings where ysBlendIdfk = :id and ysFiberMaterialIdfk = :materialId')
  Future<List<YarnSetting>> findFamilyAndBlendYarnSettings(int id,int materialId);

  @Query('SELECT * FROM yarn_settings where ysFiberMaterialIdfk = :id')
  Future<List<YarnSetting>> findFamilyYarnSettings(int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertYarnSetting(YarnSetting yarnSettings);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<List<int>> insertAllYarnSettings(List<YarnSetting> fiberSettings);

  @Query("delete from yarn_settings where id = :id")
  Future<void> deleteYarnSetting(int id);

  @Query("delete from yarn_settings")
  Future<void> deleteYarnSettings();

}