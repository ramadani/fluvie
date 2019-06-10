import 'package:equatable/equatable.dart';
import 'package:fluvie/data/repository/movie_list_enum.dart';

abstract class MovieListEvent extends Equatable {
  MovieListEvent([List props = const []]) : super(props);
}

class Fetch extends MovieListEvent {
  int currentPage = 0;
  final MovieListEnum currentType;

  Fetch({this.currentType}) : super([currentType]);

  @override
  String toString() => 'Fetch';

  int nextPage() => currentPage + 1;
}
