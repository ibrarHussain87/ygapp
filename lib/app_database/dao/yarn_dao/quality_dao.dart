import 'package:floor/floor.dart';
import 'package:yg_app/model/response/yarn_response/sync/yarn_sync_response.dart';

@dao
abstract class QualityDao{
  @Query('SELECT * FROM quality_table')
  Future<List<Quality>> findAllQuality();

  @Query('SELECT * FROM quality_table where spun_technique_id = :id and familyId = :familyId')
  Future<List<Quality>> findYarnQualityWithSpunTechId(int id,int familyId);

  @Query('SELECT * FROM quality_table where familyId = :id')
  Future<List<Quality>> findYarnQualityWithFamilyId(int id);

  @Query('SELECT * FROM quality_table where yqId = :id')
  Future<Quality?> findYarnQualityWithId(int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertQuality(Quality colorTm);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<List<int>> insertAllQuality(List<Quality> colorTm);

  @Query("delete from quality_table where yqId = :id")
  Future<void> deleteQuality(int id);

  @Query("delete from quality_table")
  Future<void> deleteAll();
}