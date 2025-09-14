
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:superapp/constants/app_colors.dart';
import 'package:superapp/constants/app_images.dart';
import 'package:superapp/constants/constants.dart';
import 'package:superapp/constants/global_variables.dart';
import 'package:superapp/views/pages/food/controller/restaurant_detail_controller.dart';
import 'package:superapp/views/pages/food/pages/check_out_page.dart';
import 'package:superapp/views/pages/food/widgets/custom_bottom_sheet.dart';
import 'package:superapp/views/pages/food/widgets/custom_offer_bottom_sheet.dart';
import 'package:superapp/views/pages/food/widgets/custom_row.dart';
import 'package:superapp/views/pages/food/widgets/custom_title_container.dart';
import 'package:superapp/views/pages/food/widgets/food_container.dart';
import 'package:superapp/views/pages/food/widgets/food_item_card.dart';
import 'package:superapp/views/pages/food/widgets/food_product_detail_sheet.dart';
import 'package:superapp/views/pages/food/widgets/menu_categories_bottom_sheet.dart';
import 'package:superapp/views/pages/food/widgets/tabbar_deligation.dart';
import 'package:superapp/widgets/custom_network_image.dart';

class RestaurantDetailPage extends StatefulWidget {
  final String id;

  const RestaurantDetailPage({super.key, required this.id});

  @override
  State<RestaurantDetailPage> createState() => _RestaurantDetailPageState();
}

