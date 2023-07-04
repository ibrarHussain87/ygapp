import 'package:floor/floor.dart';
import 'package:yg_app/model/pre_login_response.dart';

@dao
abstract class NotificationGlobalDao{
  @Query('SELECT * FROM notification_global')
  Future<List<NotificationsGlobal>> findAllNotificationGlobal();

  @Query('SELECT * FROM notification_global where notificationGlobalId = :id')
  Future<NotificationsGlobal?> findNotificationGlobalWithId(int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertNotificationGlobal(NotificationsGlobal notificationsGlobal);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<List<int>> insertAllNotificationGlobal(List<NotificationsGlobal> notificationsGlobal);

  @Query("delete from alert_bars")
  Future<void> deleteAll();
}