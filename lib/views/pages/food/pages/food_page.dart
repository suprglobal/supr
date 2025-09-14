import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:superapp/common/custom_shimmer.dart';
import 'package:superapp/constants/app_colors.dart';
import 'package:superapp/constants/app_images.dart';
import 'package:superapp/constants/constants.dart';
import 'package:superapp/constants/global_variables.dart';
import 'package:superapp/views/pages/food/controller/food_home_page_controller.dart';
import 'package:superapp/views/pages/food/pages/catagory_detail_page.dart';
import 'package:superapp/views/pages/food/pages/offers_tabs_page.dart';
import 'package:superapp/views/pages/food/pages/restaurant_detail_page.dart';
import 'package:superapp/views/pages/food/pages/search_food_screen.dart';
import 'package:superapp/views/pages/food/widgets/food_filter_widget.dart';
import 'package:superapp/views/pages/home/widgets/top_sheet.dart';
import 'package:superapp/widgets/custom_network_image.dart';


class FoodPage extends StatefulWidget {
  const FoodPage({super.key});

  @override
  State<FoodPage> createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  final FoodRestaurantController foodRestaurantController = Get.put(
    FoodRestaurantController(),
  );

  List<String> addressList = ["Villa 13", "Villa 14", "Villa 15"];
  String selectedAddress = "Villa 13";
  final List<String> allFilters = [
    'Offers',
    'Top Rated',
    'Free Delivery',
    '10% Off',
    '20% Off',
    '30% Off',
  ];
  final List<String> imageList = [
    AppImages.banner1Image,
    AppImages.banner2Image,
    AppImages.banner3Image,
    AppImages.banner4Image,
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

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
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              height: 30,
              width: 50,
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
        ),
        titleSpacing: 10,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Deliver to ",
              style: textTheme(
                context,
              ).bodyLarge?.copyWith(fontWeight: FontWeight.w500, fontSize: 16),
            ),
            const SizedBox(width: 3),
            DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: selectedAddress,
                items: addressList.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: textTheme(context).bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    selectedAddress = newValue!;
                  });
                },
                icon: const Icon(Icons.keyboard_arrow_down_outlined, size: 24),
                style: textTheme(context).bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              right: Dimensions.homePagePadding,
              top: 8,
              bottom: 8,
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
                child: const Icon(
                  Icons.menu,
                  color: Color.fromARGB(255, 20, 188, 96),
                  size: 15,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.homePagePadding,
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SearchFoodScreen(),
                      ),
                    );
                  },
                  child: Container(
                    height: 38,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: colorScheme(context).outline,
                        width: 1,
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),

                    child: Row(
                      spacing: 10,
                      children: [
                        Expanded(
                          child: Text(
                            "Search for restaurents , dishes & cusines",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: AppColors.darkGrey,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        SvgPicture.asset(
                          AppIcon.searchIcon,
                          height: 15,
                          width: 15,
                          color: colorScheme(
                            context,
                          ).onSurface.withOpacity(0.6),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 5),
              SizedBox(
                height: 53,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.homePagePadding,
                    vertical: 10,
                  ),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OffersTabsPage(),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 7,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: const Icon(
                            Icons.filter_alt_outlined,
                            size: 16,
                          ),
                        ),
                      );
                    }
                    return FoodFilterButton(label: allFilters[index - 1]);
                  },
                  separatorBuilder: (context, index) => SizedBox(width: 10),
                  itemCount: allFilters.length + 1,
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 10),
              children: [
                /// banner
                Obx(() {
                  if (foodRestaurantController.isBannerLoading.value) {
                    return CustomShimmer(
                      child: Container(
                        height: 180,
                        width: size.width,
                        decoration: BoxDecoration(
                          color: Colors.grey.withValues(alpha: 0.5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        margin: const EdgeInsets.symmetric(
                          horizontal: Dimensions.homePagePadding,
                        ),
                      ),
                    );
                  } else if (foodRestaurantController.offerRecords.isEmpty) {
                    return const Center(child: Text("No offer found"));
                  }
                  return SizedBox(
                    height: 180,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: foodRestaurantController.offerRecords.length,
                      padding: const EdgeInsets.symmetric(
                        horizontal: Dimensions.homePagePadding,
                      ),
                      separatorBuilder: (context, index) => SizedBox(width: 13),
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: CustomNetworkImage(
                              imageUrl:
                                  foodRestaurantController
                                      .offerRecords[index]
                                      .imageUrl ??
                                  "",
                              fit: BoxFit.cover,
                              width: size.width * 0.87,
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }),

                /// categories
                Obx(() {
                  if (foodRestaurantController.isCategory.value) {
                    return CustomShimmer(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: Dimensions.homePagePadding,
                              vertical: 15,
                            ),
                            child: Container(
                              height: 25,
                              width: 250,
                              decoration: BoxDecoration(
                                color: Colors.grey.withValues(alpha: 0.5),
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: (85 * 2) + 20,
                            child: GridView.builder(
                              scrollDirection: Axis.horizontal,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 2,
                                    crossAxisSpacing: 8,
                                    childAspectRatio: 1, // Square
                                  ),
                              itemCount: 20,
                              itemBuilder: (context, index) {
                                return Container(
                                  decoration: BoxDecoration(
                                    // color: Colors.blue,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                          color: Colors.grey.withValues(alpha: 0.5),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Container(
                                        height: 15,
                                        width: 50,
                                        decoration: BoxDecoration(
                                          color: Colors.grey.withValues(alpha: 0.5),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  if (foodRestaurantController.categoryRecord.isEmpty) {
                    return const Center(child: Text("No category found"));
                  }
                  final categoryRecord =
                      foodRestaurantController.categoryRecord;
                  log("category ==> ${categoryRecord.length}");
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: Dimensions.homePagePadding,
                          vertical: 15,
                        ),
                        child: Text(
                          "What are you craving today ",
                          style: textTheme(context).titleLarge?.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),

                      SizedBox(
                        height: (85 * 2) + 20,
                        // 2 rows * 30 height + spacing
                        child: GridView.builder(
                          scrollDirection: Axis.horizontal,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 2,
                                crossAxisSpacing: 8,
                                childAspectRatio: 1, // Square
                              ),
                          itemCount: categoryRecord.length,
                          itemBuilder: (context, index) {
                            final item = categoryRecord[index];

                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CatagoryDetailPage(),
                                  ),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  // color: Colors.blue,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    CustomNetworkImage(
                                      imageUrl: item.imageUrl ?? "",
                                      height: 50,
                                      width: 50,
                                      fit: BoxFit.contain,
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      textAlign: TextAlign.center,
                                      (item.name ?? "") +
                                          (item.id ?? "").toString(),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                }),

                const SizedBox(height: 20),

                Obx(() {
                  if (foodRestaurantController.isTrendingLoading.value) {
                    return CustomShimmer(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: Dimensions.homePagePadding,
                            ),
                            child: Column(
                              spacing: 8,
                              children: [
                                Container(
                                  height: 25,
                                  width: 250,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.withValues(alpha: 0.5),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                                Container(
                                  height: 20,
                                  width: 250,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.withValues(alpha: 0.5),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          SizedBox(
                            height: 240,
                            width: size.width,
                            child: ListView.separated(
                              padding: const EdgeInsets.symmetric(
                                horizontal: Dimensions.homePagePadding,
                                vertical: 10,
                              ),
                              scrollDirection: Axis.horizontal,
                              itemCount: 5,
                              separatorBuilder: (context, index) => SizedBox(width: 15),
                              itemBuilder: (context, index) {
                                return Container(
                                  width: size.width * 0.45,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.withValues(alpha: 0.5),

                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                );

                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  if (foodRestaurantController.trendingRestaurants.isEmpty) {
                    return const Center(child: Text("No restaurants found"));
                  }
                  final trendingRestaurant =
                      foodRestaurantController.trendingRestaurants;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: Dimensions.homePagePadding,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          spacing: 5,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Top Trending Restaurants",
                              style: textTheme(context).titleLarge?.copyWith(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                height: 1.0,
                              ),
                            ),
                            Text(
                              "Discover the hottest spots in town",
                              style: textTheme(context).labelLarge?.copyWith(
                                height: 1.0,
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: AppColors.darkGrey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      SizedBox(
                        height: 240,
                        width: size.width,
                        child: ListView.separated(
                          padding: const EdgeInsets.symmetric(
                            horizontal: Dimensions.homePagePadding,
                            vertical: 10,
                          ),
                          scrollDirection: Axis.horizontal,
                          itemCount: trendingRestaurant.length,
                          separatorBuilder: (context, index) => SizedBox(width: 15),
                          itemBuilder: (context, index) {
                            final food = trendingRestaurant[index];
                            return GestureDetector(
                              onTap: () {
                                if (food.id == null) return;
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RestaurantDetailPage(
                                      id: (food.id ?? "").toString(),
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                width: size.width * 0.45,
                                decoration: BoxDecoration(
                                  color: colorScheme(context).onPrimary,
                                  boxShadow: [AppConstants.boxShadow],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Stack(
                                      children: [
                                        ClipRRect(
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(5),
                                            topRight: Radius.circular(5),
                                          ),
                                          child: CustomNetworkImage(
                                            imageUrl: food.bannerUrl ?? "",
                                            height: 100,
                                            defaultImage:
                                                "assets/image/promotion.png",
                                            width: size.width,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Positioned(
                                          top: 60,
                                          left: 10,
                                          child: Text(
                                            "${index + 1}",
                                            style: textTheme(context).headlineLarge
                                                ?.copyWith(
                                                  fontWeight: FontWeight.bold,
                                                  color: colorScheme(
                                                    context,
                                                  ).onPrimary,
                                                ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        food.name ?? "",
                                        style: textTheme(context).bodyMedium
                                            ?.copyWith(
                                              fontWeight: FontWeight.w600,
                                              color: colorScheme(context).onSurface,
                                            ),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        const SizedBox(width: 8),
                                        Icon(
                                          Icons.star,
                                          size: 15,
                                          color: colorScheme(context).primary,
                                        ),
                                        Text(
                                          food.rating ?? "",
                                          style: textTheme(context).labelLarge
                                              ?.copyWith(
                                                fontWeight: FontWeight.w600,
                                                color: colorScheme(context).primary,
                                              ),
                                        ),
                                        Container(
                                          height: 5,
                                          width: 5,
                                          margin: const EdgeInsets.all(5),
                                          decoration: const BoxDecoration(
                                            color: Colors.black,
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                        Text(
                                          food.deliveryTimeRange ?? "",
                                          style: textTheme(context).bodySmall
                                              ?.copyWith(
                                                fontWeight: FontWeight.w600,
                                                color: colorScheme(
                                                  context,
                                                ).onSurface,
                                              ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        const SizedBox(width: 8),
                                        SizedBox(
                                          width: 70,
                                          child: Text(
                                            food.fullAddress ?? "",
                                            style: textTheme(context).labelLarge
                                                ?.copyWith(
                                                  overflow: TextOverflow.ellipsis,
                                                  fontWeight: FontWeight.w500,
                                                  color: AppColors.darkGrey,
                                                ),
                                          ),
                                        ),
                                        Container(
                                          height: 5,
                                          width: 5,
                                          margin: const EdgeInsets.all(5),
                                          decoration: const BoxDecoration(
                                            color: Colors.black,
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                        Text(
                                          food.deliveryFee ?? "",
                                          style: textTheme(context).labelLarge
                                              ?.copyWith(
                                                fontWeight: FontWeight.w500,
                                                color: AppColors.darkGrey,
                                              ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 5),
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 3,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.pink,
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                        child: Text(
                                          '50 % off just for items',
                                          style: textTheme(context).labelMedium
                                              ?.copyWith(
                                                fontSize: 10,
                                                color: colorScheme(context).surface,
                                                fontWeight: FontWeight.w600,
                                              ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                }),
                SizedBox(height: 20),
                Obx(() {
                  if (foodRestaurantController.isPopularBrandsLoading.value) {
                    return CustomShimmer(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: Dimensions.homePagePadding,
                            ),
                            child: Container(
                              height: 25,
                              width: 250,
                              decoration: BoxDecoration(
                                color: Colors.grey.withValues(alpha: 0.5),
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          SizedBox(
                            height: 75,
                            child: ListView.separated(
                              physics: NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.symmetric(
                                horizontal: Dimensions.homePagePadding,
                              ),
                              scrollDirection: Axis.horizontal,

                              separatorBuilder: (context, index) => SizedBox(width: 10),
                              shrinkWrap: true,
                              itemCount: 5,
                              itemBuilder: (context, index) {
                                return Container(
                                  width: 75,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.withValues(alpha: 0.5),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  if (foodRestaurantController.popularBrandRecords.isEmpty) {
                    return const Center(child: Text("No popular brand found"));
                  }
                  final popularBrandRecord =
                      foodRestaurantController.popularBrandRecords;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: Dimensions.homePagePadding,
                        ),
                        child: Text(
                          "Popular  Brands",
                          style: textTheme(context).titleLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      SizedBox(height: 12),
                      SizedBox(
                        height: 75,
                        child: ListView.separated(
                          separatorBuilder: (context, index) =>
                              SizedBox(width: 10),
                          scrollDirection: Axis.horizontal,
                          itemCount: popularBrandRecord.length,
                          padding: const EdgeInsets.symmetric(
                            horizontal: Dimensions.homePagePadding,
                          ),
                          itemBuilder: (context, index) {
                            final popularBrand = popularBrandRecord[index];
                            return InkWell(
                              onTap: () {
                                if (popularBrand.id == null) return;
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RestaurantDetailPage(
                                      id: (popularBrand.id ?? "").toString(),
                                    ),
                                  ),
                                );
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: CustomNetworkImage(
                                  imageUrl: popularBrand.bannerUrl ?? "",
                                  defaultImage: "assets/image/promotion.png",
                                  width: 75,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                }),

                SizedBox(height: 35),

                Obx(() {
                  if (foodRestaurantController.isBestSellerLoading.value) {
                    return CustomShimmer(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: Dimensions.homePagePadding,
                            ),
                            child: Column(
                              spacing: 8,
                              children: [
                                Container(
                                  height: 25,
                                  width: 250,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.withValues(alpha: 0.5),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                                Container(
                                  height: 18,
                                  width: 250,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.withValues(alpha: 0.5),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          ListView.separated(
                            physics: NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.symmetric(
                              horizontal: Dimensions.homePagePadding,
                              vertical: 10,
                            ),
                            separatorBuilder: (context, index) => SizedBox(height: 10),
                            shrinkWrap: true,
                            itemCount: 5,
                            itemBuilder: (context, index) {
                              return Container(
                                height: 100,
                                width: size.width,
                                decoration: BoxDecoration(
                                  color: Colors.grey.withValues(alpha: 0.5),

                                  borderRadius: BorderRadius.circular(8),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  }
                  if (foodRestaurantController.bestSellerRestaurants.isEmpty) {
                    return const Center(child: Text("No restaurants found"));
                  }
                  final bestSellerRestaurant =
                      foodRestaurantController.bestSellerRestaurants;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: Dimensions.homePagePadding,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: 5,
                              children: [
                                Text(
                                  "Best Sellers 🔥",
                                  style: textTheme(context).titleLarge?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                    height: 1.0,
                                  ),
                                ),

                                Text(
                                  "Satisfy cravings from top restaurents!",
                                  style: textTheme(context).labelLarge?.copyWith(
                                    height: 1.0,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    color: AppColors.darkGrey,
                                  ),
                                ),
                              ],
                            ),
                            Icon(Icons.arrow_forward_outlined, size: 20),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      SizedBox(
                        height: 320,
                        width: size.width,
                        child: GridView.builder(
                          shrinkWrap: true,
                          itemCount: bestSellerRestaurant.length,
                          padding: EdgeInsets.symmetric(
                            horizontal: Dimensions.homePagePadding,
                            vertical: 10,
                          ),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 7,
                            crossAxisSpacing: 7,
                            childAspectRatio: 0.31,
                          ),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            final bestSellerR = bestSellerRestaurant[index];
                            return InkWell(
                              onTap: () {
                                if (bestSellerR.id == null) return;
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RestaurantDetailPage(
                                      id: (bestSellerR.id ?? "").toString(),
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                width: size.width * 0.8,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Theme.of(context).cardColor,
                                  boxShadow: [AppConstants.boxShadow],
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.horizontal(
                                        left: Radius.circular(8),
                                      ),
                                      child: CustomNetworkImage(
                                        imageUrl: bestSellerR.bannerUrl ?? "",
                                        height: size.height,
                                        defaultImage: "assets/image/promotion.png",
                                        width: size.width * 0.25,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              bestSellerR.name ?? "",
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: textTheme(context).bodyMedium
                                                  ?.copyWith(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 12,
                                                    color: colorScheme(
                                                      context,
                                                    ).onSurface,
                                                  ),
                                            ),
                                            const SizedBox(height: 2),
                                            // FIXED: Rating Row
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.star,
                                                  color: colorScheme(
                                                    context,
                                                  ).primary,
                                                  size: 13,
                                                ),
                                                const SizedBox(width: 3),
                                                Text(
                                                  bestSellerR.rating ?? "",
                                                  style: textTheme(context)
                                                      .labelLarge
                                                      ?.copyWith(
                                                        fontWeight: FontWeight.w600,
                                                        fontSize: 12,
                                                        color: colorScheme(
                                                          context,
                                                        ).primary,
                                                      ),
                                                ),
                                                const SizedBox(width: 5),
                                                Icon(
                                                  Icons.brightness_1_rounded,
                                                  size: 4,
                                                ),
                                                const SizedBox(width: 5),
                                                Expanded(
                                                  child: Text(
                                                    bestSellerR
                                                            .deliveryTimeRange ??
                                                        "",
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: textTheme(context)
                                                        .bodySmall
                                                        ?.copyWith(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 12,
                                                          color: colorScheme(
                                                            context,
                                                          ).onSurface,
                                                        ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 2),
                                            // FIXED: Location Row
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Flexible(
                                                  child: Text(
                                                    bestSellerR.fullAddress ?? "",
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: textTheme(context)
                                                        .labelLarge
                                                        ?.copyWith(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 12,
                                                          color: AppColors.darkGrey,
                                                        ),
                                                  ),
                                                ),
                                                const SizedBox(width: 5),
                                                Icon(
                                                  Icons.brightness_1_rounded,
                                                  size: 4,
                                                  color: AppColors.darkGrey,
                                                ),
                                                const SizedBox(width: 5),
                                                Text(
                                                  bestSellerR.deliveryFee ?? "",
                                                  style: textTheme(context)
                                                      .labelLarge
                                                      ?.copyWith(
                                                        fontWeight: FontWeight.w600,
                                                        fontSize: 12,
                                                        color: AppColors.darkGrey,
                                                      ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 6),
                                            // FIXED: Discount Row
                                            Row(
                                              children: [
                                                Container(
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                        horizontal: 8,
                                                        vertical: 4.5,
                                                      ),
                                                  decoration: BoxDecoration(
                                                    color: Colors.pink,
                                                    borderRadius:
                                                        BorderRadius.circular(4),
                                                  ),
                                                  child: Text(
                                                    '50% off',
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                    textAlign: TextAlign.center,
                                                    style: textTheme(context)
                                                        .labelMedium
                                                        ?.copyWith(
                                                          fontSize: 9,
                                                          height: 1.0,
                                                          color: colorScheme(
                                                            context,
                                                          ).surface,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                  ),
                                                ),
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
                      ),
                    ],
                  );
                }),

                SizedBox(height: 20),


                Obx(() {
                  if (foodRestaurantController.isNearByLoading.value) {
                    return CustomShimmer(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: Dimensions.homePagePadding,
                            ),
                            child: Column(
                              spacing: 8,
                              children: [
                                Container(
                                  height: 25,
                                  width: 250,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.withValues(alpha: 0.5),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                                Container(
                                  height: 20,
                                  width: 250,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.withValues(alpha: 0.5),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          SizedBox(
                            height: 240,
                            width: size.width,
                            child: ListView.separated(
                              padding: const EdgeInsets.symmetric(
                                horizontal: Dimensions.homePagePadding,
                                vertical: 10,
                              ),
                              scrollDirection: Axis.horizontal,
                              itemCount: 5,
                              separatorBuilder: (context, index) => SizedBox(width: 15),
                              itemBuilder: (context, index) {
                                return Container(
                                  width: size.width * 0.45,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.withValues(alpha: 0.5),

                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                );

                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  if (foodRestaurantController.nearByRestaurants.isEmpty) {
                    return const Center(child: Text("No restaurants found"));
                  }
                  final nearByRestaurants =
                      foodRestaurantController.nearByRestaurants;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: Dimensions.homePagePadding,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: 5,
                              children: [
                                Text(
                                  "Nearby  ⚡",
                                  style: textTheme(context).titleLarge?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                    height: 1.0,
                                  ),
                                ),

                                Text(
                                  "Savor the speedy goodness!",
                                  style: textTheme(context).labelLarge?.copyWith(
                                    height: 1.0,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    color: AppColors.darkGrey,
                                  ),
                                ),
                              ],
                            ),
                            Icon(Icons.arrow_forward_outlined, size: 20),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      SizedBox(
                        height: 240,
                        child: ListView.separated(
                          separatorBuilder: (context, index) => SizedBox(width: 10),
                          padding: EdgeInsets.symmetric(
                            horizontal: Dimensions.homePagePadding,
                            vertical: 10,
                          ),
                          scrollDirection: Axis.horizontal,
                          itemCount: nearByRestaurants.length,
                          itemBuilder: (context, index) {
                            // final burger = nearby[index];
                            final nearByR = nearByRestaurants[index];
                            return InkWell(
                              onTap: () {
                                if (nearByR.id == null) return;
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RestaurantDetailPage(
                                      id: (nearByR.id ?? "").toString(),
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                width: size.width * 0.42,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).cardColor,
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: [AppConstants.boxShadow],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(8),
                                        topRight: Radius.circular(8),
                                      ),
                                      child: CustomNetworkImage(
                                        imageUrl: nearByR.bannerUrl ?? "",
                                        defaultImage: "assets/image/promotion.png",
                                        height: 100,
                                        width: size.width,
                                        fit: BoxFit.cover,
                                      ),
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                        8,
                                        8,
                                        8,
                                        8,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            nearByR.name ?? "",
                                            style: textTheme(context).bodyMedium
                                                ?.copyWith(
                                                  fontWeight: FontWeight.w600,
                                                  color: colorScheme(
                                                    context,
                                                  ).onSurface,
                                                ),
                                          ),
                                          SizedBox(height: 2),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.star,
                                                color: colorScheme(context).primary,
                                                size: 13,
                                              ),
                                              const SizedBox(width: 4),
                                              Text(
                                                nearByR.rating ?? "",
                                                style: textTheme(context).labelLarge
                                                    ?.copyWith(
                                                      fontWeight: FontWeight.w600,
                                                      color: colorScheme(
                                                        context,
                                                      ).primary,
                                                    ),
                                              ),
                                              const SizedBox(width: 6),
                                              Icon(
                                                Icons.brightness_1_rounded,
                                                size: 4,
                                              ),
                                              const SizedBox(width: 4),
                                              Text(
                                                nearByR.deliveryTimeRange ?? "",
                                                style: textTheme(context).bodySmall
                                                    ?.copyWith(
                                                      fontWeight: FontWeight.w600,
                                                      color: colorScheme(
                                                        context,
                                                      ).onSurface,
                                                    ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 2),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  nearByR.fullAddress ?? "",
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: textTheme(context)
                                                      .labelLarge
                                                      ?.copyWith(
                                                        fontWeight: FontWeight.w600,
                                                        color: AppColors.darkGrey,
                                                      ),
                                                ),
                                              ),
                                              const SizedBox(width: 8),
                                              Icon(
                                                Icons.brightness_1_rounded,
                                                size: 4,
                                              ),
                                              const SizedBox(width: 4),
                                              Text(
                                                nearByR.deliveryFee ?? "",
                                                style: textTheme(context).labelLarge
                                                    ?.copyWith(
                                                      fontWeight: FontWeight.w600,
                                                      color: AppColors.darkGrey,
                                                    ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 13),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 8,
                                              vertical: 5,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colors.pink,
                                              borderRadius: BorderRadius.circular(
                                                4,
                                              ),
                                            ),
                                            child: Text(
                                              '50 % off just for items',
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: textTheme(context).labelMedium
                                                  ?.copyWith(
                                                    height: 1.0,
                                                    color: colorScheme(
                                                      context,
                                                    ).surface,
                                                    fontWeight: FontWeight.bold,
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
                        ),
                      ),
                    ],
                  );
                }),
                SizedBox(height: 20),


                Obx(() {
                  if (foodRestaurantController.isAllLoading.value) {
                    return CustomShimmer(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: Dimensions.homePagePadding,
                            ),
                            child: Column(
                              spacing: 8,
                              children: [
                                Container(
                                  height: 25,
                                  width: 250,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.withValues(alpha: 0.5),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          ListView.separated(
                            physics: NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.symmetric(
                              horizontal: Dimensions.homePagePadding,
                              vertical: 10,
                            ),
                            separatorBuilder: (context, index) => SizedBox(height: 10),
                            shrinkWrap: true,
                            itemCount: 5,
                            itemBuilder: (context, index) {
                              return Container(
                                height: 125,
                                width: size.width,
                                decoration: BoxDecoration(
                                  color: Colors.grey.withValues(alpha: 0.5),

                                  borderRadius: BorderRadius.circular(8),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  }
                  if (foodRestaurantController.allRestaurants.isEmpty) {
                    return const Center(child: Text("No restaurants found"));
                  }
                  final allRestaurants =
                      foodRestaurantController.allRestaurants;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: Dimensions.homePagePadding,
                        ),
                        child: Text(
                          "All Restaurants",
                          style: textTheme(context).titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      ListView.separated(
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.symmetric(
                          horizontal: Dimensions.homePagePadding,
                          vertical: 10,
                        ),
                        separatorBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15.0),
                          child: Divider(
                            color: Theme.of(
                              context,
                            ).hintColor.withValues(alpha: 0.05),
                            height: 0.1,
                            thickness: 0.8,
                          ),
                        ),
                        shrinkWrap: true,
                        itemCount: allRestaurants.length,
                        itemBuilder: (context, index) {
                          final allR = allRestaurants[index];
                          return InkWell(
                            onTap: () {
                              if (allR.id == null) return;
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RestaurantDetailPage(
                                    id: (allR.id ?? "").toString(),
                                  ),
                                ),
                              );
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
                                    child: CustomNetworkImage(
                                      imageUrl: allR.bannerUrl ?? "",
                                      defaultImage: "assets/image/promotion.png",
                                      height: 125,
                                      width: size.width * 0.28,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                allR.name ?? "",
                                                style: textTheme(context).bodyMedium
                                                    ?.copyWith(
                                                      fontWeight: FontWeight.w600,
                                                      fontSize: 15,
                                                      color: colorScheme(
                                                        context,
                                                      ).onSurface,
                                                    ),
                                              ),
                                              SizedBox(height: 2),
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.star,
                                                    color: colorScheme(
                                                      context,
                                                    ).primary,
                                                    size: 18,
                                                  ),
                                                  const SizedBox(width: 4),
                                                  Text(
                                                    allR.rating ?? "",
                                                    style: textTheme(context)
                                                        .labelLarge
                                                        ?.copyWith(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 13,
                                                          color: colorScheme(
                                                            context,
                                                          ).primary,
                                                        ),
                                                  ),
                                                  const SizedBox(width: 4),
                                                  Text(
                                                    "(${allR.totalReviews ?? ""}+)",
                                                    style: textTheme(context)
                                                        .labelLarge
                                                        ?.copyWith(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 13,
                                                        ),
                                                  ),
                                                  const SizedBox(width: 8),
                                                  Icon(
                                                    Icons.brightness_1_rounded,
                                                    color: colorScheme(
                                                      context,
                                                    ).onSurface,
                                                    size: 5,
                                                  ),
                                                  const SizedBox(width: 8),
                                                  Text(
                                                    allR.deliveryTimeRange ?? "",
                                                    style: textTheme(context)
                                                        .bodySmall
                                                        ?.copyWith(
                                                          fontSize: 13,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: colorScheme(
                                                            context,
                                                          ).primary,
                                                        ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 2),
                                              Row(
                                                children: [
                                                  Flexible(
                                                    child: Text(
                                                      allR.cuisineType ?? "",
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: textTheme(context)
                                                          .labelLarge
                                                          ?.copyWith(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                AppColors.darkGrey,
                                                            fontSize: 12,
                                                          ),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 6),
                                                  Icon(
                                                    Icons.brightness_1_rounded,
                                                    color: colorScheme(
                                                      context,
                                                    ).onSurface,
                                                    size: 4,
                                                  ),
                                                  const SizedBox(width: 6),
                                                  Text(
                                                    "\$\$\$",
                                                    style: textTheme(context)
                                                        .bodySmall
                                                        ?.copyWith(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 2),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      allR.fullAddress ?? "",
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: textTheme(context)
                                                          .labelLarge
                                                          ?.copyWith(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 12,

                                                            color:
                                                                AppColors.darkGrey,
                                                          ),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 6),
                                                  Icon(
                                                    Icons.brightness_1_rounded,
                                                    color: Colors.black54,
                                                    size: 4,
                                                  ),
                                                  const SizedBox(width: 6),
                                                  Text(
                                                    allR.deliveryFee ?? "",
                                                    style: textTheme(context)
                                                        .labelLarge
                                                        ?.copyWith(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 12,
                                                          color: AppColors.darkGrey,
                                                        ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                padding: const EdgeInsets.symmetric(
                                                  horizontal: 8,
                                                  vertical: 5,
                                                ),
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
                                                        color: colorScheme(
                                                          context,
                                                        ).surface,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                ),
                                              ),
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
                    ],
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
