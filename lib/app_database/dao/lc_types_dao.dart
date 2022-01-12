import 'package:floor/floor.dart';
import 'package:yg_app/model/response/common_response_models/lc_type_response.dart';

@dao
abstract class LcTypesDao{
  @Query('SELECT * FROM lc_type')
  Future<List<LcType>> findAllLcType();

  @Query('SELECT * FROM lc_type where lcId = :id')
  Future<LcType?> findYarnLcTypeWithId(int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertLcType(LcType lcType);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<List<int>> insertAllLcType(List<LcType> lcType);

  @Query("delete from lc_type where lcId = :id")
  Future<void> deleteLcType(int id);

  @Query("delete * from lc_type")
  Future<void> deleteAll();
}