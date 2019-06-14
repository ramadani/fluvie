import 'package:fluvie/data/model/movie.dart';

abstract class MovieCacheProvider {
  Future<List<Movie>> fetchByListType(String listType);

  Future<Movie> findByMovieId(int movieId);

  Future<bool> insertAllByListType(List<Movie> movies, String listType);

  Future<bool> deleteAllByListType(String listType);
}
