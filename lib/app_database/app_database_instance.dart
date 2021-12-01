import 'package:yg_app/utils/constants.dart';

import 'app_database.dart';

class AppDbInstance {
 static Future<AppDatabase> getDbInstance() async {
    AppDatabase? databaseInstance;
    final database = $FloorAppDatabase.databaseBuilder(AppConstants.APP_DATABASE_NAME).build();
    await database.then((value) => {databaseInstance = value});
    return databaseInstance!;
  }
}