import 'package:floor/floor.dart';
import 'package:yg_app/model/response/common_response_models/brands_response.dart';

@dao
abstract class BrandsDao{
  @Query('SELECT * FROM brands')
  Future<List<Brands>> findAllBrands();

  @Query('SELECT * FROM brands where brdId = :id')
  Future<Brands?> findBrandWithId(int id);

  @Query('SELECT * FROM brands where isUserBrand = :value')
  Future<List<Brands>> findUserBrands(bool value);

  @Query('UPDATE brands SET isUserBrand = :value where brdId = :id')
  Future<void> updateBrands(int id,bool value);

  @Query('UPDATE brands SET isUserBrand = :value')
  Future<void> updateAllBrands(bool value);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertBrands(Brands brands);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<List<int>> insertAllBrands(List<Brands> brands);

  @Query("delete from brands where id = :id")
  Future<void> deleteBrand(int id);

  @Query("delete from brands")
  Future<void> deleteAll();
}