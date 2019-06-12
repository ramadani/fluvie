import 'package:flutter/material.dart';
import 'package:fluvie/bloc/movie_list/movie_list.dart';
import 'package:fluvie/config/config.dart';
import 'package:fluvie/config/json_config.dart';
import 'package:fluvie/data/provider/db/movie_provider_db.dart';
import 'package:fluvie/data/provider/db/sqlite_provider.dart';
import 'package:fluvie/data/provider/movie_cache_provider.dart';
import 'package:fluvie/data/provider/movie_provider.dart';
import 'package:fluvie/data/provider/network/http_client.dart';
import 'package:fluvie/data/provider/network/movie_provider_network.dart';
import 'package:fluvie/data/repository/concrete/movie_repository_concrete.dart';
import 'package:fluvie/data/repository/movie_repository.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';

class InjectorWidget extends InheritedWidget {
  final String _envFilename;

  Config _config;
  MovieProvider _movieProvider;
  MovieCacheProvider _movieCacheProvider;
  MovieRepository _movieRepository;
  MovieListBloc _movieListBloc;

  InjectorWidget({Key key, @required Widget child, String envFilename})
      : assert(child != null),
        _envFilename = envFilename,
        super(key: key, child: child);

  static InjectorWidget of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(InjectorWidget)
        as InjectorWidget;
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;

  Future<void> init() async {
    _config = JsonConfig();
    await _config.loadFromAssets(_envFilename);

    final db = await SQLiteProvider().open();
    final tmdbConfig = _config.data().tmdb;
    final httpClient = HttpClient(
      httpClient: Client(),
      baseUrl: tmdbConfig.baseUrl,
      apiKey: tmdbConfig.apiKey,
    );

    _movieProvider = MovieProviderNetwork(httpClient);
    _movieCacheProvider = MovieProviderDb(db);
    _movieRepository =
        MovieRepositoryConcrete(_movieProvider, _movieCacheProvider);
  }

  MovieListBloc movieListBloc({bool forceCreate = false}) {
    if (_movieListBloc == null || forceCreate) {
      _movieListBloc = MovieListBloc(_movieRepository);
    }

    return _movieListBloc;
  }
}
