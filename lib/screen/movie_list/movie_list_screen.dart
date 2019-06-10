import 'package:flutter/material.dart';
import 'package:fluvie/data/model/movie.dart';
import 'package:fluvie/screen/movie_list/movie_card.dart';

class MovieListScreen extends StatelessWidget {
  const MovieListScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final movie = Movie(
      "Dark Phoenix",
      "Dark Phoenix",
      "/kZv92eTc0Gg3mKxqjjDAM73z9cy.jpg",
      "/phxiKFDvPeQj4AbkvJLmuZEieDU.jpg",
      "The X-Men face their most formidable and powerful foe when one of their own, Jean Grey, starts to spiral out of control. During a rescue mission in outer space, Jean is nearly killed when she's hit by a mysterious cosmic force. Once she returns home, this force not only makes her infinitely more powerful, but far more unstable. The X-Men must now band together to save her soul and battle aliens that want to use Grey's new abilities to rule the galaxy.",
      283.205,
      1299,
      7.2,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("fluvie"),
      ),
      body: ListView.builder(
        itemCount: 20,
        itemBuilder: (context, index) {
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
        },
      ),
    );
  }
}
