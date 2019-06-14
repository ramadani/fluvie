import 'package:flutter/material.dart';

class PosterCard extends StatelessWidget {
  final String url;
  final double width;
  final double height;

  const PosterCard({Key key, this.url, this.width, this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dividedBy = 1.8;
    return Container(
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        child: Image.network(
          url,
          fit: BoxFit.contain,
          width: width / dividedBy,
          height: height / dividedBy,
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(8.0),
        ),
        boxShadow: <BoxShadow>[
          new BoxShadow(
            color: Colors.black26,
            blurRadius: 8.0,
            offset: new Offset(0.0, 6.0),
          ),
        ],
      ),
    );
  }
}
