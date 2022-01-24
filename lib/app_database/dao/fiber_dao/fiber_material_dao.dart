import 'package:floor/floor.dart';
import 'package:yg_app/model/response/fiber_response/sync/sync_fiber_response.dart';

@dao
abstract class FiberMaterialDao{

  @Query('SELECT * FROM fiber_entity')
  Future<List<FiberMaterial>> findAllFiberMaterials();

  // @Query('SELECT * FROM fiber_entity limit = :4')
  // Future<List<FiberMaterial>> findFFiberMaterials();

  @Query('SELECT * FROM fiber_entity where fbm_id = :id')
  Future<List<FiberMaterial>> findFiberMaterials(int id);

  @Query('SELECT * FROM fiber_entity where nature_id = :id')
  Future<List<FiberMaterial>> findFiberMaterialsWithNature(int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<List<int>> insertAllFiberMaterials(List<FiberMaterial> fiberMaterials);

  @Query("delete from fiber_entity")
  Future<void> deleteAll();

}