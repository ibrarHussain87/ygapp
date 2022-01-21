import 'package:floor/floor.dart';
import 'package:yg_app/model/response/common_response_models/city_state_response.dart';

@dao
abstract class CityStateDao{
  @Query('SELECT * FROM city_state')
  Future<List<CityState>> findAllCityState();

  @Query('SELECT * FROM city_state where id = :id')
  Future<CityState?> findCityStateWithId(int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertCityState(CityState cityStates);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<List<int>> insertAllCityState(List<CityState> cityStates);

  @Query("delete from city_state where id = :id")
  Future<void> deleteCityState(int id);

  @Query("delete from city_state")
  Future<void> deleteAll();
}