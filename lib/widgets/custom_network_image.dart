import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:superapp/common/custom_shimmer.dart';

class CustomNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final String defaultImage;

  const CustomNetworkImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.defaultImage = "assets/image/promotion.png",
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      fit: fit,
      placeholder: (context, url) =>
       CustomShimmer(child: Container(
         width: width,
         height: height,
         decoration: BoxDecoration(
          color: Colors.grey.withValues(alpha: 0.5),
        ),
      )),
      errorWidget: (context, url, error) => Image.asset(
        defaultImage,
        width: width,
        height: height,
        fit: fit,
      ),
    );
  }
}
