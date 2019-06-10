import 'package:flutter/material.dart';

class PosterCard extends StatelessWidget {
  final String url;

  const PosterCard({Key key, this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        child: Image.network(url, fit: BoxFit.cover),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(8.0),
        ),
        boxShadow: <BoxShadow>[
          new BoxShadow(
            color: Colors.black26,
            blurRadius: 8.0,
            offset: new Offset(0.0, 4.0),
          ),
        ],
      ),
    );
  }
}
