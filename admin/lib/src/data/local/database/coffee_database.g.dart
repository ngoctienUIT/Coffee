// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coffee_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorCoffeeDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$CoffeeDatabaseBuilder databaseBuilder(String name) =>
      _$CoffeeDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$CoffeeDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$CoffeeDatabaseBuilder(null);
}

class _$CoffeeDatabaseBuilder {
  _$CoffeeDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$CoffeeDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$CoffeeDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<CoffeeDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$CoffeeDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$CoffeeDatabase extends CoffeeDatabase {
  _$CoffeeDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  UserDao? _userDaoInstance;

  StoreDao? _storeDaoInstance;

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
            'CREATE TABLE IF NOT EXISTS `User` (`id` TEXT NOT NULL, `username` TEXT NOT NULL, `displayName` TEXT NOT NULL, `isMale` INTEGER NOT NULL, `birthOfDate` TEXT NOT NULL, `email` TEXT NOT NULL, `phoneNumber` TEXT NOT NULL, `hashedPassword` TEXT NOT NULL, `imageUrl` TEXT NOT NULL, `userRole` TEXT NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Store` (`storeId` TEXT NOT NULL, `storeName` TEXT, `address1` TEXT, `address2` TEXT, `address3` TEXT, `address4` TEXT, `openingHour` TEXT NOT NULL, `closingHour` TEXT NOT NULL, `latitude` TEXT, `longitude` TEXT, `imageUrl` TEXT, `hotlineNumber` TEXT, `googleMapUrl` TEXT, `registrationDate` TEXT, `lastUpdateDate` TEXT, PRIMARY KEY (`storeId`))');

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
  StoreDao get storeDao {
    return _storeDaoInstance ??= _$StoreDao(database, changeListener);
  }
}

