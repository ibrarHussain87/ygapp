import 'package:floor/floor.dart';
import 'package:yg_app/model/response/yarn_response/sync/yarn_sync_response.dart';

@dao
abstract class PatternCharacteristicsDao{
  @Query('SELECT * FROM pattern_table')
  Future<List<PatternCharectristic>> findAllPatternCharacteristics();

  @Query('SELECT * FROM pattern_table where ypId = :id')
  Future<PatternCharectristic?> findYarnPatternCharacteristicsWithId(int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertPatternCharacteristics(PatternCharectristic colorTm);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<List<int>> insertAllPatternCharacteristics(List<PatternCharectristic> colorTm);

  @Query("delete from pattern_table where ypId = :id")
  Future<void> deletePatternCharacteristics(int id);

  @Query("delete * from pattern_table")
  Future<void> deleteAll();
}