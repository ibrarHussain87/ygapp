import 'package:floor/floor.dart';
import 'package:yg_app/model/response/common_response_models/certification_response.dart';
import 'package:yg_app/model/response/common_response_models/delievery_period.dart';

@dao
abstract class DeliveryPeriodDao{
  @Query('SELECT * FROM delivery_period')
  Future<List<DeliveryPeriod>> findAllDeliveryPeriod();

  @Query('SELECT * FROM delivery_period where dprId = :id')
  Future<DeliveryPeriod?> findDeliveryPeriodWithId(int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertDeliveryPeriod(DeliveryPeriod deliveryPeriod);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<List<int>> insertAllDeliveryPeriods(List<DeliveryPeriod> deliveryPeriods);

  @Query("delete from delivery_period where dprId = :id")
  Future<void> deleteDeliveryPeriod(int id);

  @Query("delete * from delivery_period")
  Future<void> deleteAll();
}