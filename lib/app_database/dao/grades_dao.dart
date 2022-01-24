import 'package:floor/floor.dart';
import 'package:yg_app/model/response/common_response_models/grade.dart';

@dao
abstract class GradesDao{
  @Query('SELECT * FROM grade')
  Future<List<Grades>> findAllGrades();

  @Query('SELECT * FROM grade where grdCategoryIdfk = :id')
  Future<List<Grades>> findGradeWithCatId(int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertGrades(Grades grades);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<List<int>> insertAllGrades(List<Grades> grades);

  @Query("delete from grade where id = :id")
  Future<void> deleteGrade(int id);

  @Query("delete from grade")
  Future<void> deleteAll();
}