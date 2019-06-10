import 'package:equatable/equatable.dart';
import 'package:fluvie/data/model/movie.dart';
import 'package:fluvie/data/repository/movie_list_enum.dart';

abstract class MovieListState extends Equatable {
  MovieListState([List props = const []]) : super(props);
}

class MovieListUninitialized extends MovieListState {
  final MovieListEnum type;

  MovieListUninitialized({this.type}) : super([type]);

  @override
  String toString() => 'MovieListUninitialized';
}

class MovieListLoaded extends MovieListState {
  final List<Movie> movies;
  final bool hasReachedMax;

  MovieListLoaded({this.movies, this.hasReachedMax})
      : super([movies, hasReachedMax]);

  MovieListLoaded copyWith({List<Movie> movies, bool hasReachedMax}) {
    return MovieListLoaded(
      movies: movies ?? this.movies,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() =>
      'MovieListLoaded { movies: ${movies.length}, hasReachedMax: $hasReachedMax }';
}

class MovieListError extends MovieListState {
  @override
  String toString() => 'MovieListError';
}
