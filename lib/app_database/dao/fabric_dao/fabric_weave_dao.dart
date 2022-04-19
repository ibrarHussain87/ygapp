import 'package:floor/floor.dart';
import 'package:yg_app/model/response/fabric_response/sync/fabric_sync_response.dart';

@dao
abstract class FabricWeaveDao {
  @Query('SELECT * FROM fabric_weave')
  Future<List<FabricWeave>> findAllFabricWeave();

  @Query('SELECT * FROM fabric_weave where fabricWeaveId = :id')
  Future<List<FabricWeave>> findFabricWeave(int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertFabricWeave(FabricWeave fabricFabricWeave);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<List<int>> insertAllFabricWeave(List<FabricWeave> fabricFabricWeave);

  @Query("delete from fabric_weave where fabricWeaveId = :id")
  Future<void> deleteFabricWeave(int id);

  @Query("delete from fabric_weave")
  Future<void> deleteFabricWeaves();

}