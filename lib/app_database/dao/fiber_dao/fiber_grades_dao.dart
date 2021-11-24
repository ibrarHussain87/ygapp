import 'package:floor/floor.dart';
import 'package:yg_app/model/response/fiber_response/sync/fiber_sync_response/fiber_grade.dart';

@dao
abstract class FiberGradesDao{
  @Query('SELECT * FROM fiber_grade')
  Future<List<FiberGrades>> findAllFiberGrades();

  @Query('SELECT * FROM fiber_setting where grd_category_idfk = :id')
  Future<List<FiberGrades>> findFiberGradeWithId(int id);

  @Insert(onConflict: OnConflictStrategy.replace)  Future<void> insertFiberGrades(FiberGrades fiberGrades);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<List<int>> insertAllFiberGrades(List<FiberGrades> fiberGrades);

  @Query("delete from fiber_grade where id = :id")
  Future<void> deleteFiberGrade(int id);

  @delete
  Future<int> deleteAll(List<FiberGrades> list);
}