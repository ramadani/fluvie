import 'package:flutter/material.dart';
import 'package:fluvie/injector_widget.dart';

import 'movie_list/movie_list_screen.dart';

const String rootRoute = '/';

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

  return {
    rootRoute: (_) => movieListScreen,
  };
}
