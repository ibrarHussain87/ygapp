import 'package:floor/floor.dart';
import 'package:yg_app/model/response/yarn_response/sync/yarn_sync_response.dart';

@dao
abstract class PlyDao{
  @Query('SELECT * FROM ply_table')
  Future<List<Ply>> findAllPly();

  @Query('SELECT * FROM ply_table where familyId = :id')
  Future<List<Ply>> findYarnPlyWithFamilyId(int id);

  @Query('SELECT * FROM ply_table where plyId = :id')
  Future<Ply?> findYarnPlyWithId(int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertPly(Ply colorTm);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<List<int>> insertAllPly(List<Ply> colorTm);

  @Query("delete from ply_table where plyId = :id")
  Future<void> deletePly(int id);

  @Query("delete from ply_table")
  Future<void> deleteAll();
}