import 'package:floor/floor.dart';
import 'package:yg_app/model/response/common_response_models/certification_response.dart';
import 'package:yg_app/model/response/common_response_models/packing_response.dart';

@dao
abstract class PackingDao{
  @Query('SELECT * FROM packing')
  Future<List<Packing>> findAllPacking();

  @Query('SELECT * FROM packing where pacId = :id')
  Future<Packing?> findYarnPackingWithId(int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertPacking(Packing packing);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<List<int>> insertAllPacking(List<Packing> packing);

  @Query("delete from packing where pacId = :id")
  Future<void> deletePacking(int id);

  @Query("delete from packing")
  Future<void> deleteAll();
}