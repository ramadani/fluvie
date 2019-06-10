import 'package:fluvie/data/collection/movie_collection.dart';
import 'package:fluvie/data/repository/movie_list_enum.dart';

abstract class MovieRepository {
  Future<MovieCollection> list(int page, MovieListEnum type);
}
