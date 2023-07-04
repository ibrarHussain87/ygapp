import 'package:floor/floor.dart';
import 'package:yg_app/model/response/fabric_response/sync/fabric_sync_response.dart';

@dao
abstract class FabricLoomDao {
  @Query('SELECT * FROM fabric_loom')
  Future<List<FabricLoom>> findAllFabricLoom();

  @Query('SELECT * FROM fabric_loom where fabricLoomId = :id')
  Future<List<FabricLoom>> findFabricLoom(int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertFabricLoom(FabricLoom fabricFabricLoom);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<List<int>> insertAllFabricLoom(List<FabricLoom> fabricFabricLoom);

  @Query("delete from fabric_loom where fabricLoomId = :id")
  Future<void> deleteFabricLoom(int id);

  @Query("delete from fabric_loom")
  Future<void> deleteFabricLooms();

}