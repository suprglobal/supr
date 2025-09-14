import 'package:flutter/material.dart';

class ItemGridTileLargeImage extends StatelessWidget {
  final String imagePath;
  final String title;
  final double height;
  final double width;
  final VoidCallback? onTap;

  const ItemGridTileLargeImage({
    super.key,
    required this.imagePath,
    required this.title,
    this.height = 120,
    this.width = 120,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    List<String> titleWords = title.split(" ");

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color:  Color(0xFFEEEEEE),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: height * 0.65,
              width: width * 0.8,
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(imagePath, fit: BoxFit.cover),
            ),
            const SizedBox(height: 8),
            Text(
              titleWords.length > 1
                  ? "${titleWords[0]}\n${titleWords[1]}"
                  : title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xff000000),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
