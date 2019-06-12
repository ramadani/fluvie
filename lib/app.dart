import 'package:flutter/material.dart';
import 'package:fluvie/screen/routes.dart';

import 'screen/colors.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'fluvie',
      theme: ThemeData(
        primaryColor: primaryColor,
        accentColor: secondaryColor,
      ),
      initialRoute: rootRoute,
      routes: routes(context),
    );
  }
}
