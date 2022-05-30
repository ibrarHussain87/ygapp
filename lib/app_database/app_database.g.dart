// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  UserDao? _userDaoInstance;

  FiberSettingDao? _fiberSettingDaoInstance;

  FiberFamilyDao? _fiberFamilyDaoInstance;

  FiberBlendsDao? _fiberBlendsDaoInstance;

  FiberAppearanceDao? _fiberAppearanceDoaInstance;

  GradesDao? _gradesDaoInstance;

  BrandsDao? _brandsDaoInstance;

  CertificationsDao? _certificationDaoInstance;

  CityStateDao? _cityStateDaoInstance;

  CompaniesDao? _companiesDaoInstance;

  CountryDao? _countriesDaoInstance;

  CategoryDao? _categoriesDaoInstance;

  DeliveryPeriodDao? _deliveryPeriodDaoInstance;

  PaymentTypeDao? _paymentTypeDaoInstance;

  PortsDao? _portsDaoInstance;

  PriceTermsDao? _priceTermsDaoInstance;

  UnitDao? _unitDaoInstance;

  StocklotFamilyDao? _stocklotCategoriesDaoInstance;

  FabricSettingDao? _fabricSettingDaoInstance;

  FabricFamilyDao? _fabricFamilyDaoInstance;

  FabricBlendsDao? _fabricBlendsDaoInstance;

  FabricDenimTypesDao? _fabricDenimTypesDaoInstance;

  FabricAppearanceDao? _fabricAppearanceDaoInstance;

  KnittingTypesDao? _knittingTypesDaoInstance;

  FabricPlyDao? _fabricPlyDaoInstance;

  FabricColorTreatmentMethodDao? _fabricColorTreatmentMethodDaoInstance;

  FabricDyingTechniqueDao? _fabricDyingTechniqueDaoInstance;

  FabricQualityDao? _fabricQualityDaoInstance;

  FabricGradesDao? _fabricGradesDaoInstance;

  FabricLoomDao? _fabricLoomDaoInstance;

  FabricSalvedgeDao? _fabricSalvedgeDaoInstance;

  FabricWeaveDao? _fabricWeaveDaoInstance;

  FabricLayyerDao? _fabricLayyerDaoInstance;

  YarnSettingDao? _yarnSettingsDaoInstance;

  YarnFamilyDao? _yarnFamilyDaoInstance;

  YarnBlendDao? _yarnBlendDaoInstance;

  YarnGradesDao? _yarnGradesDaoInstance;

  DoublingMethodDao? _doublingMethodDaoInstance;

  ColorTreatmentMethodDao? _colorTreatmentMethodDaoInstance;

  ConeTypeDao? _coneTypeDaoInstance;

  DyingMethodDao? _dyingMethodDaoInstance;

  OrientationDao? _orientationDaoInstance;

  PatternCharacteristicsDao? _patternCharDaoInstance;

  PatternDao? _patternDaoInstance;

  PlyDao? _plyDaoInstance;

  QualityDao? _qualityDaoInstance;

  SpunTechniqueDao? _spunTechDaoInstance;

  UsageDao? _usageDaoInstance;

  YarnTypesDao? _yarnTypesDaoInstance;

  YarnAppearanceDao? _yarnAppearanceDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback? callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 12,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `user_table` (`id` INTEGER, `name` TEXT, `username` TEXT, `telephoneNumber` TEXT, `operatorId` TEXT, `status` TEXT, `lastActive` TEXT, `fcmToken` TEXT, `otp` TEXT, `postalCode` TEXT, `countryId` TEXT, `cityStateId` TEXT, `profileStatus` TEXT, `email` TEXT, `emailVerifiedAt` TEXT, `company` TEXT, `companyId` TEXT, `ntn_number` TEXT, `user_country` TEXT, `city_state_name` TEXT, `roleId` TEXT, `apiToken` TEXT, `deletedAt` TEXT, `createdAt` TEXT, `updatedAt` TEXT, `businessInfo` TEXT, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `fiber_family` (`fiberFamilyId` INTEGER NOT NULL, `fiberFamilyCategoryIdFk` TEXT, `fiberFamilyParentId` TEXT, `fiberFamilyName` TEXT, `iconSelected` TEXT, `iconUnselected` TEXT, `fiberFamilyIsActive` TEXT, `fiberFamilySortId` TEXT, PRIMARY KEY (`fiberFamilyId`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `fiber_appearance` (`aprId` INTEGER, `aprCategoryIdfk` TEXT, `aprName` TEXT, `aprIsActive` TEXT, PRIMARY KEY (`aprId`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `fiber_available_market` (`afmId` INTEGER NOT NULL, `afmCategoryIdfk` TEXT NOT NULL, `afmName` TEXT NOT NULL, `afmIsActive` TEXT NOT NULL, PRIMARY KEY (`afmId`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `fiber_categories` (`catId` INTEGER NOT NULL, `catName` TEXT NOT NULL, `catIsActive` TEXT NOT NULL, PRIMARY KEY (`catId`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `fiber_blends` (`blnId` INTEGER, `blnCategoryIdfk` TEXT, `familyIdfk` TEXT, `blnNature` TEXT, `blnName` TEXT, `blnAbrv` TEXT, `minMax` TEXT, `blnRatioJson` TEXT, `iconSelected` TEXT, `iconUnselected` TEXT, `blnIsActive` TEXT, `blnSortid` TEXT, PRIMARY KEY (`blnId`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `brands` (`brdId` INTEGER NOT NULL, `brdName` TEXT, `brdIsVerified` TEXT, `brdFeatured` TEXT, `brdIcon` TEXT, `brdIsActive` TEXT, PRIMARY KEY (`brdId`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `countries` (`conId` INTEGER, `conName` TEXT, `countryIso` TEXT, `countryIso3` TEXT, `countryCurrencyName` TEXT, `countryCurrencyCode` TEXT, `countryCurrencySymbol` TEXT, `countryPhoneCode` TEXT, `countryContinent` TEXT, `countryStatus` TEXT, `mainFlagImage` TEXT, `extralarge` TEXT, `large` TEXT, `medium` TEXT, PRIMARY KEY (`conId`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `categories` (`catId` INTEGER, `catName` TEXT, PRIMARY KEY (`catId`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `certifications` (`cerId` INTEGER NOT NULL, `cerCategoryIdfk` TEXT, `cerName` TEXT, `cerIsActive` TEXT, PRIMARY KEY (`cerId`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `delivery_period` (`dprId` INTEGER NOT NULL, `dprCategoryIdfk` TEXT, `dprName` TEXT, `dprIsActive` TEXT, PRIMARY KEY (`dprId`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `units_table` (`untId` INTEGER NOT NULL, `untCategoryIdfk` TEXT, `unt_family_idfk` TEXT, `untName` TEXT, `untIsActive` TEXT, PRIMARY KEY (`untId`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `companies` (`id` INTEGER NOT NULL, `name` TEXT, `gst` TEXT, `address` TEXT, `countryId` TEXT, `cityStateId` TEXT, `zipCode` TEXT, `websiteUrl` TEXT, `whatsappNumber` TEXT, `wechatNumber` TEXT, `telephoneNumber` TEXT, `emailId` TEXT, `maxProduction` TEXT, `noOfUnits` TEXT, `yearEstablished` TEXT, `tradeCategory` TEXT, `licenseHolder` TEXT, `isVerified` TEXT, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `city_state` (`id` INTEGER NOT NULL, `countryId` TEXT, `name` TEXT, `code` TEXT, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `grade` (`grdId` INTEGER, `familyId` TEXT, `grdCategoryIdfk` TEXT, `grdName` TEXT, `grdIsActive` TEXT, PRIMARY KEY (`grdId`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `price_terms_table` (`ptrId` INTEGER NOT NULL, `ptrCategoryIdfk` TEXT, `ptr_locality` TEXT, `ptrName` TEXT, `ptrIsActive` TEXT, PRIMARY KEY (`ptrId`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `payment_type` (`payId` TEXT, `payPriceTerrmIdfk` TEXT, `ptrCountryIdfk` TEXT, `payName` TEXT, `payIsActive` TEXT, `parentId` TEXT, PRIMARY KEY (`payId`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `ports` (`prtId` INTEGER NOT NULL, `prtCountryIdfk` TEXT, `prtName` TEXT, `prtIsActive` TEXT, PRIMARY KEY (`prtId`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `fiber_setting` (`fbsId` INTEGER, `fbsCategoryIdfk` TEXT, `fbsFiberFamilyIdfk` TEXT, `fbsBlendIdfk` TEXT, `showLength` TEXT, `lengthMinMax` TEXT, `showGrade` TEXT, `showMicronaire` TEXT, `micMinMax` TEXT, `showMoisture` TEXT, `moiMinMax` TEXT, `showTrash` TEXT, `trashMinMax` TEXT, `showRd` TEXT, `rdMinMax` TEXT, `showGpt` TEXT, `gptMinMax` TEXT, `showAppearance` TEXT, `showColorTreatmentMethod` TEXT, `showBrand` TEXT, `showProductionYear` TEXT, `showOrigin` TEXT, `showCertification` TEXT, `showCountUnit` TEXT, `showDeliveryPeriod` TEXT, `showAvailableForMarket` TEXT, `showPriceTerms` TEXT, `showLotNumber` TEXT, `showRatio` TEXT, `fbsIsActive` TEXT, PRIMARY KEY (`fbsId`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `yarn_settings` (`ysId` INTEGER, `ysBlendIdfk` TEXT, `ysFamilyIdfk` TEXT, `showCount` TEXT, `countMinMax` TEXT, `showOrigin` TEXT, `showDannier` TEXT, `dannierMinMax` TEXT, `showFilament` TEXT, `filamentMinMax` TEXT, `showBlend` TEXT, `showPly` TEXT, `showSpunTechnique` TEXT, `showQuality` TEXT, `showGrade` TEXT, `showDoublingMethod` TEXT, `showCertification` TEXT, `showColorTreatmentMethod` TEXT, `showDyingMethod` TEXT, `showColor` TEXT, `showAppearance` TEXT, `showQlt` TEXT, `qltMinMax` TEXT, `showClsp` TEXT, `clspMinMax` TEXT, `showUniformity` TEXT, `uniformityMinMax` TEXT, `showCv` TEXT, `cvMinMax` TEXT, `showThinPlaces` TEXT, `thinPlacesMinMax` TEXT, `showtThickPlaces` TEXT, `thickPlacesMinMax` TEXT, `showNaps` TEXT, `napsMinMax` TEXT, `showIpmKm` TEXT, `ipmKmMinMax` TEXT, `showHairness` TEXT, `hairnessMinMax` TEXT, `showRkm` TEXT, `rkmMinMax` TEXT, `showElongation` TEXT, `elongationMinMax` TEXT, `showTpi` TEXT, `tpiMinMax` TEXT, `showTm` TEXT, `tmMinMax` TEXT, `showDty` TEXT, `dtyMinMax` TEXT, `showFdy` TEXT, `fdyMinMax` TEXT, `showRatio` TEXT, `showTexturized` TEXT, `showUsage` TEXT, `showPattern` TEXT, `showPatternCharectristic` TEXT, `showOrientation` TEXT, `showTwistDirection` TEXT, `ysIsActive` TEXT, `ysSortid` TEXT, `show_actual_count` TEXT, `actual_count_min_max` TEXT, PRIMARY KEY (`ysId`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `yarn_family` (`famId` INTEGER, `famName` TEXT, `iconSelected` TEXT, `iconUnSelected` TEXT, `famType` TEXT, `famDescription` TEXT, `catIsActive` TEXT, PRIMARY KEY (`famId`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `yarn_blend` (`blnId` INTEGER, `familyIdfk` TEXT, `blnName` TEXT, `bln_category_idfk` TEXT, `bln_nature` TEXT, `bln_abrv` TEXT, `minMax` TEXT, `has_blend_id_1` TEXT, `has_blend_id_2` TEXT, `has_blend_name_1` TEXT, `has_blend_name_2` TEXT, `is_popular` TEXT, `iconSelected` TEXT, `iconUnselected` TEXT, `blnIsActive` TEXT, `blnSortid` TEXT, `bln_ratio_json` TEXT, `isSelected` INTEGER, `blendRatio` TEXT, PRIMARY KEY (`blnId`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `fabric_settings` (`fabricSettingId` INTEGER, `fabricFamilyIdfk` TEXT, `showCount` TEXT, `countMinMax` TEXT, `showPly` TEXT, `showBlend` TEXT, `showGsm` TEXT, `gsmCountMinMax` TEXT, `showRatio` TEXT, `showKnittingType` TEXT, `showAppearance` TEXT, `showColorTreatmentMethod` TEXT, `showDyingMethod` TEXT, `showColor` TEXT, `showQuality` TEXT, `showGrade` TEXT, `showCertification` TEXT, `showWarpCount` TEXT, `warpCountMinMax` TEXT, `showWarpPly` TEXT, `showNoOfEndsWarp` TEXT, `noOfEndsWarpMinMax` TEXT, `showWeftCount` TEXT, `weftCountMinMax` TEXT, `showWeftPly` TEXT, `showNoOfPickWeft` TEXT, `noOfPickWeftMinMax` TEXT, `showWidth` TEXT, `widthMinMax` TEXT, `showWeave` TEXT, `showLoom` TEXT, `showSalvedge` TEXT, `showTuckinWidth` TEXT, `showTuckinWidthMinMax` TEXT, `showOnce` TEXT, `onceMinMax` TEXT, `showLayyer` TEXT, `showWeavePatternes` TEXT, `showDenimType` TEXT, `fabricSettingIsActive` TEXT, `fabricSettingSortid` TEXT, PRIMARY KEY (`fabricSettingId`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `fabric_family` (`fabricFamilyId` INTEGER, `fabricFamilyName` TEXT, `iconSelected` TEXT, `iconUnselected` TEXT, `fabricFamilyType` TEXT, `fabricFamilyDescription` TEXT, `fabricFamilyActive` TEXT, `fabricFamilySortid` TEXT, PRIMARY KEY (`fabricFamilyId`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `fabric_blends` (`blnId` INTEGER, `blnCategoryIdfk` TEXT, `familyIdfk` TEXT, `blnName` TEXT, `blnAbrv` TEXT, `minMax` TEXT, `has_blend_id_1` TEXT, `has_blend_id_2` TEXT, `has_blend_name_1` TEXT, `has_blend_name_2` TEXT, `is_popular` TEXT, `iconSelected` TEXT, `iconUnselected` TEXT, `blnIsActive` TEXT, `blnSortid` TEXT, `blnNature` TEXT, `bln_ratio_json` TEXT, `isSelected` INTEGER, `blendRatio` TEXT, PRIMARY KEY (`blnId`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `fabric_denim_types` (`fabricDenimTypeId` INTEGER, `fabricDenimTypeName` TEXT, `fabricFamilyIdfk` TEXT, PRIMARY KEY (`fabricDenimTypeId`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `fabric_appearance` (`fabricAppearanceId` INTEGER, `fabricAppearanceName` TEXT, `fabricAppearanceSortid` TEXT, `fabricAppearanceIsActive` TEXT, `fabricFamilyIdfk` TEXT, PRIMARY KEY (`fabricAppearanceId`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `knitting_types` (`fabricKnittingTypeId` INTEGER, `fabricKnittingTypeName` TEXT, `fabricFamilyIdfk` TEXT, PRIMARY KEY (`fabricKnittingTypeId`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `fabric_ply` (`fabricPlyId` INTEGER, `fabricFamilyIdfk` TEXT, `fabricPlyType` TEXT, `fabricPlyName` TEXT, `fabricPlyDescription` TEXT, `fabricPlyIsActive` TEXT, `fabricPlySortid` TEXT, PRIMARY KEY (`fabricPlyId`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `fiber_color_treatment_method` (`fctmId` INTEGER, `fabricFamilyIdfk` TEXT, `fctmName` TEXT, `fctmDescription` TEXT, `fctmIsActive` TEXT, `fctmSortid` TEXT, PRIMARY KEY (`fctmId`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `fabric_dying_techniques` (`fdtId` INTEGER, `fctmIdfk` TEXT, `fabricFamilyIdfk` TEXT, `fdtName` TEXT, `fdtIsActive` TEXT, `fdtSortid` TEXT, PRIMARY KEY (`fdtId`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `fabric_quality` (`fabricQualityId` INTEGER, `fabricQualityName` TEXT, `fabricFamilyIdfk` TEXT, PRIMARY KEY (`fabricQualityId`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `fabric_grades` (`fabricGradeId` INTEGER, `fabricGradeName` TEXT, `fabricFamilyIdfk` TEXT, PRIMARY KEY (`fabricGradeId`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `fabric_loom` (`fabricLoomId` INTEGER, `fabricLoomName` TEXT, `fabricFamilyIdfk` TEXT, PRIMARY KEY (`fabricLoomId`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `fabric_salvedge` (`fabricSalvedgeId` INTEGER, `fabricSalvedgeName` TEXT, `fabricFamilyIdfk` TEXT, PRIMARY KEY (`fabricSalvedgeId`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `fabric_weave` (`fabricWeaveId` INTEGER, `fabricWeaveName` TEXT, `fabricFamilyIdfk` TEXT, PRIMARY KEY (`fabricWeaveId`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `fabric_layyer` (`fabricLayyerId` INTEGER, `fabricLayyerName` TEXT, `fabricFamilyIdfk` TEXT, PRIMARY KEY (`fabricLayyerId`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `color_treatment_method` (`yctmId` INTEGER, `familyId` TEXT, `yctmName` TEXT, `yctmColorMethodIdfk` TEXT, `yctmDescription` TEXT, `yctmIsActive` TEXT, `yctmSortid` TEXT, PRIMARY KEY (`yctmId`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `cone_type` (`yctId` INTEGER, `familyId` TEXT, `ctCategoryIdfk` TEXT, `yctName` TEXT, `yctDescription` TEXT, `yctIsActive` TEXT, `yctSortid` TEXT, PRIMARY KEY (`yctId`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `doubling_method` (`dmId` INTEGER, `plyId` TEXT, `dmName` TEXT, `catIsActive` TEXT, `catSortid` TEXT, PRIMARY KEY (`dmId`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `dying_method` (`ydmId` INTEGER, `apperanceId` TEXT, `ydmName` TEXT, `ydmType` TEXT, `ydmColorTreatmentMethodIdfk` TEXT, `ydmDescription` TEXT, `ydmIsActive` TEXT, `ydmSortid` TEXT, PRIMARY KEY (`ydmId`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `yarn_grades` (`grdId` INTEGER, `familyId` TEXT, `blendId` TEXT, `grdCategoryIdfk` TEXT, `grdName` TEXT, `grdIsActive` TEXT, `grdSortid` TEXT, PRIMARY KEY (`grdId`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `fiber_appearance` (`aprId` INTEGER, `aprCategoryIdfk` TEXT, `aprName` TEXT, `aprIsActive` TEXT, PRIMARY KEY (`aprId`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `yarn_appearance` (`yaId` INTEGER, `familyId` TEXT, `usageId` TEXT, `yaName` TEXT, `yaIsActive` TEXT, `catSortid` TEXT, PRIMARY KEY (`yaId`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `orientation_table` (`yoId` INTEGER, `familyId` TEXT, `yoName` TEXT, `yoDescription` TEXT, `yoIsActive` TEXT, `catSortid` TEXT, PRIMARY KEY (`yoId`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `pattern_characteristics_table` (`ypcId` INTEGER, `ypcName` TEXT, `ypcPatternIdfk` TEXT, `ypcDescription` TEXT, `ypcIsActive` TEXT, `ypcSortid` TEXT, PRIMARY KEY (`ypcId`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `pattern_table` (`ypId` INTEGER, `familyId` TEXT, `ypName` TEXT, `spun_technique_id` TEXT, `ypDescription` TEXT, `ypIsActive` TEXT, `catSortid` TEXT, PRIMARY KEY (`ypId`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `ply_table` (`plyId` INTEGER, `familyId` TEXT, `plyName` TEXT, `plyDescription` TEXT, `catIsActive` TEXT, `catSortid` TEXT, PRIMARY KEY (`plyId`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `quality_table` (`yqId` INTEGER, `familyId` TEXT, `yqName` TEXT, `yqAbrv` TEXT, `spun_technique_id` TEXT, `yqBlendIdfk` TEXT, `yqDescription` TEXT, `yqIsActive` TEXT, `yqSortid` TEXT, PRIMARY KEY (`yqId`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `spun_technique` (`ystId` INTEGER, `familyId` TEXT, `orientationId` TEXT, `ystName` TEXT, `ystBlendIdfd` TEXT, `ystDescription` TEXT, `ystIsActive` TEXT, `ystSortid` TEXT, PRIMARY KEY (`ystId`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `usage_table` (`yuId` INTEGER, `ysFamilyId` TEXT, `yuName` TEXT, `yuDescription` TEXT, `yuIsActive` TEXT, `yuSortid` TEXT, PRIMARY KEY (`yuId`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `yarn_types_table` (`ytId` INTEGER, `ytBlendIdfk` TEXT, `ytName` TEXT, `dannierRange` TEXT, `filamentRange` TEXT, `ytIsActive` TEXT, `ytSortid` TEXT, PRIMARY KEY (`ytId`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `stocklots_family` (`stocklotFamilyId` INTEGER, `stocklotFamilyParentId` TEXT, `stocklotFamilyName` TEXT, `stocklotFamilyActive` TEXT, `stocklotFamilySortid` TEXT, PRIMARY KEY (`stocklotFamilyId`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  UserDao get userDao {
    return _userDaoInstance ??= _$UserDao(database, changeListener);
  }

  @override
  FiberSettingDao get fiberSettingDao {
    return _fiberSettingDaoInstance ??=
        _$FiberSettingDao(database, changeListener);
  }

  @override
  FiberFamilyDao get fiberFamilyDao {
    return _fiberFamilyDaoInstance ??=
        _$FiberFamilyDao(database, changeListener);
  }

  @override
  FiberBlendsDao get fiberBlendsDao {
    return _fiberBlendsDaoInstance ??=
        _$FiberBlendsDao(database, changeListener);
  }

  @override
  FiberAppearanceDao get fiberAppearanceDoa {
    return _fiberAppearanceDoaInstance ??=
        _$FiberAppearanceDao(database, changeListener);
  }

  @override
  GradesDao get gradesDao {
    return _gradesDaoInstance ??= _$GradesDao(database, changeListener);
  }

  @override
  BrandsDao get brandsDao {
    return _brandsDaoInstance ??= _$BrandsDao(database, changeListener);
  }

  @override
  CertificationsDao get certificationDao {
    return _certificationDaoInstance ??=
        _$CertificationsDao(database, changeListener);
  }

  @override
  CityStateDao get cityStateDao {
    return _cityStateDaoInstance ??= _$CityStateDao(database, changeListener);
  }

  @override
  CompaniesDao get companiesDao {
    return _companiesDaoInstance ??= _$CompaniesDao(database, changeListener);
  }

  @override
  CountryDao get countriesDao {
    return _countriesDaoInstance ??= _$CountryDao(database, changeListener);
  }

  @override
  CategoryDao get categoriesDao {
    return _categoriesDaoInstance ??= _$CategoryDao(database, changeListener);
  }

  @override
  DeliveryPeriodDao get deliveryPeriodDao {
    return _deliveryPeriodDaoInstance ??=
        _$DeliveryPeriodDao(database, changeListener);
  }

  @override
  PaymentTypeDao get paymentTypeDao {
    return _paymentTypeDaoInstance ??=
        _$PaymentTypeDao(database, changeListener);
  }

  @override
  PortsDao get portsDao {
    return _portsDaoInstance ??= _$PortsDao(database, changeListener);
  }

  @override
  PriceTermsDao get priceTermsDao {
    return _priceTermsDaoInstance ??= _$PriceTermsDao(database, changeListener);
  }

  @override
  UnitDao get unitDao {
    return _unitDaoInstance ??= _$UnitDao(database, changeListener);
  }

  @override
  StocklotFamilyDao get stocklotCategoriesDao {
    return _stocklotCategoriesDaoInstance ??=
        _$StocklotFamilyDao(database, changeListener);
  }

  @override
  FabricSettingDao get fabricSettingDao {
    return _fabricSettingDaoInstance ??=
        _$FabricSettingDao(database, changeListener);
  }

  @override
  FabricFamilyDao get fabricFamilyDao {
    return _fabricFamilyDaoInstance ??=
        _$FabricFamilyDao(database, changeListener);
  }

  @override
  FabricBlendsDao get fabricBlendsDao {
    return _fabricBlendsDaoInstance ??=
        _$FabricBlendsDao(database, changeListener);
  }

  @override
  FabricDenimTypesDao get fabricDenimTypesDao {
    return _fabricDenimTypesDaoInstance ??=
        _$FabricDenimTypesDao(database, changeListener);
  }

  @override
  FabricAppearanceDao get fabricAppearanceDao {
    return _fabricAppearanceDaoInstance ??=
        _$FabricAppearanceDao(database, changeListener);
  }

  @override
  KnittingTypesDao get knittingTypesDao {
    return _knittingTypesDaoInstance ??=
        _$KnittingTypesDao(database, changeListener);
  }

  @override
  FabricPlyDao get fabricPlyDao {
    return _fabricPlyDaoInstance ??= _$FabricPlyDao(database, changeListener);
  }

  @override
  FabricColorTreatmentMethodDao get fabricColorTreatmentMethodDao {
    return _fabricColorTreatmentMethodDaoInstance ??=
        _$FabricColorTreatmentMethodDao(database, changeListener);
  }

  @override
  FabricDyingTechniqueDao get fabricDyingTechniqueDao {
    return _fabricDyingTechniqueDaoInstance ??=
        _$FabricDyingTechniqueDao(database, changeListener);
  }

  @override
  FabricQualityDao get fabricQualityDao {
    return _fabricQualityDaoInstance ??=
        _$FabricQualityDao(database, changeListener);
  }

  @override
  FabricGradesDao get fabricGradesDao {
    return _fabricGradesDaoInstance ??=
        _$FabricGradesDao(database, changeListener);
  }

  @override
  FabricLoomDao get fabricLoomDao {
    return _fabricLoomDaoInstance ??= _$FabricLoomDao(database, changeListener);
  }

  @override
  FabricSalvedgeDao get fabricSalvedgeDao {
    return _fabricSalvedgeDaoInstance ??=
        _$FabricSalvedgeDao(database, changeListener);
  }

  @override
  FabricWeaveDao get fabricWeaveDao {
    return _fabricWeaveDaoInstance ??=
        _$FabricWeaveDao(database, changeListener);
  }

  @override
  FabricLayyerDao get fabricLayyerDao {
    return _fabricLayyerDaoInstance ??=
        _$FabricLayyerDao(database, changeListener);
  }

  @override
  YarnSettingDao get yarnSettingsDao {
    return _yarnSettingsDaoInstance ??=
        _$YarnSettingDao(database, changeListener);
  }

  @override
  YarnFamilyDao get yarnFamilyDao {
    return _yarnFamilyDaoInstance ??= _$YarnFamilyDao(database, changeListener);
  }

  @override
  YarnBlendDao get yarnBlendDao {
    return _yarnBlendDaoInstance ??= _$YarnBlendDao(database, changeListener);
  }

  @override
  YarnGradesDao get yarnGradesDao {
    return _yarnGradesDaoInstance ??= _$YarnGradesDao(database, changeListener);
  }

  @override
  DoublingMethodDao get doublingMethodDao {
    return _doublingMethodDaoInstance ??=
        _$DoublingMethodDao(database, changeListener);
  }

  @override
  ColorTreatmentMethodDao get colorTreatmentMethodDao {
    return _colorTreatmentMethodDaoInstance ??=
        _$ColorTreatmentMethodDao(database, changeListener);
  }

  @override
  ConeTypeDao get coneTypeDao {
    return _coneTypeDaoInstance ??= _$ConeTypeDao(database, changeListener);
  }

  @override
  DyingMethodDao get dyingMethodDao {
    return _dyingMethodDaoInstance ??=
        _$DyingMethodDao(database, changeListener);
  }

  @override
  OrientationDao get orientationDao {
    return _orientationDaoInstance ??=
        _$OrientationDao(database, changeListener);
  }

  @override
  PatternCharacteristicsDao get patternCharDao {
    return _patternCharDaoInstance ??=
        _$PatternCharacteristicsDao(database, changeListener);
  }

  @override
  PatternDao get patternDao {
    return _patternDaoInstance ??= _$PatternDao(database, changeListener);
  }

  @override
  PlyDao get plyDao {
    return _plyDaoInstance ??= _$PlyDao(database, changeListener);
  }

  @override
  QualityDao get qualityDao {
    return _qualityDaoInstance ??= _$QualityDao(database, changeListener);
  }

  @override
  SpunTechniqueDao get spunTechDao {
    return _spunTechDaoInstance ??=
        _$SpunTechniqueDao(database, changeListener);
  }

  @override
  UsageDao get usageDao {
    return _usageDaoInstance ??= _$UsageDao(database, changeListener);
  }

  @override
  YarnTypesDao get yarnTypesDao {
    return _yarnTypesDaoInstance ??= _$YarnTypesDao(database, changeListener);
  }

  @override
  YarnAppearanceDao get yarnAppearanceDao {
    return _yarnAppearanceDaoInstance ??=
        _$YarnAppearanceDao(database, changeListener);
  }
}

class _$UserDao extends UserDao {
  _$UserDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _userInsertionAdapter = InsertionAdapter(
            database,
            'user_table',
            (User item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'username': item.username,
                  'telephoneNumber': item.telephoneNumber,
                  'operatorId': item.operatorId,
                  'status': item.status,
                  'lastActive': item.lastActive,
                  'fcmToken': item.fcmToken,
                  'otp': item.otp,
                  'postalCode': item.postalCode,
                  'countryId': item.countryId,
                  'cityStateId': item.cityStateId,
                  'profileStatus': item.profileStatus,
                  'email': item.email,
                  'emailVerifiedAt': item.emailVerifiedAt,
                  'company': item.company,
                  'companyId': item.companyId,
                  'ntn_number': item.ntn_number,
                  'user_country': item.user_country,
                  'city_state_name': item.city_state_name,
                  'roleId': item.roleId,
                  'apiToken': item.apiToken,
                  'deletedAt': item.deletedAt,
                  'createdAt': item.createdAt,
                  'updatedAt': item.updatedAt,
                  'businessInfo': item.businessInfo
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<User> _userInsertionAdapter;

  @override
  Future<User?> getUser() async {
    return _queryAdapter.query('SELECT * FROM user_table',
        mapper: (Map<String, Object?> row) => User(
            id: row['id'] as int?,
            name: row['name'] as String?,
            username: row['username'] as String?,
            telephoneNumber: row['telephoneNumber'] as String?,
            operatorId: row['operatorId'] as String?,
            status: row['status'] as String?,
            lastActive: row['lastActive'] as String?,
            fcmToken: row['fcmToken'] as String?,
            otp: row['otp'] as String?,
            postalCode: row['postalCode'] as String?,
            countryId: row['countryId'] as String?,
            cityStateId: row['cityStateId'] as String?,
            profileStatus: row['profileStatus'] as String?,
            email: row['email'] as String?,
            emailVerifiedAt: row['emailVerifiedAt'] as String?,
            company: row['company'] as String?,
            ntn_number: row['ntn_number'] as String?,
            user_country: row['user_country'] as String?,
            city_state_name: row['city_state_name'] as String?,
            roleId: row['roleId'] as String?,
            apiToken: row['apiToken'] as String?,
            deletedAt: row['deletedAt'] as String?,
            createdAt: row['createdAt'] as String?,
            updatedAt: row['updatedAt'] as String?,
            businessInfo: row['businessInfo'] as String?));
  }

  @override
  Future<void> deleteUserData() async {
    await _queryAdapter.queryNoReturn('delete FROM user_table');
  }

  @override
  Future<void> insertUser(User user) async {
    await _userInsertionAdapter.insert(user, OnConflictStrategy.replace);
  }
}

class _$FiberSettingDao extends FiberSettingDao {
  _$FiberSettingDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _fiberSettingsInsertionAdapter = InsertionAdapter(
            database,
            'fiber_setting',
            (FiberSettings item) => <String, Object?>{
                  'fbsId': item.fbsId,
                  'fbsCategoryIdfk': item.fbsCategoryIdfk,
                  'fbsFiberFamilyIdfk': item.fbsFiberFamilyIdfk,
                  'fbsBlendIdfk': item.fbsBlendIdfk,
                  'showLength': item.showLength,
                  'lengthMinMax': item.lengthMinMax,
                  'showGrade': item.showGrade,
                  'showMicronaire': item.showMicronaire,
                  'micMinMax': item.micMinMax,
                  'showMoisture': item.showMoisture,
                  'moiMinMax': item.moiMinMax,
                  'showTrash': item.showTrash,
                  'trashMinMax': item.trashMinMax,
                  'showRd': item.showRd,
                  'rdMinMax': item.rdMinMax,
                  'showGpt': item.showGpt,
                  'gptMinMax': item.gptMinMax,
                  'showAppearance': item.showAppearance,
                  'showColorTreatmentMethod': item.showColorTreatmentMethod,
                  'showBrand': item.showBrand,
                  'showProductionYear': item.showProductionYear,
                  'showOrigin': item.showOrigin,
                  'showCertification': item.showCertification,
                  'showCountUnit': item.showCountUnit,
                  'showDeliveryPeriod': item.showDeliveryPeriod,
                  'showAvailableForMarket': item.showAvailableForMarket,
                  'showPriceTerms': item.showPriceTerms,
                  'showLotNumber': item.showLotNumber,
                  'showRatio': item.showRatio,
                  'fbsIsActive': item.fbsIsActive
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<FiberSettings> _fiberSettingsInsertionAdapter;

  @override
  Future<List<FiberSettings>> findAllFiberSettings() async {
    return _queryAdapter.queryList('SELECT * FROM fiber_setting',
        mapper: (Map<String, Object?> row) => FiberSettings(
            fbsId: row['fbsId'] as int?,
            fbsCategoryIdfk: row['fbsCategoryIdfk'] as String?,
            fbsFiberFamilyIdfk: row['fbsFiberFamilyIdfk'] as String?,
            fbsBlendIdfk: row['fbsBlendIdfk'] as String?,
            showLength: row['showLength'] as String?,
            lengthMinMax: row['lengthMinMax'] as String?,
            showGrade: row['showGrade'] as String?,
            showMicronaire: row['showMicronaire'] as String?,
            micMinMax: row['micMinMax'] as String?,
            showMoisture: row['showMoisture'] as String?,
            moiMinMax: row['moiMinMax'] as String?,
            showTrash: row['showTrash'] as String?,
            trashMinMax: row['trashMinMax'] as String?,
            showRd: row['showRd'] as String?,
            rdMinMax: row['rdMinMax'] as String?,
            showGpt: row['showGpt'] as String?,
            gptMinMax: row['gptMinMax'] as String?,
            showAppearance: row['showAppearance'] as String?,
            showColorTreatmentMethod:
                row['showColorTreatmentMethod'] as String?,
            showBrand: row['showBrand'] as String?,
            showProductionYear: row['showProductionYear'] as String?,
            showOrigin: row['showOrigin'] as String?,
            showCertification: row['showCertification'] as String?,
            showCountUnit: row['showCountUnit'] as String?,
            showDeliveryPeriod: row['showDeliveryPeriod'] as String?,
            showAvailableForMarket: row['showAvailableForMarket'] as String?,
            showPriceTerms: row['showPriceTerms'] as String?,
            showLotNumber: row['showLotNumber'] as String?,
            showRatio: row['showRatio'] as String?,
            fbsIsActive: row['fbsIsActive'] as String?));
  }

  @override
  Future<FiberSettings?> findFiberSettings(int id) async {
    return _queryAdapter.query(
        'SELECT * FROM fiber_setting where fbsBlendIdfk = ?1',
        mapper: (Map<String, Object?> row) => FiberSettings(
            fbsId: row['fbsId'] as int?,
            fbsCategoryIdfk: row['fbsCategoryIdfk'] as String?,
            fbsFiberFamilyIdfk: row['fbsFiberFamilyIdfk'] as String?,
            fbsBlendIdfk: row['fbsBlendIdfk'] as String?,
            showLength: row['showLength'] as String?,
            lengthMinMax: row['lengthMinMax'] as String?,
            showGrade: row['showGrade'] as String?,
            showMicronaire: row['showMicronaire'] as String?,
            micMinMax: row['micMinMax'] as String?,
            showMoisture: row['showMoisture'] as String?,
            moiMinMax: row['moiMinMax'] as String?,
            showTrash: row['showTrash'] as String?,
            trashMinMax: row['trashMinMax'] as String?,
            showRd: row['showRd'] as String?,
            rdMinMax: row['rdMinMax'] as String?,
            showGpt: row['showGpt'] as String?,
            gptMinMax: row['gptMinMax'] as String?,
            showAppearance: row['showAppearance'] as String?,
            showColorTreatmentMethod:
                row['showColorTreatmentMethod'] as String?,
            showBrand: row['showBrand'] as String?,
            showProductionYear: row['showProductionYear'] as String?,
            showOrigin: row['showOrigin'] as String?,
            showCertification: row['showCertification'] as String?,
            showCountUnit: row['showCountUnit'] as String?,
            showDeliveryPeriod: row['showDeliveryPeriod'] as String?,
            showAvailableForMarket: row['showAvailableForMarket'] as String?,
            showPriceTerms: row['showPriceTerms'] as String?,
            showLotNumber: row['showLotNumber'] as String?,
            showRatio: row['showRatio'] as String?,
            fbsIsActive: row['fbsIsActive'] as String?),
        arguments: [id]);
  }

  @override
  Future<void> deleteFiberSetting(int id) async {
    await _queryAdapter.queryNoReturn('delete from fiber_setting where id = ?1',
        arguments: [id]);
  }

  @override
  Future<void> deleteAll() async {
    await _queryAdapter.queryNoReturn('delete from fiber_setting');
  }

  @override
  Future<void> insertFiberSetting(FiberSettings fiberSettings) async {
    await _fiberSettingsInsertionAdapter.insert(
        fiberSettings, OnConflictStrategy.replace);
  }

  @override
  Future<List<int>> insertAllFiberSettings(List<FiberSettings> fiberSettings) {
    return _fiberSettingsInsertionAdapter.insertListAndReturnIds(
        fiberSettings, OnConflictStrategy.replace);
  }
}

class _$FiberFamilyDao extends FiberFamilyDao {
  _$FiberFamilyDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _fiberFamilyInsertionAdapter = InsertionAdapter(
            database,
            'fiber_family',
            (FiberFamily item) => <String, Object?>{
                  'fiberFamilyId': item.fiberFamilyId,
                  'fiberFamilyCategoryIdFk': item.fiberFamilyCategoryIdFk,
                  'fiberFamilyParentId': item.fiberFamilyParentId,
                  'fiberFamilyName': item.fiberFamilyName,
                  'iconSelected': item.iconSelected,
                  'iconUnselected': item.iconUnselected,
                  'fiberFamilyIsActive': item.fiberFamilyIsActive,
                  'fiberFamilySortId': item.fiberFamilySortId
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<FiberFamily> _fiberFamilyInsertionAdapter;

  @override
  Future<List<FiberFamily>> findAllFiberNatures() async {
    return _queryAdapter.queryList('SELECT * FROM fiber_family',
        mapper: (Map<String, Object?> row) => FiberFamily(
            fiberFamilyId: row['fiberFamilyId'] as int,
            fiberFamilyCategoryIdFk: row['fiberFamilyCategoryIdFk'] as String?,
            fiberFamilyParentId: row['fiberFamilyParentId'] as String?,
            fiberFamilyName: row['fiberFamilyName'] as String?,
            iconSelected: row['iconSelected'] as String?,
            iconUnselected: row['iconUnselected'] as String?,
            fiberFamilyIsActive: row['fiberFamilyIsActive'] as String?,
            fiberFamilySortId: row['fiberFamilySortId'] as String?));
  }

  @override
  Future<List<FiberFamily>> findFiberNatures(int id) async {
    return _queryAdapter.queryList('SELECT * FROM fiber_family where id = ?1',
        mapper: (Map<String, Object?> row) => FiberFamily(
            fiberFamilyId: row['fiberFamilyId'] as int,
            fiberFamilyCategoryIdFk: row['fiberFamilyCategoryIdFk'] as String?,
            fiberFamilyParentId: row['fiberFamilyParentId'] as String?,
            fiberFamilyName: row['fiberFamilyName'] as String?,
            iconSelected: row['iconSelected'] as String?,
            iconUnselected: row['iconUnselected'] as String?,
            fiberFamilyIsActive: row['fiberFamilyIsActive'] as String?,
            fiberFamilySortId: row['fiberFamilySortId'] as String?),
        arguments: [id]);
  }

  @override
  Future<void> deleteAll() async {
    await _queryAdapter.queryNoReturn('delete from fiber_family');
  }

  @override
  Future<List<int>> insertAllFiberNatures(List<FiberFamily> fiberNature) {
    return _fiberFamilyInsertionAdapter.insertListAndReturnIds(
        fiberNature, OnConflictStrategy.replace);
  }
}

class _$FiberBlendsDao extends FiberBlendsDao {
  _$FiberBlendsDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _fiberBlendsInsertionAdapter = InsertionAdapter(
            database,
            'fiber_blends',
            (FiberBlends item) => <String, Object?>{
                  'blnId': item.blnId,
                  'blnCategoryIdfk': item.blnCategoryIdfk,
                  'familyIdfk': item.familyIdfk,
                  'blnNature': item.blnNature,
                  'blnName': item.blnName,
                  'blnAbrv': item.blnAbrv,
                  'minMax': item.minMax,
                  'blnRatioJson': item.blnRatioJson,
                  'iconSelected': item.iconSelected,
                  'iconUnselected': item.iconUnselected,
                  'blnIsActive': item.blnIsActive,
                  'blnSortid': item.blnSortid
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<FiberBlends> _fiberBlendsInsertionAdapter;

  @override
  Future<List<FiberBlends>> findAllFiberBlends() async {
    return _queryAdapter.queryList('SELECT * FROM fiber_blends',
        mapper: (Map<String, Object?> row) => FiberBlends(
            blnId: row['blnId'] as int?,
            blnCategoryIdfk: row['blnCategoryIdfk'] as String?,
            familyIdfk: row['familyIdfk'] as String?,
            blnNature: row['blnNature'] as String?,
            blnName: row['blnName'] as String?,
            blnAbrv: row['blnAbrv'] as String?,
            minMax: row['minMax'] as String?,
            blnRatioJson: row['blnRatioJson'] as String?,
            iconSelected: row['iconSelected'] as String?,
            iconUnselected: row['iconUnselected'] as String?,
            blnIsActive: row['blnIsActive'] as String?,
            blnSortid: row['blnSortid'] as String?));
  }

  @override
  Future<List<FiberBlends>> findFiberBlend(int id) async {
    return _queryAdapter.queryList(
        'SELECT * FROM fiber_blends where familyIdfk = ?1',
        mapper: (Map<String, Object?> row) => FiberBlends(
            blnId: row['blnId'] as int?,
            blnCategoryIdfk: row['blnCategoryIdfk'] as String?,
            familyIdfk: row['familyIdfk'] as String?,
            blnNature: row['blnNature'] as String?,
            blnName: row['blnName'] as String?,
            blnAbrv: row['blnAbrv'] as String?,
            minMax: row['minMax'] as String?,
            blnRatioJson: row['blnRatioJson'] as String?,
            iconSelected: row['iconSelected'] as String?,
            iconUnselected: row['iconUnselected'] as String?,
            blnIsActive: row['blnIsActive'] as String?,
            blnSortid: row['blnSortid'] as String?),
        arguments: [id]);
  }

  @override
  Future<List<FiberBlends>> findFiberBlendWithNature(int id) async {
    return _queryAdapter.queryList(
        'SELECT * FROM fiber_blends where familyIdfk = ?1',
        mapper: (Map<String, Object?> row) => FiberBlends(
            blnId: row['blnId'] as int?,
            blnCategoryIdfk: row['blnCategoryIdfk'] as String?,
            familyIdfk: row['familyIdfk'] as String?,
            blnNature: row['blnNature'] as String?,
            blnName: row['blnName'] as String?,
            blnAbrv: row['blnAbrv'] as String?,
            minMax: row['minMax'] as String?,
            blnRatioJson: row['blnRatioJson'] as String?,
            iconSelected: row['iconSelected'] as String?,
            iconUnselected: row['iconUnselected'] as String?,
            blnIsActive: row['blnIsActive'] as String?,
            blnSortid: row['blnSortid'] as String?),
        arguments: [id]);
  }

  @override
  Future<void> deleteAll() async {
    await _queryAdapter.queryNoReturn('delete from fiber_blends');
  }

  @override
  Future<List<int>> insertAllFiberBlends(List<FiberBlends> fiberMaterials) {
    return _fiberBlendsInsertionAdapter.insertListAndReturnIds(
        fiberMaterials, OnConflictStrategy.replace);
  }
}

class _$FiberAppearanceDao extends FiberAppearanceDao {
  _$FiberAppearanceDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _fiberAppearanceInsertionAdapter = InsertionAdapter(
            database,
            'fiber_appearance',
            (FiberAppearance item) => <String, Object?>{
                  'aprId': item.aprId,
                  'aprCategoryIdfk': item.aprCategoryIdfk,
                  'aprName': item.aprName,
                  'aprIsActive': item.aprIsActive
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<FiberAppearance> _fiberAppearanceInsertionAdapter;

  @override
  Future<List<FiberAppearance>> findAllFiberAppearance() async {
    return _queryAdapter.queryList('SELECT * FROM fiber_appearance',
        mapper: (Map<String, Object?> row) => FiberAppearance(
            aprId: row['aprId'] as int?,
            aprCategoryIdfk: row['aprCategoryIdfk'] as String?,
            aprName: row['aprName'] as String?,
            aprIsActive: row['aprIsActive'] as String?));
  }

  @override
  Future<List<FiberAppearance>> findFiberAppearance(int id) async {
    return _queryAdapter.queryList(
        'SELECT * FROM fiber_appearance where aprId = ?1',
        mapper: (Map<String, Object?> row) => FiberAppearance(
            aprId: row['aprId'] as int?,
            aprCategoryIdfk: row['aprCategoryIdfk'] as String?,
            aprName: row['aprName'] as String?,
            aprIsActive: row['aprIsActive'] as String?),
        arguments: [id]);
  }

  @override
  Future<void> deleteAll() async {
    await _queryAdapter.queryNoReturn('delete from fiber_appearance');
  }

  @override
  Future<List<int>> insertAllFiberAppearance(
      List<FiberAppearance> fiberAppearance) {
    return _fiberAppearanceInsertionAdapter.insertListAndReturnIds(
        fiberAppearance, OnConflictStrategy.replace);
  }
}

class _$GradesDao extends GradesDao {
  _$GradesDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _gradesInsertionAdapter = InsertionAdapter(
            database,
            'grade',
            (Grades item) => <String, Object?>{
                  'grdId': item.grdId,
                  'familyId': item.familyId,
                  'grdCategoryIdfk': item.grdCategoryIdfk,
                  'grdName': item.grdName,
                  'grdIsActive': item.grdIsActive
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Grades> _gradesInsertionAdapter;

  @override
  Future<List<Grades>> findAllGrades() async {
    return _queryAdapter.queryList('SELECT * FROM grade',
        mapper: (Map<String, Object?> row) => Grades(
            grdId: row['grdId'] as int?,
            grdCategoryIdfk: row['grdCategoryIdfk'] as String?,
            grdName: row['grdName'] as String?,
            grdIsActive: row['grdIsActive'] as String?));
  }

  @override
  Future<List<Grades>> findGradeWithCatId(int id) async {
    return _queryAdapter.queryList(
        'SELECT * FROM grade where grdCategoryIdfk = ?1',
        mapper: (Map<String, Object?> row) => Grades(
            grdId: row['grdId'] as int?,
            grdCategoryIdfk: row['grdCategoryIdfk'] as String?,
            grdName: row['grdName'] as String?,
            grdIsActive: row['grdIsActive'] as String?),
        arguments: [id]);
  }

  @override
  Future<void> deleteGrade(int id) async {
    await _queryAdapter
        .queryNoReturn('delete from grade where id = ?1', arguments: [id]);
  }

  @override
  Future<void> deleteAll() async {
    await _queryAdapter.queryNoReturn('delete from grade');
  }

  @override
  Future<void> insertGrades(Grades grades) async {
    await _gradesInsertionAdapter.insert(grades, OnConflictStrategy.replace);
  }

  @override
  Future<List<int>> insertAllGrades(List<Grades> grades) {
    return _gradesInsertionAdapter.insertListAndReturnIds(
        grades, OnConflictStrategy.replace);
  }
}

class _$BrandsDao extends BrandsDao {
  _$BrandsDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _brandsInsertionAdapter = InsertionAdapter(
            database,
            'brands',
            (Brands item) => <String, Object?>{
                  'brdId': item.brdId,
                  'brdName': item.brdName,
                  'brdIsVerified': item.brdIsVerified,
                  'brdFeatured': item.brdFeatured,
                  'brdIcon': item.brdIcon,
                  'brdIsActive': item.brdIsActive
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Brands> _brandsInsertionAdapter;

  @override
  Future<List<Brands>> findAllBrands() async {
    return _queryAdapter.queryList('SELECT * FROM brands',
        mapper: (Map<String, Object?> row) => Brands(
            brdId: row['brdId'] as int,
            brdName: row['brdName'] as String?,
            brdIsActive: row['brdIsActive'] as String?));
  }

  @override
  Future<Brands?> findBrandWithId(int id) async {
    return _queryAdapter.query('SELECT * FROM brands where brdId = ?1',
        mapper: (Map<String, Object?> row) => Brands(
            brdId: row['brdId'] as int,
            brdName: row['brdName'] as String?,
            brdIsActive: row['brdIsActive'] as String?),
        arguments: [id]);
  }

  @override
  Future<void> deleteBrand(int id) async {
    await _queryAdapter
        .queryNoReturn('delete from brands where id = ?1', arguments: [id]);
  }

  @override
  Future<void> deleteAll() async {
    await _queryAdapter.queryNoReturn('delete from brands');
  }

  @override
  Future<void> insertBrands(Brands brands) async {
    await _brandsInsertionAdapter.insert(brands, OnConflictStrategy.replace);
  }

  @override
  Future<List<int>> insertAllBrands(List<Brands> brands) {
    return _brandsInsertionAdapter.insertListAndReturnIds(
        brands, OnConflictStrategy.replace);
  }
}

class _$CertificationsDao extends CertificationsDao {
  _$CertificationsDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _certificationInsertionAdapter = InsertionAdapter(
            database,
            'certifications',
            (Certification item) => <String, Object?>{
                  'cerId': item.cerId,
                  'cerCategoryIdfk': item.cerCategoryIdfk,
                  'cerName': item.cerName,
                  'cerIsActive': item.cerIsActive
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Certification> _certificationInsertionAdapter;

  @override
  Future<List<Certification>> findAllCertifications() async {
    return _queryAdapter.queryList('SELECT * FROM certifications',
        mapper: (Map<String, Object?> row) => Certification(
            cerId: row['cerId'] as int,
            cerCategoryIdfk: row['cerCategoryIdfk'] as String?,
            cerName: row['cerName'] as String?,
            cerIsActive: row['cerIsActive'] as String?));
  }

  @override
  Future<Certification?> findCertificationWithId(int id) async {
    return _queryAdapter.query('SELECT * FROM certifications where brdId = ?1',
        mapper: (Map<String, Object?> row) => Certification(
            cerId: row['cerId'] as int,
            cerCategoryIdfk: row['cerCategoryIdfk'] as String?,
            cerName: row['cerName'] as String?,
            cerIsActive: row['cerIsActive'] as String?),
        arguments: [id]);
  }

  @override
  Future<List<Certification>> findCertificationWithCatId(int id) async {
    return _queryAdapter.queryList(
        'SELECT * FROM certifications where cerCategoryIdfk = ?1',
        mapper: (Map<String, Object?> row) => Certification(
            cerId: row['cerId'] as int,
            cerCategoryIdfk: row['cerCategoryIdfk'] as String?,
            cerName: row['cerName'] as String?,
            cerIsActive: row['cerIsActive'] as String?),
        arguments: [id]);
  }

  @override
  Future<void> deleteCertification(int id) async {
    await _queryAdapter.queryNoReturn(
        'delete from certifications where cerId = ?1',
        arguments: [id]);
  }

  @override
  Future<void> deleteAll() async {
    await _queryAdapter.queryNoReturn('delete from certifications');
  }

  @override
  Future<void> insertCertification(Certification certifications) async {
    await _certificationInsertionAdapter.insert(
        certifications, OnConflictStrategy.replace);
  }

  @override
  Future<List<int>> insertAllCertification(List<Certification> certifications) {
    return _certificationInsertionAdapter.insertListAndReturnIds(
        certifications, OnConflictStrategy.replace);
  }
}

class _$CityStateDao extends CityStateDao {
  _$CityStateDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _cityStateInsertionAdapter = InsertionAdapter(
            database,
            'city_state',
            (CityState item) => <String, Object?>{
                  'id': item.id,
                  'countryId': item.countryId,
                  'name': item.name,
                  'code': item.code
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<CityState> _cityStateInsertionAdapter;

  @override
  Future<List<CityState>> findAllCityState() async {
    return _queryAdapter.queryList('SELECT * FROM city_state',
        mapper: (Map<String, Object?> row) => CityState(
            id: row['id'] as int,
            countryId: row['countryId'] as String?,
            name: row['name'] as String?,
            code: row['code'] as String?));
  }

  @override
  Future<CityState?> findCityStateWithId(int id) async {
    return _queryAdapter.query('SELECT * FROM city_state where id = ?1',
        mapper: (Map<String, Object?> row) => CityState(
            id: row['id'] as int,
            countryId: row['countryId'] as String?,
            name: row['name'] as String?,
            code: row['code'] as String?),
        arguments: [id]);
  }

  @override
  Future<void> deleteCityState(int id) async {
    await _queryAdapter
        .queryNoReturn('delete from city_state where id = ?1', arguments: [id]);
  }

  @override
  Future<void> deleteAll() async {
    await _queryAdapter.queryNoReturn('delete from city_state');
  }

  @override
  Future<void> insertCityState(CityState cityStates) async {
    await _cityStateInsertionAdapter.insert(
        cityStates, OnConflictStrategy.replace);
  }

  @override
  Future<List<int>> insertAllCityState(List<CityState> cityStates) {
    return _cityStateInsertionAdapter.insertListAndReturnIds(
        cityStates, OnConflictStrategy.replace);
  }
}

class _$CompaniesDao extends CompaniesDao {
  _$CompaniesDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _companiesInsertionAdapter = InsertionAdapter(
            database,
            'companies',
            (Companies item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'gst': item.gst,
                  'address': item.address,
                  'countryId': item.countryId,
                  'cityStateId': item.cityStateId,
                  'zipCode': item.zipCode,
                  'websiteUrl': item.websiteUrl,
                  'whatsappNumber': item.whatsappNumber,
                  'wechatNumber': item.wechatNumber,
                  'telephoneNumber': item.telephoneNumber,
                  'emailId': item.emailId,
                  'maxProduction': item.maxProduction,
                  'noOfUnits': item.noOfUnits,
                  'yearEstablished': item.yearEstablished,
                  'tradeCategory': item.tradeCategory,
                  'licenseHolder': item.licenseHolder,
                  'isVerified': item.isVerified
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Companies> _companiesInsertionAdapter;

  @override
  Future<List<Companies>> findAllCompanies() async {
    return _queryAdapter.queryList('SELECT * FROM companies',
        mapper: (Map<String, Object?> row) => Companies(
            id: row['id'] as int,
            name: row['name'] as String?,
            gst: row['gst'] as String?,
            address: row['address'] as String?,
            countryId: row['countryId'] as String?,
            cityStateId: row['cityStateId'] as String?,
            zipCode: row['zipCode'] as String?,
            websiteUrl: row['websiteUrl'] as String?,
            whatsappNumber: row['whatsappNumber'] as String?,
            wechatNumber: row['wechatNumber'] as String?,
            telephoneNumber: row['telephoneNumber'] as String?,
            emailId: row['emailId'] as String?,
            maxProduction: row['maxProduction'] as String?,
            noOfUnits: row['noOfUnits'] as String?,
            yearEstablished: row['yearEstablished'] as String?,
            tradeCategory: row['tradeCategory'] as String?,
            licenseHolder: row['licenseHolder'] as String?,
            isVerified: row['isVerified'] as String?));
  }

  @override
  Future<Companies?> findCompaniesWithId(int id) async {
    return _queryAdapter.query('SELECT * FROM companies where id = ?1',
        mapper: (Map<String, Object?> row) => Companies(
            id: row['id'] as int,
            name: row['name'] as String?,
            gst: row['gst'] as String?,
            address: row['address'] as String?,
            countryId: row['countryId'] as String?,
            cityStateId: row['cityStateId'] as String?,
            zipCode: row['zipCode'] as String?,
            websiteUrl: row['websiteUrl'] as String?,
            whatsappNumber: row['whatsappNumber'] as String?,
            wechatNumber: row['wechatNumber'] as String?,
            telephoneNumber: row['telephoneNumber'] as String?,
            emailId: row['emailId'] as String?,
            maxProduction: row['maxProduction'] as String?,
            noOfUnits: row['noOfUnits'] as String?,
            yearEstablished: row['yearEstablished'] as String?,
            tradeCategory: row['tradeCategory'] as String?,
            licenseHolder: row['licenseHolder'] as String?,
            isVerified: row['isVerified'] as String?),
        arguments: [id]);
  }

  @override
  Future<void> deleteCompanies(int id) async {
    await _queryAdapter
        .queryNoReturn('delete from companies where id = ?1', arguments: [id]);
  }

  @override
  Future<void> deleteAll() async {
    await _queryAdapter.queryNoReturn('delete from companies');
  }

  @override
  Future<void> insertCompanies(Companies companies) async {
    await _companiesInsertionAdapter.insert(
        companies, OnConflictStrategy.replace);
  }

  @override
  Future<List<int>> insertAllCompanies(List<Companies> companies) {
    return _companiesInsertionAdapter.insertListAndReturnIds(
        companies, OnConflictStrategy.replace);
  }
}

class _$CountryDao extends CountryDao {
  _$CountryDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _countriesInsertionAdapter = InsertionAdapter(
            database,
            'countries',
            (Countries item) => <String, Object?>{
                  'conId': item.conId,
                  'conName': item.conName,
                  'countryIso': item.countryIso,
                  'countryIso3': item.countryIso3,
                  'countryCurrencyName': item.countryCurrencyName,
                  'countryCurrencyCode': item.countryCurrencyCode,
                  'countryCurrencySymbol': item.countryCurrencySymbol,
                  'countryPhoneCode': item.countryPhoneCode,
                  'countryContinent': item.countryContinent,
                  'countryStatus': item.countryStatus,
                  'mainFlagImage': item.mainFlagImage,
                  'extralarge': item.extralarge,
                  'large': item.large,
                  'medium': item.medium
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Countries> _countriesInsertionAdapter;

  @override
  Future<List<Countries>> findAllCountries() async {
    return _queryAdapter.queryList('SELECT * FROM countries',
        mapper: (Map<String, Object?> row) => Countries(
            conId: row['conId'] as int?,
            conName: row['conName'] as String?,
            countryIso: row['countryIso'] as String?,
            countryIso3: row['countryIso3'] as String?,
            countryCurrencyName: row['countryCurrencyName'] as String?,
            countryCurrencyCode: row['countryCurrencyCode'] as String?,
            countryCurrencySymbol: row['countryCurrencySymbol'] as String?,
            countryPhoneCode: row['countryPhoneCode'] as String?,
            countryContinent: row['countryContinent'] as String?,
            countryStatus: row['countryStatus'] as String?,
            mainFlagImage: row['mainFlagImage'] as String?,
            extralarge: row['extralarge'] as String?,
            large: row['large'] as String?,
            medium: row['medium'] as String?));
  }

  @override
  Future<Countries?> findYarnCountryWithId(int id) async {
    return _queryAdapter.query('SELECT * FROM countries where conId = ?1',
        mapper: (Map<String, Object?> row) => Countries(
            conId: row['conId'] as int?,
            conName: row['conName'] as String?,
            countryIso: row['countryIso'] as String?,
            countryIso3: row['countryIso3'] as String?,
            countryCurrencyName: row['countryCurrencyName'] as String?,
            countryCurrencyCode: row['countryCurrencyCode'] as String?,
            countryCurrencySymbol: row['countryCurrencySymbol'] as String?,
            countryPhoneCode: row['countryPhoneCode'] as String?,
            countryContinent: row['countryContinent'] as String?,
            countryStatus: row['countryStatus'] as String?,
            mainFlagImage: row['mainFlagImage'] as String?,
            extralarge: row['extralarge'] as String?,
            large: row['large'] as String?,
            medium: row['medium'] as String?),
        arguments: [id]);
  }

  @override
  Future<void> deleteCountries(int id) async {
    await _queryAdapter.queryNoReturn('delete from countries where conId = ?1',
        arguments: [id]);
  }

  @override
  Future<void> deleteAll() async {
    await _queryAdapter.queryNoReturn('delete from countries');
  }

  @override
  Future<void> insertCountry(Countries country) async {
    await _countriesInsertionAdapter.insert(
        country, OnConflictStrategy.replace);
  }

  @override
  Future<List<int>> insertAllCountry(List<Countries> country) {
    return _countriesInsertionAdapter.insertListAndReturnIds(
        country, OnConflictStrategy.replace);
  }
}

class _$CategoryDao extends CategoryDao {
  _$CategoryDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _categoriesInsertionAdapter = InsertionAdapter(
            database,
            'categories',
            (Categories item) => <String, Object?>{
                  'catId': item.catId,
                  'catName': item.catName
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Categories> _categoriesInsertionAdapter;

  @override
  Future<List<Categories>> findAllCategories() async {
    return _queryAdapter.queryList('SELECT * FROM categories',
        mapper: (Map<String, Object?> row) => Categories(
            catId: row['catId'] as int?, catName: row['catName'] as String?));
  }

  @override
  Future<Categories?> findCategoryWithId(int id) async {
    return _queryAdapter.query('SELECT * FROM categories where catId = ?1',
        mapper: (Map<String, Object?> row) => Categories(
            catId: row['catId'] as int?, catName: row['catName'] as String?),
        arguments: [id]);
  }

  @override
  Future<void> deleteCategories(int id) async {
    await _queryAdapter.queryNoReturn('delete from categories where catId = ?1',
        arguments: [id]);
  }

  @override
  Future<void> deleteAll() async {
    await _queryAdapter.queryNoReturn('delete from categories');
  }

  @override
  Future<void> insertCategory(Categories category) async {
    await _categoriesInsertionAdapter.insert(
        category, OnConflictStrategy.replace);
  }

  @override
  Future<List<int>> insertAllCategories(List<Categories> category) {
    return _categoriesInsertionAdapter.insertListAndReturnIds(
        category, OnConflictStrategy.replace);
  }
}

class _$DeliveryPeriodDao extends DeliveryPeriodDao {
  _$DeliveryPeriodDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _deliveryPeriodInsertionAdapter = InsertionAdapter(
            database,
            'delivery_period',
            (DeliveryPeriod item) => <String, Object?>{
                  'dprId': item.dprId,
                  'dprCategoryIdfk': item.dprCategoryIdfk,
                  'dprName': item.dprName,
                  'dprIsActive': item.dprIsActive
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<DeliveryPeriod> _deliveryPeriodInsertionAdapter;

  @override
  Future<List<DeliveryPeriod>> findAllDeliveryPeriod() async {
    return _queryAdapter.queryList('SELECT * FROM delivery_period',
        mapper: (Map<String, Object?> row) => DeliveryPeriod(
            dprId: row['dprId'] as int,
            dprCategoryIdfk: row['dprCategoryIdfk'] as String?,
            dprName: row['dprName'] as String?,
            dprIsActive: row['dprIsActive'] as String?));
  }

  @override
  Future<List<DeliveryPeriod>> findAllDeliveryPeriodWithCatId(int id) async {
    return _queryAdapter.queryList(
        'SELECT * FROM delivery_period where dprCategoryIdfk = ?1',
        mapper: (Map<String, Object?> row) => DeliveryPeriod(
            dprId: row['dprId'] as int,
            dprCategoryIdfk: row['dprCategoryIdfk'] as String?,
            dprName: row['dprName'] as String?,
            dprIsActive: row['dprIsActive'] as String?),
        arguments: [id]);
  }

  @override
  Future<DeliveryPeriod?> findDeliveryPeriodWithId(int id) async {
    return _queryAdapter.query('SELECT * FROM delivery_period where dprId = ?1',
        mapper: (Map<String, Object?> row) => DeliveryPeriod(
            dprId: row['dprId'] as int,
            dprCategoryIdfk: row['dprCategoryIdfk'] as String?,
            dprName: row['dprName'] as String?,
            dprIsActive: row['dprIsActive'] as String?),
        arguments: [id]);
  }

  @override
  Future<void> deleteDeliveryPeriod(int id) async {
    await _queryAdapter.queryNoReturn(
        'delete from delivery_period where dprId = ?1',
        arguments: [id]);
  }

  @override
  Future<void> deleteAll() async {
    await _queryAdapter.queryNoReturn('delete from delivery_period');
  }

  @override
  Future<void> insertDeliveryPeriod(DeliveryPeriod deliveryPeriod) async {
    await _deliveryPeriodInsertionAdapter.insert(
        deliveryPeriod, OnConflictStrategy.replace);
  }

  @override
  Future<List<int>> insertAllDeliveryPeriods(
      List<DeliveryPeriod> deliveryPeriods) {
    return _deliveryPeriodInsertionAdapter.insertListAndReturnIds(
        deliveryPeriods, OnConflictStrategy.replace);
  }
}

class _$PaymentTypeDao extends PaymentTypeDao {
  _$PaymentTypeDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _paymentTypeInsertionAdapter = InsertionAdapter(
            database,
            'payment_type',
            (PaymentType item) => <String, Object?>{
                  'payId': item.payId,
                  'payPriceTerrmIdfk': item.payPriceTerrmIdfk,
                  'ptrCountryIdfk': item.ptrCountryIdfk,
                  'payName': item.payName,
                  'payIsActive': item.payIsActive,
                  'parentId': item.parentId
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<PaymentType> _paymentTypeInsertionAdapter;

  @override
  Future<List<PaymentType>> findAllPaymentTypes() async {
    return _queryAdapter.queryList('SELECT * FROM payment_type',
        mapper: (Map<String, Object?> row) => PaymentType(
            payId: row['payId'] as String?,
            payName: row['payName'] as String?,
            payPriceTerrmIdfk: row['payPriceTerrmIdfk'] as String?,
            payIsActive: row['payIsActive'] as String?,
            parentId: row['parentId'] as String?));
  }

  @override
  Future<PaymentType?> findYarnPaymentTypeWithId(int id) async {
    return _queryAdapter.query('SELECT * FROM payment_type where payId = ?1',
        mapper: (Map<String, Object?> row) => PaymentType(
            payId: row['payId'] as String?,
            payName: row['payName'] as String?,
            payPriceTerrmIdfk: row['payPriceTerrmIdfk'] as String?,
            payIsActive: row['payIsActive'] as String?,
            parentId: row['parentId'] as String?),
        arguments: [id]);
  }

  @override
  Future<void> deletePaymentType(int id) async {
    await _queryAdapter.queryNoReturn(
        'delete from payment_type where payId = ?1',
        arguments: [id]);
  }

  @override
  Future<void> deleteAll() async {
    await _queryAdapter.queryNoReturn('delete from payment_type');
  }

  @override
  Future<void> insertPaymentType(PaymentType paymentType) async {
    await _paymentTypeInsertionAdapter.insert(
        paymentType, OnConflictStrategy.replace);
  }

  @override
  Future<List<int>> insertAllPaymentType(List<PaymentType> paymentType) {
    return _paymentTypeInsertionAdapter.insertListAndReturnIds(
        paymentType, OnConflictStrategy.replace);
  }
}

class _$PortsDao extends PortsDao {
  _$PortsDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _portsInsertionAdapter = InsertionAdapter(
            database,
            'ports',
            (Ports item) => <String, Object?>{
                  'prtId': item.prtId,
                  'prtCountryIdfk': item.prtCountryIdfk,
                  'prtName': item.prtName,
                  'prtIsActive': item.prtIsActive
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Ports> _portsInsertionAdapter;

  @override
  Future<List<Ports>> findAllPorts() async {
    return _queryAdapter.queryList('SELECT * FROM ports',
        mapper: (Map<String, Object?> row) => Ports(
            prtId: row['prtId'] as int,
            prtCountryIdfk: row['prtCountryIdfk'] as String?,
            prtName: row['prtName'] as String?,
            prtIsActive: row['prtIsActive'] as String?));
  }

  @override
  Future<Ports?> findYarnPortsWithId(int id) async {
    return _queryAdapter.query('SELECT * FROM ports where prtId = ?1',
        mapper: (Map<String, Object?> row) => Ports(
            prtId: row['prtId'] as int,
            prtCountryIdfk: row['prtCountryIdfk'] as String?,
            prtName: row['prtName'] as String?,
            prtIsActive: row['prtIsActive'] as String?),
        arguments: [id]);
  }

  @override
  Future<void> deletePorts(int id) async {
    await _queryAdapter
        .queryNoReturn('delete from ports where prtId = ?1', arguments: [id]);
  }

  @override
  Future<void> deleteAll() async {
    await _queryAdapter.queryNoReturn('delete from ports');
  }

  @override
  Future<void> insertPorts(Ports ports) async {
    await _portsInsertionAdapter.insert(ports, OnConflictStrategy.replace);
  }

  @override
  Future<List<int>> insertAllPorts(List<Ports> ports) {
    return _portsInsertionAdapter.insertListAndReturnIds(
        ports, OnConflictStrategy.replace);
  }
}

class _$PriceTermsDao extends PriceTermsDao {
  _$PriceTermsDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _fPriceTermsInsertionAdapter = InsertionAdapter(
            database,
            'price_terms_table',
            (FPriceTerms item) => <String, Object?>{
                  'ptrId': item.ptrId,
                  'ptrCategoryIdfk': item.ptrCategoryIdfk,
                  'ptr_locality': item.ptr_locality,
                  'ptrName': item.ptrName,
                  'ptrIsActive': item.ptrIsActive
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<FPriceTerms> _fPriceTermsInsertionAdapter;

  @override
  Future<List<FPriceTerms>> findAllFPriceTerms() async {
    return _queryAdapter.queryList('SELECT * FROM price_terms_table',
        mapper: (Map<String, Object?> row) => FPriceTerms(
            ptrId: row['ptrId'] as int,
            ptrCategoryIdfk: row['ptrCategoryIdfk'] as String?,
            ptr_locality: row['ptr_locality'] as String?,
            ptrName: row['ptrName'] as String?,
            ptrIsActive: row['ptrIsActive'] as String?));
  }

  @override
  Future<FPriceTerms?> findYarnFPriceTermsWithId(int id) async {
    return _queryAdapter.query(
        'SELECT * FROM price_terms_table where ptrId = ?1',
        mapper: (Map<String, Object?> row) => FPriceTerms(
            ptrId: row['ptrId'] as int,
            ptrCategoryIdfk: row['ptrCategoryIdfk'] as String?,
            ptr_locality: row['ptr_locality'] as String?,
            ptrName: row['ptrName'] as String?,
            ptrIsActive: row['ptrIsActive'] as String?),
        arguments: [id]);
  }

  @override
  Future<List<FPriceTerms>> findYarnFPriceTermsWithCatId(int id) async {
    return _queryAdapter.queryList(
        'SELECT * FROM price_terms_table where ptrCategoryIdfk = ?1',
        mapper: (Map<String, Object?> row) => FPriceTerms(
            ptrId: row['ptrId'] as int,
            ptrCategoryIdfk: row['ptrCategoryIdfk'] as String?,
            ptr_locality: row['ptr_locality'] as String?,
            ptrName: row['ptrName'] as String?,
            ptrIsActive: row['ptrIsActive'] as String?),
        arguments: [id]);
  }

  @override
  Future<List<FPriceTerms>> findYarnFPriceTermsWithCatIdLocality(
      int id, String locality) async {
    return _queryAdapter.queryList(
        'SELECT * FROM price_terms_table where ptrCategoryIdfk = ?1 and ptr_locality = ?2',
        mapper: (Map<String, Object?> row) => FPriceTerms(ptrId: row['ptrId'] as int, ptrCategoryIdfk: row['ptrCategoryIdfk'] as String?, ptr_locality: row['ptr_locality'] as String?, ptrName: row['ptrName'] as String?, ptrIsActive: row['ptrIsActive'] as String?),
        arguments: [id, locality]);
  }

  @override
  Future<void> deleteFPriceTerms(int id) async {
    await _queryAdapter.queryNoReturn(
        'delete from price_terms_table where ptrId = ?1',
        arguments: [id]);
  }

  @override
  Future<void> deleteAll() async {
    await _queryAdapter.queryNoReturn('delete from price_terms_table');
  }

  @override
  Future<void> insertFPriceTerms(FPriceTerms certifications) async {
    await _fPriceTermsInsertionAdapter.insert(
        certifications, OnConflictStrategy.replace);
  }

  @override
  Future<List<int>> insertAllFPriceTerms(List<FPriceTerms> certifications) {
    return _fPriceTermsInsertionAdapter.insertListAndReturnIds(
        certifications, OnConflictStrategy.replace);
  }
}

class _$UnitDao extends UnitDao {
  _$UnitDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _unitsInsertionAdapter = InsertionAdapter(
            database,
            'units_table',
            (Units item) => <String, Object?>{
                  'untId': item.untId,
                  'untCategoryIdfk': item.untCategoryIdfk,
                  'unt_family_idfk': item.unt_family_idfk,
                  'untName': item.untName,
                  'untIsActive': item.untIsActive
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Units> _unitsInsertionAdapter;

  @override
  Future<List<Units>> findAllUnit() async {
    return _queryAdapter.queryList('SELECT * FROM units_table',
        mapper: (Map<String, Object?> row) => Units(
            untId: row['untId'] as int,
            untCategoryIdfk: row['untCategoryIdfk'] as String?,
            unt_family_idfk: row['unt_family_idfk'] as String?,
            untName: row['untName'] as String?,
            untIsActive: row['untIsActive'] as String?));
  }

  @override
  Future<List<Units>> findAllUnitWithCatId(int id) async {
    return _queryAdapter.queryList(
        'SELECT * FROM units_table where untCategoryIdfk = ?1',
        mapper: (Map<String, Object?> row) => Units(
            untId: row['untId'] as int,
            untCategoryIdfk: row['untCategoryIdfk'] as String?,
            unt_family_idfk: row['unt_family_idfk'] as String?,
            untName: row['untName'] as String?,
            untIsActive: row['untIsActive'] as String?),
        arguments: [id]);
  }

  @override
  Future<List<Units>> findAllUnitWithCatIdFamId(int id, int famId) async {
    return _queryAdapter.queryList(
        'SELECT * FROM units_table where untCategoryIdfk = ?1 and unt_family_idfk = ?2',
        mapper: (Map<String, Object?> row) => Units(untId: row['untId'] as int, untCategoryIdfk: row['untCategoryIdfk'] as String?, unt_family_idfk: row['unt_family_idfk'] as String?, untName: row['untName'] as String?, untIsActive: row['untIsActive'] as String?),
        arguments: [id, famId]);
  }

  @override
  Future<Units?> findYarnUnitWithId(int id) async {
    return _queryAdapter.query('SELECT * FROM units_table where untId = ?1',
        mapper: (Map<String, Object?> row) => Units(
            untId: row['untId'] as int,
            untCategoryIdfk: row['untCategoryIdfk'] as String?,
            unt_family_idfk: row['unt_family_idfk'] as String?,
            untName: row['untName'] as String?,
            untIsActive: row['untIsActive'] as String?),
        arguments: [id]);
  }

  @override
  Future<void> deleteUnit(int id) async {
    await _queryAdapter.queryNoReturn(
        'delete from units_table where untId = ?1',
        arguments: [id]);
  }

  @override
  Future<void> deleteAll() async {
    await _queryAdapter.queryNoReturn('delete from units_table');
  }

  @override
  Future<void> insertUnit(Units certifications) async {
    await _unitsInsertionAdapter.insert(
        certifications, OnConflictStrategy.replace);
  }

  @override
  Future<List<int>> insertAllUnit(List<Units> certifications) {
    return _unitsInsertionAdapter.insertListAndReturnIds(
        certifications, OnConflictStrategy.replace);
  }
}

class _$StocklotFamilyDao extends StocklotFamilyDao {
  _$StocklotFamilyDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _stockLotFamilyInsertionAdapter = InsertionAdapter(
            database,
            'stocklots_family',
            (StockLotFamily item) => <String, Object?>{
                  'stocklotFamilyId': item.stocklotFamilyId,
                  'stocklotFamilyParentId': item.stocklotFamilyParentId,
                  'stocklotFamilyName': item.stocklotFamilyName,
                  'stocklotFamilyActive': item.stocklotFamilyActive,
                  'stocklotFamilySortid': item.stocklotFamilySortid
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<StockLotFamily> _stockLotFamilyInsertionAdapter;

  @override
  Future<List<StockLotFamily>> findAllStocklotCategories() async {
    return _queryAdapter.queryList('SELECT * FROM stocklots_family',
        mapper: (Map<String, Object?> row) => StockLotFamily(
            stocklotFamilyId: row['stocklotFamilyId'] as int?,
            stocklotFamilyParentId: row['stocklotFamilyParentId'] as String?,
            stocklotFamilyName: row['stocklotFamilyName'] as String?,
            stocklotFamilyActive: row['stocklotFamilyActive'] as String?,
            stocklotFamilySortid: row['stocklotFamilySortid'] as String?));
  }

  @override
  Future<List<StockLotFamily>> findParentStocklot() async {
    return _queryAdapter.queryList(
        'SELECT * FROM stocklots_family where stocklotFamilyParentId IS NULL',
        mapper: (Map<String, Object?> row) => StockLotFamily(
            stocklotFamilyId: row['stocklotFamilyId'] as int?,
            stocklotFamilyParentId: row['stocklotFamilyParentId'] as String?,
            stocklotFamilyName: row['stocklotFamilyName'] as String?,
            stocklotFamilyActive: row['stocklotFamilyActive'] as String?,
            stocklotFamilySortid: row['stocklotFamilySortid'] as String?));
  }

  @override
  Future<StockLotFamily?> findStocklotCategoriesWithId(int id) async {
    return _queryAdapter.query(
        'SELECT * FROM stocklots_family where stocklotFamilyParentId = ?1',
        mapper: (Map<String, Object?> row) => StockLotFamily(
            stocklotFamilyId: row['stocklotFamilyId'] as int?,
            stocklotFamilyParentId: row['stocklotFamilyParentId'] as String?,
            stocklotFamilyName: row['stocklotFamilyName'] as String?,
            stocklotFamilyActive: row['stocklotFamilyActive'] as String?,
            stocklotFamilySortid: row['stocklotFamilySortid'] as String?),
        arguments: [id]);
  }

  @override
  Future<void> deleteStocklotCategories(int id) async {
    await _queryAdapter.queryNoReturn(
        'delete from stocklots_family where stocklotFamilyParentId = ?1',
        arguments: [id]);
  }

  @override
  Future<void> deleteAll() async {
    await _queryAdapter.queryNoReturn('delete from stocklots_family');
  }

  @override
  Future<void> insertStocklotCategories(
      StockLotFamily stocklotCategories) async {
    await _stockLotFamilyInsertionAdapter.insert(
        stocklotCategories, OnConflictStrategy.replace);
  }

  @override
  Future<List<int>> insertAllStocklotCategories(
      List<StockLotFamily> stocklotCategories) {
    return _stockLotFamilyInsertionAdapter.insertListAndReturnIds(
        stocklotCategories, OnConflictStrategy.replace);
  }
}

class _$FabricSettingDao extends FabricSettingDao {
  _$FabricSettingDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _fabricSettingInsertionAdapter = InsertionAdapter(
            database,
            'fabric_settings',
            (FabricSetting item) => <String, Object?>{
                  'fabricSettingId': item.fabricSettingId,
                  'fabricFamilyIdfk': item.fabricFamilyIdfk,
                  'showCount': item.showCount,
                  'countMinMax': item.countMinMax,
                  'showPly': item.showPly,
                  'showBlend': item.showBlend,
                  'showGsm': item.showGsm,
                  'gsmCountMinMax': item.gsmCountMinMax,
                  'showRatio': item.showRatio,
                  'showKnittingType': item.showKnittingType,
                  'showAppearance': item.showAppearance,
                  'showColorTreatmentMethod': item.showColorTreatmentMethod,
                  'showDyingMethod': item.showDyingMethod,
                  'showColor': item.showColor,
                  'showQuality': item.showQuality,
                  'showGrade': item.showGrade,
                  'showCertification': item.showCertification,
                  'showWarpCount': item.showWarpCount,
                  'warpCountMinMax': item.warpCountMinMax,
                  'showWarpPly': item.showWarpPly,
                  'showNoOfEndsWarp': item.showNoOfEndsWarp,
                  'noOfEndsWarpMinMax': item.noOfEndsWarpMinMax,
                  'showWeftCount': item.showWeftCount,
                  'weftCountMinMax': item.weftCountMinMax,
                  'showWeftPly': item.showWeftPly,
                  'showNoOfPickWeft': item.showNoOfPickWeft,
                  'noOfPickWeftMinMax': item.noOfPickWeftMinMax,
                  'showWidth': item.showWidth,
                  'widthMinMax': item.widthMinMax,
                  'showWeave': item.showWeave,
                  'showLoom': item.showLoom,
                  'showSalvedge': item.showSalvedge,
                  'showTuckinWidth': item.showTuckinWidth,
                  'showTuckinWidthMinMax': item.showTuckinWidthMinMax,
                  'showOnce': item.showOnce,
                  'onceMinMax': item.onceMinMax,
                  'showLayyer': item.showLayyer,
                  'showWeavePatternes': item.showWeavePatternes,
                  'showDenimType': item.showDenimType,
                  'fabricSettingIsActive': item.fabricSettingIsActive,
                  'fabricSettingSortid': item.fabricSettingSortid
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<FabricSetting> _fabricSettingInsertionAdapter;

  @override
  Future<List<FabricSetting>> findAllFabricSettings() async {
    return _queryAdapter.queryList('SELECT * FROM fabric_settings',
        mapper: (Map<String, Object?> row) => FabricSetting(
            fabricSettingId: row['fabricSettingId'] as int?,
            fabricFamilyIdfk: row['fabricFamilyIdfk'] as String?,
            showCount: row['showCount'] as String?,
            countMinMax: row['countMinMax'] as String?,
            showPly: row['showPly'] as String?,
            showBlend: row['showBlend'] as String?,
            showGsm: row['showGsm'] as String?,
            gsmCountMinMax: row['gsmCountMinMax'] as String?,
            showRatio: row['showRatio'] as String?,
            showKnittingType: row['showKnittingType'] as String?,
            showAppearance: row['showAppearance'] as String?,
            showColorTreatmentMethod:
                row['showColorTreatmentMethod'] as String?,
            showDyingMethod: row['showDyingMethod'] as String?,
            showColor: row['showColor'] as String?,
            showQuality: row['showQuality'] as String?,
            showGrade: row['showGrade'] as String?,
            showCertification: row['showCertification'] as String?,
            showWarpCount: row['showWarpCount'] as String?,
            warpCountMinMax: row['warpCountMinMax'] as String?,
            showWarpPly: row['showWarpPly'] as String?,
            showNoOfEndsWarp: row['showNoOfEndsWarp'] as String?,
            noOfEndsWarpMinMax: row['noOfEndsWarpMinMax'] as String?,
            showWeftCount: row['showWeftCount'] as String?,
            weftCountMinMax: row['weftCountMinMax'] as String?,
            showWeftPly: row['showWeftPly'] as String?,
            showNoOfPickWeft: row['showNoOfPickWeft'] as String?,
            noOfPickWeftMinMax: row['noOfPickWeftMinMax'] as String?,
            showWidth: row['showWidth'] as String?,
            widthMinMax: row['widthMinMax'] as String?,
            showWeave: row['showWeave'] as String?,
            showLoom: row['showLoom'] as String?,
            showSalvedge: row['showSalvedge'] as String?,
            showTuckinWidth: row['showTuckinWidth'] as String?,
            showTuckinWidthMinMax: row['showTuckinWidthMinMax'] as String?,
            showOnce: row['showOnce'] as String?,
            onceMinMax: row['onceMinMax'] as String?,
            showLayyer: row['showLayyer'] as String?,
            showWeavePatternes: row['showWeavePatternes'] as String?,
            showDenimType: row['showDenimType'] as String?,
            fabricSettingIsActive: row['fabricSettingIsActive'] as String?,
            fabricSettingSortid: row['fabricSettingSortid'] as String?));
  }

  @override
  Future<List<FabricSetting>> findFamilyFabricSettings(int id) async {
    return _queryAdapter.queryList(
        'SELECT * FROM fabric_settings where fabricFamilyIdfk = ?1',
        mapper: (Map<String, Object?> row) => FabricSetting(
            fabricSettingId: row['fabricSettingId'] as int?,
            fabricFamilyIdfk: row['fabricFamilyIdfk'] as String?,
            showCount: row['showCount'] as String?,
            countMinMax: row['countMinMax'] as String?,
            showPly: row['showPly'] as String?,
            showBlend: row['showBlend'] as String?,
            showGsm: row['showGsm'] as String?,
            gsmCountMinMax: row['gsmCountMinMax'] as String?,
            showRatio: row['showRatio'] as String?,
            showKnittingType: row['showKnittingType'] as String?,
            showAppearance: row['showAppearance'] as String?,
            showColorTreatmentMethod:
                row['showColorTreatmentMethod'] as String?,
            showDyingMethod: row['showDyingMethod'] as String?,
            showColor: row['showColor'] as String?,
            showQuality: row['showQuality'] as String?,
            showGrade: row['showGrade'] as String?,
            showCertification: row['showCertification'] as String?,
            showWarpCount: row['showWarpCount'] as String?,
            warpCountMinMax: row['warpCountMinMax'] as String?,
            showWarpPly: row['showWarpPly'] as String?,
            showNoOfEndsWarp: row['showNoOfEndsWarp'] as String?,
            noOfEndsWarpMinMax: row['noOfEndsWarpMinMax'] as String?,
            showWeftCount: row['showWeftCount'] as String?,
            weftCountMinMax: row['weftCountMinMax'] as String?,
            showWeftPly: row['showWeftPly'] as String?,
            showNoOfPickWeft: row['showNoOfPickWeft'] as String?,
            noOfPickWeftMinMax: row['noOfPickWeftMinMax'] as String?,
            showWidth: row['showWidth'] as String?,
            widthMinMax: row['widthMinMax'] as String?,
            showWeave: row['showWeave'] as String?,
            showLoom: row['showLoom'] as String?,
            showSalvedge: row['showSalvedge'] as String?,
            showTuckinWidth: row['showTuckinWidth'] as String?,
            showTuckinWidthMinMax: row['showTuckinWidthMinMax'] as String?,
            showOnce: row['showOnce'] as String?,
            onceMinMax: row['onceMinMax'] as String?,
            showLayyer: row['showLayyer'] as String?,
            showWeavePatternes: row['showWeavePatternes'] as String?,
            showDenimType: row['showDenimType'] as String?,
            fabricSettingIsActive: row['fabricSettingIsActive'] as String?,
            fabricSettingSortid: row['fabricSettingSortid'] as String?),
        arguments: [id]);
  }

  @override
  Future<void> deleteFabricSetting(int id) async {
    await _queryAdapter.queryNoReturn(
        'delete from fabric_settings where fabricSettingId = ?1',
        arguments: [id]);
  }

  @override
  Future<void> deleteFabricSettings() async {
    await _queryAdapter.queryNoReturn('delete from fabric_settings');
  }

  @override
  Future<void> insertFabricSetting(FabricSetting fabricSettings) async {
    await _fabricSettingInsertionAdapter.insert(
        fabricSettings, OnConflictStrategy.replace);
  }

  @override
  Future<List<int>> insertAllFabricSettings(List<FabricSetting> fiberSettings) {
    return _fabricSettingInsertionAdapter.insertListAndReturnIds(
        fiberSettings, OnConflictStrategy.replace);
  }
}

class _$FabricFamilyDao extends FabricFamilyDao {
  _$FabricFamilyDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _fabricFamilyInsertionAdapter = InsertionAdapter(
            database,
            'fabric_family',
            (FabricFamily item) => <String, Object?>{
                  'fabricFamilyId': item.fabricFamilyId,
                  'fabricFamilyName': item.fabricFamilyName,
                  'iconSelected': item.iconSelected,
                  'iconUnselected': item.iconUnselected,
                  'fabricFamilyType': item.fabricFamilyType,
                  'fabricFamilyDescription': item.fabricFamilyDescription,
                  'fabricFamilyActive': item.fabricFamilyActive,
                  'fabricFamilySortid': item.fabricFamilySortid
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<FabricFamily> _fabricFamilyInsertionAdapter;

  @override
  Future<List<FabricFamily>> findAllFabricFamily() async {
    return _queryAdapter.queryList('SELECT * FROM fabric_family',
        mapper: (Map<String, Object?> row) => FabricFamily(
            fabricFamilyId: row['fabricFamilyId'] as int?,
            fabricFamilyName: row['fabricFamilyName'] as String?,
            iconSelected: row['iconSelected'] as String?,
            iconUnselected: row['iconUnselected'] as String?,
            fabricFamilyType: row['fabricFamilyType'] as String?,
            fabricFamilyDescription: row['fabricFamilyDescription'] as String?,
            fabricFamilyActive: row['fabricFamilyActive'] as String?,
            fabricFamilySortid: row['fabricFamilySortid'] as String?));
  }

  @override
  Future<List<FabricFamily>> findFamilyFabricFamily(int id) async {
    return _queryAdapter.queryList(
        'SELECT * FROM fabric_family where fabricFamilyId = ?1',
        mapper: (Map<String, Object?> row) => FabricFamily(
            fabricFamilyId: row['fabricFamilyId'] as int?,
            fabricFamilyName: row['fabricFamilyName'] as String?,
            iconSelected: row['iconSelected'] as String?,
            iconUnselected: row['iconUnselected'] as String?,
            fabricFamilyType: row['fabricFamilyType'] as String?,
            fabricFamilyDescription: row['fabricFamilyDescription'] as String?,
            fabricFamilyActive: row['fabricFamilyActive'] as String?,
            fabricFamilySortid: row['fabricFamilySortid'] as String?),
        arguments: [id]);
  }

  @override
  Future<void> deleteFabricFamily(int id) async {
    await _queryAdapter.queryNoReturn(
        'delete from fabric_family where fabricFamilyId = ?1',
        arguments: [id]);
  }

  @override
  Future<void> deleteFabricFamilies() async {
    await _queryAdapter.queryNoReturn('delete from fabric_family');
  }

  @override
  Future<void> insertFabricFamily(FabricFamily fabricFamily) async {
    await _fabricFamilyInsertionAdapter.insert(
        fabricFamily, OnConflictStrategy.replace);
  }

  @override
  Future<List<int>> insertAllFabricFamily(List<FabricFamily> fabricFamily) {
    return _fabricFamilyInsertionAdapter.insertListAndReturnIds(
        fabricFamily, OnConflictStrategy.replace);
  }
}

class _$FabricBlendsDao extends FabricBlendsDao {
  _$FabricBlendsDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _fabricBlendsInsertionAdapter = InsertionAdapter(
            database,
            'fabric_blends',
            (FabricBlends item) => <String, Object?>{
                  'blnId': item.blnId,
                  'blnCategoryIdfk': item.blnCategoryIdfk,
                  'familyIdfk': item.familyIdfk,
                  'blnName': item.blnName,
                  'blnAbrv': item.blnAbrv,
                  'minMax': item.minMax,
                  'has_blend_id_1': item.has_blend_id_1,
                  'has_blend_id_2': item.has_blend_id_2,
                  'has_blend_name_1': item.has_blend_name_1,
                  'has_blend_name_2': item.has_blend_name_2,
                  'is_popular': item.is_popular,
                  'iconSelected': item.iconSelected,
                  'iconUnselected': item.iconUnselected,
                  'blnIsActive': item.blnIsActive,
                  'blnSortid': item.blnSortid,
                  'blnNature': item.blnNature,
                  'bln_ratio_json': item.bln_ratio_json,
                  'isSelected': item.isSelected == null
                      ? null
                      : (item.isSelected! ? 1 : 0),
                  'blendRatio': item.blendRatio
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<FabricBlends> _fabricBlendsInsertionAdapter;

  @override
  Future<List<FabricBlends>> findAllFabricBlends() async {
    return _queryAdapter.queryList('SELECT * FROM fabric_blends',
        mapper: (Map<String, Object?> row) => FabricBlends(
            blnId: row['blnId'] as int?,
            blnCategoryIdfk: row['blnCategoryIdfk'] as String?,
            familyIdfk: row['familyIdfk'] as String?,
            blnName: row['blnName'] as String?,
            blnAbrv: row['blnAbrv'] as String?,
            minMax: row['minMax'] as String?,
            has_blend_id_1: row['has_blend_id_1'] as String?,
            has_blend_id_2: row['has_blend_id_2'] as String?,
            has_blend_name_1: row['has_blend_name_1'] as String?,
            has_blend_name_2: row['has_blend_name_2'] as String?,
            is_popular: row['is_popular'] as String?,
            iconSelected: row['iconSelected'] as String?,
            iconUnselected: row['iconUnselected'] as String?,
            blnIsActive: row['blnIsActive'] as String?,
            isSelected: row['isSelected'] == null
                ? null
                : (row['isSelected'] as int) != 0,
            blendRatio: row['blendRatio'] as String?,
            blnNature: row['blnNature'] as String?,
            bln_ratio_json: row['bln_ratio_json'] as String?,
            blnSortid: row['blnSortid'] as String?));
  }

  @override
  Future<List<FabricBlends>> findFabricBlend(int id) async {
    return _queryAdapter.queryList(
        'SELECT * FROM fabric_blends where familyIdfk = ?1',
        mapper: (Map<String, Object?> row) => FabricBlends(
            blnId: row['blnId'] as int?,
            blnCategoryIdfk: row['blnCategoryIdfk'] as String?,
            familyIdfk: row['familyIdfk'] as String?,
            blnName: row['blnName'] as String?,
            blnAbrv: row['blnAbrv'] as String?,
            minMax: row['minMax'] as String?,
            has_blend_id_1: row['has_blend_id_1'] as String?,
            has_blend_id_2: row['has_blend_id_2'] as String?,
            has_blend_name_1: row['has_blend_name_1'] as String?,
            has_blend_name_2: row['has_blend_name_2'] as String?,
            is_popular: row['is_popular'] as String?,
            iconSelected: row['iconSelected'] as String?,
            iconUnselected: row['iconUnselected'] as String?,
            blnIsActive: row['blnIsActive'] as String?,
            isSelected: row['isSelected'] == null
                ? null
                : (row['isSelected'] as int) != 0,
            blendRatio: row['blendRatio'] as String?,
            blnNature: row['blnNature'] as String?,
            bln_ratio_json: row['bln_ratio_json'] as String?,
            blnSortid: row['blnSortid'] as String?),
        arguments: [id]);
  }

  @override
  Future<void> deleteFabricBlend(int id) async {
    await _queryAdapter.queryNoReturn(
        'delete from fabric_blends where blnId = ?1',
        arguments: [id]);
  }

  @override
  Future<void> deleteFabricBlends() async {
    await _queryAdapter.queryNoReturn('delete from fabric_blends');
  }

  @override
  Future<void> insertFabricBlends(FabricBlends fabricBlends) async {
    await _fabricBlendsInsertionAdapter.insert(
        fabricBlends, OnConflictStrategy.replace);
  }

  @override
  Future<List<int>> insertAllFabricBlends(List<FabricBlends> fabricBlends) {
    return _fabricBlendsInsertionAdapter.insertListAndReturnIds(
        fabricBlends, OnConflictStrategy.replace);
  }
}

class _$FabricDenimTypesDao extends FabricDenimTypesDao {
  _$FabricDenimTypesDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _denimTypesInsertionAdapter = InsertionAdapter(
            database,
            'fabric_denim_types',
            (DenimTypes item) => <String, Object?>{
                  'fabricDenimTypeId': item.fabricDenimTypeId,
                  'fabricDenimTypeName': item.fabricDenimTypeName,
                  'fabricFamilyIdfk': item.fabricFamilyIdfk
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<DenimTypes> _denimTypesInsertionAdapter;

  @override
  Future<List<DenimTypes>> findAllFabricDenimTypes() async {
    return _queryAdapter.queryList('SELECT * FROM fabric_denim_types',
        mapper: (Map<String, Object?> row) => DenimTypes(
            fabricDenimTypeId: row['fabricDenimTypeId'] as int?,
            fabricDenimTypeName: row['fabricDenimTypeName'] as String?,
            fabricFamilyIdfk: row['fabricFamilyIdfk'] as String?));
  }

  @override
  Future<List<DenimTypes>> findFabricDenimTypes(int id) async {
    return _queryAdapter.queryList(
        'SELECT * FROM fabric_denim_types where fabricDenimTypeId = ?1',
        mapper: (Map<String, Object?> row) => DenimTypes(
            fabricDenimTypeId: row['fabricDenimTypeId'] as int?,
            fabricDenimTypeName: row['fabricDenimTypeName'] as String?,
            fabricFamilyIdfk: row['fabricFamilyIdfk'] as String?),
        arguments: [id]);
  }

  @override
  Future<void> deleteFabricDenimType(int id) async {
    await _queryAdapter.queryNoReturn(
        'delete from fabric_denim_types where fabricDenimTypeId = ?1',
        arguments: [id]);
  }

  @override
  Future<void> deleteFabricDenimTypes() async {
    await _queryAdapter.queryNoReturn('delete from fabric_denim_types');
  }

  @override
  Future<void> insertFabricDenimTypes(DenimTypes denimTypes) async {
    await _denimTypesInsertionAdapter.insert(
        denimTypes, OnConflictStrategy.replace);
  }

  @override
  Future<List<int>> insertAllFabricDenimTypes(
      List<DenimTypes> fabricFabricDenimTypes) {
    return _denimTypesInsertionAdapter.insertListAndReturnIds(
        fabricFabricDenimTypes, OnConflictStrategy.replace);
  }
}

class _$FabricAppearanceDao extends FabricAppearanceDao {
  _$FabricAppearanceDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _fabricAppearanceInsertionAdapter = InsertionAdapter(
            database,
            'fabric_appearance',
            (FabricAppearance item) => <String, Object?>{
                  'fabricAppearanceId': item.fabricAppearanceId,
                  'fabricAppearanceName': item.fabricAppearanceName,
                  'fabricAppearanceSortid': item.fabricAppearanceSortid,
                  'fabricAppearanceIsActive': item.fabricAppearanceIsActive,
                  'fabricFamilyIdfk': item.fabricFamilyIdfk
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<FabricAppearance> _fabricAppearanceInsertionAdapter;

  @override
  Future<List<FabricAppearance>> findAllFabricAppearance() async {
    return _queryAdapter.queryList('SELECT * FROM fabric_appearance',
        mapper: (Map<String, Object?> row) => FabricAppearance(
            fabricAppearanceId: row['fabricAppearanceId'] as int?,
            fabricAppearanceName: row['fabricAppearanceName'] as String?,
            fabricAppearanceSortid: row['fabricAppearanceSortid'] as String?,
            fabricAppearanceIsActive:
                row['fabricAppearanceIsActive'] as String?,
            fabricFamilyIdfk: row['fabricFamilyIdfk'] as String?));
  }

  @override
  Future<List<FabricAppearance>> findFabricAppearance(int id) async {
    return _queryAdapter.queryList(
        'SELECT * FROM fabric_appearance where fabricAppearanceId = ?1',
        mapper: (Map<String, Object?> row) => FabricAppearance(
            fabricAppearanceId: row['fabricAppearanceId'] as int?,
            fabricAppearanceName: row['fabricAppearanceName'] as String?,
            fabricAppearanceSortid: row['fabricAppearanceSortid'] as String?,
            fabricAppearanceIsActive:
                row['fabricAppearanceIsActive'] as String?,
            fabricFamilyIdfk: row['fabricFamilyIdfk'] as String?),
        arguments: [id]);
  }

  @override
  Future<void> deleteFabricAppearance(int id) async {
    await _queryAdapter.queryNoReturn(
        'delete from fabric_appearance where fabricAppearanceId = ?1',
        arguments: [id]);
  }

  @override
  Future<void> deleteFabricAppearances() async {
    await _queryAdapter.queryNoReturn('delete from fabric_appearance');
  }

  @override
  Future<void> insertFabricAppearance(FabricAppearance fabricAppearance) async {
    await _fabricAppearanceInsertionAdapter.insert(
        fabricAppearance, OnConflictStrategy.replace);
  }

  @override
  Future<List<int>> insertAllFabricAppearance(
      List<FabricAppearance> fabricAppearance) {
    return _fabricAppearanceInsertionAdapter.insertListAndReturnIds(
        fabricAppearance, OnConflictStrategy.replace);
  }
}

class _$KnittingTypesDao extends KnittingTypesDao {
  _$KnittingTypesDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _knittingTypesInsertionAdapter = InsertionAdapter(
            database,
            'knitting_types',
            (KnittingTypes item) => <String, Object?>{
                  'fabricKnittingTypeId': item.fabricKnittingTypeId,
                  'fabricKnittingTypeName': item.fabricKnittingTypeName,
                  'fabricFamilyIdfk': item.fabricFamilyIdfk
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<KnittingTypes> _knittingTypesInsertionAdapter;

  @override
  Future<List<KnittingTypes>> findAllKnittingTypes() async {
    return _queryAdapter.queryList('SELECT * FROM knitting_types',
        mapper: (Map<String, Object?> row) => KnittingTypes(
            fabricKnittingTypeId: row['fabricKnittingTypeId'] as int?,
            fabricKnittingTypeName: row['fabricKnittingTypeName'] as String?,
            fabricFamilyIdfk: row['fabricFamilyIdfk'] as String?));
  }

  @override
  Future<List<KnittingTypes>> findKnittingType(int id) async {
    return _queryAdapter.queryList(
        'SELECT * FROM knitting_types where fabricKnittingTypeId = ?1',
        mapper: (Map<String, Object?> row) => KnittingTypes(
            fabricKnittingTypeId: row['fabricKnittingTypeId'] as int?,
            fabricKnittingTypeName: row['fabricKnittingTypeName'] as String?,
            fabricFamilyIdfk: row['fabricFamilyIdfk'] as String?),
        arguments: [id]);
  }

  @override
  Future<void> deleteKnittingType(int id) async {
    await _queryAdapter.queryNoReturn(
        'delete from knitting_types where fabricKnittingTypeId = ?1',
        arguments: [id]);
  }

  @override
  Future<void> deleteKnittingTypes() async {
    await _queryAdapter.queryNoReturn('delete from knitting_types');
  }

  @override
  Future<void> insertKnittingTypes(KnittingTypes knittingTypes) async {
    await _knittingTypesInsertionAdapter.insert(
        knittingTypes, OnConflictStrategy.replace);
  }

  @override
  Future<List<int>> insertAllKnittingTypes(List<KnittingTypes> knittingTypes) {
    return _knittingTypesInsertionAdapter.insertListAndReturnIds(
        knittingTypes, OnConflictStrategy.replace);
  }
}

class _$FabricPlyDao extends FabricPlyDao {
  _$FabricPlyDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _fabricPlyInsertionAdapter = InsertionAdapter(
            database,
            'fabric_ply',
            (FabricPly item) => <String, Object?>{
                  'fabricPlyId': item.fabricPlyId,
                  'fabricFamilyIdfk': item.fabricFamilyIdfk,
                  'fabricPlyType': item.fabricPlyType,
                  'fabricPlyName': item.fabricPlyName,
                  'fabricPlyDescription': item.fabricPlyDescription,
                  'fabricPlyIsActive': item.fabricPlyIsActive,
                  'fabricPlySortid': item.fabricPlySortid
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<FabricPly> _fabricPlyInsertionAdapter;

  @override
  Future<List<FabricPly>> findAllFabricPly() async {
    return _queryAdapter.queryList('SELECT * FROM fabric_ply',
        mapper: (Map<String, Object?> row) => FabricPly(
            fabricPlyId: row['fabricPlyId'] as int?,
            fabricFamilyIdfk: row['fabricFamilyIdfk'] as String?,
            fabricPlyType: row['fabricPlyType'] as String?,
            fabricPlyName: row['fabricPlyName'] as String?,
            fabricPlyDescription: row['fabricPlyDescription'] as String?,
            fabricPlyIsActive: row['fabricPlyIsActive'] as String?,
            fabricPlySortid: row['fabricPlySortid'] as String?));
  }

  @override
  Future<List<FabricPly>> findFabricPly(int id) async {
    return _queryAdapter.queryList(
        'SELECT * FROM fabric_ply where fabricPlyId = ?1',
        mapper: (Map<String, Object?> row) => FabricPly(
            fabricPlyId: row['fabricPlyId'] as int?,
            fabricFamilyIdfk: row['fabricFamilyIdfk'] as String?,
            fabricPlyType: row['fabricPlyType'] as String?,
            fabricPlyName: row['fabricPlyName'] as String?,
            fabricPlyDescription: row['fabricPlyDescription'] as String?,
            fabricPlyIsActive: row['fabricPlyIsActive'] as String?,
            fabricPlySortid: row['fabricPlySortid'] as String?),
        arguments: [id]);
  }

  @override
  Future<void> deleteFabricPly(int id) async {
    await _queryAdapter.queryNoReturn(
        'delete from fabric_ply where fabricPlyId = ?1',
        arguments: [id]);
  }

  @override
  Future<void> deleteFabricPlys() async {
    await _queryAdapter.queryNoReturn('delete from fabric_ply');
  }

  @override
  Future<void> insertFabricPly(FabricPly fabricFabricPly) async {
    await _fabricPlyInsertionAdapter.insert(
        fabricFabricPly, OnConflictStrategy.replace);
  }

  @override
  Future<List<int>> insertAllFabricPly(List<FabricPly> fabricFabricPly) {
    return _fabricPlyInsertionAdapter.insertListAndReturnIds(
        fabricFabricPly, OnConflictStrategy.replace);
  }
}

class _$FabricColorTreatmentMethodDao extends FabricColorTreatmentMethodDao {
  _$FabricColorTreatmentMethodDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _fabricColorTreatmentMethodInsertionAdapter = InsertionAdapter(
            database,
            'fiber_color_treatment_method',
            (FabricColorTreatmentMethod item) => <String, Object?>{
                  'fctmId': item.fctmId,
                  'fabricFamilyIdfk': item.fabricFamilyIdfk,
                  'fctmName': item.fctmName,
                  'fctmDescription': item.fctmDescription,
                  'fctmIsActive': item.fctmIsActive,
                  'fctmSortid': item.fctmSortid
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<FabricColorTreatmentMethod>
      _fabricColorTreatmentMethodInsertionAdapter;

  @override
  Future<List<FabricColorTreatmentMethod>>
      findAllFabricColorTreatmentMethod() async {
    return _queryAdapter.queryList('SELECT * FROM fiber_color_treatment_method',
        mapper: (Map<String, Object?> row) => FabricColorTreatmentMethod(
            fctmId: row['fctmId'] as int?,
            fabricFamilyIdfk: row['fabricFamilyIdfk'] as String?,
            fctmName: row['fctmName'] as String?,
            fctmDescription: row['fctmDescription'] as String?,
            fctmIsActive: row['fctmIsActive'] as String?,
            fctmSortid: row['fctmSortid'] as String?));
  }

  @override
  Future<List<FabricColorTreatmentMethod>> findFabricColorTreatmentMethod(
      int id) async {
    return _queryAdapter.queryList(
        'SELECT * FROM fiber_color_treatment_method where fctmId = ?1',
        mapper: (Map<String, Object?> row) => FabricColorTreatmentMethod(
            fctmId: row['fctmId'] as int?,
            fabricFamilyIdfk: row['fabricFamilyIdfk'] as String?,
            fctmName: row['fctmName'] as String?,
            fctmDescription: row['fctmDescription'] as String?,
            fctmIsActive: row['fctmIsActive'] as String?,
            fctmSortid: row['fctmSortid'] as String?),
        arguments: [id]);
  }

  @override
  Future<void> deleteFabricFiberColorTreatmentMethod(int id) async {
    await _queryAdapter.queryNoReturn(
        'delete from fiber_color_treatment_method where fctmId = ?1',
        arguments: [id]);
  }

  @override
  Future<void> deleteFabricFiberColorTreatmentMethods() async {
    await _queryAdapter
        .queryNoReturn('delete from fiber_color_treatment_method');
  }

  @override
  Future<void> insertFabricColorTreatmentMethod(
      FabricColorTreatmentMethod fabricColorTreatmentMethod) async {
    await _fabricColorTreatmentMethodInsertionAdapter.insert(
        fabricColorTreatmentMethod, OnConflictStrategy.replace);
  }

  @override
  Future<List<int>> insertAllFabricFiberColorTreatmentMethod(
      List<FabricColorTreatmentMethod> fabricColorTreatmentMethod) {
    return _fabricColorTreatmentMethodInsertionAdapter.insertListAndReturnIds(
        fabricColorTreatmentMethod, OnConflictStrategy.replace);
  }
}

class _$FabricDyingTechniqueDao extends FabricDyingTechniqueDao {
  _$FabricDyingTechniqueDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _fabricDyingTechniquesInsertionAdapter = InsertionAdapter(
            database,
            'fabric_dying_techniques',
            (FabricDyingTechniques item) => <String, Object?>{
                  'fdtId': item.fdtId,
                  'fctmIdfk': item.fctmIdfk,
                  'fabricFamilyIdfk': item.fabricFamilyIdfk,
                  'fdtName': item.fdtName,
                  'fdtIsActive': item.fdtIsActive,
                  'fdtSortid': item.fdtSortid
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<FabricDyingTechniques>
      _fabricDyingTechniquesInsertionAdapter;

  @override
  Future<List<FabricDyingTechniques>> findAllFabricDyingTechniques() async {
    return _queryAdapter.queryList('SELECT * FROM fabric_dying_techniques',
        mapper: (Map<String, Object?> row) => FabricDyingTechniques(
            fdtId: row['fdtId'] as int?,
            fctmIdfk: row['fctmIdfk'] as String?,
            fabricFamilyIdfk: row['fabricFamilyIdfk'] as String?,
            fdtName: row['fdtName'] as String?,
            fdtIsActive: row['fdtIsActive'] as String?,
            fdtSortid: row['fdtSortid'] as String?));
  }

  @override
  Future<List<FabricDyingTechniques>> findFabricDyingTechnique(int id) async {
    return _queryAdapter.queryList(
        'SELECT * FROM fabric_dying_techniques where fdtId = ?1',
        mapper: (Map<String, Object?> row) => FabricDyingTechniques(
            fdtId: row['fdtId'] as int?,
            fctmIdfk: row['fctmIdfk'] as String?,
            fabricFamilyIdfk: row['fabricFamilyIdfk'] as String?,
            fdtName: row['fdtName'] as String?,
            fdtIsActive: row['fdtIsActive'] as String?,
            fdtSortid: row['fdtSortid'] as String?),
        arguments: [id]);
  }

  @override
  Future<void> deleteFabricDyingTechnique(int id) async {
    await _queryAdapter.queryNoReturn(
        'delete from fabric_dying_techniques where fdtId = ?1',
        arguments: [id]);
  }

  @override
  Future<void> deleteFabricDyingTechniques() async {
    await _queryAdapter.queryNoReturn('delete from fabric_dying_techniques');
  }

  @override
  Future<void> insertFabricDyingTechnique(
      FabricDyingTechniques fabricFabricDyingTechnique) async {
    await _fabricDyingTechniquesInsertionAdapter.insert(
        fabricFabricDyingTechnique, OnConflictStrategy.replace);
  }

  @override
  Future<List<int>> insertAllFabricDyingTechnique(
      List<FabricDyingTechniques> fabricFabricDyingTechnique) {
    return _fabricDyingTechniquesInsertionAdapter.insertListAndReturnIds(
        fabricFabricDyingTechnique, OnConflictStrategy.replace);
  }
}

class _$FabricQualityDao extends FabricQualityDao {
  _$FabricQualityDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _fabricQualityInsertionAdapter = InsertionAdapter(
            database,
            'fabric_quality',
            (FabricQuality item) => <String, Object?>{
                  'fabricQualityId': item.fabricQualityId,
                  'fabricQualityName': item.fabricQualityName,
                  'fabricFamilyIdfk': item.fabricFamilyIdfk
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<FabricQuality> _fabricQualityInsertionAdapter;

  @override
  Future<List<FabricQuality>> findAllFabricQuality() async {
    return _queryAdapter.queryList('SELECT * FROM fabric_quality',
        mapper: (Map<String, Object?> row) => FabricQuality(
            fabricQualityId: row['fabricQualityId'] as int?,
            fabricQualityName: row['fabricQualityName'] as String?,
            fabricFamilyIdfk: row['fabricFamilyIdfk'] as String?));
  }

  @override
  Future<List<FabricQuality>> findFabricQuality(int id) async {
    return _queryAdapter.queryList(
        'SELECT * FROM fabric_quality where fabricQualityId = ?1',
        mapper: (Map<String, Object?> row) => FabricQuality(
            fabricQualityId: row['fabricQualityId'] as int?,
            fabricQualityName: row['fabricQualityName'] as String?,
            fabricFamilyIdfk: row['fabricFamilyIdfk'] as String?),
        arguments: [id]);
  }

  @override
  Future<void> deleteFabricQuality(int id) async {
    await _queryAdapter.queryNoReturn(
        'delete from fabric_quality where fabricQualityId = ?1',
        arguments: [id]);
  }

  @override
  Future<void> deleteFabricQualities() async {
    await _queryAdapter.queryNoReturn('delete from fabric_quality');
  }

  @override
  Future<void> insertFabricQuality(FabricQuality fabricFabricQuality) async {
    await _fabricQualityInsertionAdapter.insert(
        fabricFabricQuality, OnConflictStrategy.replace);
  }

  @override
  Future<List<int>> insertAllFabricQuality(
      List<FabricQuality> fabricFabricQuality) {
    return _fabricQualityInsertionAdapter.insertListAndReturnIds(
        fabricFabricQuality, OnConflictStrategy.replace);
  }
}

class _$FabricGradesDao extends FabricGradesDao {
  _$FabricGradesDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _fabricGradesInsertionAdapter = InsertionAdapter(
            database,
            'fabric_grades',
            (FabricGrades item) => <String, Object?>{
                  'fabricGradeId': item.fabricGradeId,
                  'fabricGradeName': item.fabricGradeName,
                  'fabricFamilyIdfk': item.fabricFamilyIdfk
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<FabricGrades> _fabricGradesInsertionAdapter;

  @override
  Future<List<FabricGrades>> findAllFabricGrade() async {
    return _queryAdapter.queryList('SELECT * FROM fabric_grades',
        mapper: (Map<String, Object?> row) => FabricGrades(
            fabricGradeId: row['fabricGradeId'] as int?,
            fabricGradeName: row['fabricGradeName'] as String?,
            fabricFamilyIdfk: row['fabricFamilyIdfk'] as String?));
  }

  @override
  Future<List<FabricGrades>> findFabricGrade(int id) async {
    return _queryAdapter.queryList(
        'SELECT * FROM fabric_grades where fabricGradeId = ?1',
        mapper: (Map<String, Object?> row) => FabricGrades(
            fabricGradeId: row['fabricGradeId'] as int?,
            fabricGradeName: row['fabricGradeName'] as String?,
            fabricFamilyIdfk: row['fabricFamilyIdfk'] as String?),
        arguments: [id]);
  }

  @override
  Future<void> deleteFabricGrade(int id) async {
    await _queryAdapter.queryNoReturn(
        'delete from fabric_grades where fabricGradeId = ?1',
        arguments: [id]);
  }

  @override
  Future<void> deleteFabricGrades() async {
    await _queryAdapter.queryNoReturn('delete from fabric_grades');
  }

  @override
  Future<void> insertFabricGrade(FabricGrades fabricFabricGrade) async {
    await _fabricGradesInsertionAdapter.insert(
        fabricFabricGrade, OnConflictStrategy.replace);
  }

  @override
  Future<List<int>> insertAllFabricGrade(List<FabricGrades> fabricFabricGrade) {
    return _fabricGradesInsertionAdapter.insertListAndReturnIds(
        fabricFabricGrade, OnConflictStrategy.replace);
  }
}

class _$FabricLoomDao extends FabricLoomDao {
  _$FabricLoomDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _fabricLoomInsertionAdapter = InsertionAdapter(
            database,
            'fabric_loom',
            (FabricLoom item) => <String, Object?>{
                  'fabricLoomId': item.fabricLoomId,
                  'fabricLoomName': item.fabricLoomName,
                  'fabricFamilyIdfk': item.fabricFamilyIdfk
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<FabricLoom> _fabricLoomInsertionAdapter;

  @override
  Future<List<FabricLoom>> findAllFabricLoom() async {
    return _queryAdapter.queryList('SELECT * FROM fabric_loom',
        mapper: (Map<String, Object?> row) => FabricLoom(
            fabricLoomId: row['fabricLoomId'] as int?,
            fabricLoomName: row['fabricLoomName'] as String?,
            fabricFamilyIdfk: row['fabricFamilyIdfk'] as String?));
  }

  @override
  Future<List<FabricLoom>> findFabricLoom(int id) async {
    return _queryAdapter.queryList(
        'SELECT * FROM fabric_loom where fabricLoomId = ?1',
        mapper: (Map<String, Object?> row) => FabricLoom(
            fabricLoomId: row['fabricLoomId'] as int?,
            fabricLoomName: row['fabricLoomName'] as String?,
            fabricFamilyIdfk: row['fabricFamilyIdfk'] as String?),
        arguments: [id]);
  }

  @override
  Future<void> deleteFabricLoom(int id) async {
    await _queryAdapter.queryNoReturn(
        'delete from fabric_loom where fabricLoomId = ?1',
        arguments: [id]);
  }

  @override
  Future<void> deleteFabricLooms() async {
    await _queryAdapter.queryNoReturn('delete from fabric_loom');
  }

  @override
  Future<void> insertFabricLoom(FabricLoom fabricFabricLoom) async {
    await _fabricLoomInsertionAdapter.insert(
        fabricFabricLoom, OnConflictStrategy.replace);
  }

  @override
  Future<List<int>> insertAllFabricLoom(List<FabricLoom> fabricFabricLoom) {
    return _fabricLoomInsertionAdapter.insertListAndReturnIds(
        fabricFabricLoom, OnConflictStrategy.replace);
  }
}

class _$FabricSalvedgeDao extends FabricSalvedgeDao {
  _$FabricSalvedgeDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _fabricSalvedgeInsertionAdapter = InsertionAdapter(
            database,
            'fabric_salvedge',
            (FabricSalvedge item) => <String, Object?>{
                  'fabricSalvedgeId': item.fabricSalvedgeId,
                  'fabricSalvedgeName': item.fabricSalvedgeName,
                  'fabricFamilyIdfk': item.fabricFamilyIdfk
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<FabricSalvedge> _fabricSalvedgeInsertionAdapter;

  @override
  Future<List<FabricSalvedge>> findAllFabricSalvedge() async {
    return _queryAdapter.queryList('SELECT * FROM fabric_salvedge',
        mapper: (Map<String, Object?> row) => FabricSalvedge(
            fabricSalvedgeId: row['fabricSalvedgeId'] as int?,
            fabricSalvedgeName: row['fabricSalvedgeName'] as String?,
            fabricFamilyIdfk: row['fabricFamilyIdfk'] as String?));
  }

  @override
  Future<List<FabricSalvedge>> findFabricSalvedge(int id) async {
    return _queryAdapter.queryList(
        'SELECT * FROM fabric_salvedge where fabricSalvedgeId = ?1',
        mapper: (Map<String, Object?> row) => FabricSalvedge(
            fabricSalvedgeId: row['fabricSalvedgeId'] as int?,
            fabricSalvedgeName: row['fabricSalvedgeName'] as String?,
            fabricFamilyIdfk: row['fabricFamilyIdfk'] as String?),
        arguments: [id]);
  }

  @override
  Future<void> deleteFabricSalvedge(int id) async {
    await _queryAdapter.queryNoReturn(
        'delete from fabric_salvedge where fabricSalvedgeId = ?1',
        arguments: [id]);
  }

  @override
  Future<void> deleteFabricSalvedges() async {
    await _queryAdapter.queryNoReturn('delete from fabric_salvedge');
  }

  @override
  Future<void> insertFabricSalvedge(FabricSalvedge fabricFabricSalvedge) async {
    await _fabricSalvedgeInsertionAdapter.insert(
        fabricFabricSalvedge, OnConflictStrategy.replace);
  }

  @override
  Future<List<int>> insertAllFabricSalvedge(
      List<FabricSalvedge> fabricFabricSalvedge) {
    return _fabricSalvedgeInsertionAdapter.insertListAndReturnIds(
        fabricFabricSalvedge, OnConflictStrategy.replace);
  }
}

class _$FabricWeaveDao extends FabricWeaveDao {
  _$FabricWeaveDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _fabricWeaveInsertionAdapter = InsertionAdapter(
            database,
            'fabric_weave',
            (FabricWeave item) => <String, Object?>{
                  'fabricWeaveId': item.fabricWeaveId,
                  'fabricWeaveName': item.fabricWeaveName,
                  'fabricFamilyIdfk': item.fabricFamilyIdfk
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<FabricWeave> _fabricWeaveInsertionAdapter;

  @override
  Future<List<FabricWeave>> findAllFabricWeave() async {
    return _queryAdapter.queryList('SELECT * FROM fabric_weave',
        mapper: (Map<String, Object?> row) => FabricWeave(
            fabricWeaveId: row['fabricWeaveId'] as int?,
            fabricWeaveName: row['fabricWeaveName'] as String?,
            fabricFamilyIdfk: row['fabricFamilyIdfk'] as String?));
  }

  @override
  Future<List<FabricWeave>> findFabricWeave(int id) async {
    return _queryAdapter.queryList(
        'SELECT * FROM fabric_weave where fabricWeaveId = ?1',
        mapper: (Map<String, Object?> row) => FabricWeave(
            fabricWeaveId: row['fabricWeaveId'] as int?,
            fabricWeaveName: row['fabricWeaveName'] as String?,
            fabricFamilyIdfk: row['fabricFamilyIdfk'] as String?),
        arguments: [id]);
  }

  @override
  Future<void> deleteFabricWeave(int id) async {
    await _queryAdapter.queryNoReturn(
        'delete from fabric_weave where fabricWeaveId = ?1',
        arguments: [id]);
  }

  @override
  Future<void> deleteFabricWeaves() async {
    await _queryAdapter.queryNoReturn('delete from fabric_weave');
  }

  @override
  Future<void> insertFabricWeave(FabricWeave fabricFabricWeave) async {
    await _fabricWeaveInsertionAdapter.insert(
        fabricFabricWeave, OnConflictStrategy.replace);
  }

  @override
  Future<List<int>> insertAllFabricWeave(List<FabricWeave> fabricFabricWeave) {
    return _fabricWeaveInsertionAdapter.insertListAndReturnIds(
        fabricFabricWeave, OnConflictStrategy.replace);
  }
}

class _$FabricLayyerDao extends FabricLayyerDao {
  _$FabricLayyerDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _fabricLayyerInsertionAdapter = InsertionAdapter(
            database,
            'fabric_layyer',
            (FabricLayyer item) => <String, Object?>{
                  'fabricLayyerId': item.fabricLayyerId,
                  'fabricLayyerName': item.fabricLayyerName,
                  'fabricFamilyIdfk': item.fabricFamilyIdfk
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<FabricLayyer> _fabricLayyerInsertionAdapter;

  @override
  Future<List<FabricLayyer>> findAllFabricLayyer() async {
    return _queryAdapter.queryList('SELECT * FROM fabric_layyer',
        mapper: (Map<String, Object?> row) => FabricLayyer(
            fabricLayyerId: row['fabricLayyerId'] as int?,
            fabricLayyerName: row['fabricLayyerName'] as String?,
            fabricFamilyIdfk: row['fabricFamilyIdfk'] as String?));
  }

  @override
  Future<List<FabricLayyer>> findFabricLayyer(int id) async {
    return _queryAdapter.queryList(
        'SELECT * FROM fabric_layyer where fabricLayyerId = ?1',
        mapper: (Map<String, Object?> row) => FabricLayyer(
            fabricLayyerId: row['fabricLayyerId'] as int?,
            fabricLayyerName: row['fabricLayyerName'] as String?,
            fabricFamilyIdfk: row['fabricFamilyIdfk'] as String?),
        arguments: [id]);
  }

  @override
  Future<void> deleteFabricLayyer(int id) async {
    await _queryAdapter.queryNoReturn(
        'delete from fabric_layyer where fabricLayyerId = ?1',
        arguments: [id]);
  }

  @override
  Future<void> deleteFabricLayyers() async {
    await _queryAdapter.queryNoReturn('delete from fabric_layyer');
  }

  @override
  Future<void> insertFabricLayyer(FabricLayyer fabricFabricLayyer) async {
    await _fabricLayyerInsertionAdapter.insert(
        fabricFabricLayyer, OnConflictStrategy.replace);
  }

  @override
  Future<List<int>> insertAllFabricLayyer(
      List<FabricLayyer> fabricFabricLayyer) {
    return _fabricLayyerInsertionAdapter.insertListAndReturnIds(
        fabricFabricLayyer, OnConflictStrategy.replace);
  }
}

class _$YarnSettingDao extends YarnSettingDao {
  _$YarnSettingDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _yarnSettingInsertionAdapter = InsertionAdapter(
            database,
            'yarn_settings',
            (YarnSetting item) => <String, Object?>{
                  'ysId': item.ysId,
                  'ysBlendIdfk': item.ysBlendIdfk,
                  'ysFamilyIdfk': item.ysFamilyIdfk,
                  'showCount': item.showCount,
                  'countMinMax': item.countMinMax,
                  'showOrigin': item.showOrigin,
                  'showDannier': item.showDannier,
                  'dannierMinMax': item.dannierMinMax,
                  'showFilament': item.showFilament,
                  'filamentMinMax': item.filamentMinMax,
                  'showBlend': item.showBlend,
                  'showPly': item.showPly,
                  'showSpunTechnique': item.showSpunTechnique,
                  'showQuality': item.showQuality,
                  'showGrade': item.showGrade,
                  'showDoublingMethod': item.showDoublingMethod,
                  'showCertification': item.showCertification,
                  'showColorTreatmentMethod': item.showColorTreatmentMethod,
                  'showDyingMethod': item.showDyingMethod,
                  'showColor': item.showColor,
                  'showAppearance': item.showAppearance,
                  'showQlt': item.showQlt,
                  'qltMinMax': item.qltMinMax,
                  'showClsp': item.showClsp,
                  'clspMinMax': item.clspMinMax,
                  'showUniformity': item.showUniformity,
                  'uniformityMinMax': item.uniformityMinMax,
                  'showCv': item.showCv,
                  'cvMinMax': item.cvMinMax,
                  'showThinPlaces': item.showThinPlaces,
                  'thinPlacesMinMax': item.thinPlacesMinMax,
                  'showtThickPlaces': item.showtThickPlaces,
                  'thickPlacesMinMax': item.thickPlacesMinMax,
                  'showNaps': item.showNaps,
                  'napsMinMax': item.napsMinMax,
                  'showIpmKm': item.showIpmKm,
                  'ipmKmMinMax': item.ipmKmMinMax,
                  'showHairness': item.showHairness,
                  'hairnessMinMax': item.hairnessMinMax,
                  'showRkm': item.showRkm,
                  'rkmMinMax': item.rkmMinMax,
                  'showElongation': item.showElongation,
                  'elongationMinMax': item.elongationMinMax,
                  'showTpi': item.showTpi,
                  'tpiMinMax': item.tpiMinMax,
                  'showTm': item.showTm,
                  'tmMinMax': item.tmMinMax,
                  'showDty': item.showDty,
                  'dtyMinMax': item.dtyMinMax,
                  'showFdy': item.showFdy,
                  'fdyMinMax': item.fdyMinMax,
                  'showRatio': item.showRatio,
                  'showTexturized': item.showTexturized,
                  'showUsage': item.showUsage,
                  'showPattern': item.showPattern,
                  'showPatternCharectristic': item.showPatternCharectristic,
                  'showOrientation': item.showOrientation,
                  'showTwistDirection': item.showTwistDirection,
                  'ysIsActive': item.ysIsActive,
                  'ysSortid': item.ysSortid,
                  'show_actual_count': item.show_actual_count,
                  'actual_count_min_max': item.actual_count_min_max
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<YarnSetting> _yarnSettingInsertionAdapter;

  @override
  Future<List<YarnSetting>> findAllYarnSettings() async {
    return _queryAdapter.queryList('SELECT * FROM yarn_settings',
        mapper: (Map<String, Object?> row) => YarnSetting(
            ysId: row['ysId'] as int?,
            ysBlendIdfk: row['ysBlendIdfk'] as String?,
            ysFamilyIdfk: row['ysFamilyIdfk'] as String?,
            showCount: row['showCount'] as String?,
            countMinMax: row['countMinMax'] as String?,
            showOrigin: row['showOrigin'] as String?,
            showDannier: row['showDannier'] as String?,
            dannierMinMax: row['dannierMinMax'] as String?,
            showFilament: row['showFilament'] as String?,
            filamentMinMax: row['filamentMinMax'] as String?,
            showBlend: row['showBlend'] as String?,
            showPly: row['showPly'] as String?,
            showSpunTechnique: row['showSpunTechnique'] as String?,
            showQuality: row['showQuality'] as String?,
            showGrade: row['showGrade'] as String?,
            showDoublingMethod: row['showDoublingMethod'] as String?,
            showCertification: row['showCertification'] as String?,
            showColorTreatmentMethod:
                row['showColorTreatmentMethod'] as String?,
            showDyingMethod: row['showDyingMethod'] as String?,
            showColor: row['showColor'] as String?,
            showAppearance: row['showAppearance'] as String?,
            showQlt: row['showQlt'] as String?,
            qltMinMax: row['qltMinMax'] as String?,
            showClsp: row['showClsp'] as String?,
            clspMinMax: row['clspMinMax'] as String?,
            showUniformity: row['showUniformity'] as String?,
            uniformityMinMax: row['uniformityMinMax'] as String?,
            showCv: row['showCv'] as String?,
            cvMinMax: row['cvMinMax'] as String?,
            showThinPlaces: row['showThinPlaces'] as String?,
            thinPlacesMinMax: row['thinPlacesMinMax'] as String?,
            showtThickPlaces: row['showtThickPlaces'] as String?,
            thickPlacesMinMax: row['thickPlacesMinMax'] as String?,
            showNaps: row['showNaps'] as String?,
            napsMinMax: row['napsMinMax'] as String?,
            showIpmKm: row['showIpmKm'] as String?,
            ipmKmMinMax: row['ipmKmMinMax'] as String?,
            showHairness: row['showHairness'] as String?,
            hairnessMinMax: row['hairnessMinMax'] as String?,
            showRkm: row['showRkm'] as String?,
            rkmMinMax: row['rkmMinMax'] as String?,
            showElongation: row['showElongation'] as String?,
            elongationMinMax: row['elongationMinMax'] as String?,
            showTpi: row['showTpi'] as String?,
            tpiMinMax: row['tpiMinMax'] as String?,
            showTm: row['showTm'] as String?,
            tmMinMax: row['tmMinMax'] as String?,
            showDty: row['showDty'] as String?,
            dtyMinMax: row['dtyMinMax'] as String?,
            showFdy: row['showFdy'] as String?,
            fdyMinMax: row['fdyMinMax'] as String?,
            showRatio: row['showRatio'] as String?,
            showTexturized: row['showTexturized'] as String?,
            showUsage: row['showUsage'] as String?,
            showPattern: row['showPattern'] as String?,
            showPatternCharectristic:
                row['showPatternCharectristic'] as String?,
            showOrientation: row['showOrientation'] as String?,
            showTwistDirection: row['showTwistDirection'] as String?,
            ysIsActive: row['ysIsActive'] as String?,
            ysSortid: row['ysSortid'] as String?,
            show_actual_count: row['show_actual_count'] as String?,
            actual_count_min_max: row['actual_count_min_max'] as String?));
  }

  @override
  Future<List<YarnSetting>> findFamilyAndBlendYarnSettings(
      int id, int materialId) async {
    return _queryAdapter.queryList(
        'SELECT * FROM yarn_settings where ysBlendIdfk = ?1 and ysFamilyIdfk = ?2',
        mapper: (Map<String, Object?> row) => YarnSetting(ysId: row['ysId'] as int?, ysBlendIdfk: row['ysBlendIdfk'] as String?, ysFamilyIdfk: row['ysFamilyIdfk'] as String?, showCount: row['showCount'] as String?, countMinMax: row['countMinMax'] as String?, showOrigin: row['showOrigin'] as String?, showDannier: row['showDannier'] as String?, dannierMinMax: row['dannierMinMax'] as String?, showFilament: row['showFilament'] as String?, filamentMinMax: row['filamentMinMax'] as String?, showBlend: row['showBlend'] as String?, showPly: row['showPly'] as String?, showSpunTechnique: row['showSpunTechnique'] as String?, showQuality: row['showQuality'] as String?, showGrade: row['showGrade'] as String?, showDoublingMethod: row['showDoublingMethod'] as String?, showCertification: row['showCertification'] as String?, showColorTreatmentMethod: row['showColorTreatmentMethod'] as String?, showDyingMethod: row['showDyingMethod'] as String?, showColor: row['showColor'] as String?, showAppearance: row['showAppearance'] as String?, showQlt: row['showQlt'] as String?, qltMinMax: row['qltMinMax'] as String?, showClsp: row['showClsp'] as String?, clspMinMax: row['clspMinMax'] as String?, showUniformity: row['showUniformity'] as String?, uniformityMinMax: row['uniformityMinMax'] as String?, showCv: row['showCv'] as String?, cvMinMax: row['cvMinMax'] as String?, showThinPlaces: row['showThinPlaces'] as String?, thinPlacesMinMax: row['thinPlacesMinMax'] as String?, showtThickPlaces: row['showtThickPlaces'] as String?, thickPlacesMinMax: row['thickPlacesMinMax'] as String?, showNaps: row['showNaps'] as String?, napsMinMax: row['napsMinMax'] as String?, showIpmKm: row['showIpmKm'] as String?, ipmKmMinMax: row['ipmKmMinMax'] as String?, showHairness: row['showHairness'] as String?, hairnessMinMax: row['hairnessMinMax'] as String?, showRkm: row['showRkm'] as String?, rkmMinMax: row['rkmMinMax'] as String?, showElongation: row['showElongation'] as String?, elongationMinMax: row['elongationMinMax'] as String?, showTpi: row['showTpi'] as String?, tpiMinMax: row['tpiMinMax'] as String?, showTm: row['showTm'] as String?, tmMinMax: row['tmMinMax'] as String?, showDty: row['showDty'] as String?, dtyMinMax: row['dtyMinMax'] as String?, showFdy: row['showFdy'] as String?, fdyMinMax: row['fdyMinMax'] as String?, showRatio: row['showRatio'] as String?, showTexturized: row['showTexturized'] as String?, showUsage: row['showUsage'] as String?, showPattern: row['showPattern'] as String?, showPatternCharectristic: row['showPatternCharectristic'] as String?, showOrientation: row['showOrientation'] as String?, showTwistDirection: row['showTwistDirection'] as String?, ysIsActive: row['ysIsActive'] as String?, ysSortid: row['ysSortid'] as String?, show_actual_count: row['show_actual_count'] as String?, actual_count_min_max: row['actual_count_min_max'] as String?),
        arguments: [id, materialId]);
  }

  @override
  Future<List<YarnSetting>> findFamilyYarnSettings(int id) async {
    return _queryAdapter.queryList(
        'SELECT * FROM yarn_settings where ysFamilyIdfk = ?1',
        mapper: (Map<String, Object?> row) => YarnSetting(
            ysId: row['ysId'] as int?,
            ysBlendIdfk: row['ysBlendIdfk'] as String?,
            ysFamilyIdfk: row['ysFamilyIdfk'] as String?,
            showCount: row['showCount'] as String?,
            countMinMax: row['countMinMax'] as String?,
            showOrigin: row['showOrigin'] as String?,
            showDannier: row['showDannier'] as String?,
            dannierMinMax: row['dannierMinMax'] as String?,
            showFilament: row['showFilament'] as String?,
            filamentMinMax: row['filamentMinMax'] as String?,
            showBlend: row['showBlend'] as String?,
            showPly: row['showPly'] as String?,
            showSpunTechnique: row['showSpunTechnique'] as String?,
            showQuality: row['showQuality'] as String?,
            showGrade: row['showGrade'] as String?,
            showDoublingMethod: row['showDoublingMethod'] as String?,
            showCertification: row['showCertification'] as String?,
            showColorTreatmentMethod:
                row['showColorTreatmentMethod'] as String?,
            showDyingMethod: row['showDyingMethod'] as String?,
            showColor: row['showColor'] as String?,
            showAppearance: row['showAppearance'] as String?,
            showQlt: row['showQlt'] as String?,
            qltMinMax: row['qltMinMax'] as String?,
            showClsp: row['showClsp'] as String?,
            clspMinMax: row['clspMinMax'] as String?,
            showUniformity: row['showUniformity'] as String?,
            uniformityMinMax: row['uniformityMinMax'] as String?,
            showCv: row['showCv'] as String?,
            cvMinMax: row['cvMinMax'] as String?,
            showThinPlaces: row['showThinPlaces'] as String?,
            thinPlacesMinMax: row['thinPlacesMinMax'] as String?,
            showtThickPlaces: row['showtThickPlaces'] as String?,
            thickPlacesMinMax: row['thickPlacesMinMax'] as String?,
            showNaps: row['showNaps'] as String?,
            napsMinMax: row['napsMinMax'] as String?,
            showIpmKm: row['showIpmKm'] as String?,
            ipmKmMinMax: row['ipmKmMinMax'] as String?,
            showHairness: row['showHairness'] as String?,
            hairnessMinMax: row['hairnessMinMax'] as String?,
            showRkm: row['showRkm'] as String?,
            rkmMinMax: row['rkmMinMax'] as String?,
            showElongation: row['showElongation'] as String?,
            elongationMinMax: row['elongationMinMax'] as String?,
            showTpi: row['showTpi'] as String?,
            tpiMinMax: row['tpiMinMax'] as String?,
            showTm: row['showTm'] as String?,
            tmMinMax: row['tmMinMax'] as String?,
            showDty: row['showDty'] as String?,
            dtyMinMax: row['dtyMinMax'] as String?,
            showFdy: row['showFdy'] as String?,
            fdyMinMax: row['fdyMinMax'] as String?,
            showRatio: row['showRatio'] as String?,
            showTexturized: row['showTexturized'] as String?,
            showUsage: row['showUsage'] as String?,
            showPattern: row['showPattern'] as String?,
            showPatternCharectristic:
                row['showPatternCharectristic'] as String?,
            showOrientation: row['showOrientation'] as String?,
            showTwistDirection: row['showTwistDirection'] as String?,
            ysIsActive: row['ysIsActive'] as String?,
            ysSortid: row['ysSortid'] as String?,
            show_actual_count: row['show_actual_count'] as String?,
            actual_count_min_max: row['actual_count_min_max'] as String?),
        arguments: [id]);
  }

  @override
  Future<void> deleteYarnSetting(int id) async {
    await _queryAdapter.queryNoReturn('delete from yarn_settings where id = ?1',
        arguments: [id]);
  }

  @override
  Future<void> deleteYarnSettings() async {
    await _queryAdapter.queryNoReturn('delete from yarn_settings');
  }

  @override
  Future<void> insertYarnSetting(YarnSetting yarnSettings) async {
    await _yarnSettingInsertionAdapter.insert(
        yarnSettings, OnConflictStrategy.replace);
  }

  @override
  Future<List<int>> insertAllYarnSettings(List<YarnSetting> fiberSettings) {
    return _yarnSettingInsertionAdapter.insertListAndReturnIds(
        fiberSettings, OnConflictStrategy.replace);
  }
}

class _$YarnFamilyDao extends YarnFamilyDao {
  _$YarnFamilyDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _familyInsertionAdapter = InsertionAdapter(
            database,
            'yarn_family',
            (Family item) => <String, Object?>{
                  'famId': item.famId,
                  'famName': item.famName,
                  'iconSelected': item.iconSelected,
                  'iconUnSelected': item.iconUnSelected,
                  'famType': item.famType,
                  'famDescription': item.famDescription,
                  'catIsActive': item.catIsActive
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Family> _familyInsertionAdapter;

  @override
  Future<List<Family>> findAllYarnFamily() async {
    return _queryAdapter.queryList('SELECT * FROM yarn_family',
        mapper: (Map<String, Object?> row) => Family(
            famId: row['famId'] as int?,
            famName: row['famName'] as String?,
            iconSelected: row['iconSelected'] as String?,
            iconUnSelected: row['iconUnSelected'] as String?,
            famType: row['famType'] as String?,
            famDescription: row['famDescription'] as String?,
            catIsActive: row['catIsActive'] as String?));
  }

  @override
  Future<List<Family>> findYarnFamily(int id) async {
    return _queryAdapter.queryList('SELECT * FROM yarn_family where famId = ?1',
        mapper: (Map<String, Object?> row) => Family(
            famId: row['famId'] as int?,
            famName: row['famName'] as String?,
            iconSelected: row['iconSelected'] as String?,
            iconUnSelected: row['iconUnSelected'] as String?,
            famType: row['famType'] as String?,
            famDescription: row['famDescription'] as String?,
            catIsActive: row['catIsActive'] as String?),
        arguments: [id]);
  }

  @override
  Future<void> deleteAll() async {
    await _queryAdapter.queryNoReturn('delete from yarn_family');
  }

  @override
  Future<void> insertAllYarnFamily(List<Family> yarnFamily) async {
    await _familyInsertionAdapter.insertList(
        yarnFamily, OnConflictStrategy.replace);
  }
}

class _$YarnBlendDao extends YarnBlendDao {
  _$YarnBlendDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _blendsInsertionAdapter = InsertionAdapter(
            database,
            'yarn_blend',
            (Blends item) => <String, Object?>{
                  'blnId': item.blnId,
                  'familyIdfk': item.familyIdfk,
                  'blnName': item.blnName,
                  'bln_category_idfk': item.bln_category_idfk,
                  'bln_nature': item.bln_nature,
                  'bln_abrv': item.bln_abrv,
                  'minMax': item.minMax,
                  'has_blend_id_1': item.has_blend_id_1,
                  'has_blend_id_2': item.has_blend_id_2,
                  'has_blend_name_1': item.has_blend_name_1,
                  'has_blend_name_2': item.has_blend_name_2,
                  'is_popular': item.is_popular,
                  'iconSelected': item.iconSelected,
                  'iconUnselected': item.iconUnselected,
                  'blnIsActive': item.blnIsActive,
                  'blnSortid': item.blnSortid,
                  'bln_ratio_json': item.bln_ratio_json,
                  'isSelected': item.isSelected == null
                      ? null
                      : (item.isSelected! ? 1 : 0),
                  'blendRatio': item.blendRatio
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Blends> _blendsInsertionAdapter;

  @override
  Future<List<Blends>> allYarnBlends() async {
    return _queryAdapter.queryList('SELECT * FROM yarn_blend',
        mapper: (Map<String, Object?> row) => Blends(
            blnId: row['blnId'] as int?,
            familyIdfk: row['familyIdfk'] as String?,
            blnName: row['blnName'] as String?,
            bln_category_idfk: row['bln_category_idfk'] as String?,
            bln_nature: row['bln_nature'] as String?,
            bln_abrv: row['bln_abrv'] as String?,
            minMax: row['minMax'] as String?,
            has_blend_id_1: row['has_blend_id_1'] as String?,
            has_blend_id_2: row['has_blend_id_2'] as String?,
            has_blend_name_1: row['has_blend_name_1'] as String?,
            has_blend_name_2: row['has_blend_name_2'] as String?,
            is_popular: row['is_popular'] as String?,
            iconSelected: row['iconSelected'] as String?,
            iconUnselected: row['iconUnselected'] as String?,
            blnIsActive: row['blnIsActive'] as String?,
            isSelected: row['isSelected'] == null
                ? null
                : (row['isSelected'] as int) != 0,
            blendRatio: row['blendRatio'] as String?,
            bln_ratio_json: row['bln_ratio_json'] as String?,
            blnSortid: row['blnSortid'] as String?));
  }

  @override
  Future<List<Blends>> findAllYarnBlends(int famId, int catId) async {
    return _queryAdapter.queryList(
        'SELECT * FROM yarn_blend where familyIdfk = ?1 and bln_category_idfk = ?2',
        mapper: (Map<String, Object?> row) => Blends(blnId: row['blnId'] as int?, familyIdfk: row['familyIdfk'] as String?, blnName: row['blnName'] as String?, bln_category_idfk: row['bln_category_idfk'] as String?, bln_nature: row['bln_nature'] as String?, bln_abrv: row['bln_abrv'] as String?, minMax: row['minMax'] as String?, has_blend_id_1: row['has_blend_id_1'] as String?, has_blend_id_2: row['has_blend_id_2'] as String?, has_blend_name_1: row['has_blend_name_1'] as String?, has_blend_name_2: row['has_blend_name_2'] as String?, is_popular: row['is_popular'] as String?, iconSelected: row['iconSelected'] as String?, iconUnselected: row['iconUnselected'] as String?, blnIsActive: row['blnIsActive'] as String?, isSelected: row['isSelected'] == null ? null : (row['isSelected'] as int) != 0, blendRatio: row['blendRatio'] as String?, bln_ratio_json: row['bln_ratio_json'] as String?, blnSortid: row['blnSortid'] as String?),
        arguments: [famId, catId]);
  }

  @override
  Future<List<Blends>> findYarnBlend(int id) async {
    return _queryAdapter.queryList('SELECT * FROM yarn_blend where blnId = ?1',
        mapper: (Map<String, Object?> row) => Blends(
            blnId: row['blnId'] as int?,
            familyIdfk: row['familyIdfk'] as String?,
            blnName: row['blnName'] as String?,
            bln_category_idfk: row['bln_category_idfk'] as String?,
            bln_nature: row['bln_nature'] as String?,
            bln_abrv: row['bln_abrv'] as String?,
            minMax: row['minMax'] as String?,
            has_blend_id_1: row['has_blend_id_1'] as String?,
            has_blend_id_2: row['has_blend_id_2'] as String?,
            has_blend_name_1: row['has_blend_name_1'] as String?,
            has_blend_name_2: row['has_blend_name_2'] as String?,
            is_popular: row['is_popular'] as String?,
            iconSelected: row['iconSelected'] as String?,
            iconUnselected: row['iconUnselected'] as String?,
            blnIsActive: row['blnIsActive'] as String?,
            isSelected: row['isSelected'] == null
                ? null
                : (row['isSelected'] as int) != 0,
            blendRatio: row['blendRatio'] as String?,
            bln_ratio_json: row['bln_ratio_json'] as String?,
            blnSortid: row['blnSortid'] as String?),
        arguments: [id]);
  }

  @override
  Future<void> deleteAll() async {
    await _queryAdapter.queryNoReturn('delete from yarn_blend');
  }

  @override
  Future<void> insertAllYarnBlend(List<Blends> yarnBlend) async {
    await _blendsInsertionAdapter.insertList(
        yarnBlend, OnConflictStrategy.replace);
  }
}

class _$YarnGradesDao extends YarnGradesDao {
  _$YarnGradesDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _yarnGradesInsertionAdapter = InsertionAdapter(
            database,
            'yarn_grades',
            (YarnGrades item) => <String, Object?>{
                  'grdId': item.grdId,
                  'familyId': item.familyId,
                  'blendId': item.blendId,
                  'grdCategoryIdfk': item.grdCategoryIdfk,
                  'grdName': item.grdName,
                  'grdIsActive': item.grdIsActive,
                  'grdSortid': item.grdSortid
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<YarnGrades> _yarnGradesInsertionAdapter;

  @override
  Future<List<YarnGrades>> findAllGrades() async {
    return _queryAdapter.queryList('SELECT * FROM yarn_grades',
        mapper: (Map<String, Object?> row) => YarnGrades(
            grdId: row['grdId'] as int?,
            familyId: row['familyId'] as String?,
            blendId: row['blendId'] as String?,
            grdName: row['grdName'] as String?,
            grdIsActive: row['grdIsActive'] as String?,
            grdSortid: row['grdSortid'] as String?));
  }

  @override
  Future<List<YarnGrades>> findGradeWithFamilyId(int id) async {
    return _queryAdapter.queryList(
        'SELECT * FROM yarn_grades where familyId = ?1',
        mapper: (Map<String, Object?> row) => YarnGrades(
            grdId: row['grdId'] as int?,
            familyId: row['familyId'] as String?,
            blendId: row['blendId'] as String?,
            grdName: row['grdName'] as String?,
            grdIsActive: row['grdIsActive'] as String?,
            grdSortid: row['grdSortid'] as String?),
        arguments: [id]);
  }

  @override
  Future<void> deleteGrade(int id) async {
    await _queryAdapter.queryNoReturn('delete from yarn_grades where id = ?1',
        arguments: [id]);
  }

  @override
  Future<void> deleteAll() async {
    await _queryAdapter.queryNoReturn('delete from yarn_grades');
  }

  @override
  Future<void> insertGrades(YarnGrades grades) async {
    await _yarnGradesInsertionAdapter.insert(
        grades, OnConflictStrategy.replace);
  }

  @override
  Future<List<int>> insertAllGrades(List<YarnGrades> grades) {
    return _yarnGradesInsertionAdapter.insertListAndReturnIds(
        grades, OnConflictStrategy.replace);
  }
}

class _$DoublingMethodDao extends DoublingMethodDao {
  _$DoublingMethodDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _doublingMethodInsertionAdapter = InsertionAdapter(
            database,
            'doubling_method',
            (DoublingMethod item) => <String, Object?>{
                  'dmId': item.dmId,
                  'plyId': item.plyId,
                  'dmName': item.dmName,
                  'catIsActive': item.catIsActive,
                  'catSortid': item.catSortid
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<DoublingMethod> _doublingMethodInsertionAdapter;

  @override
  Future<List<DoublingMethod>> findAllDoublingMethod() async {
    return _queryAdapter.queryList('SELECT * FROM doubling_method',
        mapper: (Map<String, Object?> row) => DoublingMethod(
            dmId: row['dmId'] as int?,
            plyId: row['plyId'] as String?,
            dmName: row['dmName'] as String?,
            catIsActive: row['catIsActive'] as String?,
            catSortid: row['catSortid'] as String?));
  }

  @override
  Future<List<DoublingMethod>> findYarnDoublingMethodWithPlyId(int id) async {
    return _queryAdapter.queryList(
        'SELECT * FROM doubling_method where plyId = ?1',
        mapper: (Map<String, Object?> row) => DoublingMethod(
            dmId: row['dmId'] as int?,
            plyId: row['plyId'] as String?,
            dmName: row['dmName'] as String?,
            catIsActive: row['catIsActive'] as String?,
            catSortid: row['catSortid'] as String?),
        arguments: [id]);
  }

  @override
  Future<void> deleteDoublingMethod(int id) async {
    await _queryAdapter.queryNoReturn(
        'delete from doubling_method where yctmId = ?1',
        arguments: [id]);
  }

  @override
  Future<void> deleteAll() async {
    await _queryAdapter.queryNoReturn('delete from doubling_method');
  }

  @override
  Future<void> insertDoublingMethod(DoublingMethod colorTm) async {
    await _doublingMethodInsertionAdapter.insert(
        colorTm, OnConflictStrategy.replace);
  }

  @override
  Future<List<int>> insertAllDoublingMethod(List<DoublingMethod> colorTm) {
    return _doublingMethodInsertionAdapter.insertListAndReturnIds(
        colorTm, OnConflictStrategy.replace);
  }
}

class _$ColorTreatmentMethodDao extends ColorTreatmentMethodDao {
  _$ColorTreatmentMethodDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _colorTreatmentMethodInsertionAdapter = InsertionAdapter(
            database,
            'color_treatment_method',
            (ColorTreatmentMethod item) => <String, Object?>{
                  'yctmId': item.yctmId,
                  'familyId': item.familyId,
                  'yctmName': item.yctmName,
                  'yctmColorMethodIdfk': item.yctmColorMethodIdfk,
                  'yctmDescription': item.yctmDescription,
                  'yctmIsActive': item.yctmIsActive,
                  'yctmSortid': item.yctmSortid
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<ColorTreatmentMethod>
      _colorTreatmentMethodInsertionAdapter;

  @override
  Future<List<ColorTreatmentMethod>> findAllColorTreatmentMethod() async {
    return _queryAdapter.queryList('SELECT * FROM color_treatment_method',
        mapper: (Map<String, Object?> row) => ColorTreatmentMethod(
            yctmId: row['yctmId'] as int?,
            familyId: row['familyId'] as String?,
            yctmName: row['yctmName'] as String?,
            yctmColorMethodIdfk: row['yctmColorMethodIdfk'] as String?,
            yctmDescription: row['yctmDescription'] as String?,
            yctmIsActive: row['yctmIsActive'] as String?,
            yctmSortid: row['yctmSortid'] as String?));
  }

  @override
  Future<List<ColorTreatmentMethod>> findYarnColorTreatmentMethodWithFamilyId(
      int id) async {
    return _queryAdapter.queryList(
        'SELECT * FROM color_treatment_method where familyId = ?1',
        mapper: (Map<String, Object?> row) => ColorTreatmentMethod(
            yctmId: row['yctmId'] as int?,
            familyId: row['familyId'] as String?,
            yctmName: row['yctmName'] as String?,
            yctmColorMethodIdfk: row['yctmColorMethodIdfk'] as String?,
            yctmDescription: row['yctmDescription'] as String?,
            yctmIsActive: row['yctmIsActive'] as String?,
            yctmSortid: row['yctmSortid'] as String?),
        arguments: [id]);
  }

  @override
  Future<ColorTreatmentMethod?> findYarnColorTreatmentMethodWithId(
      int id) async {
    return _queryAdapter.query(
        'SELECT * FROM color_treatment_method where yctmId = ?1',
        mapper: (Map<String, Object?> row) => ColorTreatmentMethod(
            yctmId: row['yctmId'] as int?,
            familyId: row['familyId'] as String?,
            yctmName: row['yctmName'] as String?,
            yctmColorMethodIdfk: row['yctmColorMethodIdfk'] as String?,
            yctmDescription: row['yctmDescription'] as String?,
            yctmIsActive: row['yctmIsActive'] as String?,
            yctmSortid: row['yctmSortid'] as String?),
        arguments: [id]);
  }

  @override
  Future<void> deleteColorTreatmentMethod(int id) async {
    await _queryAdapter.queryNoReturn(
        'delete from color_treatment_method where yctmId = ?1',
        arguments: [id]);
  }

  @override
  Future<void> deleteAll() async {
    await _queryAdapter.queryNoReturn('delete from color_treatment_method');
  }

  @override
  Future<void> insertColorTreatmentMethod(ColorTreatmentMethod colorTm) async {
    await _colorTreatmentMethodInsertionAdapter.insert(
        colorTm, OnConflictStrategy.replace);
  }

  @override
  Future<List<int>> insertAllColorTreatmentMethod(
      List<ColorTreatmentMethod> colorTm) {
    return _colorTreatmentMethodInsertionAdapter.insertListAndReturnIds(
        colorTm, OnConflictStrategy.replace);
  }
}

class _$ConeTypeDao extends ConeTypeDao {
  _$ConeTypeDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _coneTypeInsertionAdapter = InsertionAdapter(
            database,
            'cone_type',
            (ConeType item) => <String, Object?>{
                  'yctId': item.yctId,
                  'familyId': item.familyId,
                  'ctCategoryIdfk': item.ctCategoryIdfk,
                  'yctName': item.yctName,
                  'yctDescription': item.yctDescription,
                  'yctIsActive': item.yctIsActive,
                  'yctSortid': item.yctSortid
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<ConeType> _coneTypeInsertionAdapter;

  @override
  Future<List<ConeType>> findAllConeType() async {
    return _queryAdapter.queryList('SELECT * FROM cone_type',
        mapper: (Map<String, Object?> row) => ConeType(
            yctId: row['yctId'] as int?,
            familyId: row['familyId'] as String?,
            yctName: row['yctName'] as String?,
            yctDescription: row['yctDescription'] as String?,
            yctIsActive: row['yctIsActive'] as String?,
            yctSortid: row['yctSortid'] as String?));
  }

  @override
  Future<List<ConeType>> findAllConeTypeWithCatAndFamID(
      int famId, int catId) async {
    return _queryAdapter.queryList(
        'SELECT * FROM cone_type where familyId = ?1 and ctCategoryIdfk = ?2',
        mapper: (Map<String, Object?> row) => ConeType(
            yctId: row['yctId'] as int?,
            familyId: row['familyId'] as String?,
            yctName: row['yctName'] as String?,
            yctDescription: row['yctDescription'] as String?,
            yctIsActive: row['yctIsActive'] as String?,
            yctSortid: row['yctSortid'] as String?),
        arguments: [famId, catId]);
  }

  @override
  Future<ConeType?> findYarnConeTypeWithId(int id) async {
    return _queryAdapter.query('SELECT * FROM cone_type where yctId = ?1',
        mapper: (Map<String, Object?> row) => ConeType(
            yctId: row['yctId'] as int?,
            familyId: row['familyId'] as String?,
            yctName: row['yctName'] as String?,
            yctDescription: row['yctDescription'] as String?,
            yctIsActive: row['yctIsActive'] as String?,
            yctSortid: row['yctSortid'] as String?),
        arguments: [id]);
  }

  @override
  Future<void> deleteConeType(int id) async {
    await _queryAdapter.queryNoReturn('delete from cone_type where yctId = ?1',
        arguments: [id]);
  }

  @override
  Future<void> deleteAll() async {
    await _queryAdapter.queryNoReturn('delete from cone_type');
  }

  @override
  Future<void> insertConeType(ConeType colorTm) async {
    await _coneTypeInsertionAdapter.insert(colorTm, OnConflictStrategy.replace);
  }

  @override
  Future<List<int>> insertAllConeType(List<ConeType> colorTm) {
    return _coneTypeInsertionAdapter.insertListAndReturnIds(
        colorTm, OnConflictStrategy.replace);
  }
}

class _$DyingMethodDao extends DyingMethodDao {
  _$DyingMethodDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _dyingMethodInsertionAdapter = InsertionAdapter(
            database,
            'dying_method',
            (DyingMethod item) => <String, Object?>{
                  'ydmId': item.ydmId,
                  'apperanceId': item.apperanceId,
                  'ydmName': item.ydmName,
                  'ydmType': item.ydmType,
                  'ydmColorTreatmentMethodIdfk':
                      item.ydmColorTreatmentMethodIdfk,
                  'ydmDescription': item.ydmDescription,
                  'ydmIsActive': item.ydmIsActive,
                  'ydmSortid': item.ydmSortid
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<DyingMethod> _dyingMethodInsertionAdapter;

  @override
  Future<List<DyingMethod>> findAllDyingMethod() async {
    return _queryAdapter.queryList('SELECT * FROM dying_method',
        mapper: (Map<String, Object?> row) => DyingMethod(
            ydmId: row['ydmId'] as int?,
            apperanceId: row['apperanceId'] as String?,
            ydmName: row['ydmName'] as String?,
            ydmType: row['ydmType'] as String?,
            ydmColorTreatmentMethodIdfk:
                row['ydmColorTreatmentMethodIdfk'] as String?,
            ydmDescription: row['ydmDescription'] as String?,
            ydmIsActive: row['ydmIsActive'] as String?,
            ydmSortid: row['ydmSortid'] as String?));
  }

  @override
  Future<List<DyingMethod>> findAllDyingMethodWithAppearanceId(int id) async {
    return _queryAdapter.queryList(
        'SELECT * FROM dying_method where apperanceId = ?1',
        mapper: (Map<String, Object?> row) => DyingMethod(
            ydmId: row['ydmId'] as int?,
            apperanceId: row['apperanceId'] as String?,
            ydmName: row['ydmName'] as String?,
            ydmType: row['ydmType'] as String?,
            ydmColorTreatmentMethodIdfk:
                row['ydmColorTreatmentMethodIdfk'] as String?,
            ydmDescription: row['ydmDescription'] as String?,
            ydmIsActive: row['ydmIsActive'] as String?,
            ydmSortid: row['ydmSortid'] as String?),
        arguments: [id]);
  }

  @override
  Future<List<DyingMethod>> findAllDyingMethodWithCTMId(int id) async {
    return _queryAdapter.queryList(
        'SELECT * FROM dying_method where ydmColorTreatmentMethodIdfk = ?1',
        mapper: (Map<String, Object?> row) => DyingMethod(
            ydmId: row['ydmId'] as int?,
            apperanceId: row['apperanceId'] as String?,
            ydmName: row['ydmName'] as String?,
            ydmType: row['ydmType'] as String?,
            ydmColorTreatmentMethodIdfk:
                row['ydmColorTreatmentMethodIdfk'] as String?,
            ydmDescription: row['ydmDescription'] as String?,
            ydmIsActive: row['ydmIsActive'] as String?,
            ydmSortid: row['ydmSortid'] as String?),
        arguments: [id]);
  }

  @override
  Future<DyingMethod?> findYarnDyingMethodWithId(int id) async {
    return _queryAdapter.query('SELECT * FROM dying_method where ydmId = ?1',
        mapper: (Map<String, Object?> row) => DyingMethod(
            ydmId: row['ydmId'] as int?,
            apperanceId: row['apperanceId'] as String?,
            ydmName: row['ydmName'] as String?,
            ydmType: row['ydmType'] as String?,
            ydmColorTreatmentMethodIdfk:
                row['ydmColorTreatmentMethodIdfk'] as String?,
            ydmDescription: row['ydmDescription'] as String?,
            ydmIsActive: row['ydmIsActive'] as String?,
            ydmSortid: row['ydmSortid'] as String?),
        arguments: [id]);
  }

  @override
  Future<void> deleteDyingMethod(int id) async {
    await _queryAdapter.queryNoReturn(
        'delete from dying_method where ydmId = ?1',
        arguments: [id]);
  }

  @override
  Future<void> deleteAll() async {
    await _queryAdapter.queryNoReturn('delete from dying_method');
  }

  @override
  Future<void> insertDyingMethod(DyingMethod dyingMethod) async {
    await _dyingMethodInsertionAdapter.insert(
        dyingMethod, OnConflictStrategy.replace);
  }

  @override
  Future<List<int>> insertAllDyingMethod(List<DyingMethod> dyingMethod) {
    return _dyingMethodInsertionAdapter.insertListAndReturnIds(
        dyingMethod, OnConflictStrategy.replace);
  }
}

class _$OrientationDao extends OrientationDao {
  _$OrientationDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _orientationTableInsertionAdapter = InsertionAdapter(
            database,
            'orientation_table',
            (OrientationTable item) => <String, Object?>{
                  'yoId': item.yoId,
                  'familyId': item.familyId,
                  'yoName': item.yoName,
                  'yoDescription': item.yoDescription,
                  'yoIsActive': item.yoIsActive,
                  'catSortid': item.catSortid
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<OrientationTable> _orientationTableInsertionAdapter;

  @override
  Future<List<OrientationTable>> findAllOrientation() async {
    return _queryAdapter.queryList('SELECT * FROM orientation_table',
        mapper: (Map<String, Object?> row) => OrientationTable(
            yoId: row['yoId'] as int?,
            familyId: row['familyId'] as String?,
            yoName: row['yoName'] as String?,
            yoDescription: row['yoDescription'] as String?,
            yoIsActive: row['yoIsActive'] as String?,
            catSortid: row['catSortid'] as String?));
  }

  @override
  Future<List<OrientationTable>> findYarnOrientationWithFamilyId(int id) async {
    return _queryAdapter.queryList(
        'SELECT * FROM orientation_table where familyId = ?1',
        mapper: (Map<String, Object?> row) => OrientationTable(
            yoId: row['yoId'] as int?,
            familyId: row['familyId'] as String?,
            yoName: row['yoName'] as String?,
            yoDescription: row['yoDescription'] as String?,
            yoIsActive: row['yoIsActive'] as String?,
            catSortid: row['catSortid'] as String?),
        arguments: [id]);
  }

  @override
  Future<OrientationTable?> findYarnOrientationWithId(int id) async {
    return _queryAdapter.query(
        'SELECT * FROM orientation_table where yoId = ?1',
        mapper: (Map<String, Object?> row) => OrientationTable(
            yoId: row['yoId'] as int?,
            familyId: row['familyId'] as String?,
            yoName: row['yoName'] as String?,
            yoDescription: row['yoDescription'] as String?,
            yoIsActive: row['yoIsActive'] as String?,
            catSortid: row['catSortid'] as String?),
        arguments: [id]);
  }

  @override
  Future<void> deleteOrientation(int id) async {
    await _queryAdapter.queryNoReturn(
        'delete from orientation_table where yoId = ?1',
        arguments: [id]);
  }

  @override
  Future<void> deleteAll() async {
    await _queryAdapter.queryNoReturn('delete from orientation_table');
  }

  @override
  Future<void> insertOrientation(OrientationTable orientation) async {
    await _orientationTableInsertionAdapter.insert(
        orientation, OnConflictStrategy.replace);
  }

  @override
  Future<List<int>> insertAllOrientation(List<OrientationTable> orientation) {
    return _orientationTableInsertionAdapter.insertListAndReturnIds(
        orientation, OnConflictStrategy.replace);
  }
}

class _$PatternCharacteristicsDao extends PatternCharacteristicsDao {
  _$PatternCharacteristicsDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _patternCharectristicInsertionAdapter = InsertionAdapter(
            database,
            'pattern_characteristics_table',
            (PatternCharectristic item) => <String, Object?>{
                  'ypcId': item.ypcId,
                  'ypcName': item.ypcName,
                  'ypcPatternIdfk': item.ypcPatternIdfk,
                  'ypcDescription': item.ypcDescription,
                  'ypcIsActive': item.ypcIsActive,
                  'ypcSortid': item.ypcSortid
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<PatternCharectristic>
      _patternCharectristicInsertionAdapter;

  @override
  Future<List<PatternCharectristic>> findAllPatternCharacteristics() async {
    return _queryAdapter.queryList(
        'SELECT * FROM pattern_characteristics_table',
        mapper: (Map<String, Object?> row) => PatternCharectristic(
            ypcId: row['ypcId'] as int?,
            ypcName: row['ypcName'] as String?,
            ypcPatternIdfk: row['ypcPatternIdfk'] as String?,
            ypcDescription: row['ypcDescription'] as String?,
            ypcIsActive: row['ypcIsActive'] as String?,
            ypcSortid: row['ypcSortid'] as String?));
  }

  @override
  Future<List<PatternCharectristic>> findYarnPatternCharacteristicsWithPtrId(
      int id) async {
    return _queryAdapter.queryList(
        'SELECT * FROM pattern_characteristics_table where ypcPatternIdfk = ?1',
        mapper: (Map<String, Object?> row) => PatternCharectristic(
            ypcId: row['ypcId'] as int?,
            ypcName: row['ypcName'] as String?,
            ypcPatternIdfk: row['ypcPatternIdfk'] as String?,
            ypcDescription: row['ypcDescription'] as String?,
            ypcIsActive: row['ypcIsActive'] as String?,
            ypcSortid: row['ypcSortid'] as String?),
        arguments: [id]);
  }

  @override
  Future<PatternCharectristic?> findYarnPatternCharacteristicsWithId(
      int id) async {
    return _queryAdapter.query(
        'SELECT * FROM pattern_characteristics_table where ypcId = ?1',
        mapper: (Map<String, Object?> row) => PatternCharectristic(
            ypcId: row['ypcId'] as int?,
            ypcName: row['ypcName'] as String?,
            ypcPatternIdfk: row['ypcPatternIdfk'] as String?,
            ypcDescription: row['ypcDescription'] as String?,
            ypcIsActive: row['ypcIsActive'] as String?,
            ypcSortid: row['ypcSortid'] as String?),
        arguments: [id]);
  }

  @override
  Future<void> deletePatternCharacteristics(int id) async {
    await _queryAdapter.queryNoReturn(
        'delete from pattern_characteristics_table where ypcId = ?1',
        arguments: [id]);
  }

  @override
  Future<void> deleteAll() async {
    await _queryAdapter
        .queryNoReturn('delete from pattern_characteristics_table');
  }

  @override
  Future<void> insertPatternCharacteristics(
      PatternCharectristic colorTm) async {
    await _patternCharectristicInsertionAdapter.insert(
        colorTm, OnConflictStrategy.replace);
  }

  @override
  Future<List<int>> insertAllPatternCharacteristics(
      List<PatternCharectristic> colorTm) {
    return _patternCharectristicInsertionAdapter.insertListAndReturnIds(
        colorTm, OnConflictStrategy.replace);
  }
}

class _$PatternDao extends PatternDao {
  _$PatternDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _patternModelInsertionAdapter = InsertionAdapter(
            database,
            'pattern_table',
            (PatternModel item) => <String, Object?>{
                  'ypId': item.ypId,
                  'familyId': item.familyId,
                  'ypName': item.ypName,
                  'spun_technique_id': item.spun_technique_id,
                  'ypDescription': item.ypDescription,
                  'ypIsActive': item.ypIsActive,
                  'catSortid': item.catSortid
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<PatternModel> _patternModelInsertionAdapter;

  @override
  Future<List<PatternModel>> findAllPattern() async {
    return _queryAdapter.queryList('SELECT * FROM pattern_table',
        mapper: (Map<String, Object?> row) => PatternModel(
            ypId: row['ypId'] as int?,
            familyId: row['familyId'] as String?,
            spun_technique_id: row['spun_technique_id'] as String?,
            ypName: row['ypName'] as String?,
            ypDescription: row['ypDescription'] as String?,
            ypIsActive: row['ypIsActive'] as String?,
            catSortid: row['catSortid'] as String?));
  }

  @override
  Future<List<PatternModel>> findAllPatternWithFamily(int id) async {
    return _queryAdapter.queryList(
        'SELECT * FROM pattern_table where familyId = ?1',
        mapper: (Map<String, Object?> row) => PatternModel(
            ypId: row['ypId'] as int?,
            familyId: row['familyId'] as String?,
            spun_technique_id: row['spun_technique_id'] as String?,
            ypName: row['ypName'] as String?,
            ypDescription: row['ypDescription'] as String?,
            ypIsActive: row['ypIsActive'] as String?,
            catSortid: row['catSortid'] as String?),
        arguments: [id]);
  }

  @override
  Future<List<PatternModel>> findAllPatternWithSpunTechId(
      int id, int famId) async {
    return _queryAdapter.queryList(
        'SELECT * FROM pattern_table where spun_technique_id = ?1 and familyId = ?2',
        mapper: (Map<String, Object?> row) => PatternModel(ypId: row['ypId'] as int?, familyId: row['familyId'] as String?, spun_technique_id: row['spun_technique_id'] as String?, ypName: row['ypName'] as String?, ypDescription: row['ypDescription'] as String?, ypIsActive: row['ypIsActive'] as String?, catSortid: row['catSortid'] as String?),
        arguments: [id, famId]);
  }

  @override
  Future<PatternModel?> findYarnPatternWithId(int id) async {
    return _queryAdapter.query('SELECT * FROM pattern_table where ypId = ?1',
        mapper: (Map<String, Object?> row) => PatternModel(
            ypId: row['ypId'] as int?,
            familyId: row['familyId'] as String?,
            spun_technique_id: row['spun_technique_id'] as String?,
            ypName: row['ypName'] as String?,
            ypDescription: row['ypDescription'] as String?,
            ypIsActive: row['ypIsActive'] as String?,
            catSortid: row['catSortid'] as String?),
        arguments: [id]);
  }

  @override
  Future<void> deletePattern(int id) async {
    await _queryAdapter.queryNoReturn(
        'delete from pattern_table where ypId = ?1',
        arguments: [id]);
  }

  @override
  Future<void> deleteAll() async {
    await _queryAdapter.queryNoReturn('delete from pattern_table');
  }

  @override
  Future<void> insertPattern(PatternModel colorTm) async {
    await _patternModelInsertionAdapter.insert(
        colorTm, OnConflictStrategy.replace);
  }

  @override
  Future<List<int>> insertAllPattern(List<PatternModel> colorTm) {
    return _patternModelInsertionAdapter.insertListAndReturnIds(
        colorTm, OnConflictStrategy.replace);
  }
}

class _$PlyDao extends PlyDao {
  _$PlyDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _plyInsertionAdapter = InsertionAdapter(
            database,
            'ply_table',
            (Ply item) => <String, Object?>{
                  'plyId': item.plyId,
                  'familyId': item.familyId,
                  'plyName': item.plyName,
                  'plyDescription': item.plyDescription,
                  'catIsActive': item.catIsActive,
                  'catSortid': item.catSortid
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Ply> _plyInsertionAdapter;

  @override
  Future<List<Ply>> findAllPly() async {
    return _queryAdapter.queryList('SELECT * FROM ply_table',
        mapper: (Map<String, Object?> row) => Ply(
            plyId: row['plyId'] as int?,
            familyId: row['familyId'] as String?,
            plyName: row['plyName'] as String?,
            plyDescription: row['plyDescription'] as String?,
            catIsActive: row['catIsActive'] as String?,
            catSortid: row['catSortid'] as String?));
  }

  @override
  Future<List<Ply>> findYarnPlyWithFamilyId(int id) async {
    return _queryAdapter.queryList(
        'SELECT * FROM ply_table where familyId = ?1',
        mapper: (Map<String, Object?> row) => Ply(
            plyId: row['plyId'] as int?,
            familyId: row['familyId'] as String?,
            plyName: row['plyName'] as String?,
            plyDescription: row['plyDescription'] as String?,
            catIsActive: row['catIsActive'] as String?,
            catSortid: row['catSortid'] as String?),
        arguments: [id]);
  }

  @override
  Future<Ply?> findYarnPlyWithId(int id) async {
    return _queryAdapter.query('SELECT * FROM ply_table where plyId = ?1',
        mapper: (Map<String, Object?> row) => Ply(
            plyId: row['plyId'] as int?,
            familyId: row['familyId'] as String?,
            plyName: row['plyName'] as String?,
            plyDescription: row['plyDescription'] as String?,
            catIsActive: row['catIsActive'] as String?,
            catSortid: row['catSortid'] as String?),
        arguments: [id]);
  }

  @override
  Future<void> deletePly(int id) async {
    await _queryAdapter.queryNoReturn('delete from ply_table where plyId = ?1',
        arguments: [id]);
  }

  @override
  Future<void> deleteAll() async {
    await _queryAdapter.queryNoReturn('delete from ply_table');
  }

  @override
  Future<void> insertPly(Ply colorTm) async {
    await _plyInsertionAdapter.insert(colorTm, OnConflictStrategy.replace);
  }

  @override
  Future<List<int>> insertAllPly(List<Ply> colorTm) {
    return _plyInsertionAdapter.insertListAndReturnIds(
        colorTm, OnConflictStrategy.replace);
  }
}

class _$QualityDao extends QualityDao {
  _$QualityDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _qualityInsertionAdapter = InsertionAdapter(
            database,
            'quality_table',
            (Quality item) => <String, Object?>{
                  'yqId': item.yqId,
                  'familyId': item.familyId,
                  'yqName': item.yqName,
                  'yqAbrv': item.yqAbrv,
                  'spun_technique_id': item.spun_technique_id,
                  'yqBlendIdfk': item.yqBlendIdfk,
                  'yqDescription': item.yqDescription,
                  'yqIsActive': item.yqIsActive,
                  'yqSortid': item.yqSortid
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Quality> _qualityInsertionAdapter;

  @override
  Future<List<Quality>> findAllQuality() async {
    return _queryAdapter.queryList('SELECT * FROM quality_table',
        mapper: (Map<String, Object?> row) => Quality(
            yqId: row['yqId'] as int?,
            familyId: row['familyId'] as String?,
            yqName: row['yqName'] as String?,
            yqAbrv: row['yqAbrv'] as String?,
            spun_technique_id: row['spun_technique_id'] as String?,
            yqBlendIdfk: row['yqBlendIdfk'] as String?,
            yqDescription: row['yqDescription'] as String?,
            yqIsActive: row['yqIsActive'] as String?,
            yqSortid: row['yqSortid'] as String?));
  }

  @override
  Future<List<Quality>> findYarnQualityWithSpunTechId(
      int id, int familyId) async {
    return _queryAdapter.queryList(
        'SELECT * FROM quality_table where spun_technique_id = ?1 and familyId = ?2',
        mapper: (Map<String, Object?> row) => Quality(yqId: row['yqId'] as int?, familyId: row['familyId'] as String?, yqName: row['yqName'] as String?, yqAbrv: row['yqAbrv'] as String?, spun_technique_id: row['spun_technique_id'] as String?, yqBlendIdfk: row['yqBlendIdfk'] as String?, yqDescription: row['yqDescription'] as String?, yqIsActive: row['yqIsActive'] as String?, yqSortid: row['yqSortid'] as String?),
        arguments: [id, familyId]);
  }

  @override
  Future<List<Quality>> findYarnQualityWithFamilyId(int id) async {
    return _queryAdapter.queryList(
        'SELECT * FROM quality_table where familyId = ?1',
        mapper: (Map<String, Object?> row) => Quality(
            yqId: row['yqId'] as int?,
            familyId: row['familyId'] as String?,
            yqName: row['yqName'] as String?,
            yqAbrv: row['yqAbrv'] as String?,
            spun_technique_id: row['spun_technique_id'] as String?,
            yqBlendIdfk: row['yqBlendIdfk'] as String?,
            yqDescription: row['yqDescription'] as String?,
            yqIsActive: row['yqIsActive'] as String?,
            yqSortid: row['yqSortid'] as String?),
        arguments: [id]);
  }

  @override
  Future<Quality?> findYarnQualityWithId(int id) async {
    return _queryAdapter.query('SELECT * FROM quality_table where yqId = ?1',
        mapper: (Map<String, Object?> row) => Quality(
            yqId: row['yqId'] as int?,
            familyId: row['familyId'] as String?,
            yqName: row['yqName'] as String?,
            yqAbrv: row['yqAbrv'] as String?,
            spun_technique_id: row['spun_technique_id'] as String?,
            yqBlendIdfk: row['yqBlendIdfk'] as String?,
            yqDescription: row['yqDescription'] as String?,
            yqIsActive: row['yqIsActive'] as String?,
            yqSortid: row['yqSortid'] as String?),
        arguments: [id]);
  }

  @override
  Future<void> deleteQuality(int id) async {
    await _queryAdapter.queryNoReturn(
        'delete from quality_table where yqId = ?1',
        arguments: [id]);
  }

  @override
  Future<void> deleteAll() async {
    await _queryAdapter.queryNoReturn('delete from quality_table');
  }

  @override
  Future<void> insertQuality(Quality colorTm) async {
    await _qualityInsertionAdapter.insert(colorTm, OnConflictStrategy.replace);
  }

  @override
  Future<List<int>> insertAllQuality(List<Quality> colorTm) {
    return _qualityInsertionAdapter.insertListAndReturnIds(
        colorTm, OnConflictStrategy.replace);
  }
}

class _$SpunTechniqueDao extends SpunTechniqueDao {
  _$SpunTechniqueDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _spunTechniqueInsertionAdapter = InsertionAdapter(
            database,
            'spun_technique',
            (SpunTechnique item) => <String, Object?>{
                  'ystId': item.ystId,
                  'familyId': item.familyId,
                  'orientationId': item.orientationId,
                  'ystName': item.ystName,
                  'ystBlendIdfd': item.ystBlendIdfd,
                  'ystDescription': item.ystDescription,
                  'ystIsActive': item.ystIsActive,
                  'ystSortid': item.ystSortid
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<SpunTechnique> _spunTechniqueInsertionAdapter;

  @override
  Future<List<SpunTechnique>> findAllSpunTechnique() async {
    return _queryAdapter.queryList('SELECT * FROM spun_technique',
        mapper: (Map<String, Object?> row) => SpunTechnique(
            ystId: row['ystId'] as int?,
            familyId: row['familyId'] as String?,
            orientationId: row['orientationId'] as String?,
            ystName: row['ystName'] as String?,
            ystBlendIdfd: row['ystBlendIdfd'] as String?,
            ystDescription: row['ystDescription'] as String?,
            ystIsActive: row['ystIsActive'] as String?,
            ystSortid: row['ystSortid'] as String?));
  }

  @override
  Future<List<SpunTechnique>> findYarnSpunTechniqueWithFamilyId(int id) async {
    return _queryAdapter.queryList(
        'SELECT * FROM spun_technique where familyId = ?1',
        mapper: (Map<String, Object?> row) => SpunTechnique(
            ystId: row['ystId'] as int?,
            familyId: row['familyId'] as String?,
            orientationId: row['orientationId'] as String?,
            ystName: row['ystName'] as String?,
            ystBlendIdfd: row['ystBlendIdfd'] as String?,
            ystDescription: row['ystDescription'] as String?,
            ystIsActive: row['ystIsActive'] as String?,
            ystSortid: row['ystSortid'] as String?),
        arguments: [id]);
  }

  @override
  Future<List<SpunTechnique>> findYarnSpunTechniqueWithOrientationId(
      int id) async {
    return _queryAdapter.queryList(
        'SELECT * FROM spun_technique where orientationId = ?1',
        mapper: (Map<String, Object?> row) => SpunTechnique(
            ystId: row['ystId'] as int?,
            familyId: row['familyId'] as String?,
            orientationId: row['orientationId'] as String?,
            ystName: row['ystName'] as String?,
            ystBlendIdfd: row['ystBlendIdfd'] as String?,
            ystDescription: row['ystDescription'] as String?,
            ystIsActive: row['ystIsActive'] as String?,
            ystSortid: row['ystSortid'] as String?),
        arguments: [id]);
  }

  @override
  Future<SpunTechnique?> findYarnSpunTechniqueWithId(int id) async {
    return _queryAdapter.query('SELECT * FROM spun_technique where ystId = ?1',
        mapper: (Map<String, Object?> row) => SpunTechnique(
            ystId: row['ystId'] as int?,
            familyId: row['familyId'] as String?,
            orientationId: row['orientationId'] as String?,
            ystName: row['ystName'] as String?,
            ystBlendIdfd: row['ystBlendIdfd'] as String?,
            ystDescription: row['ystDescription'] as String?,
            ystIsActive: row['ystIsActive'] as String?,
            ystSortid: row['ystSortid'] as String?),
        arguments: [id]);
  }

  @override
  Future<void> deleteSpunTechnique(int id) async {
    await _queryAdapter.queryNoReturn(
        'delete from spun_technique where ystId = ?1',
        arguments: [id]);
  }

  @override
  Future<void> deleteAll() async {
    await _queryAdapter.queryNoReturn('delete from spun_technique');
  }

  @override
  Future<void> insertSpunTechnique(SpunTechnique colorTm) async {
    await _spunTechniqueInsertionAdapter.insert(
        colorTm, OnConflictStrategy.replace);
  }

  @override
  Future<List<int>> insertAllSpunTechnique(List<SpunTechnique> colorTm) {
    return _spunTechniqueInsertionAdapter.insertListAndReturnIds(
        colorTm, OnConflictStrategy.replace);
  }
}

class _$UsageDao extends UsageDao {
  _$UsageDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _usageInsertionAdapter = InsertionAdapter(
            database,
            'usage_table',
            (Usage item) => <String, Object?>{
                  'yuId': item.yuId,
                  'ysFamilyId': item.ysFamilyId,
                  'yuName': item.yuName,
                  'yuDescription': item.yuDescription,
                  'yuIsActive': item.yuIsActive,
                  'yuSortid': item.yuSortid
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Usage> _usageInsertionAdapter;

  @override
  Future<List<Usage>> findAllUsage() async {
    return _queryAdapter.queryList('SELECT * FROM usage_table',
        mapper: (Map<String, Object?> row) => Usage(
            yuId: row['yuId'] as int?,
            ysFamilyId: row['ysFamilyId'] as String?,
            yuName: row['yuName'] as String?,
            yuDescription: row['yuDescription'] as String?,
            yuIsActive: row['yuIsActive'] as String?,
            yuSortid: row['yuSortid'] as String?));
  }

  @override
  Future<List<Usage>> findYarnUsageWithFamilyId(int id) async {
    return _queryAdapter.queryList(
        'SELECT * FROM usage_table where ysFamilyId = ?1',
        mapper: (Map<String, Object?> row) => Usage(
            yuId: row['yuId'] as int?,
            ysFamilyId: row['ysFamilyId'] as String?,
            yuName: row['yuName'] as String?,
            yuDescription: row['yuDescription'] as String?,
            yuIsActive: row['yuIsActive'] as String?,
            yuSortid: row['yuSortid'] as String?),
        arguments: [id]);
  }

  @override
  Future<void> deleteUsage(int id) async {
    await _queryAdapter.queryNoReturn('delete from usage_table where yuId = ?1',
        arguments: [id]);
  }

  @override
  Future<void> deleteAll() async {
    await _queryAdapter.queryNoReturn('delete from usage_table');
  }

  @override
  Future<void> insertUsage(Usage colorTm) async {
    await _usageInsertionAdapter.insert(colorTm, OnConflictStrategy.replace);
  }

  @override
  Future<List<int>> insertAllUsage(List<Usage> colorTm) {
    return _usageInsertionAdapter.insertListAndReturnIds(
        colorTm, OnConflictStrategy.replace);
  }
}

class _$YarnTypesDao extends YarnTypesDao {
  _$YarnTypesDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _yarnTypesInsertionAdapter = InsertionAdapter(
            database,
            'yarn_types_table',
            (YarnTypes item) => <String, Object?>{
                  'ytId': item.ytId,
                  'ytBlendIdfk': item.ytBlendIdfk,
                  'ytName': item.ytName,
                  'dannierRange': item.dannierRange,
                  'filamentRange': item.filamentRange,
                  'ytIsActive': item.ytIsActive,
                  'ytSortid': item.ytSortid
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<YarnTypes> _yarnTypesInsertionAdapter;

  @override
  Future<List<YarnTypes>> findAllYarnTypes() async {
    return _queryAdapter.queryList('SELECT * FROM yarn_types_table',
        mapper: (Map<String, Object?> row) => YarnTypes(
            ytId: row['ytId'] as int?,
            ytBlendIdfk: row['ytBlendIdfk'] as String?,
            ytName: row['ytName'] as String?,
            dannierRange: row['dannierRange'] as String?,
            filamentRange: row['filamentRange'] as String?,
            ytIsActive: row['ytIsActive'] as String?,
            ytSortid: row['ytSortid'] as String?));
  }

  @override
  Future<YarnTypes?> findYarnYarnTypesWithId(int id) async {
    return _queryAdapter.query('SELECT * FROM yarn_types_table where ytId = ?1',
        mapper: (Map<String, Object?> row) => YarnTypes(
            ytId: row['ytId'] as int?,
            ytBlendIdfk: row['ytBlendIdfk'] as String?,
            ytName: row['ytName'] as String?,
            dannierRange: row['dannierRange'] as String?,
            filamentRange: row['filamentRange'] as String?,
            ytIsActive: row['ytIsActive'] as String?,
            ytSortid: row['ytSortid'] as String?),
        arguments: [id]);
  }

  @override
  Future<void> deleteYarnTypes(int id) async {
    await _queryAdapter.queryNoReturn(
        'delete from yarn_types_table where ytId = ?1',
        arguments: [id]);
  }

  @override
  Future<void> deleteAll() async {
    await _queryAdapter.queryNoReturn('delete from yarn_types_table');
  }

  @override
  Future<void> insertYarnTypes(YarnTypes colorTm) async {
    await _yarnTypesInsertionAdapter.insert(
        colorTm, OnConflictStrategy.replace);
  }

  @override
  Future<List<int>> insertAllYarnTypes(List<YarnTypes> colorTm) {
    return _yarnTypesInsertionAdapter.insertListAndReturnIds(
        colorTm, OnConflictStrategy.replace);
  }
}

class _$YarnAppearanceDao extends YarnAppearanceDao {
  _$YarnAppearanceDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _yarnAppearanceInsertionAdapter = InsertionAdapter(
            database,
            'yarn_appearance',
            (YarnAppearance item) => <String, Object?>{
                  'yaId': item.yaId,
                  'familyId': item.familyId,
                  'usageId': item.usageId,
                  'yaName': item.yaName,
                  'yaIsActive': item.yaIsActive,
                  'catSortid': item.catSortid
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<YarnAppearance> _yarnAppearanceInsertionAdapter;

  @override
  Future<List<YarnAppearance>> findAllYarnAppearance() async {
    return _queryAdapter.queryList('SELECT * FROM yarn_appearance',
        mapper: (Map<String, Object?> row) => YarnAppearance(
            yaId: row['yaId'] as int?,
            familyId: row['familyId'] as String?,
            usageId: row['usageId'] as String?,
            yaName: row['yaName'] as String?,
            yaIsActive: row['yaIsActive'] as String?,
            catSortid: row['catSortid'] as String?));
  }

  @override
  Future<List<YarnAppearance>> findYarnAppearanceWithFamilyId(int id) async {
    return _queryAdapter.queryList(
        'SELECT * FROM yarn_appearance where familyId = ?1',
        mapper: (Map<String, Object?> row) => YarnAppearance(
            yaId: row['yaId'] as int?,
            familyId: row['familyId'] as String?,
            usageId: row['usageId'] as String?,
            yaName: row['yaName'] as String?,
            yaIsActive: row['yaIsActive'] as String?,
            catSortid: row['catSortid'] as String?),
        arguments: [id]);
  }

  @override
  Future<List<YarnAppearance>> findYarnAppearance(int id) async {
    return _queryAdapter.queryList(
        'SELECT * FROM yarn_appearance where yaId = ?1',
        mapper: (Map<String, Object?> row) => YarnAppearance(
            yaId: row['yaId'] as int?,
            familyId: row['familyId'] as String?,
            usageId: row['usageId'] as String?,
            yaName: row['yaName'] as String?,
            yaIsActive: row['yaIsActive'] as String?,
            catSortid: row['catSortid'] as String?),
        arguments: [id]);
  }

  @override
  Future<void> deleteAll() async {
    await _queryAdapter.queryNoReturn('delete from yarn_appearance');
  }

  @override
  Future<List<int>> insertAllYarnAppearance(
      List<YarnAppearance> yarnAppearance) {
    return _yarnAppearanceInsertionAdapter.insertListAndReturnIds(
        yarnAppearance, OnConflictStrategy.replace);
  }
}

// ignore_for_file: unused_element
final _jsonConverter = JsonConverter();
