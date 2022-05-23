import 'package:floor/floor.dart';
import 'package:yg_app/model/response/yarn_response/sync/yarn_sync_response.dart';

@dao
abstract class PatternDao{
  @Query('SELECT * FROM pattern_table')
  Future<List<PatternModel>> findAllPattern();

  @Query('SELECT * FROM pattern_table where familyId = :id')
  Future<List<PatternModel>> findAllPatternWithFamily(int id);

  @Query('SELECT * FROM pattern_table where spun_technique_id = :id and familyId = :famId')
  Future<List<PatternModel>> findAllPatternWithSpunTechId(int id,int famId);

  @Query('SELECT * FROM pattern_table where ypId = :id')
  Future<PatternModel?> findYarnPatternWithId(int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertPattern(PatternModel colorTm);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<List<int>> insertAllPattern(List<PatternModel> colorTm);

  @Query("delete from pattern_table where ypId = :id")
  Future<void> deletePattern(int id);

  @Query("delete from pattern_table")
  Future<void> deleteAll();
}