import 'package:floor/floor.dart';
import 'package:yg_app/model/response/fabric_response/sync/fabric_sync_response.dart';

@dao
abstract class FabricPlyDao {
  @Query('SELECT * FROM fabric_ply')
  Future<List<FabricPly>> findAllFabricPly();

  @Query('SELECT * FROM fabric_ply where fabricPlyId = :id')
  Future<List<FabricPly>> findFabricPly(int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertFabricPly(FabricPly fabricFabricPly);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<List<int>> insertAllFabricPly(List<FabricPly> fabricFabricPly);

  @Query("delete from fabric_ply where fabricPlyId = :id")
  Future<void> deleteFabricPly(int id);

  @Query("delete from fabric_ply")
  Future<void> deleteFabricPlys();

}