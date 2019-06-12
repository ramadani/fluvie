import 'package:fluvie/data/collection/movie_collection.dart';

abstract class MovieProvider {
  Future<MovieCollection> getNowPlaying(int page);

  Future<MovieCollection> getPopular(int page);

  Future<MovieCollection> getTopRated(int page);

  Future<MovieCollection> getUpcoming(int page);
}
