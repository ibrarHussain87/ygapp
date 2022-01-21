import 'package:floor/floor.dart';
import 'package:yg_app/model/response/yarn_response/sync/yarn_sync_response.dart';

@dao
abstract class YarnBlendDao{

  @Query('SELECT * FROM yarn_blend')
  Future<List<Blends>> findAllYarnBlends();

  @Query('SELECT * FROM yarn_blend where blnId = :id')
  Future<List<Blends>> findYarnBlend(int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertAllYarnBlend(List<Blends> yarnBlend);

  @Query("delete from yarn_blend")
  Future<void> deleteAll();
}