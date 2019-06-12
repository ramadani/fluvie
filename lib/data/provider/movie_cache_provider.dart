import 'package:fluvie/data/model/movie.dart';

abstract class MovieCacheProvider {
  Future<List<Movie>> fetchByListType(String listType);

  Future<bool> insertAllByListType(List<Movie> movies, String listType);

  Future<bool> deleteAllByListType(String listType);
}