class _$UserDao extends UserDao {
  _$UserDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _userEntityInsertionAdapter = InsertionAdapter(
            database,
            'User',
            (UserEntity item) => <String, Object?>{
                  'id': item.id,
                  'username': item.username,
                  'displayName': item.displayName,
                  'isMale': item.isMale ? 1 : 0,
                  'birthOfDate': item.birthOfDate,
                  'email': item.email,
                  'phoneNumber': item.phoneNumber,
                  'hashedPassword': item.hashedPassword,
                  'imageUrl': item.imageUrl,
                  'userRole': item.userRole
                },
            changeListener),
        _userEntityUpdateAdapter = UpdateAdapter(
            database,
            'User',
            ['id'],
            (UserEntity item) => <String, Object?>{
                  'id': item.id,
                  'username': item.username,
                  'displayName': item.displayName,
                  'isMale': item.isMale ? 1 : 0,
                  'birthOfDate': item.birthOfDate,
                  'email': item.email,
                  'phoneNumber': item.phoneNumber,
                  'hashedPassword': item.hashedPassword,
                  'imageUrl': item.imageUrl,
                  'userRole': item.userRole
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<UserEntity> _userEntityInsertionAdapter;

  final UpdateAdapter<UserEntity> _userEntityUpdateAdapter;

  @override
  Stream<UserEntity?> findUserById(String id) {
    return _queryAdapter.queryStream('SELECT * FROM User WHERE id = ?1',
        mapper: (Map<String, Object?> row) => UserEntity(
            row['id'] as String,
            row['username'] as String,
            row['displayName'] as String,
            (row['isMale'] as int) != 0,
            row['birthOfDate'] as String,
            row['email'] as String,
            row['phoneNumber'] as String,
            row['hashedPassword'] as String,
            row['imageUrl'] as String,
            row['userRole'] as String),
        arguments: [id],
        queryableName: 'User',
        isView: false);
  }

  @override
  Future<void> insertUser(UserEntity user) async {
    await _userEntityInsertionAdapter.insert(user, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateUser(UserEntity user) async {
    await _userEntityUpdateAdapter.update(user, OnConflictStrategy.abort);
  }
}

class _$StoreDao extends StoreDao {
  _$StoreDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _storeEntityInsertionAdapter = InsertionAdapter(
            database,
            'Store',
            (StoreEntity item) => <String, Object?>{
                  'storeId': item.storeId,
                  'storeName': item.storeName,
                  'address1': item.address1,
                  'address2': item.address2,
                  'address3': item.address3,
                  'address4': item.address4,
                  'openingHour': item.openingHour,
                  'closingHour': item.closingHour,
                  'latitude': item.latitude,
                  'longitude': item.longitude,
                  'imageUrl': item.imageUrl,
                  'hotlineNumber': item.hotlineNumber,
                  'googleMapUrl': item.googleMapUrl,
                  'registrationDate': item.registrationDate,
                  'lastUpdateDate': item.lastUpdateDate
                },
            changeListener),
        _storeEntityUpdateAdapter = UpdateAdapter(
            database,
            'Store',
            ['storeId'],
            (StoreEntity item) => <String, Object?>{
                  'storeId': item.storeId,
                  'storeName': item.storeName,
                  'address1': item.address1,
                  'address2': item.address2,
                  'address3': item.address3,
                  'address4': item.address4,
                  'openingHour': item.openingHour,
                  'closingHour': item.closingHour,
                  'latitude': item.latitude,
                  'longitude': item.longitude,
                  'imageUrl': item.imageUrl,
                  'hotlineNumber': item.hotlineNumber,
                  'googleMapUrl': item.googleMapUrl,
                  'registrationDate': item.registrationDate,
                  'lastUpdateDate': item.lastUpdateDate
                },
            changeListener),
        _storeEntityDeletionAdapter = DeletionAdapter(
            database,
            'Store',
            ['storeId'],
            (StoreEntity item) => <String, Object?>{
                  'storeId': item.storeId,
                  'storeName': item.storeName,
                  'address1': item.address1,
                  'address2': item.address2,
                  'address3': item.address3,
                  'address4': item.address4,
                  'openingHour': item.openingHour,
                  'closingHour': item.closingHour,
                  'latitude': item.latitude,
                  'longitude': item.longitude,
                  'imageUrl': item.imageUrl,
                  'hotlineNumber': item.hotlineNumber,
                  'googleMapUrl': item.googleMapUrl,
                  'registrationDate': item.registrationDate,
                  'lastUpdateDate': item.lastUpdateDate
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<StoreEntity> _storeEntityInsertionAdapter;

  final UpdateAdapter<StoreEntity> _storeEntityUpdateAdapter;

  final DeletionAdapter<StoreEntity> _storeEntityDeletionAdapter;

  @override
  Stream<StoreEntity?> findStoreById(String id) {
    return _queryAdapter.queryStream('SELECT * FROM Store WHERE storeId = ?1',
        mapper: (Map<String, Object?> row) => StoreEntity(
            row['storeId'] as String,
            row['storeName'] as String?,
            row['address1'] as String?,
            row['address2'] as String?,
            row['address3'] as String?,
            row['address4'] as String?,
            row['openingHour'] as String,
            row['closingHour'] as String,
            row['latitude'] as String?,
            row['longitude'] as String?,
            row['imageUrl'] as String?,
            row['hotlineNumber'] as String?,
            row['googleMapUrl'] as String?,
            row['registrationDate'] as String?,
            row['lastUpdateDate'] as String?),
        arguments: [id],
        queryableName: 'Store',
        isView: false);
  }

  @override
  Stream<List<StoreEntity>> findStoreByName(String name) {
    return _queryAdapter.queryListStream(
        'SELECT * FROM Store WHERE storeName LIKE \'%\'|| ?1 || \'%\'',
        mapper: (Map<String, Object?> row) => StoreEntity(
            row['storeId'] as String,
            row['storeName'] as String?,
            row['address1'] as String?,
            row['address2'] as String?,
            row['address3'] as String?,
            row['address4'] as String?,
            row['openingHour'] as String,
            row['closingHour'] as String,
            row['latitude'] as String?,
            row['longitude'] as String?,
            row['imageUrl'] as String?,
            row['hotlineNumber'] as String?,
            row['googleMapUrl'] as String?,
            row['registrationDate'] as String?,
            row['lastUpdateDate'] as String?),
        arguments: [name],
        queryableName: 'Store',
        isView: false);
  }

  @override
  Stream<List<StoreEntity>> getListStore() {
    return _queryAdapter.queryListStream('SELECT * FROM Store',
        mapper: (Map<String, Object?> row) => StoreEntity(
            row['storeId'] as String,
            row['storeName'] as String?,
            row['address1'] as String?,
            row['address2'] as String?,
            row['address3'] as String?,
            row['address4'] as String?,
            row['openingHour'] as String,
            row['closingHour'] as String,
            row['latitude'] as String?,
            row['longitude'] as String?,
            row['imageUrl'] as String?,
            row['hotlineNumber'] as String?,
            row['googleMapUrl'] as String?,
            row['registrationDate'] as String?,
            row['lastUpdateDate'] as String?),
        queryableName: 'Store',
        isView: false);
  }

  @override
  Future<int?> getNumberStore() async {
    return _queryAdapter.query('SELECT COUNT(*) FROM Store',
        mapper: (Map<String, Object?> row) => row.values.first as int);
  }

  @override
  Future<void> deleteAllStore() async {
    await _queryAdapter.queryNoReturn('DELETE FROM Store');
  }

  @override
  Future<void> insertStore(StoreEntity store) async {
    await _storeEntityInsertionAdapter.insert(store, OnConflictStrategy.abort);
  }

  @override
  Future<void> insertListStore(List<StoreEntity> list) async {
    await _storeEntityInsertionAdapter.insertList(
        list, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateStore(StoreEntity store) async {
    await _storeEntityUpdateAdapter.update(store, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteStore(StoreEntity store) async {
    await _storeEntityDeletionAdapter.delete(store);
  }
}
