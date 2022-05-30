import 'package:floor/floor.dart';

import '../../model/pre_login_response.dart';

@dao
abstract class DesignationsDao{
  @Query('SELECT * FROM designations')
  Future<List<Designations>> findAllDesignations();

  @Query('SELECT * FROM designations where designationId = :id')
  Future<Designations?> findDesignationsWithId(int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertDesignation(Designations designations);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<List<int>> insertAllDesignations(List<Designations> designations);

  @Query("delete from designations where designationId = :id")
  Future<void> deleteDesignation(int id);

  @Query("delete from designations")
  Future<void> deleteAll();
}