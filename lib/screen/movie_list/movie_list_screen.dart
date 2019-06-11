import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluvie/bloc/movie_list/movie_list.dart';
import 'package:fluvie/bloc/movie_list/movie_list_bloc.dart';
import 'package:fluvie/data/model/movie.dart';
import 'package:fluvie/data/repository/movie_list_enum.dart';

import 'movie_card.dart';

class MovieListScreen extends StatefulWidget {
  final MovieListBloc _bloc;

  MovieListScreen({Key key, MovieListBloc bloc})
      : _bloc = bloc,
        super(key: key);

  @override
  _MovieListScreenState createState() => _MovieListScreenState(bloc: _bloc);
}

class _MovieListScreenState extends State<MovieListScreen> {
  MovieListBloc _bloc;
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;

  _MovieListScreenState({MovieListBloc bloc}) {
    _bloc = bloc;
    _scrollController.addListener(_onScroll);
    _bloc.dispatch(Fetch(type: MovieListEnum.nowPlaying));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("fluvie"),
      ),
      body: BlocBuilder(
        bloc: _bloc,
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
      ),
    );
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      _bloc.dispatch(Fetch());
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
