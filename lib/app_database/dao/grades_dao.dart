import 'package:floor/floor.dart';
import 'package:yg_app/model/response/common_response_models/grade.dart';

@dao
abstract class GradesDao{
  @Query('SELECT * FROM fiber_grade')
  Future<List<Grades>> findAllGrades();

  @Query('SELECT * FROM fiber_setting where grd_category_idfk = :id')
  Future<List<Grades>> findFiberGradeWithId(int id);

  @Query('SELECT * FROM yarn_settings where grd_category_idfk = :id')
  Future<List<Grades>> findYarnGradeWithId(int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertGrades(Grades grades);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<List<int>> insertAllGrades(List<Grades> grades);

  @Query("delete from fiber_grade where id = :id")
  Future<void> deleteGrade(int id);

  @Query("delete * from fiber_grade")
  Future<void> deleteAll();
}