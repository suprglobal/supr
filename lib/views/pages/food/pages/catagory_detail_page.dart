import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:superapp/constants/app_colors.dart';
import 'package:superapp/constants/constants.dart';
import 'package:superapp/constants/global_variables.dart';
import 'package:superapp/views/pages/food/controller/food_controller.dart';
import 'package:superapp/views/pages/food/delegates/category_page_delegate.dart';
import 'package:superapp/views/pages/food/model/food_model.dart';
import 'package:superapp/views/pages/food/pages/restaurant_detail_page.dart';
import 'package:superapp/views/pages/food/pages/sub_catagory_food.dart';
import 'package:superapp/views/pages/food/widgets/lists.dart';

import '../widgets/catagory_tab_buttons.dart' show CatagoryTabButtons;

class CatagoryDetailPage extends StatefulWidget {
  const CatagoryDetailPage({super.key});

  @override
  State<CatagoryDetailPage> createState() => _CatagoryDetailPageState();
}

class _CatagoryDetailPageState extends State<CatagoryDetailPage> {
  int selectedIndex = 0;
  final List<String> allFilters = [
    'GOT YOU',
    '4.5 + Rated',
    '30 mins',
    'Newly Added',
    'Group Order',
    'Top Choice',
    'Supr+ Exclusive',
    '30% Off',
  ];

