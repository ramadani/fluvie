import 'package:bloc/bloc.dart';
import 'package:fluvie/bloc/movie_list/movie_list.dart';
import 'package:fluvie/data/repository/movie_repository.dart';

class MovieListBloc extends Bloc<MovieListEvent, MovieListState> {
  final MovieRepository _movieRepository;

  MovieListBloc(this._movieRepository);

  @override
  MovieListState get initialState => MovieListUninitialized();

  @override
  Stream<MovieListState> mapEventToState(MovieListEvent event) async* {
    if (event is ChangeTab) {
      yield MovieListUninitialized();
    }

    if (event is Fetch && !_hasReachedMax(currentState)) {
      final state = currentState;
      try {
        if (state is MovieListUninitialized) {
          final collection = await _movieRepository.list(1, event.type);

          yield MovieListLoaded(
            movies: collection.results,
            currentPage: collection.page,
            hasReachedMax: collection.page >= collection.totalPages,
            listType: event.type,
          );
        } else if (state is MovieListLoaded) {
          final collection =
          await _movieRepository.list(state.nextPage(), state.listType);

          if (collection.results.isEmpty) {
            yield state.copyWith(
              currentPage: collection.page,
              hasReachedMax: true,
            );
          } else {
            yield MovieListLoaded(
              movies: state.movies + collection.results,
              currentPage: collection.page,
              hasReachedMax: collection.page >= collection.totalPages,
              listType: state.listType,
            );
          }
        }
      } catch (_) {
        yield MovieListError();
      }
    }
  }

  bool _hasReachedMax(MovieListState state) =>
      state is MovieListLoaded && state.hasReachedMax;
}
