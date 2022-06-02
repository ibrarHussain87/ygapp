import 'package:floor/floor.dart';
import 'package:yg_app/model/response/common_response_models/brands_response.dart';

@dao
abstract class UserBrandsDao{
  @Query('SELECT * FROM user_brands')
  Future<List<UserBrands>> findAllUserBrands();

  @Query('SELECT * FROM user_brands where brdId = :id')
  Future<UserBrands?> findUserBrandWithId(int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertUserBrands(UserBrands brands);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<List<int>> insertAllUserBrands(List<UserBrands> brands);

  @Query("delete from user_brands where brdId = :id")
  Future<void> deleteUserBrand(int id);

  @Query("delete from user_brands")
  Future<void> deleteAll();
}