  final List<FoodCategory> foodCategories = [
    FoodCategory(
      'Classic',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ0FoJ9skQZByTHEk3Qz8PF88o4Vjp1WrRMaw&s',
    ),
    FoodCategory(
      'Smashed',
      'https://static.vecteezy.com/system/resources/thumbnails/027/145/344/small_2x/delicious-bbq-bacon-burger-isolated-on-transparent-background-png.png',
    ),
    FoodCategory(
      'Chicken Sando',
      'https://static.vecteezy.com/system/resources/thumbnails/041/445/512/small_2x/ai-generated-delicious-chicken-sandwich-on-transparent-background-png.png',
    ),
    FoodCategory(
      'Sliders',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRHzCC8dtX-YdqhUGPOkv6wet2JnokJtkGAUw&s',
    ),
    FoodCategory(
      'Classic',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ0FoJ9skQZByTHEk3Qz8PF88o4Vjp1WrRMaw&s',
    ),
    FoodCategory(
      'Smashed',
      'https://static.vecteezy.com/system/resources/thumbnails/027/145/344/small_2x/delicious-bbq-bacon-burger-isolated-on-transparent-background-png.png',
    ),
    FoodCategory(
      'Chicken Sando',
      'https://static.vecteezy.com/system/resources/thumbnails/041/445/512/small_2x/ai-generated-delicious-chicken-sandwich-on-transparent-background-png.png',
    ),
    FoodCategory(
      'Sliders',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRHzCC8dtX-YdqhUGPOkv6wet2JnokJtkGAUw&s',
    ),
  ];
  final _showTitle = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final foodProvider = Provider.of<FoodController>(context);
    final foodList = foodProvider.foods;
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification scrollInfo) {
        if (scrollInfo.metrics.pixels > 160 && !_showTitle.value) {
          _showTitle.value = true;

        } else if (scrollInfo.metrics.pixels <= 160 && _showTitle.value) {
          _showTitle.value = false;
        }
        return false;
      },
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
                pinned: true,
                expandedHeight: 220,
                backgroundColor: Colors.white,
                elevation: 0,
                scrolledUnderElevation: 0,
                automaticallyImplyLeading: false,
                titleSpacing: 0,
                title:  Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5.0,
                          horizontal: Dimensions.homePagePadding),
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 35,
                          width: 35,
                          decoration: BoxDecoration(
                              color: colorScheme(context).surface,
                              border: Border.all(color: AppColors.appGrey),
                              borderRadius: BorderRadius.circular(7)),
                          child: const Icon(
                            Icons.arrow_back,
                            color: AppColors.darkGrey,
                            size: 18,
                          ),
                        ),
                      ),
                    ),
                      ValueListenableBuilder(
                        valueListenable: _showTitle,
                        builder: (context, value, child) {
                          return value ? const Expanded(
                            child: Text(
                              "Burger",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ) : const SizedBox.shrink();
                        }
                      ),
                  ],
                ),
                flexibleSpace:  FlexibleSpaceBar(
                  background: Container(
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                              'https://www.foodandwine.com/thmb/DI29Houjc_ccAtFKly0BbVsusHc=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/crispy-comte-cheesburgers-FT-RECIPE0921-6166c6552b7148e8a8561f7765ddf20b.jpg',
                            ),
                            fit: BoxFit.fill)),
                  ),
                )),
            SliverPersistentHeader(
              pinned: true, // stays visible
              delegate: CategoryPageDelegate(
                minHeight: 58,
                maxHeight: 58,
                child: Container(
                  height: 32,
                  color: Theme.of(context).cardColor,
                  child: ListView.separated(
                    separatorBuilder: (context, index) => SizedBox(width: 8),
                    itemCount: allFilters.length,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.homePagePadding, vertical: 13),
                    itemBuilder: (context, index) => CatagoryTabButtons(
                      label: allFilters[index],
                      isSelected: selectedIndex == index,
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                    ),
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              sliver: SliverList(
                  delegate: SliverChildListDelegate([
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.homePagePadding),
                  child: Text(
                    "Popular  Brands",
                    style: textTheme(context)
                        .titleLarge
                        ?.copyWith(fontWeight: FontWeight.w600, fontSize: 20),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height:75,
                  child: ListView.separated(
                    separatorBuilder: (context, index) => SizedBox(width: 10),
                    scrollDirection: Axis.horizontal,
                    itemCount: popularBrands.length,
                    padding: const EdgeInsets.symmetric(
                        horizontal: Dimensions.homePagePadding),
                    itemBuilder: (context, index) {
                      final restaurent = popularBrands[index];
                      return InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => RestaurantDetailPage(id: "")));
                        },
                        child: Container(
                          height:75,
                          width: size.width * 0.23,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            image: DecorationImage(
                              fit: BoxFit.cover,

                              image: NetworkImage(restaurent.image),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.homePagePadding),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 5,
                        children: [
                          Text(
                            'Top burgers 🍔',
                            style: textTheme(context).titleLarge?.copyWith(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                height: 1.0),
                          ),
                          Text(
                            'Meet your next burger obsession',
                            style: textTheme(context).labelLarge?.copyWith(
                                height: 1.0,
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: AppColors.darkGrey),
                          ),
                        ],
                      ),
                      Icon(
                        Icons.arrow_forward_outlined,
                        size: 20,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 217,
                  width: size.width,
                  child: ListView.separated(
                      separatorBuilder: (context, index) => SizedBox(width: 10),
                      padding: EdgeInsets.symmetric(
                          horizontal: Dimensions.homePagePadding, vertical: 10),
                      scrollDirection: Axis.horizontal,
                      itemCount: burgerList.length,
                      itemBuilder: (context, index) {
                        final food = burgerList[index];
                        return GestureDetector(
                            onTap: () {},
                            child: Container(
                              width: size.width * 0.42,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).cardColor,
                                  boxShadow: [AppConstants.boxShadow],
                                  borderRadius: BorderRadius.circular(8)),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(8),
                                          topRight: Radius.circular(8)),
                                      child: Image.network(
                                        food['image'],
                                        height: 100,
                                        width: size.width,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            food['title'],
                                            style: textTheme(context)
                                                .bodyMedium
                                                ?.copyWith(
                                                    fontWeight: FontWeight.w600,
                                                    color: colorScheme(context)
                                                        .onSurface),
                                          ),
                                          const SizedBox(height: 2),
                                          Row(
                                            children: [
                                              Icon(Icons.star,
                                                  size: 13,
                                                  color: colorScheme(context)
                                                      .primary),
                                              const SizedBox(width: 4),
                                              Text(
                                                food['rating'].toString(),
                                                style: textTheme(context)
                                                    .labelLarge
                                                    ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color:
                                                            colorScheme(context)
                                                                .primary),
                                              ),
                                              const SizedBox(width: 6),
                                              Icon(
                                                Icons.brightness_1_rounded,
                                                size: 4,
                                              ),
                                              const SizedBox(width: 4),
                                              Text(
                                                food['arriveTime'],
                                                style: textTheme(context)
                                                    .bodySmall
                                                    ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color:
                                                            colorScheme(context)
                                                                .onSurface),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 2),
                                          Row(
                                            children: [
                                              Flexible(
                                                child: Text(food['foodItems'],
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: textTheme(context)
                                                        .labelLarge
                                                        ?.copyWith(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: AppColors
                                                                .darkGrey)),
                                              ),
                                              const SizedBox(width: 8),
                                              Icon(
                                                Icons.brightness_1_rounded,
                                                size: 4,
                                              ),
                                              const SizedBox(width: 4),
                                              Text(food['distance'],
                                                  style: textTheme(context)
                                                      .labelLarge
                                                      ?.copyWith(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: AppColors
                                                              .darkGrey)),
                                            ],
                                          ),
                                          const SizedBox(height: 13),
                                          Row(
                                            children: [
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8,
                                                        vertical: 5),
                                                decoration: BoxDecoration(
                                                  color: Colors.pink,
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                ),
                                                child: Text(
                                                    '50 % off just for items',
                                                    style: textTheme(context)
                                                        .labelMedium
                                                        ?.copyWith(
                                                            height: 1.0,
                                                            color: colorScheme(
                                                                    context)
                                                                .surface,
                                                            fontWeight:
                                                                FontWeight.bold)),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ]),
                            ));
                      }),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.homePagePadding),
                  child: Text(
                    "What's on your mind?",
                    style: textTheme(context)
                        .titleLarge
                        ?.copyWith(fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  height: 100,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 10),
                    itemCount: foodCategories.length,
                    shrinkWrap: true,
                    padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.homePagePadding),
                    itemBuilder: (context, index) => FoodCategoryWidget(
                        label: foodCategories[index].name,
                        imageUrl: foodCategories[index].imageUrl),
                  ),
                ),
                SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.homePagePadding),
                  child: Text(
                    '214 Burger Restaurants',
                    style: textTheme(context)
                        .titleLarge
                        ?.copyWith(fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.homePagePadding, vertical: 10),
                  separatorBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: Divider(
                      color: Theme.of(context).hintColor.withValues(alpha: 0.05),
                      height: 0.1,
                      thickness: 0.8,
                    ),
                  ),
                  shrinkWrap: true,
                  itemCount: nearby.length,
                  itemBuilder: (context, index) {
                    final burger = nearby[index];
                    return InkWell(
                      onTap: () {
                        foodProvider.selectFood(burger);
                        Navigator.push(context, MaterialPageRoute(builder: (context) => RestaurantDetailPage(id: "")));
                      },
                      child: Container(
                        height: 125,
                        width: size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          spacing: 10,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                burger.image,
                                height: 125,
                                width: size.width * 0.28,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          burger.title,
                                          style: textTheme(context)
                                              .bodyMedium
                                              ?.copyWith(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 17,
                                                  color: colorScheme(context)
                                                      .onSurface),
                                        ),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        Row(
                                          children: [
                                            Icon(Icons.star,
                                                color:
                                                    colorScheme(context).primary,
                                                size: 18),
                                            const SizedBox(width: 4),
                                            Text(
                                              burger.rating,
                                              style: textTheme(context)
                                                  .labelLarge
                                                  ?.copyWith(
                                                      fontWeight: FontWeight.w600,
                                                      fontSize: 15,
                                                      color: colorScheme(context)
                                                          .primary),
                                            ),
                                            const SizedBox(width: 4),
                                            Text("(999+)",
                                                style: textTheme(context)
                                                    .labelLarge
                                                    ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 15)),
                                            const SizedBox(width: 8),
                                            Icon(
                                              Icons.brightness_1_rounded,
                                              color:
                                                  colorScheme(context).onSurface,
                                              size: 5,
                                            ),
                                            const SizedBox(width: 8),
                                            Text(
                                              burger.time,
                                              style: textTheme(context)
                                                  .bodySmall
                                                  ?.copyWith(
                                                      fontSize: 15,
                                                      fontWeight: FontWeight.w600,
                                                      color: colorScheme(context)
                                                          .primary),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        Row(
                                          children: [
                                            Flexible(
                                              child: Text("American,Fast food",
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: textTheme(context)
                                                      .labelLarge
                                                      ?.copyWith(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color:
                                                              AppColors.darkGrey,
                                                          fontSize: 12)),
                                            ),
                                            const SizedBox(width: 6),
                                            Icon(
                                              Icons.brightness_1_rounded,
                                              color:
                                                  colorScheme(context).onSurface,
                                              size: 4,
                                            ),
                                            const SizedBox(width: 6),
                                            Text(
                                              "\$\$\$",
                                              style: textTheme(context)
                                                  .bodySmall
                                                  ?.copyWith(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        Row(
                                          children: [
                                            Text(burger.location,
                                                style: textTheme(context)
                                                    .labelLarge
                                                    ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 12,
                                                        color:
                                                            AppColors.darkGrey)),
                                            const SizedBox(width: 6),
                                            Icon(Icons.brightness_1_rounded,
                                                color: Colors.black54, size: 4),
                                            const SizedBox(width: 6),
                                            Text(burger.distance,
                                                style: textTheme(context)
                                                    .labelLarge
                                                    ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 12,
                                                        color:
                                                            AppColors.darkGrey)),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 5),
                                          decoration: BoxDecoration(
                                            color: Colors.pink,
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                          child: Text('50 % off just for items',
                                              style: textTheme(context)
                                                  .labelMedium
                                                  ?.copyWith(
                                                      color: colorScheme(context)
                                                          .surface,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ])),
            )
          ],
        ),
      ),
    );
  }
}

class FoodCategory {
  final String name;
  final String imageUrl;

  FoodCategory(this.name, this.imageUrl);
}

class FoodCategoryWidget extends StatelessWidget {
  final String label;
  final String imageUrl;

  const FoodCategoryWidget(
      {super.key, required this.label, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SubCatagoryFoodPage(),
          ),
        );
      },
      child: SizedBox(
        width: 70,
        child: Column(
          children: [
            Image.network(imageUrl, height: 50),
            SizedBox(height: 6),
            Text(label,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
