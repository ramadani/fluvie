import 'package:flutter/material.dart';
import 'package:fluvie/bloc/movie_list/movie_list.dart';
import 'package:fluvie/data/repository/movie_list_enum.dart';

import 'movie_list_view.dart';

class MovieListScreen extends StatefulWidget {
  final MovieListBloc nowPlayingBloc;
  final MovieListBloc upcomingBloc;
  final MovieListBloc popularBloc;
  final MovieListBloc topRatedBloc;

  const MovieListScreen({
    Key key,
    this.nowPlayingBloc,
    this.upcomingBloc,
    this.popularBloc,
    this.topRatedBloc,
  }) : super(key: key);

  @override
  _MovieListScreenState createState() => _MovieListScreenState();
}

class _MovieListScreenState extends State<MovieListScreen>
    with SingleTickerProviderStateMixin {
  final List<Tab> tabs = [
    Tab(text: "Now Playing"),
    Tab(text: "Upcoming"),
    Tab(text: "Popular"),
    Tab(text: "Top Rated"),
  ];

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: tabs.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text("fluvie"),
          bottom: TabBar(
            isScrollable: true,
            tabs: tabs,
            controller: _tabController,
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: <Widget>[
            MovieList(
              movieListBloc: widget.nowPlayingBloc,
              listType: MovieListEnum.nowPlaying,
            ),
            MovieList(
              movieListBloc: widget.upcomingBloc,
              listType: MovieListEnum.upcoming,
            ),
            MovieList(
              movieListBloc: widget.popularBloc,
              listType: MovieListEnum.popular,
            ),
            MovieList(
              movieListBloc: widget.topRatedBloc,
              listType: MovieListEnum.topRated,
            ),
          ],
        ),
      ),
    );
  }
}
