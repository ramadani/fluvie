import 'package:fluvie/data/collection/movie_collection.dart';
import 'package:fluvie/data/provider/movie_provider.dart';
import 'package:fluvie/data/repository/movie_list_enum.dart';
import 'package:fluvie/data/repository/movie_repository.dart';

class MovieRepositoryConcrete implements MovieRepository {
  final MovieProvider movieProvider;

  MovieRepositoryConcrete(this.movieProvider);

  @override
  Future<MovieCollection> list(int page, MovieListEnum type) async {
    MovieCollection result;

    switch (type) {
      case MovieListEnum.nowPlaying:
        result = await movieProvider.getNowPlaying(page);
        break;
      case MovieListEnum.popular:
        result = await movieProvider.getPopular(page);
        break;
      case MovieListEnum.topRated:
        result = await movieProvider.getTopRated(page);
        break;
      default:
        result = await movieProvider.getUpcoming(page);
    }

    return result;
  }
}
