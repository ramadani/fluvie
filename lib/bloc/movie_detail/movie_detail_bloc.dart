import 'package:bloc/bloc.dart';
import 'package:fluvie/bloc/movie_detail/movie_detail_events.dart';
import 'package:fluvie/bloc/movie_detail/movie_detail_states.dart';
import 'package:fluvie/data/repository/movie_repository.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final MovieRepository _movieRepository;

  MovieDetailBloc(this._movieRepository);

  @override
  MovieDetailState get initialState => MovieDetailLoading();

  @override
  Stream<MovieDetailState> mapEventToState(MovieDetailEvent event) async* {
    try {
      if (event is GetMovieDetail) {
        final movie = await _movieRepository.findFromCache(event.movieId);
        yield MovieDetailLoaded(movie);
      }
    } catch (e) {
      yield MovieDetailError(e.toString());
    }
  }
}
