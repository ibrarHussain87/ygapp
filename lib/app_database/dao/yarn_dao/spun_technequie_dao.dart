import 'package:floor/floor.dart';
import 'package:yg_app/model/response/yarn_response/sync/yarn_sync_response.dart';

@dao
abstract class SpunTechniqueDao{
  @Query('SELECT * FROM spun_technique')
  Future<List<SpunTechnique>> findAllSpunTechnique();

  @Query('SELECT * FROM spun_technique where ystId = :id')
  Future<SpunTechnique?> findYarnSpunTechniqueWithId(int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertSpunTechnique(SpunTechnique colorTm);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<List<int>> insertAllSpunTechnique(List<SpunTechnique> colorTm);

  @Query("delete from spun_technique where ystId = :id")
  Future<void> deleteSpunTechnique(int id);

  @Query("delete from spun_technique")
  Future<void> deleteAll();
}