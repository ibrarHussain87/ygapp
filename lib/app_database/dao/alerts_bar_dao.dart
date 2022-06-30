import 'package:floor/floor.dart';
import 'package:yg_app/model/pre_login_response.dart';

@dao
abstract class AlertBarDao{
  @Query('SELECT * FROM alert_bars')
  Future<List<AlertBars>> findAllAlertBars();

  @Query('SELECT * FROM brands where alertBarId = :id')
  Future<AlertBars?> findAlertBarWithId(int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertAlertBar(AlertBars alertBars);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<List<int>> insertAllAlertBars(List<AlertBars> alertBars);

  @Query("delete from alert_bars")
  Future<void> deleteAll();
}