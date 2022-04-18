import 'package:floor/floor.dart';
import 'package:yg_app/model/response/fabric_response/sync/fabric_sync_response.dart';

@dao
abstract class FabricBlendsDao {
  @Query('SELECT * FROM fabric_blends')
  Future<List<FabricBlends>> findAllFabricBlends();

  @Query('SELECT * FROM fabric_blends where blnId = :id')
  Future<List<FabricBlends>> findFabricBlend(int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertFabricBlends(FabricBlends fabricBlends);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<List<int>> insertAllFabricBlends(List<FabricBlends> fabricBlends);

  @Query("delete from fabric_blends where blnId = :id")
  Future<void> deleteFabricBlend(int id);

  @Query("delete from fabric_blends")
  Future<void> deleteFabricBlends();

}