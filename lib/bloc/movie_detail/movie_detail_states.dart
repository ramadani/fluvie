import 'package:equatable/equatable.dart';
import 'package:fluvie/data/model/movie.dart';

abstract class MovieDetailState extends Equatable {
  MovieDetailState([List props = const []]) : super(props);
}

class MovieDetailLoading extends MovieDetailState {
  @override
  String toString() => 'MovieDetailLoading';
}

class MovieDetailLoaded extends MovieDetailState {
  final Movie movie;

  MovieDetailLoaded(this.movie) : super([movie]);

  @override
  String toString() => 'MovieDetailLoaded';
}
