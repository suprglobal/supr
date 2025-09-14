import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:superapp/constants/app_colors.dart';
import 'package:superapp/constants/constants.dart';
import 'package:superapp/constants/global_variables.dart';
import 'package:superapp/views/pages/food/controller/filter_food_controller.dart';
import 'package:superapp/views/pages/food/pages/restaurant_detail_page.dart';
import 'package:superapp/views/pages/food/widgets/filter_bottom_sheet.dart';
import 'package:superapp/views/pages/home/widgets/top_sheet.dart';
import 'package:superapp/widgets/custom_network_image.dart';

class OffersTabsPage extends StatefulWidget {
  const OffersTabsPage({super.key});

  @override
  State<OffersTabsPage> createState() => _OffersTabsPageState();
}

class _OffersTabsPageState extends State<OffersTabsPage> {
  final filterController = Get.put(FilterFoodController());

  void _openFilterSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) =>  SortBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        leading: Padding(
          padding: const EdgeInsets.only(
            top: 8,
            bottom: 8,
            left: Dimensions.homePagePadding,
          ),
          child: InkWell(
            onTap: () => Navigator.pop(context),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.appGrey),
                borderRadius: BorderRadius.circular(7),
              ),
              child: const Icon(Icons.arrow_back,
                  size: 20, color: AppColors.darkGrey),
            ),
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              top: 8,
              bottom: 8,
              right: Dimensions.homePagePadding,
            ),
            child: InkWell(
              onTap: () {
                showGeneralDialog(
                  context: context,
                  barrierDismissible: true,
                  barrierLabel: 'TopSheet',
                  transitionDuration: const Duration(milliseconds: 300),
                  pageBuilder: (_, __, ___) => const SizedBox.shrink(),
                  transitionBuilder: (_, animation, __, ___) {
                    return SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0, -1),
                        end: Offset.zero,
                      ).animate(animation),
                      child: const Align(
                        alignment: Alignment.topCenter,
                        child: TopSheetWidget(),
                      ),
                    );
                  },
                );
              },
              child: Container(
                height: 50,
                width: 40,
                decoration: BoxDecoration(
                  color: colorScheme(context).primary,
                  border: Border.all(color: AppColors.appGrey),
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Icon(Icons.menu,
                    color: colorScheme(context).secondary, size: 17),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              "Restaurants",
              style: textTheme(context).headlineMedium?.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 28,
              ),
            ),
          ),
          const SizedBox(height: 10),

          Row(
            children: [
              InkWell(
                onTap: () => _openFilterSheet(context),
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, right: 6),
                  child: Container(
                    height: 35,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 7.5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color:
                        colorScheme(context).onSurface.withOpacity(0.3),
                      ),
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: const Icon(Icons.filter_alt_outlined, size: 16),
                  ),
                ),
              ),
              Expanded  (
                child: Obx(
                      () {

                        final selectedFilters = filterController.selectedFilters.value;
                        return SizedBox(
                    height: 35,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (_, __) => const SizedBox(width: 6),
                      itemCount: filterController.filters.length,
                      itemBuilder: (context, index) {
                        final filter = filterController.filters[index];
                        final isSelected = selectedFilters
                            .contains(filter);

                        return InkWell(
                          onTap: () => filterController.toggleFilter(filter),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              color: isSelected
                                  ? colorScheme(context).primary
                                  : Colors.white,
                              border: Border.all(
                                color: isSelected
                                    ? colorScheme(context).primary
                                    : Colors.grey.shade400,
                              ),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              filter,
                              style:
                              textTheme(context).titleSmall?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: isSelected
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                      },
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          Expanded(
            child: Obx(() {
              if (filterController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (filterController.restaurants.isEmpty) {
                return const Center(child: Text("No restaurants found"));
              }

              return ListView.separated(
                itemCount: filterController.restaurants.length,
                separatorBuilder: (_, __) =>
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Divider(color: Colors.grey.shade100),
                    ),
                padding: EdgeInsets.symmetric(vertical: 10),
                itemBuilder: (context, index) {
                  final restaurant = filterController.restaurants[index];
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
                                    color: colorScheme(context).onSurface,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  children: [
                                    Icon(Icons.star,
                                        color: colorScheme(context).primary,
                                        size: 15),
                                    Text(
                                      ' ${restaurant.rating ?? ""} ',
                                      style: textTheme(context)
                                          .bodySmall
                                          ?.copyWith(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        color: colorScheme(context).primary,
                                      ),
                                    ),
                                    Text(
                                      '(${restaurant.totalReviews ?? ""}+)',
                                      style: textTheme(context)
                                          .bodySmall
                                          ?.copyWith(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                        color: colorScheme(context).primary,
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    Icon(Icons.brightness_1_rounded,
                                        size: 4,
                                        color: Colors.grey.shade400),
                                    const SizedBox(width: 4),
                                    Text(
                                      restaurant.deliveryTimeRange ?? "",
                                      style: textTheme(context)
                                          .bodySmall
                                          ?.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: colorScheme(context).onSurface,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.pink,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    "50% OFF",
                                    style: textTheme(context)
                                        .bodySmall
                                        ?.copyWith(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color:
                                      colorScheme(context).surface,
                                    ),
                                  ),
                                ),
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
      ),
    );
  }
}
