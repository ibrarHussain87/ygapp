import 'package:floor/floor.dart';
import 'package:yg_app/model/response/fiber_response/sync/sync_fiber_response.dart';

@dao
abstract class FiberNatureDao {
  @Query('SELECT * FROM fiber_natures')
  Future<List<FiberNature>> findAllFiberNatures();

  @Query('SELECT * FROM fiber_natures where id = :id')
  Future<List<FiberNature>> findFiberNatures(int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<List<int>> insertAllFiberNatures(List<FiberNature> fiberNature);

  @Query("delete from fiber_natures")
  Future<void> deleteAll();
}
