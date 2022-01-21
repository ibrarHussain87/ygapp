import 'package:floor/floor.dart';
import 'package:yg_app/model/response/common_response_models/certification_response.dart';
import 'package:yg_app/model/response/common_response_models/companies_reponse.dart';

@dao
abstract class CompaniesDao{
  @Query('SELECT * FROM companies')
  Future<List<Companies>> findAllCompanies();

  @Query('SELECT * FROM companies where id = :id')
  Future<Companies?> findCompaniesWithId(int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertCompanies(Companies companies);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<List<int>> insertAllCompanies(List<Companies> companies);

  @Query("delete from companies where id = :id")
  Future<void> deleteCompanies(int id);

  @Query("delete from companies")
  Future<void> deleteAll();
}