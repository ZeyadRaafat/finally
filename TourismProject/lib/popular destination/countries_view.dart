import 'package:flutter/material.dart';

class Countries extends StatelessWidget {
  final String imagePath;
  final String text;
  final bool isFavorite;
  final VoidCallback onFavoritePressed;

   const Countries({
    super.key,
    required this.imagePath,
    required this.text,
    required this.isFavorite,
    required this.onFavoritePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF8F1E7),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center, // Center the image vertically
        children: [
          SizedBox(
            width: 410,
            height: 200,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            text,
            textAlign: TextAlign.left,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'Madimi One',
            ),
          ),
        ],
      ),
    );
  }
}
