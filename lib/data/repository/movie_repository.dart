import 'package:fluvie/data/collection/movie_collection.dart';
import 'package:fluvie/data/model/movie.dart';
import 'package:fluvie/data/repository/movie_list_enum.dart';

abstract class MovieRepository {
  Future<MovieCollection> fetch(int page, MovieListEnum type);

  Future<List<Movie>> fetchFromCache(MovieListEnum type);

  Future<bool> syncToCache(List<Movie> movies, MovieListEnum type);
}
