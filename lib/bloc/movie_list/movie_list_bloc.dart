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
    if (event is Fetch && !_hasReachedMax(currentState)) {
      try {
        if (currentState is MovieListUninitialized) {
          yield* _mapUninitializedToState(event);
        } else if (currentState is MovieListLoaded) {
          yield* _mapLoadedListToState(event);
        }
      } catch (e) {
        yield MovieListError();
      }
    }
  }

  Stream<MovieListState> _mapUninitializedToState(Fetch event) async* {
    final movies = await _movieRepository.fetchFromCache(event.type);
    if (movies.isNotEmpty) {
      yield MovieListLoaded(
        movies: movies,
        currentPage: 1,
        hasReachedMax: false,
        listType: event.type,
      );
    }

    final collection = await _movieRepository.fetch(1, event.type);
    yield MovieListLoaded(
      movies: collection.results,
      currentPage: collection.page,
      hasReachedMax: collection.page >= collection.totalPages,
      listType: event.type,
    );

    await _movieRepository.syncToCache(collection.results, event.type);
  }

  Stream<MovieListState> _mapLoadedListToState(Fetch event) async* {
    final state = currentState as MovieListLoaded;
    final collection =
    await _movieRepository.fetch(state.nextPage(), state.listType);

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

  bool _hasReachedMax(MovieListState state) =>
      state is MovieListLoaded && state.hasReachedMax;
}
