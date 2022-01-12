import 'package:floor/floor.dart';
import 'package:yg_app/model/response/common_response_models/countries_response.dart';

@dao
abstract class CountryDao{
  @Query('SELECT * FROM countries')
  Future<List<Countries>> findAllCountries();

  @Query('SELECT * FROM countries where conId = :id')
  Future<Countries?> findYarnCountryWithId(int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertCountry(Countries country);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<List<int>> insertAllCountry(List<Countries> country);

  @Query("delete from countries where conId = :id")
  Future<void> deleteCountries(int id);

  @Query("delete * from countries")
  Future<void> deleteAll();
}