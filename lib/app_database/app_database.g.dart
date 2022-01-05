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

  FiberSettingDao? _fiberSettingDaoInstance;

  GradesDao? _gradesDaoInstance;

  FiberMaterialDao? _fiberMaterialDaoInstance;

  YarnSettingDao? _yarnSettingsDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback? callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
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
            'CREATE TABLE IF NOT EXISTS `apperance` (`aprId` INTEGER, `aprCategoryIdfk` TEXT, `aprName` TEXT, `aprIsActive` TEXT, PRIMARY KEY (`aprId`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `fiber_available_market` (`afmId` INTEGER NOT NULL, `afmCategoryIdfk` TEXT NOT NULL, `afmName` TEXT NOT NULL, `afmIsActive` TEXT NOT NULL, PRIMARY KEY (`afmId`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `fiber_categories` (`catId` INTEGER NOT NULL, `catName` TEXT NOT NULL, `catIsActive` TEXT NOT NULL, PRIMARY KEY (`catId`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `fiber_entity` (`fbmId` INTEGER NOT NULL, `fbmCategoryIdfk` TEXT, `nature_id` TEXT, `fbmName` TEXT, `icon_selected` TEXT, `icon_unselected` TEXT, `fbmIsActive` TEXT, PRIMARY KEY (`fbmId`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `brands` (`brdId` INTEGER NOT NULL, `brdName` TEXT, `brdIsVerified` TEXT, `brdFeatured` TEXT, `brdIcon` TEXT, `brdIsActive` TEXT, PRIMARY KEY (`brdId`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `countries` (`conId` INTEGER NOT NULL, `conName` TEXT, `conIsoCode_2` TEXT, `conIsoCode_3` TEXT, `conCurrency` TEXT, `conAddressFormat` TEXT, `conPostcodeRequired` TEXT, `conIsActive` TEXT, PRIMARY KEY (`conId`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `certifications` (`cerId` INTEGER NOT NULL, `cerCategoryIdfk` TEXT, `cerName` TEXT, `cerIsActive` TEXT, PRIMARY KEY (`cerId`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `delivery_period` (`dprId` INTEGER NOT NULL, `dprCategoryIdfk` TEXT, `dprName` TEXT, `dprIsActive` TEXT, PRIMARY KEY (`dprId`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `units_table` (`untId` INTEGER NOT NULL, `untCategoryIdfk` TEXT, `untName` TEXT, `untIsActive` TEXT, PRIMARY KEY (`untId`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `grade` (`grdId` INTEGER, `familyId` TEXT, `grdCategoryIdfk` TEXT, `grdName` TEXT, `grdIsActive` TEXT, PRIMARY KEY (`grdId`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `price_terms_table` (`ptrId` INTEGER NOT NULL, `ptrCategoryIdfk` TEXT, `ptrName` TEXT, `ptrIsActive` TEXT, PRIMARY KEY (`ptrId`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `lc_type` (`lcId` INTEGER NOT NULL, `lcName` TEXT, `lcIsActive` TEXT, PRIMARY KEY (`lcId`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `packing` (`pacId` INTEGER NOT NULL, `pacName` TEXT, `pacIsActive` TEXT, PRIMARY KEY (`pacId`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `payment_type` (`payId` TEXT, `payPriceTerrmIdfk` TEXT, `payName` TEXT, `payIsActive` TEXT, PRIMARY KEY (`payId`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `ports` (`prtId` INTEGER NOT NULL, `prtCountryIdfk` TEXT, `prtName` TEXT, `prtIsActive` TEXT, PRIMARY KEY (`prtId`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `fiber_setting` (`fbsId` INTEGER NOT NULL, `fbsCategoryIdfk` TEXT NOT NULL, `fbsFiberMaterialIdfk` TEXT NOT NULL, `showLength` TEXT NOT NULL, `lengthMinMax` TEXT NOT NULL, `showGrade` TEXT NOT NULL, `showMicronaire` TEXT NOT NULL, `micMinMax` TEXT NOT NULL, `showMoisture` TEXT NOT NULL, `moiMinMax` TEXT NOT NULL, `showTrash` TEXT NOT NULL, `trashMinMax` TEXT NOT NULL, `showRd` TEXT NOT NULL, `rdMinMax` TEXT NOT NULL, `showGpt` TEXT NOT NULL, `gptMinMax` TEXT NOT NULL, `showAppearance` TEXT NOT NULL, `showBrand` TEXT NOT NULL, `showOrigin` TEXT NOT NULL, `showCertification` TEXT NOT NULL, `showCountUnit` TEXT NOT NULL, `showDeliveryPeriod` TEXT NOT NULL, `showAvailableForMarket` TEXT NOT NULL, `showPriceTerms` TEXT NOT NULL, `showLotNumber` TEXT NOT NULL, `fbsIsActive` TEXT NOT NULL, `catName` TEXT NOT NULL, `matName` TEXT NOT NULL, PRIMARY KEY (`fbsId`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `yarn_settings` (`ysId` INTEGER, `ysBlendIdfk` TEXT, `ysFiberMaterialIdfk` TEXT, `showCount` TEXT, `countMinMax` TEXT, `showOrigin` TEXT, `showDannier` TEXT, `dannierMinMax` TEXT, `showFilament` TEXT, `filamentMinMax` TEXT, `showBlend` TEXT, `showPly` TEXT, `showSpunTechnique` TEXT, `showQuality` TEXT, `showGrade` TEXT, `showDoublingMethod` TEXT, `showCertification` TEXT, `showColorTreatmentMethod` TEXT, `showDyingMethod` TEXT, `showColor` TEXT, `showAppearance` TEXT, `showQlt` TEXT, `qltMinMax` TEXT, `showClsp` TEXT, `clspMinMax` TEXT, `showUniformity` TEXT, `uniformityMinMax` TEXT, `showCv` TEXT, `cvMinMax` TEXT, `showThinPlaces` TEXT, `thinPlacesMinMax` TEXT, `showtThickPlaces` TEXT, `thickPlacesMinMax` TEXT, `showNaps` TEXT, `napsMinMax` TEXT, `showIpmKm` TEXT, `ipmKmMinMax` TEXT, `showHairness` TEXT, `hairnessMinMax` TEXT, `showRkm` TEXT, `rkmMinMax` TEXT, `showElongation` TEXT, `elongationMinMax` TEXT, `showTpi` TEXT, `tpiMinMax` TEXT, `showTm` TEXT, `tmMinMax` TEXT, `showDty` TEXT, `dtyMinMax` TEXT, `showFdy` TEXT, `fdyMinMax` TEXT, `showRatio` TEXT, `showTexturized` TEXT, `showUsage` TEXT, `showPattern` TEXT, `showPatternCharectristic` TEXT, `showOrientation` TEXT, `showTwistDirection` TEXT, `ysIsActive` TEXT, `ysSortid` TEXT, `show_actual_count` TEXT, `actual_count_min_max` TEXT, PRIMARY KEY (`ysId`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  FiberSettingDao get fiberSettingDao {
    return _fiberSettingDaoInstance ??=
        _$FiberSettingDao(database, changeListener);
  }

  @override
  GradesDao get gradesDao {
    return _gradesDaoInstance ??= _$GradesDao(database, changeListener);
  }

  @override
  FiberMaterialDao get fiberMaterialDao {
    return _fiberMaterialDaoInstance ??=
        _$FiberMaterialDao(database, changeListener);
  }

  @override
  YarnSettingDao get yarnSettingsDao {
    return _yarnSettingsDaoInstance ??=
        _$YarnSettingDao(database, changeListener);
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
                  'fbsFiberMaterialIdfk': item.fbsFiberMaterialIdfk,
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
                  'showBrand': item.showBrand,
                  'showOrigin': item.showOrigin,
                  'showCertification': item.showCertification,
                  'showCountUnit': item.showCountUnit,
                  'showDeliveryPeriod': item.showDeliveryPeriod,
                  'showAvailableForMarket': item.showAvailableForMarket,
                  'showPriceTerms': item.showPriceTerms,
                  'showLotNumber': item.showLotNumber,
                  'fbsIsActive': item.fbsIsActive,
                  'catName': item.catName,
                  'matName': item.matName
                }),
        _fiberSettingsDeletionAdapter = DeletionAdapter(
            database,
            'fiber_setting',
            ['fbsId'],
            (FiberSettings item) => <String, Object?>{
                  'fbsId': item.fbsId,
                  'fbsCategoryIdfk': item.fbsCategoryIdfk,
                  'fbsFiberMaterialIdfk': item.fbsFiberMaterialIdfk,
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
                  'showBrand': item.showBrand,
                  'showOrigin': item.showOrigin,
                  'showCertification': item.showCertification,
                  'showCountUnit': item.showCountUnit,
                  'showDeliveryPeriod': item.showDeliveryPeriod,
                  'showAvailableForMarket': item.showAvailableForMarket,
                  'showPriceTerms': item.showPriceTerms,
                  'showLotNumber': item.showLotNumber,
                  'fbsIsActive': item.fbsIsActive,
                  'catName': item.catName,
                  'matName': item.matName
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<FiberSettings> _fiberSettingsInsertionAdapter;

  final DeletionAdapter<FiberSettings> _fiberSettingsDeletionAdapter;

  @override
  Future<List<FiberSettings>> findAllFiberSettings() async {
    return _queryAdapter.queryList('SELECT * FROM fiber_setting',
        mapper: (Map<String, Object?> row) => FiberSettings(
            fbsId: row['fbsId'] as int,
            fbsCategoryIdfk: row['fbsCategoryIdfk'] as String,
            fbsFiberMaterialIdfk: row['fbsFiberMaterialIdfk'] as String,
            showLength: row['showLength'] as String,
            lengthMinMax: row['lengthMinMax'] as String,
            showGrade: row['showGrade'] as String,
            showMicronaire: row['showMicronaire'] as String,
            micMinMax: row['micMinMax'] as String,
            showMoisture: row['showMoisture'] as String,
            moiMinMax: row['moiMinMax'] as String,
            showTrash: row['showTrash'] as String,
            trashMinMax: row['trashMinMax'] as String,
            showRd: row['showRd'] as String,
            rdMinMax: row['rdMinMax'] as String,
            showGpt: row['showGpt'] as String,
            gptMinMax: row['gptMinMax'] as String,
            showAppearance: row['showAppearance'] as String,
            showBrand: row['showBrand'] as String,
            showOrigin: row['showOrigin'] as String,
            showCertification: row['showCertification'] as String,
            showCountUnit: row['showCountUnit'] as String,
            showDeliveryPeriod: row['showDeliveryPeriod'] as String,
            showAvailableForMarket: row['showAvailableForMarket'] as String,
            showPriceTerms: row['showPriceTerms'] as String,
            showLotNumber: row['showLotNumber'] as String,
            fbsIsActive: row['fbsIsActive'] as String,
            catName: row['catName'] as String,
            matName: row['matName'] as String));
  }

  @override
  Future<List<FiberSettings>> findFiberSettings(int id) async {
    return _queryAdapter.queryList(
        'SELECT * FROM fiber_setting where fbsFiberMaterialIdfk = ?1',
        mapper: (Map<String, Object?> row) => FiberSettings(
            fbsId: row['fbsId'] as int,
            fbsCategoryIdfk: row['fbsCategoryIdfk'] as String,
            fbsFiberMaterialIdfk: row['fbsFiberMaterialIdfk'] as String,
            showLength: row['showLength'] as String,
            lengthMinMax: row['lengthMinMax'] as String,
            showGrade: row['showGrade'] as String,
            showMicronaire: row['showMicronaire'] as String,
            micMinMax: row['micMinMax'] as String,
            showMoisture: row['showMoisture'] as String,
            moiMinMax: row['moiMinMax'] as String,
            showTrash: row['showTrash'] as String,
            trashMinMax: row['trashMinMax'] as String,
            showRd: row['showRd'] as String,
            rdMinMax: row['rdMinMax'] as String,
            showGpt: row['showGpt'] as String,
            gptMinMax: row['gptMinMax'] as String,
            showAppearance: row['showAppearance'] as String,
            showBrand: row['showBrand'] as String,
            showOrigin: row['showOrigin'] as String,
            showCertification: row['showCertification'] as String,
            showCountUnit: row['showCountUnit'] as String,
            showDeliveryPeriod: row['showDeliveryPeriod'] as String,
            showAvailableForMarket: row['showAvailableForMarket'] as String,
            showPriceTerms: row['showPriceTerms'] as String,
            showLotNumber: row['showLotNumber'] as String,
            fbsIsActive: row['fbsIsActive'] as String,
            catName: row['catName'] as String,
            matName: row['matName'] as String),
        arguments: [id]);
  }

  @override
  Future<void> deleteFiberSetting(int id) async {
    await _queryAdapter.queryNoReturn('delete from fiber_setting where id = ?1',
        arguments: [id]);
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

  @override
  Future<int> deleteAll(List<FiberSettings> list) {
    return _fiberSettingsDeletionAdapter.deleteListAndReturnChangedRows(list);
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
                }),
        _gradesDeletionAdapter = DeletionAdapter(
            database,
            'grade',
            ['grdId'],
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

  final DeletionAdapter<Grades> _gradesDeletionAdapter;

  @override
  Future<List<Grades>> findAllGrades() async {
    return _queryAdapter.queryList('SELECT * FROM fiber_grade',
        mapper: (Map<String, Object?> row) => Grades(
            grdId: row['grdId'] as int?,
            grdCategoryIdfk: row['grdCategoryIdfk'] as String?,
            grdName: row['grdName'] as String?,
            grdIsActive: row['grdIsActive'] as String?));
  }

  @override
  Future<List<Grades>> findFiberGradeWithId(int id) async {
    return _queryAdapter.queryList(
        'SELECT * FROM fiber_setting where grd_category_idfk = ?1',
        mapper: (Map<String, Object?> row) => Grades(
            grdId: row['grdId'] as int?,
            grdCategoryIdfk: row['grdCategoryIdfk'] as String?,
            grdName: row['grdName'] as String?,
            grdIsActive: row['grdIsActive'] as String?),
        arguments: [id]);
  }

  @override
  Future<List<Grades>> findYarnGradeWithId(int id) async {
    return _queryAdapter.queryList(
        'SELECT * FROM yarn_settings where grd_category_idfk = ?1',
        mapper: (Map<String, Object?> row) => Grades(
            grdId: row['grdId'] as int?,
            grdCategoryIdfk: row['grdCategoryIdfk'] as String?,
            grdName: row['grdName'] as String?,
            grdIsActive: row['grdIsActive'] as String?),
        arguments: [id]);
  }

  @override
  Future<void> deleteGrade(int id) async {
    await _queryAdapter.queryNoReturn('delete from fiber_grade where id = ?1',
        arguments: [id]);
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

  @override
  Future<int> deleteAll(List<Grades> list) {
    return _gradesDeletionAdapter.deleteListAndReturnChangedRows(list);
  }
}

class _$FiberMaterialDao extends FiberMaterialDao {
  _$FiberMaterialDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _fiberMaterialInsertionAdapter = InsertionAdapter(
            database,
            'fiber_entity',
            (FiberMaterial item) => <String, Object?>{
                  'fbmId': item.fbmId,
                  'fbmCategoryIdfk': item.fbmCategoryIdfk,
                  'nature_id': item.nature_id,
                  'fbmName': item.fbmName,
                  'icon_selected': item.icon_selected,
                  'icon_unselected': item.icon_unselected,
                  'fbmIsActive': item.fbmIsActive
                }),
        _fiberMaterialDeletionAdapter = DeletionAdapter(
            database,
            'fiber_entity',
            ['fbmId'],
            (FiberMaterial item) => <String, Object?>{
                  'fbmId': item.fbmId,
                  'fbmCategoryIdfk': item.fbmCategoryIdfk,
                  'nature_id': item.nature_id,
                  'fbmName': item.fbmName,
                  'icon_selected': item.icon_selected,
                  'icon_unselected': item.icon_unselected,
                  'fbmIsActive': item.fbmIsActive
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<FiberMaterial> _fiberMaterialInsertionAdapter;

  final DeletionAdapter<FiberMaterial> _fiberMaterialDeletionAdapter;

  @override
  Future<List<FiberMaterial>> findAllFiberMaterials() async {
    return _queryAdapter.queryList('SELECT * FROM fiber_entity',
        mapper: (Map<String, Object?> row) => FiberMaterial(
            fbmId: row['fbmId'] as int,
            fbmCategoryIdfk: row['fbmCategoryIdfk'] as String?,
            nature_id: row['nature_id'] as String?,
            fbmName: row['fbmName'] as String?,
            icon_selected: row['icon_selected'] as String?,
            icon_unselected: row['icon_unselected'] as String?,
            fbmIsActive: row['fbmIsActive'] as String?));
  }

  @override
  Future<List<FiberMaterial>> findFiberMaterials(int id) async {
    return _queryAdapter.queryList(
        'SELECT * FROM fiber_entity where fbm_id = ?1',
        mapper: (Map<String, Object?> row) => FiberMaterial(
            fbmId: row['fbmId'] as int,
            fbmCategoryIdfk: row['fbmCategoryIdfk'] as String?,
            nature_id: row['nature_id'] as String?,
            fbmName: row['fbmName'] as String?,
            icon_selected: row['icon_selected'] as String?,
            icon_unselected: row['icon_unselected'] as String?,
            fbmIsActive: row['fbmIsActive'] as String?),
        arguments: [id]);
  }

  @override
  Future<void> deleteFiberSetting(int id) async {
    await _queryAdapter.queryNoReturn('delete from fiber_entity where id = ?1',
        arguments: [id]);
  }

  @override
  Future<void> insertFiberSetting(FiberMaterial fiberMaterials) async {
    await _fiberMaterialInsertionAdapter.insert(
        fiberMaterials, OnConflictStrategy.replace);
  }

  @override
  Future<List<int>> insertAllFiberMaterials(
      List<FiberMaterial> fiberMaterials) {
    return _fiberMaterialInsertionAdapter.insertListAndReturnIds(
        fiberMaterials, OnConflictStrategy.replace);
  }

  @override
  Future<int> deleteAll(List<FiberMaterial> list) {
    return _fiberMaterialDeletionAdapter.deleteListAndReturnChangedRows(list);
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
                  'ysFiberMaterialIdfk': item.ysFiberMaterialIdfk,
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
                }),
        _yarnSettingDeletionAdapter = DeletionAdapter(
            database,
            'yarn_settings',
            ['ysId'],
            (YarnSetting item) => <String, Object?>{
                  'ysId': item.ysId,
                  'ysBlendIdfk': item.ysBlendIdfk,
                  'ysFiberMaterialIdfk': item.ysFiberMaterialIdfk,
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

  final DeletionAdapter<YarnSetting> _yarnSettingDeletionAdapter;

  @override
  Future<List<YarnSetting>> findAllYarnSettings() async {
    return _queryAdapter.queryList('SELECT * FROM yarn_settings',
        mapper: (Map<String, Object?> row) => YarnSetting(
            ysId: row['ysId'] as int?,
            ysBlendIdfk: row['ysBlendIdfk'] as String?,
            ysFiberMaterialIdfk: row['ysFiberMaterialIdfk'] as String?,
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
        'SELECT * FROM yarn_settings where ysBlendIdfk = ?1 and ysFiberMaterialIdfk = ?2',
        mapper: (Map<String, Object?> row) => YarnSetting(ysId: row['ysId'] as int?, ysBlendIdfk: row['ysBlendIdfk'] as String?, ysFiberMaterialIdfk: row['ysFiberMaterialIdfk'] as String?, showCount: row['showCount'] as String?, countMinMax: row['countMinMax'] as String?, showOrigin: row['showOrigin'] as String?, showDannier: row['showDannier'] as String?, dannierMinMax: row['dannierMinMax'] as String?, showFilament: row['showFilament'] as String?, filamentMinMax: row['filamentMinMax'] as String?, showBlend: row['showBlend'] as String?, showPly: row['showPly'] as String?, showSpunTechnique: row['showSpunTechnique'] as String?, showQuality: row['showQuality'] as String?, showGrade: row['showGrade'] as String?, showDoublingMethod: row['showDoublingMethod'] as String?, showCertification: row['showCertification'] as String?, showColorTreatmentMethod: row['showColorTreatmentMethod'] as String?, showDyingMethod: row['showDyingMethod'] as String?, showColor: row['showColor'] as String?, showAppearance: row['showAppearance'] as String?, showQlt: row['showQlt'] as String?, qltMinMax: row['qltMinMax'] as String?, showClsp: row['showClsp'] as String?, clspMinMax: row['clspMinMax'] as String?, showUniformity: row['showUniformity'] as String?, uniformityMinMax: row['uniformityMinMax'] as String?, showCv: row['showCv'] as String?, cvMinMax: row['cvMinMax'] as String?, showThinPlaces: row['showThinPlaces'] as String?, thinPlacesMinMax: row['thinPlacesMinMax'] as String?, showtThickPlaces: row['showtThickPlaces'] as String?, thickPlacesMinMax: row['thickPlacesMinMax'] as String?, showNaps: row['showNaps'] as String?, napsMinMax: row['napsMinMax'] as String?, showIpmKm: row['showIpmKm'] as String?, ipmKmMinMax: row['ipmKmMinMax'] as String?, showHairness: row['showHairness'] as String?, hairnessMinMax: row['hairnessMinMax'] as String?, showRkm: row['showRkm'] as String?, rkmMinMax: row['rkmMinMax'] as String?, showElongation: row['showElongation'] as String?, elongationMinMax: row['elongationMinMax'] as String?, showTpi: row['showTpi'] as String?, tpiMinMax: row['tpiMinMax'] as String?, showTm: row['showTm'] as String?, tmMinMax: row['tmMinMax'] as String?, showDty: row['showDty'] as String?, dtyMinMax: row['dtyMinMax'] as String?, showFdy: row['showFdy'] as String?, fdyMinMax: row['fdyMinMax'] as String?, showRatio: row['showRatio'] as String?, showTexturized: row['showTexturized'] as String?, showUsage: row['showUsage'] as String?, showPattern: row['showPattern'] as String?, showPatternCharectristic: row['showPatternCharectristic'] as String?, showOrientation: row['showOrientation'] as String?, showTwistDirection: row['showTwistDirection'] as String?, ysIsActive: row['ysIsActive'] as String?, ysSortid: row['ysSortid'] as String?, show_actual_count: row['show_actual_count'] as String?, actual_count_min_max: row['actual_count_min_max'] as String?),
        arguments: [id, materialId]);
  }

  @override
  Future<List<YarnSetting>> findFamilyYarnSettings(int id) async {
    return _queryAdapter.queryList(
        'SELECT * FROM yarn_settings where ysFiberMaterialIdfk = ?1',
        mapper: (Map<String, Object?> row) => YarnSetting(
            ysId: row['ysId'] as int?,
            ysBlendIdfk: row['ysBlendIdfk'] as String?,
            ysFiberMaterialIdfk: row['ysFiberMaterialIdfk'] as String?,
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
  Future<void> insertYarnSetting(YarnSetting yarnSettings) async {
    await _yarnSettingInsertionAdapter.insert(
        yarnSettings, OnConflictStrategy.replace);
  }

  @override
  Future<List<int>> insertAllYarnSettings(List<YarnSetting> fiberSettings) {
    return _yarnSettingInsertionAdapter.insertListAndReturnIds(
        fiberSettings, OnConflictStrategy.replace);
  }

  @override
  Future<int> deleteAll(List<YarnSetting> list) {
    return _yarnSettingDeletionAdapter.deleteListAndReturnChangedRows(list);
  }
}
