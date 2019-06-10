import 'package:flutter/material.dart';

class StarRating extends StatelessWidget {
  final Color color;
  final int starCount;
  final double rating;

  const StarRating({Key key, this.color, this.starCount, this.rating})
      : super(key: key);

  Widget _buildStar(int index) {
    Icon icon;
    if (index >= rating || (index > rating - 0.5 && index < rating)) {
      icon = new Icon(
        Icons.star,
        color: Colors.grey[300],
      );
    } else {
      icon = new Icon(
        Icons.star,
        color: color,
      );
    }

    return Padding(
      padding: EdgeInsets.only(
        left: index == 0 ? 0.0 : 2.0,
      ),
      child: Icon(icon.icon, color: icon.color, size: 16.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        starCount,
        (index) => _buildStar(index),
      ),
    );
  }
}
