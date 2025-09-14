import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:superapp/constants/global_variables.dart';

class ItemGridTile extends StatelessWidget {
  final String imagePath;
  final String title;
  final double tileWidth;
  final double imageScaleFactor;
  final VoidCallback? onTap;

  const ItemGridTile({
    super.key,
    required this.imagePath,
    required this.title,
    required this.tileWidth,
    this.imageScaleFactor = 1.0,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // final double maxImageSize = tileWidth * 0.6;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color:  Color(0xFFEEEEEE),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 5,
          children: [
            Image.asset(
              imagePath,
              fit: BoxFit.fill,
              height: 40,
              width: 40,
            ),
            // SvgPicture.asset(imagePath,
            //   fit: BoxFit.cover,
            //   height: 50,
            //   width: 65,
            // ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: textTheme(context).bodySmall?.copyWith(
                    fontSize: 12,
                    height: 1.1,
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
