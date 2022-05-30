import 'package:floor/floor.dart';

import '../../model/pre_login_response.dart';

@dao
abstract class ServiceTypesDao{
  @Query('SELECT * FROM service_types')
  Future<List<ServiceTypes>> findAllServiceTypes();

  @Query('SELECT * FROM service_types where serviceTypeId = :id')
  Future<ServiceTypes?> findServiceTypesWithId(int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertServiceType(ServiceTypes serviceTypes);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<List<int>> insertAllServiceTypes(List<ServiceTypes> serviceTypes);

  @Query("delete from service_types where serviceTypeId = :id")
  Future<void> deleteServiceType(int id);

  @Query("delete from service_types")
  Future<void> deleteAll();
}