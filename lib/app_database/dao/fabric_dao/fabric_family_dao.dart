import 'package:floor/floor.dart';
import 'package:yg_app/model/response/fabric_response/sync/fabric_sync_response.dart';

@dao
abstract class FabricFamilyDao {
  @Query('SELECT * FROM fabric_family')
  Future<List<FabricFamily>> findAllFabricFamily();

  @Query('SELECT * FROM fabric_family where fabric_family_id = :id')
  Future<List<FabricFamily>> findFamilyFabricFamily(int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertFabricFamily(FabricFamily fabricFamily);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<List<int>> insertAllFabricFamily(List<FabricFamily> fabricFamily);

  @Query("delete from fabric_family where fabric_family_id = :id")
  Future<void> deleteFabricFamily(int id);

  @Query("delete from fabric_family")
  Future<void> deleteFabricFamilies();

}