import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:superapp/constants/app_images.dart';
import 'package:superapp/extensions/string.dart';
import 'package:velocity_x/velocity_x.dart';

class CustomImage extends StatefulWidget {
  CustomImage({
    required this.imageUrl,
    this.height = Vx.dp40,
    this.width,
    this.boxFit,
    this.canZoom = false,
    this.hideDefaultImg = false,
    Key? key,
  }) : super(key: key);

  final String? imageUrl;
  final double? height;
  final double? width;
  final BoxFit? boxFit;
  final bool canZoom;
  final bool hideDefaultImg;

  @override
  State<CustomImage> createState() => _CustomImageState();
}

class _CustomImageState extends State<CustomImage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (this.widget.imageUrl == null ||
        (this.widget.hideDefaultImg &&
            !this.widget.imageUrl.isNotDefaultImage)) {
      return 0.widthBox;
    }

    //if default image
    if (!this.widget.imageUrl.isNotDefaultImage) {
      return Image.asset(
        AppImages.appLogo,
        fit: BoxFit.cover,
        height: this.widget.height,
        width: this.widget.width,
      );
    }


    return _imageView;
  }

  Widget get _imageView {
    return CachedNetworkImage(
      imageUrl: this.widget.imageUrl!,
      errorWidget:
          (context, imageUrl, _) => Image.asset(
            imageUrl.isNotDefaultImage ? AppImages.noImage : AppImages.appLogo,
            fit: this.widget.boxFit ?? BoxFit.cover,
          ),
      fit: this.widget.boxFit ?? BoxFit.cover,
      progressIndicatorBuilder: (context, imageURL, progress) {
        // return BusyIndicator().centered();
        return Image.asset(
          AppImages.placeholder,
          fit: BoxFit.cover,
          height: this.widget.height,
          width: this.widget.width,
        ).shimmer(
          primaryColor:
              context.isDarkMode ? Colors.grey.shade400 : Colors.grey.shade200,
          secondaryColor:
              context.isDarkMode ? Colors.grey.shade600 : Colors.grey.shade50,
        );
      },
      height: this.widget.height,
      width: this.widget.width,
    );
  }

  @override
  bool get wantKeepAlive => true;
}
