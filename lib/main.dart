import 'package:flutter/material.dart';
import 'package:fluvie/injector_widget.dart';

import 'app.dart';

void main() async {
  final app = InjectorWidget(
    child: App(),
    envFilename: "development.json",
  );
  await app.init();

  runApp(app);
}
