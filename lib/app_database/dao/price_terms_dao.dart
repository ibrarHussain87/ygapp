import 'package:floor/floor.dart';
import 'package:yg_app/model/response/common_response_models/certification_response.dart';
import 'package:yg_app/model/response/common_response_models/price_term.dart';

@dao
abstract class PriceTermsDao{
  @Query('SELECT * FROM price_terms_table')
  Future<List<FPriceTerms>> findAllFPriceTerms();

  @Query('SELECT * FROM price_terms_table where ptrId = :id')
  Future<FPriceTerms?> findYarnFPriceTermsWithId(int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertFPriceTerms(FPriceTerms certifications);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<List<int>> insertAllFPriceTerms(List<FPriceTerms> certifications);

  @Query("delete from price_terms_table where ptrId = :id")
  Future<void> deleteFPriceTerms(int id);

  @Query("delete * from price_terms_table")
  Future<void> deleteAll();
}