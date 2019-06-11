import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:fluvie/config/config.dart';
import 'package:fluvie/config/config_data.dart';

class JsonConfig extends Config {
  ConfigData _data;

  @override
  Future<void> loadFromEnv(String path) async {
    final content = await rootBundle.loadString("assets/env/$path");
    final data = jsonDecode(content);

    _data = ConfigData(
      tmdb: TmDB(
        baseUrl: data['tmdb']['baseUrl'],
        apiKey: data['tmdb']['apiKey'],
      ),
    );

    return null;
  }

  @override
  ConfigData data() {
    return _data;
  }
}
