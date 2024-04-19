import 'package:flutter/material.dart';

class StarRating extends StatelessWidget {
  final int count;
  final double size;
  final Color color;
  final Color fillColor;

  const StarRating({
    Key? key,
    required this.count,
    this.size = 18,
    this.color = Colors.grey,
    this.fillColor = Colors.yellow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        if (index < count) {
          return Icon(
            Icons.star,
            size: size,
            color: fillColor,
          );
        } else {
          return Icon(
            Icons.star_border,
            size: size,
            color: color,
          );
        }
      }),
    );
  }
}
