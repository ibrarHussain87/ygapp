import 'package:floor/floor.dart';
import 'package:yg_app/model/response/fabric_response/sync/fabric_sync_response.dart';

@dao
abstract class FabricDenimTypesDao {
  @Query('SELECT * FROM fabric_denim_types')
  Future<List<DenimTypes>> findAllFabricDenimTypes();

  @Query('SELECT * FROM fabric_denim_types where fabricDenimTypeId = :id')
  Future<List<DenimTypes>> findFabricDenimTypes(int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertFabricDenimTypes(DenimTypes denimTypes);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<List<int>> insertAllFabricDenimTypes(List<DenimTypes> fabricFabricDenimTypes);

  @Query("delete from fabric_denim_types where fabricDenimTypeId = :id")
  Future<void> deleteFabricDenimType(int id);

  @Query("delete from fabric_denim_types")
  Future<void> deleteFabricDenimTypes();

}