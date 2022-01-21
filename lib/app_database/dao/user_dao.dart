import 'package:floor/floor.dart';
import 'package:yg_app/model/response/login/login_response.dart';

@dao
abstract class UserDao{
  @Query('SELECT * FROM user_table')
  Future<User?> getUser();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertUser(User user);

  @delete
  Future<void> deleteUserData();
}