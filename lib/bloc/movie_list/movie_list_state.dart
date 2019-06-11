import 'package:equatable/equatable.dart';
import 'package:fluvie/data/model/movie.dart';
import 'package:fluvie/data/repository/movie_list_enum.dart';

abstract class MovieListState extends Equatable {
  MovieListState([List props = const []]) : super(props);
}

class MovieListUninitialized extends MovieListState {
  @override
  String toString() => 'MovieListUninitialized';
}

class MovieListLoaded extends MovieListState {
  final List<Movie> movies;
  final int currentPage;
  final MovieListEnum listType;
  final bool hasReachedMax;

  MovieListLoaded({
    this.movies,
    this.currentPage,
    this.hasReachedMax,
    this.listType,
  }) : super([movies, currentPage, hasReachedMax]);

  MovieListLoaded copyWith({
    List<Movie> movies,
    int currentPage,
    bool hasReachedMax,
    MovieListEnum listType,
  }) {
    return MovieListLoaded(
      movies: movies ?? this.movies,
      currentPage: currentPage ?? this.currentPage,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      listType: listType ?? this.listType,
    );
  }

  @override
  String toString() =>
      'MovieListLoaded { movies: ${movies
          .length}, page $currentPage, hasReachedMax: $hasReachedMax }';

  int nextPage() => currentPage + 1;
}

class MovieListError extends MovieListState {
  @override
  String toString() => 'MovieListError';
}
