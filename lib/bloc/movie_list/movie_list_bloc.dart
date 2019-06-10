import 'package:bloc/bloc.dart';
import 'package:fluvie/bloc/movie_list_bloc.dart';
import 'package:fluvie/data/repository/movie_repository.dart';

class MovieListBloc extends Bloc<MovieListEvent, MovieListState> {
  final MovieRepository _movieRepository;

  MovieListBloc(this._movieRepository);

  @override
  MovieListState get initialState => MovieListUninitialized();

  @override
  Stream<MovieListState> mapEventToState(MovieListEvent event) async* {
    if (event is Fetch) {
      final state = currentState;
      try {
        if (state is MovieListUninitialized) {
          final collection =
              await _movieRepository.list(event.nextPage(), event.currentType);

          yield MovieListLoaded(
            movies: collection.results,
            hasReachedMax: collection.page >= collection.totalPages,
          );
        } else if (state is MovieListLoaded) {
          final collection =
              await _movieRepository.list(event.nextPage(), event.currentType);

          yield collection.results.isEmpty
              ? state.copyWith(hasReachedMax: true)
              : MovieListLoaded(
                  movies: state.movies + collection.results,
                  hasReachedMax: collection.page >= collection.totalPages,
                );
        }
      } catch (_) {
        yield MovieListError();
      }
    }
  }
}
