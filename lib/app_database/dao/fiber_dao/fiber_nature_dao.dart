import 'package:floor/floor.dart';
import 'package:yg_app/model/response/fiber_response/sync/sync_fiber_response.dart';

@dao
abstract class FiberFamilyDao {
  @Query('SELECT * FROM fiber_family')
  Future<List<FiberFamily>> findAllFiberNatures();

  @Query('SELECT * FROM fiber_family where id = :id')
  Future<List<FiberFamily>> findFiberNatures(int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<List<int>> insertAllFiberNatures(List<FiberFamily> fiberNature);

  @Query("delete from fiber_family")
  Future<void> deleteAll();
}
