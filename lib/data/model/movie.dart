import 'package:equatable/equatable.dart';

class Movie extends Equatable {
  final String title;
  final String originalTitle;
  final String posterPath;
  final String backdropPath;
  final String overview;
  final double popularity;
  final int voteCount;
  final double voteAverage;
  String releaseDate;

  Movie(this.title, this.originalTitle, this.posterPath, this.backdropPath,
      this.overview, this.popularity, this.voteCount, this.voteAverage);

  DateTime getReleaseDate() {
    return DateTime.parse(releaseDate);
  }

  String posterUrl() {
    return "https://image.tmdb.org/t/p/w200$posterPath";
  }
}
