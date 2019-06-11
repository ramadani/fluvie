import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluvie/data/model/movie.dart';
import 'package:fluvie/widget/poster_card.dart';
import 'package:fluvie/widget/star_rating.dart';

class MovieCard extends StatelessWidget {
  final Movie _movie;

  const MovieCard({Key key, Movie movie})
      : _movie = movie,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        PosterCard(url: _movie.posterUrl()),
        Expanded(
          flex: 3,
          child: Padding(
            padding: EdgeInsets.only(left: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: Text(
                          _movie.title,
                          style: Theme
                              .of(context)
                              .textTheme
                              .title,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 0,
                      child: Icon(
                        Icons.favorite_border,
                        color: Colors.redAccent,
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 2.0),
                  child: StarRating(
                    color: Colors.orangeAccent,
                    starCount: 5,
                    rating: _movie.voteAverage / 2,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 16.0),
                  child: Text(
                    _movie.overview,
                    style: Theme.of(context).textTheme.body1.copyWith(
                      fontSize: 12.0,
                      color: Colors.grey[600],
                    ),
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
