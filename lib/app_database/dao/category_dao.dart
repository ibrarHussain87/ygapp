import 'package:floor/floor.dart';
import 'package:yg_app/model/response/common_response_models/user_category_response.dart';

@dao
abstract class UserCategoryDao{
  @Query('SELECT * FROM categories')
  Future<List<UserCategories>> findAllCategories();

  @Query('SELECT * FROM categories where catId = :id')
  Future<UserCategories?> findCategoryWithId(int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertCategory(UserCategories category);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<List<int>> insertAllCategories(List<UserCategories> category);

  @Query("delete from categories where catId = :id")
  Future<void> deleteCategories(int id);

  @Query("delete from categories")
  Future<void> deleteAll();
}