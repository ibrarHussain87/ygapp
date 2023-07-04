import 'package:floor/floor.dart';
import 'package:yg_app/model/response/fabric_response/sync/fabric_sync_response.dart';

@dao
abstract class FabricAppearanceDao {
  @Query('SELECT * FROM fabric_appearance')
  Future<List<FabricAppearance>> findAllFabricAppearance();

  @Query('SELECT * FROM fabric_appearance where fabricAppearanceId = :id')
  Future<List<FabricAppearance>> findFabricAppearance(int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertFabricAppearance(FabricAppearance fabricAppearance);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<List<int>> insertAllFabricAppearance(List<FabricAppearance> fabricAppearance);

  @Query("delete from fabric_appearance where fabricAppearanceId = :id")
  Future<void> deleteFabricAppearance(int id);

  @Query("delete from fabric_appearance")
  Future<void> deleteFabricAppearances();

}