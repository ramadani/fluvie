import 'package:flutter/material.dart';
import 'package:fluvie/injector_widget.dart';

import 'screen/screens.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final movieListBloc = InjectorWidget.of(context).movieListBloc();

    return MaterialApp(
      title: 'fluvie',
      theme: ThemeData(
        primaryColor: primaryColor,
        accentColor: secondaryColor,
      ),
      home: MovieListScreen(bloc: movieListBloc),
    );
  }
}
