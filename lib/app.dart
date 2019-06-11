import 'package:flutter/material.dart';

import 'screen/screens.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'fluvie',
      theme: ThemeData(
        primaryColor: primaryColor,
        accentColor: secondaryColor,
      ),
      home: MovieListScreen(),
    );
  }
}
