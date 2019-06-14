import 'package:equatable/equatable.dart';

class Movie extends Equatable {
  final int id;
  final String title;
  final String originalTitle;
  final String posterPath;
  final String backdropPath;
  final String overview;
  final double popularity;
  final int voteCount;
  final double voteAverage;
  final String releaseDate;

  Movie({
    this.id,
    this.title,
    this.originalTitle,
    this.posterPath,
    this.backdropPath,
    this.overview,
    this.popularity,
    this.voteCount,
    this.voteAverage,
    this.releaseDate,
  });

  DateTime getReleaseDate() {
    return DateTime.parse(releaseDate);
  }

  String posterUrl() {
    return "https://image.tmdb.org/t/p/w200$posterPath";
  }
}
