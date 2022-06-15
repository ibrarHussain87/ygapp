import 'package:floor/floor.dart';

import '../../model/pre_login_response.dart';

@dao
abstract class CitiesDao{
  @Query('SELECT * FROM cities')
  Future<List<Cities>> findAllCities();

  @Query('SELECT * FROM cities where cityId = :id')
  Future<Cities?> findCitiesWithId(int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertCity(Cities cities);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<List<int>> insertAllCities(List<Cities> cities);

  @Query("delete from cities where cityId = :id")
  Future<void> deleteCity(int id);

  @Query("delete from cities")
  Future<void> deleteAll();
}