// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movies_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

class $FloorMoviesDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$MoviesDatabaseBuilder databaseBuilder(String name) =>
      _$MoviesDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$MoviesDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$MoviesDatabaseBuilder(null);
}

class _$MoviesDatabaseBuilder {
  _$MoviesDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$MoviesDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$MoviesDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<MoviesDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$MoviesDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$MoviesDatabase extends MoviesDatabase {
  _$MoviesDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  MovieDao? _moviesDaoInstance;

  MovieDetailDao? _movieDetailsDaoInstance;

  MovieTicketDao? _movieTicketDaoInstance;

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
            'CREATE TABLE IF NOT EXISTS `MovieModel` (`id` INTEGER NOT NULL, `adult` INTEGER NOT NULL, `overview` TEXT NOT NULL, `posterPath` TEXT NOT NULL, `releaseDate` TEXT NOT NULL, `title` TEXT NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `MovieDetailModel` (`id` INTEGER NOT NULL, `genres` TEXT NOT NULL, `overview` TEXT NOT NULL, `releaseDate` TEXT NOT NULL, `title` TEXT NOT NULL, `voteAverage` REAL NOT NULL, `imageUrlList` TEXT NOT NULL, `youtubeTrailorId` TEXT NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `MovieTicketModel` (`id` INTEGER NOT NULL, `seatNumber` TEXT NOT NULL, `location` TEXT NOT NULL, `cinema` TEXT NOT NULL, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  MovieDao get moviesDao {
    return _moviesDaoInstance ??= _$MovieDao(database, changeListener);
  }

  @override
  MovieDetailDao get movieDetailsDao {
    return _movieDetailsDaoInstance ??=
        _$MovieDetailDao(database, changeListener);
  }

  @override
  MovieTicketDao get movieTicketDao {
    return _movieTicketDaoInstance ??=
        _$MovieTicketDao(database, changeListener);
  }
}

class _$MovieDao extends MovieDao {
  _$MovieDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _movieModelInsertionAdapter = InsertionAdapter(
            database,
            'MovieModel',
            (MovieModel item) => <String, Object?>{
                  'id': item.id,
                  'adult': item.adult ? 1 : 0,
                  'overview': item.overview,
                  'posterPath': item.posterPath,
                  'releaseDate': item.releaseDate,
                  'title': item.title
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<MovieModel> _movieModelInsertionAdapter;

  @override
  Future<void> clearMovieData() async {
    await _queryAdapter.queryNoReturn('DELETE FROM MovieModel');
  }

  @override
  Future<List<MovieModel>?> getAllMovies() async {
    return _queryAdapter.queryList('SELECT * FROM MovieModel',
        mapper: (Map<String, Object?> row) => MovieModel(
            adult: (row['adult'] as int) != 0,
            id: row['id'] as int,
            overview: row['overview'] as String,
            posterPath: row['posterPath'] as String,
            releaseDate: row['releaseDate'] as String,
            title: row['title'] as String));
  }

  @override
  Future<void> insertMovie(MovieModel movie) async {
    await _movieModelInsertionAdapter.insert(movie, OnConflictStrategy.abort);
  }
}

class _$MovieDetailDao extends MovieDetailDao {
  _$MovieDetailDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _movieDetailModelInsertionAdapter = InsertionAdapter(
            database,
            'MovieDetailModel',
            (MovieDetailModel item) => <String, Object?>{
                  'id': item.id,
                  'genres': item.genres,
                  'overview': item.overview,
                  'releaseDate': item.releaseDate,
                  'title': item.title,
                  'voteAverage': item.voteAverage,
                  'imageUrlList': item.imageUrlList,
                  'youtubeTrailorId': item.youtubeTrailorId
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<MovieDetailModel> _movieDetailModelInsertionAdapter;

  @override
  Future<MovieDetailModel?> getMovieDetail(int id) async {
    return _queryAdapter.query('SELECT FROM MovieDetailModel WHERE id = ?1',
        mapper: (Map<String, Object?> row) => MovieDetailModel(
            genres: row['genres'] as String,
            id: row['id'] as int,
            overview: row['overview'] as String,
            releaseDate: row['releaseDate'] as String,
            title: row['title'] as String,
            voteAverage: row['voteAverage'] as double,
            imageUrlList: row['imageUrlList'] as String,
            youtubeTrailorId: row['youtubeTrailorId'] as String),
        arguments: [id]);
  }

  @override
  Future<List<MovieDetailModel>?> getAllMoviesDetals() async {
    return _queryAdapter.queryList('SELECT * FROM MovieDetailModel',
        mapper: (Map<String, Object?> row) => MovieDetailModel(
            genres: row['genres'] as String,
            id: row['id'] as int,
            overview: row['overview'] as String,
            releaseDate: row['releaseDate'] as String,
            title: row['title'] as String,
            voteAverage: row['voteAverage'] as double,
            imageUrlList: row['imageUrlList'] as String,
            youtubeTrailorId: row['youtubeTrailorId'] as String));
  }

  @override
  Future<void> insertMovie(MovieDetailModel movieDetail) async {
    await _movieDetailModelInsertionAdapter.insert(
        movieDetail, OnConflictStrategy.abort);
  }
}

class _$MovieTicketDao extends MovieTicketDao {
  _$MovieTicketDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _movieTicketModelInsertionAdapter = InsertionAdapter(
            database,
            'MovieTicketModel',
            (MovieTicketModel item) => <String, Object?>{
                  'id': item.id,
                  'seatNumber': item.seatNumber,
                  'location': item.location,
                  'cinema': item.cinema
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<MovieTicketModel> _movieTicketModelInsertionAdapter;

  @override
  Future<MovieTicketModel?> getMovieTicket(int id) async {
    return _queryAdapter.query('SELECT FROM MovieTicketModel WHERE id = ?1',
        mapper: (Map<String, Object?> row) => MovieTicketModel(
            id: row['id'] as int,
            seatNumber: row['seatNumber'] as String,
            location: row['location'] as String,
            cinema: row['cinema'] as String),
        arguments: [id]);
  }

  @override
  Future<void> insertMovieTicket(MovieTicketModel movieTicket) async {
    await _movieTicketModelInsertionAdapter.insert(
        movieTicket, OnConflictStrategy.abort);
  }
}
