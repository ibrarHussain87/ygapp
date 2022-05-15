import 'package:get_it/get_it.dart';
import 'package:yg_app/providers/home_providers/family_list_provider.dart';
import 'package:yg_app/providers/fiber_providers/fiber_specification_provider.dart';
import 'package:yg_app/providers/fiber_providers/post_fiber_provider.dart';
import 'package:yg_app/providers/yarn_providers/post_yarn_provider.dart';
import 'package:yg_app/providers/specification_local_filter_provider.dart';
import 'package:yg_app/providers/home_providers/sync_provider.dart';


/// Locators to get instances of classes mostly singletons
GetIt locator = GetIt.I;

/// needs to be called at in the main
/// it creates the instances of services
void setupLocators() {


  if(!locator.isRegistered<SyncProvider>()) {
    locator.registerLazySingleton<SyncProvider>(
          () => SyncProvider(),
    );
  }

  if(!locator.isRegistered<FiberSpecificationProvider>()) {
    locator.registerLazySingleton<FiberSpecificationProvider>(
          () => FiberSpecificationProvider(),
    );
  }

  if(!locator.isRegistered<PostFiberProvider>()) {
    locator.registerLazySingleton<PostFiberProvider>(
          () => PostFiberProvider(),
    );
  }

  if(!locator.isRegistered<SpecificationLocalFilterProvider>()) {
    locator.registerLazySingleton<SpecificationLocalFilterProvider>(
          () => SpecificationLocalFilterProvider(),
    );
  }

  if(!locator.isRegistered<PostYarnProvider>()) {
    locator.registerLazySingleton<PostYarnProvider>(
          () => PostYarnProvider(),
    );
  }

  if(!locator.isRegistered<FamilyListProvider>()) {
    locator.registerLazySingleton<FamilyListProvider>(
          () => FamilyListProvider(),
    );
  }

}