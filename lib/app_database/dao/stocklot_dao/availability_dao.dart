import 'package:floor/floor.dart';
import 'package:yg_app/model/response/stocklot_sync/stocklot_sync_response.dart';

@dao
abstract class AvailabilityDao{
  @Query('SELECT * FROM availability_table')
  Future<List<AvailabilityModel>> findAllAvailability();

  @Query('SELECT * FROM availability_table where id = :id')
  Future<AvailabilityModel?> findAvailabilityWithId(int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertAvailability(AvailabilityModel availablityModel);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<List<int>> insertAllAvailability(List<AvailabilityModel> availablityModel);

  @Query("delete from availability_table where id = :id")
  Future<void> deleteAvailability(int id);

  @Query("delete from availability_table")
  Future<void> deleteAll();
}