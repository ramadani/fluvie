import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SQLiteProvider {
  Future<Database> open() async {
    return openDatabase(
      join(await getDatabasesPath(), 'fluvie.db'),
      onCreate: (db, version) {
        return db.execute(_createMoviesTable());
      },
      version: 1,
    );
  }

  String _createMoviesTable() {
    return 'CREATE TABLE movies(id INTEGER PRIMARY KEY, movie_id INTEGER, '
        'title TEXT, original_title TEXT, poster_path TEXT, backdrop_path TEXT, '
        'overview TEXT, popularity REAL, vote_count INTEGER,'
        'vote_average REAL, release_date TEXT, list_type TEXT)';
  }
}
