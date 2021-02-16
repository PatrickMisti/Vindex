// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appDatabase.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

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

  final String name;

  final List<Migration> _migrations = [];

  Callback _callback;

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
        ? await sqfliteDatabaseFactory.getDatabasePath(name)
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
  _$AppDatabase([StreamController<String> listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  WineDao _wineDaoInstance;

  ReviewDao _reviewDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
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
            'CREATE TABLE IF NOT EXISTS `wine` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT, `vintage` INTEGER, `picture` BLOB, `location` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `review` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `ratingDate` TEXT, `rating` INTEGER, `stringRating` TEXT, `wineForFood` TEXT, `wine_id` INTEGER NOT NULL, FOREIGN KEY (`wine_id`) REFERENCES `wine` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  WineDao get wineDao {
    return _wineDaoInstance ??= _$WineDao(database, changeListener);
  }

  @override
  ReviewDao get reviewDao {
    return _reviewDaoInstance ??= _$ReviewDao(database, changeListener);
  }
}

class _$WineDao extends WineDao {
  _$WineDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _wineInsertionAdapter = InsertionAdapter(
            database,
            'wine',
            (Wine item) => <String, dynamic>{
                  'id': item.id,
                  'name': item.name,
                  'vintage': item.vintage,
                  'picture': item.picture,
                  'location': item.location
                },
            changeListener),
        _wineUpdateAdapter = UpdateAdapter(
            database,
            'wine',
            ['id'],
            (Wine item) => <String, dynamic>{
                  'id': item.id,
                  'name': item.name,
                  'vintage': item.vintage,
                  'picture': item.picture,
                  'location': item.location
                },
            changeListener),
        _wineDeletionAdapter = DeletionAdapter(
            database,
            'wine',
            ['id'],
            (Wine item) => <String, dynamic>{
                  'id': item.id,
                  'name': item.name,
                  'vintage': item.vintage,
                  'picture': item.picture,
                  'location': item.location
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Wine> _wineInsertionAdapter;

  final UpdateAdapter<Wine> _wineUpdateAdapter;

  final DeletionAdapter<Wine> _wineDeletionAdapter;

  @override
  Future<List<Wine>> findAllWineFuture() async {
    return _queryAdapter.queryList('SELECT * FROM Wine',
        mapper: (Map<String, dynamic> row) => Wine(
            row['id'] as int,
            row['name'] as String,
            row['vintage'] as int,
            row['picture'] as Uint8List,
            row['location'] as String));
  }

  @override
  Stream<List<Wine>> findAllWineStream() {
    return _queryAdapter.queryListStream('SELECT * FROM Wine',
        queryableName: 'wine',
        isView: false,
        mapper: (Map<String, dynamic> row) => Wine(
            row['id'] as int,
            row['name'] as String,
            row['vintage'] as int,
            row['picture'] as Uint8List,
            row['location'] as String));
  }

  @override
  Future<Wine> findWineById(int id) async {
    return _queryAdapter.query('SELECT * FROM Wine WHERE id = ?',
        arguments: <dynamic>[id],
        mapper: (Map<String, dynamic> row) => Wine(
            row['id'] as int,
            row['name'] as String,
            row['vintage'] as int,
            row['picture'] as Uint8List,
            row['location'] as String));
  }

  @override
  Future<void> deleteWineById(int id) async {
    await _queryAdapter.queryNoReturn('SELECT * FROM Wine WHERE id = ?',
        arguments: <dynamic>[id]);
  }

  @override
  Future<int> insertWine(Wine wine) {
    return _wineInsertionAdapter.insertAndReturnId(
        wine, OnConflictStrategy.abort);
  }

  @override
  Future<int> updateWine(Wine wine) {
    return _wineUpdateAdapter.updateAndReturnChangedRows(
        wine, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteWine(Wine wine) async {
    await _wineDeletionAdapter.delete(wine);
  }
}

class _$ReviewDao extends ReviewDao {
  _$ReviewDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _reviewInsertionAdapter = InsertionAdapter(
            database,
            'review',
            (Review item) => <String, dynamic>{
                  'id': item.id,
                  'ratingDate': item.ratingDate,
                  'rating': item.rating,
                  'stringRating': item.stringRating,
                  'wineForFood': item.wineForFood,
                  'wine_id': item.wineId
                },
            changeListener),
        _reviewUpdateAdapter = UpdateAdapter(
            database,
            'review',
            ['id'],
            (Review item) => <String, dynamic>{
                  'id': item.id,
                  'ratingDate': item.ratingDate,
                  'rating': item.rating,
                  'stringRating': item.stringRating,
                  'wineForFood': item.wineForFood,
                  'wine_id': item.wineId
                },
            changeListener),
        _reviewDeletionAdapter = DeletionAdapter(
            database,
            'review',
            ['id'],
            (Review item) => <String, dynamic>{
                  'id': item.id,
                  'ratingDate': item.ratingDate,
                  'rating': item.rating,
                  'stringRating': item.stringRating,
                  'wineForFood': item.wineForFood,
                  'wine_id': item.wineId
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Review> _reviewInsertionAdapter;

  final UpdateAdapter<Review> _reviewUpdateAdapter;

  final DeletionAdapter<Review> _reviewDeletionAdapter;

  @override
  Future<List<Review>> findAllReviewFuture() async {
    return _queryAdapter.queryList('SELECT * FROM Review',
        mapper: (Map<String, dynamic> row) => Review(
            row['id'] as int,
            row['ratingDate'] as String,
            row['rating'] as int,
            row['stringRating'] as String,
            row['wineForFood'] as String,
            row['wine_id'] as int));
  }

  @override
  Stream<List<Review>> findAllReviewStream() {
    return _queryAdapter.queryListStream('SELECT * FROM Review',
        queryableName: 'review',
        isView: false,
        mapper: (Map<String, dynamic> row) => Review(
            row['id'] as int,
            row['ratingDate'] as String,
            row['rating'] as int,
            row['stringRating'] as String,
            row['wineForFood'] as String,
            row['wine_id'] as int));
  }

  @override
  Future<Review> findReviewById(int id) async {
    return _queryAdapter.query('SELECT * FROM Review WHERE id = ?',
        arguments: <dynamic>[id],
        mapper: (Map<String, dynamic> row) => Review(
            row['id'] as int,
            row['ratingDate'] as String,
            row['rating'] as int,
            row['stringRating'] as String,
            row['wineForFood'] as String,
            row['wine_id'] as int));
  }

  @override
  Future<void> deleteReviewById(int id) async {
    await _queryAdapter.queryNoReturn('SELECT * FROM Review WHERE id = ?',
        arguments: <dynamic>[id]);
  }

  @override
  Future<int> insertReview(Review review) {
    return _reviewInsertionAdapter.insertAndReturnId(
        review, OnConflictStrategy.abort);
  }

  @override
  Future<int> updateReview(Review review) {
    return _reviewUpdateAdapter.updateAndReturnChangedRows(
        review, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteReview(Review review) async {
    await _reviewDeletionAdapter.delete(review);
  }

  @override
  Future<List<Review>> findReviewByWineId(int id) {
    return _queryAdapter.queryList('SELECT * FROM Review WHERE wine_id = ?',
        arguments: <dynamic>[id],
        mapper: (Map<String, dynamic> row) => Review(
            row['id'] as int,
            row['ratingDate'] as String,
            row['rating'] as int,
            row['stringRating'] as String,
            row['wineForFood'] as String,
            row['wine_id'] as int));
  }

  @override
  Future<void> deleteReviewByWineId(int id) async{
    await _queryAdapter.queryNoReturn('DELETE FROM Review WHERE wine_id = ?',
        arguments: <dynamic>[id]);
  }
}
