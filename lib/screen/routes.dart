import 'package:flutter/material.dart';
import 'package:fluvie/injector_widget.dart';
import 'package:fluvie/screen/movie_detail/movie_detail_screen.dart';

import 'movie_list/movie_list_screen.dart';

Map<String, WidgetBuilder> routes(BuildContext context) {
  final nowPlayingBloc =
      InjectorWidget.of(context).movieListBloc(forceCreate: true);
  final upcomingBloc =
      InjectorWidget.of(context).movieListBloc(forceCreate: true);
  final popularBloc =
      InjectorWidget.of(context).movieListBloc(forceCreate: true);
  final topRatedBloc =
      InjectorWidget.of(context).movieListBloc(forceCreate: true);

  final movieListScreen = MovieListScreen(
    nowPlayingBloc: nowPlayingBloc,
    upcomingBloc: upcomingBloc,
    popularBloc: popularBloc,
    topRatedBloc: topRatedBloc,
  );
  final movieDetailScreen = MovieDetailScreen();

  return {
    MovieListScreen.routeName: (_) => movieListScreen,
    MovieDetailScreen.routeName: (_) => movieDetailScreen,
  };
}
