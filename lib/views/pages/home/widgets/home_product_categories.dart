import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:superapp/constants/app_colors.dart';
 import 'package:superapp/constants/global_variables.dart';

class HomeProductCategories extends StatelessWidget {
  HomeProductCategories({super.key});

  final List<Map<String, String>> sliderItems = [
    {
      'image':
          'https://tapcom-live.ams3.cdn.digitaloceanspaces.com/media/cache/f0/a0/f0a0e2c7269e2c92eb270c41b967da47.jpg',
      'title': 'Shop Healthy Food',
    },
    {
      'image':
          'https://www.macopkg.com/wp-content/uploads/2023/02/supermarket-aisle-1536x1152.jpg',
      'title': 'shop Groceries',
    },
    {
      'image':
          'https://i.pinimg.com/736x/69/e1/d8/69e1d85f37191bcfd655c9892dcf11f4.jpg',
      'title': 'shop Electronics',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'Popular Categories',
            style: textTheme(
              context,
            ).headlineSmall?.copyWith(
                fontWeight: FontWeight.bold, color: const Color(0xff0A0C0B)),
          ),
        ),
        SizedBox(
          height: 200,
          child: CarouselSlider(
            items: sliderItems.map((item) {
              return Container(
                width: 400,
                margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: NetworkImage(item['image']!),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned.fill(
                      bottom: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              colorScheme(context).secondary.withAlpha(
                                    1,
                                  ), // Fading color (black)
                              Colors.transparent, // Transparent at the top
                            ],
                          ),
                        ),
                      ),
                    ),

                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            stops: const [
                              0.0,
                              0.3,
                              0.6,
                              1.0
                            ], // Adjusted stops for smoother transition
                            colors: [
                              Colors.transparent,
                              Colors.transparent,
                              AppColors.accentColor.withOpacity(
                                  0.2), // Lower opacity for smoother fade
                              AppColors.bluish.withOpacity(
                                  0.8), // Lower opacity for smoother fade
                            ],
                          ),
                        ),
                      ),
                    ),
                    /// Centered Text on top of the image
                    Positioned(
                      bottom: 20,
                      left: 20,
                      child: Text(
                        item['title']!,
                        style: textTheme(context).titleLarge?.copyWith(
                            color: colorScheme(context).surface,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
            options: CarouselOptions(
              height: 200,
              aspectRatio: 14 / 9,
              viewportFraction: 0.9,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 2),
              autoPlayAnimationDuration: const Duration(milliseconds: 600),
              autoPlayCurve: Curves.linear,
              enlargeCenterPage: true,
              enlargeFactor: 0.3,
              onPageChanged: (index, reason) {
                print(index);
              },
              scrollDirection: Axis.horizontal,
            ),
          ),
        ),
      ],
    );
  }
}