class _RestaurantDetailPageState extends State<RestaurantDetailPage>
    with TickerProviderStateMixin {
  final restaurantsDetailController = Get.put(RestaurantsDetailController());

  TabController? _tabController;
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _foodKey = GlobalKey();
  final GlobalKey _beveragesKey = GlobalKey();

  var width;
  @override
  void initState() {
    super.initState();
    restaurantsDetailController.fetchRestaurantsDetails(widget.id);
  }

  void _initializeTabController(int length) {
    _tabController?.dispose();
    _tabController = TabController(length: length, vsync: this);
    _tabController!.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    if (_tabController == null || _tabController!.indexIsChanging) return;
    final context = _tabController!.index == 0
        ? _foodKey.currentContext
        : _beveragesKey.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 300),
      );
    }
  }

  void openGroupOrderSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(2)),
      ),
      builder: (_) => const GroupOrderBottomSheet(),
    );
  }

  void showOfferBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => const OfferBottomSheet(),
    );
  }

  void showProductBottomSheet(BuildContext context,String id) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) =>  ProductDetailSheet(id: id),
    );
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;

    return Scaffold(
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          boxShadow: [AppConstants.boxShadow],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '₹17.0',
              style: textTheme(context).titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CheckOutPage()),
                );
              },
              child: Container(
                height: 52,
                width: 165,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 42, 70, 55),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: colorScheme(context).secondary,
                      ),
                      child: Center(
                        child: Text(
                          '1',
                          style: TextStyle(
                            color: colorScheme(context).primary,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'View Basket',
                      style: TextStyle(
                        color: colorScheme(context).secondary,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        top: false,
        bottom: true,
        child: Obx(() {
          if (restaurantsDetailController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          final restaurant = restaurantsDetailController.restaurantDetailRecord.value;
          final categories = restaurant?.categories ?? [];

          if (restaurant == null) {
            return const Center(child: Text("No restaurant found"));
          }

          // Initialize TabController safely when categories are ready
          if (categories.isNotEmpty && _tabController == null) {
            _initializeTabController(categories.length);
          }
          log("categories ${categories.length}");



          return CustomScrollView(
            slivers: [
              // Keep your existing SliverAppBar
              SliverAppBar(
                expandedHeight: 525,
                pinned: true,
                floating: false,
                leadingWidth: 68,
                leading: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: Dimensions.homePagePadding,
                  ),
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: colorScheme(context).surface,
                        border: Border.all(
                          color: Theme.of(context).hintColor.withValues(alpha: 0.1),
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.arrow_back,
                        color: colorScheme(context).onSurface,
                        size: 20,
                      ),
                    ),
                  ),
                ),
                backgroundColor: Colors.white,
                scrolledUnderElevation: 0,
                flexibleSpace: FlexibleSpaceBar(
                  title: LayoutBuilder(
                    builder: (BuildContext context, BoxConstraints constraints) {
                      final isCollapsed =
                          constraints.maxHeight <= kToolbarHeight + MediaQuery.of(context).padding.top;
                      return isCollapsed
                          ? SafeArea(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 10),
                            Text(
                              restaurant.name ?? "",
                              style: textTheme(context).labelLarge?.copyWith(
                                color: Colors.black,
                                fontSize: 15,
                                height: 1.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              restaurant.deliveryTimeRange ?? "",
                              style: textTheme(context).bodySmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 11,
                                height: 1.0,
                              ),
                            ),
                          ],
                        ),
                      )
                          : SizedBox();
                    },
                  ),
                  background: Stack(
                    children: [
                      SizedBox(
                        width: width,
                        child: Column(
                          children: [
                            CustomNetworkImage(
                              imageUrl: restaurant.bannerUrl ?? "",
                              height:300,
                              width: width,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(height: 40),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: Dimensions.homePagePadding),
                              width: width,
                              child: Column(
                                children: [
                                  CustomTitleContainer(
                                    title: restaurant.name ?? "",
                                    location: restaurant.fullAddress ?? "",
                                    distance: restaurant.deliveryRadius ?? "",
                                    rating: restaurant.rating ?? "",
                                    norating: (restaurant.totalReviews ?? "").toString(),
                                  ),
                                  SizedBox(height: 12),
                                  FoodContainer(
                                    time: restaurant.deliveryTimeRange ?? "",
                                    price: "\₹\₹\₹",
                                    fee: restaurant.deliveryFee ?? "",
                                  ),
                                  const SizedBox(height: 10),
                                  CustomRow(
                                    discount: "50 % off just for items",
                                    onTap: () {
                                      showOfferBottomSheet(context);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top:260,
                        left: Dimensions.homePagePadding,
                        child: customStackContainer(
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: CustomNetworkImage(
                              imageUrl: restaurant.logoUrl ?? "",
                              defaultImage: AppImages.abcd,
                              height: 70,
                              width: 70,
                            ),
                          ),
                              () {},
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(child: SizedBox(height: 15)),
              SliverToBoxAdapter(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 4),
                  color: Colors.grey.withValues(alpha: 0.2),
                ),
              ),

              // Safely build TabBar only if tabController is available
              if (_tabController != null)
                SliverPersistentHeader(
                  pinned: true,
                  delegate: SliverAppBarDelegate(
                    TabBar(
                      tabAlignment: TabAlignment.start,
                      labelStyle: textTheme(context).bodySmall?.copyWith(fontWeight: FontWeight.bold),
                      controller: _tabController,
                      labelColor: Colors.black,
                      indicatorColor: Colors.teal,
                      dividerColor: Colors.white,
                      padding: EdgeInsets.zero,
                      indicatorPadding: const EdgeInsets.symmetric(horizontal: 5),
                      isScrollable: true,
                      labelPadding: const EdgeInsets.symmetric(horizontal: 10),
                      onTap: (index) {},
                      tabs: categories.map((text) => Tab(text: text.name ?? "")).toList(),
                    ),
                    InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          backgroundColor: Colors.white,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                          ),
                          builder: (_) => MenuCategoriesBottomSheet(),
                        );
                      },
                      child: Container(
                        child: Icon(Icons.menu, color: Colors.black54),
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: Dimensions.homePagePadding,
                        ),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ),
                ),

              SliverToBoxAdapter(
                child: ListView.separated(
                  controller: _scrollController,
                  separatorBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.symmetric(vertical: 4),
                      color: Colors.grey.withValues(alpha: 0.2),
                    );
                  },
                  shrinkWrap: true,
                  itemCount: categories.length,
                  padding: EdgeInsets.zero,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 12, top: 15),
                          child: Text(
                            category.name ?? "",
                            style: textTheme(context).titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        ListView.separated(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          separatorBuilder: (context, index) =>
                          const Divider(color: AppColors.appGrey),
                          itemCount: category.products?.length ?? 0,
                          itemBuilder: (context, i) {
                            final product = category.products?[i];
                            return FoodItemCardWidget(
                              title: product?.name ?? "",
                              description: product?.description ?? "",
                              imageUrl: AppImages.award,
                              price: double.tryParse(product?.finalPrice ?? "") ?? 0,
                              oldPrice: double.tryParse(product?.originalPrice ?? "") ?? 0,
                              discount: 50,
                              product: product,
                            );
                          },
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget customIconContainer(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Theme.of(context).hintColor.withValues(alpha: 0.1)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, size: 16),
      ),
    );
  }

  Widget customStackContainer(Widget child, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [AppConstants.boxShadow],
          border: Border.all(
            color: Theme.of(context).hintColor.withValues(alpha: 0.1),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: child,
      ),
    );
  }

  @override
  void dispose() {
    _tabController?.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}

