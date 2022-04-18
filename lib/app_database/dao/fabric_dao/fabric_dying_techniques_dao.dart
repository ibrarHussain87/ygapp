import 'package:floor/floor.dart';
import 'package:yg_app/model/response/fabric_response/sync/fabric_sync_response.dart';

@dao
abstract class FabricDyingTechniqueDao {
  @Query('SELECT * FROM fabric_dying_techniques')
  Future<List<FabricDyingTechniques>> findAllFabricDyingTechniques();

  @Query('SELECT * FROM fabric_dying_techniques where fdtId = :id')
  Future<List<FabricDyingTechniques>> findFabricDyingTechnique(int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertFabricDyingTechnique(FabricDyingTechniques fabricFabricDyingTechnique);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<List<int>> insertAllFabricDyingTechnique(List<FabricDyingTechniques> fabricFabricDyingTechnique);

  @Query("delete from fabric_dying_techniques where fdtId = :id")
  Future<void> deleteFabricDyingTechnique(int id);

  @Query("delete from fabric_dying_techniques")
  Future<void> deleteFabricDyingTechniques();

}