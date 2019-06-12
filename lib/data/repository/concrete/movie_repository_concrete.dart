import 'package:fluvie/data/collection/movie_collection.dart';
import 'package:fluvie/data/model/movie.dart';
import 'package:fluvie/data/provider/movie_cache_provider.dart';
import 'package:fluvie/data/provider/movie_provider.dart';
import 'package:fluvie/data/repository/movie_list_enum.dart';
import 'package:fluvie/data/repository/movie_repository.dart';

class MovieRepositoryConcrete implements MovieRepository {
  final MovieProvider _movieProvider;
  final MovieCacheProvider _movieCacheProvider;

  MovieRepositoryConcrete(this._movieProvider, this._movieCacheProvider);

  @override
  Future<MovieCollection> fetch(int page, MovieListEnum type) async {
    MovieCollection result;

    switch (type) {
      case MovieListEnum.nowPlaying:
        result = await _movieProvider.getNowPlaying(page);
        break;
      case MovieListEnum.popular:
        result = await _movieProvider.getPopular(page);
        break;
      case MovieListEnum.topRated:
        result = await _movieProvider.getTopRated(page);
        break;
      default:
        result = await _movieProvider.getUpcoming(page);
    }

    return result;
  }

  @override
  Future<List<Movie>> fetchFromCache(MovieListEnum type) async {
    return await _movieCacheProvider.fetchByListType(type.toString());
  }

  @override
  Future<bool> syncToCache(List<Movie> movies, MovieListEnum type) async {
    await _movieCacheProvider.deleteAllByListType(type.toString());
    await _movieCacheProvider.insertAllByListType(movies, type.toString());

    return true;
  }
}
