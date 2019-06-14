import 'package:equatable/equatable.dart';

abstract class MovieDetailEvent extends Equatable {
  MovieDetailEvent([List props = const []]) : super(props);
}

class GetMovieDetail extends MovieDetailEvent {
  final int movieId;

  GetMovieDetail(this.movieId) : super([movieId]);
}
