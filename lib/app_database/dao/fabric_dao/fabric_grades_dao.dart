import 'package:floor/floor.dart';
import 'package:yg_app/model/response/fabric_response/sync/fabric_sync_response.dart';

@dao
abstract class FabricGradesDao {
  @Query('SELECT * FROM fabric_grades')
  Future<List<FabricGrades>> findAllFabricGrade();

  @Query('SELECT * FROM fabric_grades where fabricGradeId = :id')
  Future<List<FabricGrades>> findFabricGrade(int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertFabricGrade(FabricGrades fabricFabricGrade);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<List<int>> insertAllFabricGrade(List<FabricGrades> fabricFabricGrade);

  @Query("delete from fabric_grades where fabricGradeId = :id")
  Future<void> deleteFabricGrade(int id);

  @Query("delete from fabric_grades")
  Future<void> deleteFabricGrades();

}