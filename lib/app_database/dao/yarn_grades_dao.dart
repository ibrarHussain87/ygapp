import 'package:floor/floor.dart';
import 'package:yg_app/model/response/yarn_response/sync/yarn_grades.dart';

@dao
abstract class YarnGradesDao{
  @Query('SELECT * FROM yarn_grades')
  Future<List<YarnGrades>> findAllGrades();

  @Query('SELECT * FROM yarn_grades where familyId = :id')
  Future<List<YarnGrades>> findGradeWithFamilyId(int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertGrades(YarnGrades grades);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<List<int>> insertAllGrades(List<YarnGrades> grades);

  @Query("delete from yarn_grades where id = :id")
  Future<void> deleteGrade(int id);

  @Query("delete from yarn_grades")
  Future<void> deleteAll();
}