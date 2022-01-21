import 'package:floor/floor.dart';
import 'package:yg_app/model/response/yarn_response/sync/yarn_sync_response.dart';

@dao
abstract class UsageDao{
  @Query('SELECT * FROM usage_table')
  Future<List<Usage>> findAllUsage();

  @Query('SELECT * FROM usage_table where yuId = :id')
  Future<Usage?> findYarnUsageWithId(int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertUsage(Usage colorTm);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<List<int>> insertAllUsage(List<Usage> colorTm);

  @Query("delete from usage_table where yuId = :id")
  Future<void> deleteUsage(int id);

  @Query("delete from usage_table")
  Future<void> deleteAll();
}