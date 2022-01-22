import 'package:flutter/material.dart';
import 'package:random_color/random_color.dart';

RandomColor _randomColor = RandomColor();

class CircularImage extends StatelessWidget {
  final String? imageUrl;
  final String placeholderText;
  final double radius;
  const CircularImage({
    Key? key,
    this.imageUrl,
    required this.placeholderText,
    required this.radius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: _randomColor.randomColor(),
      radius: radius,
      child: Text(
        placeholderText,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 30.0,
        ),
      ),
    );
  }
}
