import 'package:floor/floor.dart';
import 'package:yg_app/model/response/common_response_models/payment_type_response.dart';

@dao
abstract class PaymentTypeDao{
  @Query('SELECT * FROM payment_type')
  Future<List<PaymentType>> findAllPaymentTypes();

  @Query('SELECT * FROM payment_type where payId = :id')
  Future<PaymentType?> findYarnPaymentTypeWithId(int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertPaymentType(PaymentType paymentType);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<List<int>> insertAllPaymentType(List<PaymentType> paymentType);

  @Query("delete from payment_type where payId = :id")
  Future<void> deletePaymentType(int id);

  @Query("delete from payment_type")
  Future<void> deleteAll();
}