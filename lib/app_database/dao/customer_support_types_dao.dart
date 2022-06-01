import 'package:floor/floor.dart';

import '../../model/pre_login_response.dart';

@dao
abstract class CustomerSupportTypesDao{
  @Query('SELECT * FROM customer_support_types')
  Future<List<CustomerSupportTypes>> findAllCustomerSupportTypes();

  @Query('SELECT * FROM customer_support_types where cstype_id = :id')
  Future<CustomerSupportTypes?> findCustomerSupportTypesWithId(int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertCustomerSupportType(CustomerSupportTypes customerSupportTypes);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<List<int>> insertAllCustomerSupportTypes(List<CustomerSupportTypes> customerSupportTypes);

  @Query("delete from customer_support_types where cstype_id = :id")
  Future<void> deleteCustomerSupportType(int id);

  @Query("delete from customer_support_types")
  Future<void> deleteAll();
}