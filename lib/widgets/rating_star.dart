import 'package:flutter/material.dart';

class RatingStar extends StatelessWidget {
  final int rating;

  const RatingStar({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    String star = ''; // Initialize an empty string to hold the stars
    for (int i = 0; i < rating; i++) {
      star += '\u2605'; // Unicode for filled star
    }

    // Returning a Text widget that displays the stars
    return Text(
      star,
      style: TextStyle(
        fontSize: 24, // Customize the star size as needed
        color: Colors.amber, // You can change the color of the stars
      ),
    );
  }
}
