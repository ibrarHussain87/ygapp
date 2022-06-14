import 'package:floor/floor.dart';
import 'package:yg_app/model/response/common_response_models/category_response.dart';

@dao
abstract class CategoryDao{
  @Query('SELECT * FROM categories')
  Future<List<Categories>> findAllCategories();

  @Query('SELECT * FROM categories where catId = :id')
  Future<Categories?> findCategoryWithId(int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertCategory(Categories category);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<List<int>> insertAllCategories(List<Categories> category);

  @Query("delete from categories where catId = :id")
  Future<void> deleteCategories(int id);

  @Query("delete from categories")
  Future<void> deleteAll();
}