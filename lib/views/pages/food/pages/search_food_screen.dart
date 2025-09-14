import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:superapp/constants/app_colors.dart';
import 'package:superapp/constants/app_images.dart';
import 'package:superapp/constants/constants.dart';
import 'package:superapp/constants/global_variables.dart';
import 'package:superapp/shared/widgets/custom_textformfield.dart';
import 'package:superapp/views/pages/food/controller/search_food_controller.dart';
import 'package:superapp/views/pages/food/pages/restaurant_detail_page.dart';
import 'package:superapp/widgets/custom_network_image.dart';

class SearchFoodScreen extends StatefulWidget {
  const SearchFoodScreen({super.key});

  @override
  State<SearchFoodScreen> createState() => _SearchFoodScreenState();
}

class _SearchFoodScreenState extends State<SearchFoodScreen> {
  final searchController = Get.put(SearchFoodController());
  final searchC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            /// 🔹 Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.homePagePadding,
                vertical: 13,
              ),
              child: Row(
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      height: 38,
                      width: 38,
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.appGrey),
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: const Icon(
                        Icons.arrow_back,
                        color: AppColors.darkGrey,
                        size: 20,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: SizedBox(
                      height: 38,
                      child: CustomTextFormField(
                        hint: 'Search for restaurants, dishes & cuisines',
                        horizontalPadding: 10,
                        controller: searchC,
                        hintSize: 15,
                        filled: true,
                        fillColor: Colors.transparent,
                        hintColor: AppColors.darkGrey,
                        fontWeight: FontWeight.w500,
                        borderRadius: 8,
                        onFieldSubmitted: (p0) =>
                            searchController.searchRestaurantDishes(p0),
                        suffixIcon: InkWell(
                          onTap: () => searchController
                              .searchRestaurantDishes(searchC.text.trim()),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: SvgPicture.asset(
                              AppIcon.searchIcon,
                              height: 10,
                              width: 10,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurface
                                  .withOpacity(0.6),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            /// 🔹 Results
            Expanded(
              child: Obx(() {
                if (searchController.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                } else if (searchController.searchFoodModel.value == null && searchC.text.isNotEmpty) {
                  return const Center(child: Text("No Restaurant/Dishes Found"));
                }else if(searchC.text.isEmpty){
                  return SizedBox.shrink();
                }
                final searchFoodModel =
                    searchController.searchFoodModel.value?.data;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: Dimensions.homePagePadding,
                        vertical: 10,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () =>
                              searchController.isRestaurantSelected.value =
                              true,
                              child: Column(
                                children: [
                                  SvgPicture.asset(AppIcon.shop,
                                      height: 24,
                                      width: 24,
                                      colorFilter: const ColorFilter.mode(
                                          Colors.black54, BlendMode.srcIn)),
                                  const Text(
                                    "Restaurants",
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () =>
                              searchController.isRestaurantSelected.value =
                              false,
                              child: Column(
                                children: [
                                  SvgPicture.asset(AppIcon.dishes,
                                      height: 24,
                                      width: 24,
                                      colorFilter: const ColorFilter.mode(
                                          Colors.black54, BlendMode.srcIn)),
                                  const Text(
                                    "Dishes",
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Obx(() {
                      final isSelected =
                          searchController.isRestaurantSelected.value;
                      return Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 3,
                              color: isSelected
                                  ? Theme.of(context).primaryColor
                                  : Colors.grey.withOpacity(0.2),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: 3,
                              color: !isSelected
                                  ? Theme.of(context).primaryColor
                                  : Colors.grey.withOpacity(0.2),
                            ),
                          ),
                        ],
                      );
                    }),

                    Expanded(
                      child: Obx(() {
                        final isRestaurant =
                            searchController.isRestaurantSelected.value;

                        final restaurants = searchFoodModel?.restaurants ?? [] ;

                        final dishes = searchFoodModel?.dishes ?? [];

                        return isRestaurant ?ListView.separated(
                          itemCount: restaurants.length,
                          padding: EdgeInsets.symmetric(vertical: 15),
                          separatorBuilder: (context, index) =>
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 6.0),
                                child: Divider(color: Colors.grey.shade100),
                              ),

                          itemBuilder: (context, index) {
                            final restaurant = restaurants[index];
                            return InkWell(
                              onTap: () {
                                if(restaurant.id == null) return;
                                Navigator.push(context, MaterialPageRoute(builder: (context) => RestaurantDetailPage(id: (restaurant.id ?? "").toString())));

                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: CustomNetworkImage(
                                        imageUrl: restaurant.bannerUrl ?? "",
                                        height: 70,
                                        width: 70,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            restaurant.name ?? "",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: textTheme(context)
                                                .bodyLarge
                                                ?.copyWith(
                                                fontSize: 14,
                                                height: 1,
                                                fontWeight: FontWeight.w600,
                                                color: colorScheme(context)
                                                    .onSurface),
                                          ),
                                          const SizedBox(height: 5),
                                          Row(
                                            children: [
                                              Icon(Icons.star,
                                                  color: colorScheme(context)
                                                      .primary,size: 15),
                                              Text(
                                                restaurant.rating ?? "",
                                                style: textTheme(context)
                                                    .bodySmall
                                                    ?.copyWith(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w600,
                                                    color: colorScheme(context)
                                                        .primary),
                                              ),
                                              const SizedBox(width: 4),
                                              Text(
                                                '(${restaurant.totalReviews ?? 0}+)',
                                                style: textTheme(context)
                                                    .bodySmall
                                                    ?.copyWith(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w500,
                                                    color: colorScheme(context)
                                                        .primary),
                                              ),
                                              const SizedBox(width: 4),
                                              Icon(Icons.brightness_1_rounded, size: 4,color: Colors.grey.shade400),
                                              const SizedBox(width: 4),

                                              Text(
                                                restaurant.deliveryTimeRange ?? "",
                                                style: textTheme(context)
                                                    .bodySmall
                                                    ?.copyWith(
                                                    fontWeight: FontWeight.w600,
                                                    color: colorScheme(context)
                                                        .onSurface),
                                              ),
                                            ],
                                          ),
                                          // if (restaurant['offer']!.isNotEmpty) ...[
                                            const SizedBox(height: 5),
                                            Container(
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: 8, vertical: 4),
                                              decoration: BoxDecoration(
                                                color: Colors.pink,
                                                borderRadius:
                                                BorderRadius.circular(4),
                                              ),
                                              child: Text(
                                                "30% off on select items",
                                                style: textTheme(context)
                                                    .bodySmall
                                                    ?.copyWith(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w600,
                                                    color: colorScheme(context)
                                                        .surface),
                                              ),
                                            ),
                                          // ]
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ) :
                        ListView.separated(
                          itemCount: dishes.length,
                          padding: EdgeInsets.symmetric(vertical: 15),
                          separatorBuilder: (context, index) =>
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 6.0),
                                child: Divider(color: Colors.grey.shade100),
                              ),

                          itemBuilder: (context, index) {
                            final dish = dishes[index];
                            return InkWell(
                              onTap: () {
                                if(dish.restaurantId == null) return;
                                Navigator.push(context, MaterialPageRoute(builder: (context) => RestaurantDetailPage(id: (dish.restaurantId ?? "").toString())));
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: CustomNetworkImage(
                                        imageUrl: dish.imageUrl ?? "",
                                        height: 70,
                                        width: 70,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            dish.name ?? "",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: textTheme(context)
                                                .bodyLarge
                                                ?.copyWith(
                                                fontSize: 14,
                                                height: 1,
                                                fontWeight: FontWeight.w600,
                                                color: colorScheme(context)
                                                    .onSurface),
                                          ),
                                          const SizedBox(height: 8),
                                          Row(
                                            spacing: 5,
                                            children: [
                                              Text(
                                               "₹"+ (dish.finalPrice ?? ""),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: textTheme(context)
                                                    .bodyLarge
                                                    ?.copyWith(
                                                    fontSize: 14,
                                                    height: 1,
                                                    fontWeight: FontWeight.w600,
                                                    color: colorScheme(context)
                                                        .onSurface),
                                              ),
                                              Text(
                                                "₹"+ (dish.originalPrice ?? ""),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: textTheme(context)
                                                    .bodyLarge
                                                    ?.copyWith(
                                                    fontSize: 14,
                                                    decoration: TextDecoration.lineThrough,
                                                    height: 1,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black54
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 5),
                                          Row(
                                            children: [
                                              Icon(Icons.star,
                                                  color: colorScheme(context)
                                                      .primary,size: 15),
                                              Text(
                                                dish.rating ?? "",
                                                style: textTheme(context)
                                                    .bodySmall
                                                    ?.copyWith(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w600,
                                                    color: colorScheme(context)
                                                        .primary),
                                              ),
                                              const SizedBox(width: 4),
                                              Text(
                                                '(${dish.totalReviews ?? 0}+)',
                                                style: textTheme(context)
                                                    .bodySmall
                                                    ?.copyWith(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w500,
                                                    color: colorScheme(context)
                                                        .primary),
                                              ),

                                            ],
                                          ),
                                            const SizedBox(height: 5),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      }),
                    ),
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

