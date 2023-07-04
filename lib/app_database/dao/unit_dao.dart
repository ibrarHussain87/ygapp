import 'package:floor/floor.dart';
import 'package:yg_app/model/response/common_response_models/unit_of_count.dart';

@dao
abstract class UnitDao{
  @Query('SELECT * FROM units_table')
  Future<List<Units>> findAllUnit();

  @Query('SELECT * FROM units_table where untCategoryIdfk = :id')
  Future<List<Units>> findAllUnitWithCatId(int id);

  @Query('SELECT * FROM units_table where untCategoryIdfk = :id and unt_family_idfk = :famId')
  Future<List<Units>> findAllUnitWithCatIdFamId(int id,int famId);

  @Query('SELECT * FROM units_table where untId = :id')
  Future<Units?> findYarnUnitWithId(int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertUnit(Units certifications);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<List<int>> insertAllUnit(List<Units> certifications);

  @Query("delete from units_table where untId = :id")
  Future<void> deleteUnit(int id);

  @Query("delete from units_table")
  Future<void> deleteAll();
}