import 'package:floor/floor.dart';
import 'package:yg_app/model/response/fabric_response/sync/fabric_sync_response.dart';

@dao
abstract class FabricQualityDao {
  @Query('SELECT * FROM fabric_quality')
  Future<List<FabricQuality>> findAllFabricQuality();

  @Query('SELECT * FROM fabric_quality where fabricQualityId = :id')
  Future<List<FabricQuality>> findFabricQuality(int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertFabricQuality(FabricQuality fabricFabricQuality);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<List<int>> insertAllFabricQuality(List<FabricQuality> fabricFabricQuality);

  @Query("delete from fabric_quality where fabricQualityId = :id")
  Future<void> deleteFabricQuality(int id);

  @Query("delete from fabric_quality")
  Future<void> deleteFabricQualities();

}