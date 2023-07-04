import 'package:floor/floor.dart';

import '../../model/pre_login_response.dart';

@dao
abstract class StatesDao{
  @Query('SELECT * FROM states')
  Future<List<States>> findAllStates();

  @Query('SELECT * FROM states where stateId = :id')
  Future<States?> findStatesWithId(int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertState(States states);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<List<int>> insertAllStates(List<States> states);

  @Query("delete from states where stateId = :id")
  Future<void> deleteState(int id);

  @Query("delete from states")
  Future<void> deleteAll();
}