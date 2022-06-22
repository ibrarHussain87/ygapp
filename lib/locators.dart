import 'package:get_it/get_it.dart';
import 'package:yg_app/providers/detail_provider/detail_page_provider.dart';
import 'package:yg_app/providers/fabric_providers/fabric_specifications_provider.dart';
import 'package:yg_app/providers/fabric_providers/post_fabric_provider.dart';
import 'package:yg_app/providers/home_providers/family_list_provider.dart';
import 'package:yg_app/providers/fiber_providers/fiber_specification_provider.dart';
import 'package:yg_app/providers/fiber_providers/post_fiber_provider.dart';
import 'package:yg_app/providers/pre_login_sync_provider.dart';
import 'package:yg_app/providers/profile_providers/my_yg_services_provider.dart';
import 'package:yg_app/providers/profile_providers/profile_info_provider.dart';
import 'package:yg_app/providers/stocklot_providers/post_stocklot_provider.dart';
import 'package:yg_app/providers/stocklot_providers/stocklot_specification_provider.dart';
import 'package:yg_app/providers/yarn_providers/yarn_filter_provider.dart';
import 'providers/profile_providers/user_brands_provider.dart';
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

  if(!locator.isRegistered<FabricSpecificationsProvider>()) {
    locator.registerLazySingleton<FabricSpecificationsProvider>(
          () => FabricSpecificationsProvider(),
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

  if(!locator.isRegistered<StockLotSpecificationProvider>()) {
    locator.registerLazySingleton<StockLotSpecificationProvider>(
          () => StockLotSpecificationProvider(),
    );
  }

  if(!locator.isRegistered<PostStockLotProvider>()) {
    locator.registerLazySingleton<PostStockLotProvider>(
          () => PostStockLotProvider(),
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

  if(!locator.isRegistered<ProfileInfoProvider>()) {
    locator.registerLazySingleton<ProfileInfoProvider>(
          () => ProfileInfoProvider(),
    );
  }

  if(!locator.isRegistered<YgServicesProvider>()) {
    locator.registerLazySingleton<YgServicesProvider>(
          () => YgServicesProvider(),
    );
  }

  if(!locator.isRegistered<YarnFilterProvider>()) {
    locator.registerLazySingleton<YarnFilterProvider>(
          () => YarnFilterProvider(),
    );
  }
}