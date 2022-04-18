import 'package:floor/floor.dart';
import 'package:yg_app/model/response/fabric_response/sync/fabric_sync_response.dart';

@dao
abstract class KnittingTypesDao {

  @Query('SELECT * FROM knitting_types')
  Future<List<KnittingTypes>> findAllKnittingTypes();

  @Query('SELECT * FROM knitting_types where fabricKnittingTypeId = :id')
  Future<List<KnittingTypes>> findKnittingType(int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertKnittingTypes(KnittingTypes knittingTypes);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<List<int>> insertAllKnittingTypes(List<KnittingTypes> knittingTypes);

  @Query("delete from knitting_types where fabricKnittingTypeId = :id")
  Future<void> deleteKnittingType(int id);

  @Query("delete from knitting_types")
  Future<void> deleteKnittingTypes();

}