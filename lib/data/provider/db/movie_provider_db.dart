import 'package:fluvie/data/model/movie.dart';
import 'package:fluvie/data/provider/movie_cache_provider.dart';
import 'package:sqflite/sqflite.dart';

class MovieProviderDb implements MovieCacheProvider {
  final Database db;

  MovieProviderDb(this.db);

  Future<List<Movie>> fetchByListType(String listType) async {
    List<Movie> results;

    final movies = await db.rawQuery('SELECT movie_id, title, '
        'original_title, poster_path, backdrop_path, overview, popularity, '
        'vote_count, vote_average, release_date, list_type FROM movies'
        'WHERE list_type = $listType');

    if (movies.isNotEmpty) {
      movies.toList().forEach((raw) {
        final movie = Movie(
          id: raw['movie_id'] as num,
          title: raw['title'],
          originalTitle: raw['original_title'],
          posterPath: raw['poster_path'],
          backdropPath: raw['backdrop_path'],
          overview: raw['overview'],
          popularity: (raw['popularity'] as num).toDouble(),
          voteCount: raw['vote_count'] as num,
          voteAverage: (raw['vote_average'] as num).toDouble(),
        );
        results.add(movie);
      });
    }

    return results;
  }

  @override
  Future<bool> insertAllByListType(List<Movie> movies, String listType) async {
    movies.forEach((movie) async => await _insert(movie, listType));
    return true;
  }

  @override
  Future<bool> deleteAllByListType(String listType) async {
    await db.delete('DELETE FROM movies WHERE list_type = $listType');
    return null;
  }

  Future<int> _insert(Movie movie, String listType) async {
    return await db.rawInsert('INSERT INTO movies (movie_id, title, '
        'original_title, poster_path, backdrop_path, overview, popularity, '
        'vote_count, vote_average, release_date, list_type)'
        'VALUES (${movie.id}, ${movie.title}, ${movie.originalTitle}, '
        '${movie.posterPath}, ${movie.backdropPath}, ${movie.overview},'
        '${movie.popularity}, ${movie.voteCount}, ${movie.voteAverage},'
        '${movie.releaseDate}, $listType})');
  }
}
