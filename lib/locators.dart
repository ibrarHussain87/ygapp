import 'package:get_it/get_it.dart';
import 'package:yg_app/pages/profile/update_profile/brands_notifier.dart';
import 'package:yg_app/providers/detail_provider/detail_page_provider.dart';
import 'package:yg_app/providers/fabric_providers/post_fabric_provider.dart';
import 'package:yg_app/providers/home_providers/family_list_provider.dart';
import 'package:yg_app/providers/fiber_providers/fiber_specification_provider.dart';
import 'package:yg_app/providers/fiber_providers/post_fiber_provider.dart';
import 'package:yg_app/providers/pre_login_sync_provider.dart';
import 'package:yg_app/providers/stocklot_providers/stocklot_provider.dart';
import 'package:yg_app/providers/user_brands_provider.dart';
import 'package:yg_app/providers/yarn_providers/post_yarn_provider.dart';
import 'package:yg_app/providers/specification_local_filter_provider.dart';
import 'package:yg_app/providers/home_providers/sync_provider.dart';
import 'package:yg_app/providers/yarn_providers/yarn_specifications_provider.dart';


/// Locators to get instances of classes mostly singletons
GetIt locator = GetIt.I;

/// needs to be called at in the main
/// it creates the instances of services
void setupLocators() {


  if(!locator.isRegistered<PreLoginSyncProvider>()) {
    locator.registerLazySingleton<PreLoginSyncProvider>(
          () => PreLoginSyncProvider(),
    );
  }

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

  if(!locator.isRegistered<YarnSpecificationsProvider>()) {
    locator.registerLazySingleton<YarnSpecificationsProvider>(
          () => YarnSpecificationsProvider(),
    );
  }

  if(!locator.isRegistered<PostYarnProvider>()) {
    locator.registerLazySingleton<PostYarnProvider>(
          () => PostYarnProvider(),
    );
  }

  if(!locator.isRegistered<PostFabricProvider>()) {
    locator.registerLazySingleton<PostFabricProvider>(
          () => PostFabricProvider(),
    );
  }

  if(!locator.isRegistered<FamilyListProvider>()) {
    locator.registerLazySingleton<FamilyListProvider>(
          () => FamilyListProvider(),
    );
  }

  if(!locator.isRegistered<StocklotProvider>()) {
    locator.registerLazySingleton<StocklotProvider>(
          () => StocklotProvider(),
    );
  }

  if(!locator.isRegistered<UserBrandsProvider>()) {
    locator.registerLazySingleton<UserBrandsProvider>(
          () => UserBrandsProvider(),
    );
  }

  if(!locator.isRegistered<DetailPageProvider>()) {
    locator.registerLazySingleton<DetailPageProvider>(
          () => DetailPageProvider(),
    );
  }

}