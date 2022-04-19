import 'package:floor/floor.dart';
import 'package:yg_app/model/response/fabric_response/sync/fabric_sync_response.dart';

@dao
abstract class FabricLayyerDao {
  @Query('SELECT * FROM fabric_layyer')
  Future<List<FabricLayyer>> findAllFabricLayyer();

  @Query('SELECT * FROM fabric_layyer where fabricLayyerId = :id')
  Future<List<FabricLayyer>> findFabricLayyer(int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertFabricLayyer(FabricLayyer fabricFabricLayyer);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<List<int>> insertAllFabricLayyer(List<FabricLayyer> fabricFabricLayyer);

  @Query("delete from fabric_layyer where fabricLayyerId = :id")
  Future<void> deleteFabricLayyer(int id);

  @Query("delete from fabric_layyer")
  Future<void> deleteFabricLayyers();

}