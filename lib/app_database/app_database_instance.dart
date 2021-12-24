import 'package:yg_app/helper_utils/app_constants.dart';

import 'app_database.dart';

class AppDbInstance {
 static Future<AppDatabase> getDbInstance() async {
    AppDatabase? databaseInstance;
    final database = $FloorAppDatabase.databaseBuilder(APP_DATABASE_NAME).build();
    await database.then((value) => {databaseInstance = value});
    return databaseInstance!;
  }
}