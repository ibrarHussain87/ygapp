import 'package:floor/floor.dart';
import 'package:yg_app/model/response/fabric_response/sync/fabric_sync_response.dart';

@dao
abstract class FabricSalvedgeDao {
  @Query('SELECT * FROM fabric_salvedge')
  Future<List<FabricSalvedge>> findAllFabricSalvedge();

  @Query('SELECT * FROM fabric_salvedge where fabric_salvedge_id = :id')
  Future<List<FabricSalvedge>> findFabricSalvedge(int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertFabricSalvedge(FabricSalvedge fabricFabricSalvedge);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<List<int>> insertAllFabricSalvedge(List<FabricSalvedge> fabricFabricSalvedge);

  @Query("delete from fabric_salvedge where fabric_salvedge_id = :id")
  Future<void> deleteFabricSalvedge(int id);

  @Query("delete from fabric_salvedge")
  Future<void> deleteFabricSalvedges();

}