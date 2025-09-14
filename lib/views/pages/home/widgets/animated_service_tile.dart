import 'package:flutter/material.dart';
import 'package:superapp/constants/global_variables.dart';
import 'package:superapp/views/pages/home/provider/image_carousel_provider.dart';
import 'package:provider/provider.dart';

class AnimatedGridTile extends StatelessWidget {
  final List<String> imageList;
  final String title;
  final double tileWidth;
  final VoidCallback onTap;

  const AnimatedGridTile({
    super.key,
    required this.imageList,
    required this.title,
    required this.tileWidth,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ImageCarouselProvider(imageList.length),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color:  Color(0xFFEEEEEE),
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 5,
            children: [
              SizedBox(
                height: 40,
                width: 40,
                child: Consumer<ImageCarouselProvider>(
                  builder: (context, provider, _) {
                    return PageView.builder(
                      controller: provider.controller,
                      itemCount: imageList.length,
                      itemBuilder: (context, index) {
                        return Image.asset(
                          height: 40,
                          width: 40,
                          imageList[index],
                          fit: BoxFit.cover,
                        );
                      },
                    );
                  },
                ),
              ),
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
      ),
    );
  }
}
