import 'package:fluvie/data/model/movie.dart';

class MovieCollection {
  final int page;
  final int totalResults;
  final int totalPages;
  final List<Movie> results = List();

  MovieCollection(this.page, this.totalResults, this.totalPages);

  void addMovie(Movie movie) {
    results.add(movie);
  }

  void addMovies(List<Movie> movies) {
    results.addAll(movies);
  }
}
