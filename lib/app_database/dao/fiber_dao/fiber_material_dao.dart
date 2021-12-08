import 'package:floor/floor.dart';
import 'package:yg_app/model/response/fiber_response/sync/sync_fiber_response.dart';

@dao
abstract class FiberMaterialDao{

  @Query('SELECT * FROM fiber_entity')
  Future<List<FiberMaterial>> findAllFiberMaterials();

  @Query('SELECT * FROM fiber_entity where fbm_id = :id')
  Future<List<FiberMaterial>> findFiberMaterials(int id);

  @Insert(onConflict: OnConflictStrategy.replace)  Future<void> insertFiberSetting(FiberMaterial fiberMaterials);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<List<int>> insertAllFiberMaterials(List<FiberMaterial> fiberMaterials);

  @Query("delete from fiber_entity where id = :id")
  Future<void> deleteFiberSetting(int id);

  @delete
  Future<int> deleteAll(List<FiberMaterial> list);

}