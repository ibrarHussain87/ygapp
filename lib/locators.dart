import 'package:get_it/get_it.dart';
import 'package:yg_app/providers/post_yarn_provider.dart';


/// Locators to get instances of classes mostly singletons
GetIt locator = GetIt.I;

/// needs to be called at in the main
/// it creates the instances of services
void setupLocators() {

  if(!locator.isRegistered<PostYarnProvider>()) {
    locator.registerLazySingleton<PostYarnProvider>(
          () => PostYarnProvider(),
    );
  }

}