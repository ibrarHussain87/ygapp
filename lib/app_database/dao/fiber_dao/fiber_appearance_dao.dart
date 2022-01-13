import 'package:floor/floor.dart';
import 'package:yg_app/model/response/fiber_response/sync/fiber_apperance.dart';

@dao
abstract class FiberAppearanceDao{

  @Query('SELECT * FROM fiber_appearance')
  Future<List<FiberAppearance>> findAllFiberAppearance();

  @Query('SELECT * FROM fiber_appearance where aprId = :id')
  Future<List<FiberAppearance>> findFiberAppearance(int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<List<int>> insertAllFiberAppearance(List<FiberAppearance> fiberAppearance);

  @Query("delete * from fiber_appearance")
  Future<void> deleteAll();

}