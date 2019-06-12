import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluvie/bloc/movie_list/movie_list.dart';
import 'package:fluvie/data/model/movie.dart';
import 'package:fluvie/data/repository/movie_list_enum.dart';

import 'movie_card.dart';

class MovieList extends StatefulWidget {
  final MovieListBloc movieListBloc;
  final MovieListEnum listType;

  const MovieList({Key key, this.movieListBloc, this.listType})
      : super(key: key);

  @override
  _MovieListState createState() => _MovieListState(
        movieListBloc: movieListBloc,
        listType: listType,
      );
}

class _MovieListState extends State<MovieList>
    with AutomaticKeepAliveClientMixin<MovieList> {
  final MovieListBloc movieListBloc;
  final MovieListEnum listType;
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;

  _MovieListState({this.movieListBloc, this.listType}) {
    _scrollController.addListener(_onScroll);
    print('fetch type: ${listType.toString()}');
    movieListBloc.dispatch(Fetch(type: listType));
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder(
      bloc: movieListBloc,
      builder: (BuildContext context, MovieListState state) {
        if (state is MovieListUninitialized) {
          return Center(child: Text("Loading"));
        }

        if (state is MovieListError) {
          return Center(child: Text("Failed to fetch movies"));
        }

        if (state is MovieListLoaded) {
          if (state.movies.isEmpty) {
            return Center(child: Text("No movies"));
          }

          return ListView.builder(
            itemBuilder: (context, index) {
              if (index >= state.movies.length) {
                return _BottomLoader();
              }

              return _MovieItem(
                movie: state.movies[index],
                index: index,
              );
            },
            itemCount: state.hasReachedMax
                ? state.movies.length
                : state.movies.length + 1,
            controller: _scrollController,
          );
        }
      },
    );
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      movieListBloc.dispatch(Fetch());
    }
  }
}

class _MovieItem extends StatelessWidget {
  final Movie movie;
  final int index;

  const _MovieItem({Key key, this.movie, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vertical = 28.0;
    final horizontal = 16.0;
    return InkWell(
      onTap: () {
        print(movie.title);
      },
      child: Padding(
        padding: EdgeInsets.only(
          top: index == 0 ? vertical : vertical / 2,
          bottom: index == (20 - 1) ? vertical : vertical / 2,
          left: horizontal,
          right: horizontal,
        ),
        child: MovieCard(movie: movie),
      ),
    );
  }
}

class _BottomLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Center(
        child: SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(
            strokeWidth: 2,
          ),
        ),
      ),
    );
  }
}