import 'dart:convert';

import 'package:fluvie/data/collection/movie_collection.dart';
import 'package:fluvie/data/model/movie.dart';
import 'package:fluvie/data/provider/movie_provider.dart';
import 'package:fluvie/data/provider/network/http_client.dart';

class MovieProviderNetwork implements MovieProvider {
  final HttpClient httpClient;

  MovieProviderNetwork(this.httpClient);

  @override
  Future<MovieCollection> getNowPlaying(int page) async {
    final queryParams = {'page': page.toString()};
    final response =
    await httpClient.get("/movie/now_playing", queryParams: queryParams,);
    final data = json.decode(response.body);

    if (response.statusCode == 200) {
      return _parseCollection(data);
    } else {
      throw Exception(data['status_message']);
    }
  }

  @override
  Future<MovieCollection> getPopular(int page) async {
    final queryParams = {'page': page.toString()};
    final response =
    await httpClient.get("/movie/popular", queryParams: queryParams);
    final data = json.decode(response.body);

    if (response.statusCode == 200) {
      return _parseCollection(data);
    } else {
      throw Exception(data['status_message']);
    }
  }

  @override
  Future<MovieCollection> getTopRated(int page) async {
    final queryParams = {'page': page.toString()};
    final response =
    await httpClient.get("/movie/top_rated", queryParams: queryParams);
    final data = json.decode(response.body);

    if (response.statusCode == 200) {
      return _parseCollection(data);
    } else {
      throw Exception(data['status_message']);
    }
  }

  @override
  Future<MovieCollection> getUpcoming(int page) async {
    final queryParams = {'page': page.toString()};
    final response =
    await httpClient.get("/movie/upcoming", queryParams: queryParams);
    final data = json.decode(response.body);

    if (response.statusCode == 200) {
      return _parseCollection(data);
    } else {
      throw Exception(data['status_message']);
    }
  }

  MovieCollection _parseCollection(dynamic data) {
    final int page = data['page'];
    final int total = data['total_results'];
    final int pages = data['total_pages'];
    final results = data['results'] as List;
    final collection = MovieCollection(page, total, pages);
    final List<Movie> movies = results.map((raw) {
      return Movie(
        id: raw['id'] as num,
        title: raw['title'],
        originalTitle: raw['original_title'],
        posterPath: raw['poster_path'],
        backdropPath: raw['backdrop_path'],
        overview: raw['overview'],
        popularity: (raw['popularity'] as num).toDouble(),
        voteCount: raw['vote_count'] as num,
        voteAverage: (raw['vote_average'] as num).toDouble(),
      );
    }).toList();

    collection.addMovies(movies);
    return collection;
  }
}
