import 'package:floor/floor.dart';
import 'package:yg_app/model/response/common_response_models/certification_response.dart';
import 'package:yg_app/model/response/common_response_models/ports_response.dart';

@dao
abstract class PortsDao{
  @Query('SELECT * FROM ports')
  Future<List<Ports>> findAllPorts();

  @Query('SELECT * FROM ports where prtId = :id')
  Future<Ports?> findYarnPortsWithId(int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertPorts(Ports ports);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<List<int>> insertAllPorts(List<Ports> ports);

  @Query("delete from ports where prtId = :id")
  Future<void> deletePorts(int id);

  @Query("delete * from ports")
  Future<void> deleteAll();
}