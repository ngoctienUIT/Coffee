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
            'CREATE TABLE IF NOT EXISTS `User` (`id` TEXT NOT NULL, `username` TEXT NOT NULL, `displayName` TEXT NOT NULL, `isMale` INTEGER NOT NULL, `birthOfDate` TEXT NOT NULL, `email` TEXT NOT NULL, `phoneNumber` TEXT NOT NULL, `hashedPassword` TEXT NOT NULL, `imageUrl` TEXT NOT NULL, `userRole` TEXT NOT NULL, `provider` TEXT NOT NULL, `google` TEXT NOT NULL, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  UserDao get userDao {
    return _userDaoInstance ??= _$UserDao(database, changeListener);
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
                  'userRole': item.userRole,
                  'provider': item.provider,
                  'google': item.google
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
                  'userRole': item.userRole,
                  'provider': item.provider,
                  'google': item.google
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
            row['userRole'] as String,
            row['provider'] as String,
            row['google'] as String),
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
