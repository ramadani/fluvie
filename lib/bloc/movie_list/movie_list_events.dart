import 'package:equatable/equatable.dart';
import 'package:fluvie/data/repository/movie_list_enum.dart';

abstract class MovieListEvent extends Equatable {
  MovieListEvent([List props = const []]) : super(props);
}

class Fetch extends MovieListEvent {
  final MovieListEnum type;

  Fetch({this.type}) : super([type]);

  @override
  String toString() => 'Fetch ${type.toString()}';
}

class ChangeTab extends MovieListEvent {
  @override
  String toString() => 'ChangeTab';
}
