import 'package:floor/floor.dart';

import '../../model/pre_login_response.dart';

@dao
abstract class GenericCategoriesDao{
  @Query('SELECT * FROM generic_categories')
  Future<List<GenericCategories>> findAllGenericCategories();

  @Query('SELECT * FROM generic_categories where catId = :id')
  Future<GenericCategories?> findGenericCategoriesWithId(int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertGenericCategory(GenericCategories genericCategories);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<List<int>> insertAllGenericCategories(List<GenericCategories> genericCategories);

  @Query("delete from generic_categories where catId = :id")
  Future<void> deleteGenericCategory(int id);

  @Query("delete from generic_categories")
  Future<void> deleteAll();
}