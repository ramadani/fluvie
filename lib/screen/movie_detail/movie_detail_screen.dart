import 'package:flutter/material.dart';
import 'package:fluvie/data/model/movie.dart';
import 'package:fluvie/widget/poster_card.dart';
import 'package:fluvie/widget/star_rating.dart';

class MovieDetailScreen extends StatelessWidget {
  static const routeName = "/movies-detail";

  @override
  Widget build(BuildContext context) {
    final MovieDetailScreenArgs args =
        ModalRoute
            .of(context)
            .settings
            .arguments;
    final movie = args.movie;

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, _) {
          return [
            SliverAppBar(
              expandedHeight: 180.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  children: <Widget>[
                    _HeaderStackBackground(
                      child: Image.network(
                        movie.backdropUrl(),
                        fit: BoxFit.cover,
                      ),
                    ),
                    _HeaderStackBackground(
                      child: Opacity(
                        opacity: 0.5,
                        child: Container(
                          color: Theme
                              .of(context)
                              .primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ];
        },
        body: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  PosterCard(
                    url: movie.posterUrl(),
                    width: 100 * 1.8,
                    height: 150 * 1.8,
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      margin: EdgeInsets.only(left: 20.0),
                      child: _SummaryContent(movie: movie),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Overview', style: Theme
                      .of(context)
                      .textTheme
                      .subtitle),
                  Container(
                    margin: EdgeInsets.only(top: 8.0),
                    child: Text(movie.overview),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _HeaderStackBackground extends StatelessWidget {
  final Widget child;

  const _HeaderStackBackground({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      bottom: 0,
      left: 0,
      right: 0,
      child: child,
    );
  }
}

class _SummaryContent extends StatelessWidget {
  final Movie movie;

  const _SummaryContent({Key key, this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          movie.title,
          style: Theme
              .of(context)
              .textTheme
              .title,
        ),
        Container(
          margin: EdgeInsets.only(top: 4.0),
          child: StarRating(
            starCount: 5,
            starSize: 20.0,
            rating: movie.voteAverage,
            color: Colors.orangeAccent,
          ),
        ),
        _ItemHeader(
          margin: EdgeInsets.only(top: 16.0),
          label: 'Genre',
          content: 'Adventure, Science Fiction, Action',
        ),
        _ItemHeader(
          margin: EdgeInsets.only(top: 4.0),
          label: 'Duration',
          content: '3 hours 1 minute',
        ),
        _ItemHeader(
          margin: EdgeInsets.only(top: 4.0),
          label: 'Production',
          content: 'Marvel Studios',
        ),
      ],
    );
  }
}

class _ItemHeader extends StatelessWidget {
  final EdgeInsets margin;
  final String label;
  final String content;

  const _ItemHeader({Key key, this.margin, this.label, this.content})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: Theme
                  .of(context)
                  .textTheme
                  .body1
                  .copyWith(color: Colors.black38, fontSize: 12.0),
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              margin: EdgeInsets.only(left: 8.0),
              child: Text(
                content,
                style:
                Theme
                    .of(context)
                    .textTheme
                    .body1
                    .copyWith(fontSize: 12.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MovieDetailScreenArgs {
  final Movie movie;

  MovieDetailScreenArgs(this.movie);
}
