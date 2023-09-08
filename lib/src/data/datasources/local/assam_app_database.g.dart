// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assam_app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAssamAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AssamAppDatabaseBuilder databaseBuilder(String name) =>
      _$AssamAppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AssamAppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AssamAppDatabaseBuilder(null);
}

class _$AssamAppDatabaseBuilder {
  _$AssamAppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AssamAppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AssamAppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AssamAppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AssamAppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AssamAppDatabase extends AssamAppDatabase {
  _$AssamAppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  MyGeoLocationDao? _geoLocationDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
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
            'CREATE TABLE IF NOT EXISTS `geo_location_table` (`id` INTEGER, `latitude` REAL, `longitude` REAL, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  MyGeoLocationDao get geoLocationDao {
    return _geoLocationDaoInstance ??=
        _$MyGeoLocationDao(database, changeListener);
  }
}

class _$MyGeoLocationDao extends MyGeoLocationDao {
  _$MyGeoLocationDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _geoLocationInsertionAdapter = InsertionAdapter(
            database,
            'geo_location_table',
            (GeoLocation item) => <String, Object?>{
                  'id': item.id,
                  'latitude': item.latitude,
                  'longitude': item.longitude
                }),
        _geoLocationDeletionAdapter = DeletionAdapter(
            database,
            'geo_location_table',
            ['id'],
            (GeoLocation item) => <String, Object?>{
                  'id': item.id,
                  'latitude': item.latitude,
                  'longitude': item.longitude
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<GeoLocation> _geoLocationInsertionAdapter;

  final DeletionAdapter<GeoLocation> _geoLocationDeletionAdapter;

  @override
  Future<List<GeoLocation>> getAllGeoLocation() async {
    return _queryAdapter.queryList('SELECT * FROM geo_location_table',
        mapper: (Map<String, Object?> row) => GeoLocation(
            id: row['id'] as int?,
            latitude: row['latitude'] as double?,
            longitude: row['longitude'] as double?));
  }

  @override
  Future<void> updateGeoLocation(
    int id,
    double latitude,
    double longitude,
  ) async {
    await _queryAdapter.queryNoReturn(
        'UPDATE FloorUser SET latitude = ?2 , longitude = ?3  WHERE id != ?1',
        arguments: [id, latitude, longitude]);
  }

  @override
  Future<GeoLocation?> getLastGeoLocation() async {
    return _queryAdapter.query(
        'select *  from geo_location_table ORDER BY id DESC LIMIT 1;',
        mapper: (Map<String, Object?> row) => GeoLocation(
            id: row['id'] as int?,
            latitude: row['latitude'] as double?,
            longitude: row['longitude'] as double?));
  }

  @override
  Future<GeoLocation?> deleteData() async {
    return _queryAdapter.query('delete from geo_location_table',
        mapper: (Map<String, Object?> row) => GeoLocation(
            id: row['id'] as int?,
            latitude: row['latitude'] as double?,
            longitude: row['longitude'] as double?));
  }

  @override
  Future<void> saveGeoLocation(GeoLocation saveGeoLocation) async {
    await _geoLocationInsertionAdapter.insert(
        saveGeoLocation, OnConflictStrategy.replace);
  }

  @override
  Future<void> deleteGeoLocation(GeoLocation geoLocation) async {
    await _geoLocationDeletionAdapter.delete(geoLocation);
  }
}

// ignore_for_file: unused_element
final _sourceTypeConverter = SourceTypeConverter();
