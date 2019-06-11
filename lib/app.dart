import 'package:flutter/material.dart';
import 'package:fluvie/injector_widget.dart';

import 'screen/screens.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final nowPlayingBloc =
    InjectorWidget.of(context).movieListBloc(forceCreate: true);
    final upcomingBloc =
    InjectorWidget.of(context).movieListBloc(forceCreate: true);
    final popularBloc =
    InjectorWidget.of(context).movieListBloc(forceCreate: true);
    final topRatedBloc =
    InjectorWidget.of(context).movieListBloc(forceCreate: true);

    return MaterialApp(
      title: 'fluvie',
      theme: ThemeData(
        primaryColor: primaryColor,
        accentColor: secondaryColor,
      ),
      home: MovieListScreen(
        nowPlayingBloc: nowPlayingBloc,
        upcomingBloc: upcomingBloc,
        popularBloc: popularBloc,
        topRatedBloc: topRatedBloc,
      ),
    );
  }
}
