import 'package:floor/floor.dart';

import '../../model/pre_login_response.dart';

@dao
abstract class SubscriptionPlansDao{
  @Query('SELECT * FROM subscription_plans')
  Future<List<SubscriptionPlans>> findAllSubscriptionPlans();

  @Query('SELECT * FROM subscription_plans where spId = :id')
  Future<SubscriptionPlans?> findSubscriptionPlansWithId(int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertSubscriptionPlan(SubscriptionPlans subscriptionPlans);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<List<int>> insertAllSubscriptionPlans(List<SubscriptionPlans> subscriptionPlans);

  @Query("delete from subscription_plans where spId = :id")
  Future<void> deleteSubscriptionPlan(int id);

  @Query("delete from subscription_plans")
  Future<void> deleteAll();
}