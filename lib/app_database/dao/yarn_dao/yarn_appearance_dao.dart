import 'package:floor/floor.dart';
import 'package:yg_app/model/response/fiber_response/sync/fiber_apperance.dart';
import 'package:yg_app/model/response/yarn_response/sync/yarn_sync_response.dart';

@dao
abstract class YarnAppearanceDao{

  @Query('SELECT * FROM yarn_appearance')
  Future<List<YarnAppearance>> findAllYarnAppearance();

  @Query('SELECT * FROM yarn_appearance where familyId = :id')
  Future<List<YarnAppearance>> findYarnAppearanceWithFamilyId(int id);

  @Query('SELECT * FROM yarn_appearance where yaId = :id')
  Future<List<YarnAppearance>> findYarnAppearance(int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<List<int>> insertAllYarnAppearance(List<YarnAppearance> yarnAppearance);

  @Query("delete from yarn_appearance")
  Future<void> deleteAll();

}