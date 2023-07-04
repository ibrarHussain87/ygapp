import 'package:floor/floor.dart';
import 'package:yg_app/model/response/yarn_response/sync/yarn_sync_response.dart';

@dao
abstract class YarnFamilyDao{
  @Query('SELECT * FROM yarn_family')
  Future<List<Family>> findAllYarnFamily();

  @Query('SELECT * FROM yarn_family where famId = :id')
  Future<List<Family>> findYarnFamily(int id);


  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertAllYarnFamily(List<Family> yarnFamily);

  @Query("delete from yarn_family")
  Future<void> deleteAll();
}