import 'package:floor/floor.dart';
import 'package:yg_app/model/response/fiber_response/sync/sync_fiber_response.dart';

@dao
abstract class FiberBlendsDao{

  @Query('SELECT * FROM fiber_blends')
  Future<List<FiberBlends>> findAllFiberBlends();

  // @Query('SELECT * FROM fiber_entity limit = :4')
  // Future<List<FiberMaterial>> findFFiberMaterials();

  @Query('SELECT * FROM fiber_blends where familyIdfk = :id')
  Future<List<FiberBlends>> findFiberBlend(int id);

  @Query('SELECT * FROM fiber_blends where nature_id = :id')
  Future<List<FiberBlends>> findFiberBlendWithNature(int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<List<int>> insertAllFiberBlends(List<FiberBlends> fiberMaterials);

  @Query("delete from fiber_blends")
  Future<void> deleteAll();

}