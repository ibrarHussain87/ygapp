import 'package:floor/floor.dart';
import 'package:yg_app/model/response/fabric_response/sync/fabric_sync_response.dart';

@dao
abstract class FabricSettingDao {
  @Query('SELECT * FROM fabric_settings')
  Future<List<FabricSetting>> findAllFabricSettings();

  /*@Query('SELECT * FROM fabric_settings where ysBlendIdfk = :id and fabric_family_idfk = :materialId')
  Future<List<FabricSetting>> findFamilyAndBlendFabricSettings(int id,int materialId);*/

  @Query('SELECT * FROM fabric_settings where fabric_setting_id = :id')
  Future<List<FabricSetting>> findFamilyFabricSettings(int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertFabricSetting(FabricSetting fabricSettings);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<List<int>> insertAllFabricSettings(List<FabricSetting> fiberSettings);

  @Query("delete from fabric_settings where fabric_setting_id = :id")
  Future<void> deleteFabricSetting(int id);

  @Query("delete from fabric_settings")
  Future<void> deleteFabricSettings();

}