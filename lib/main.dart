import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:fluvie/injector_widget.dart';

import 'app.dart';

void main() async {
  final app = InjectorWidget(
    child: App(),
    envFilename: "env.json",
  );
  await app.init();

  BlocSupervisor.delegate = _SimpleBlocDelegate();
  runApp(app);
}

class _SimpleBlocDelegate extends BlocDelegate {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }
}