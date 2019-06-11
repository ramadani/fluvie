import 'package:fluvie/config/config_data.dart';

abstract class Config {
  Future<void> loadFromEnv(String path);

  ConfigData data();
}
