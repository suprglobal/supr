import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:superapp/constants/app_colors.dart';
import 'package:superapp/constants/app_images.dart';
import 'package:superapp/constants/constants.dart';
import 'package:superapp/constants/global_variables.dart';
import 'package:superapp/views/pages/home/widgets/top_sheet.dart';
import 'package:superapp/views/pages/home_services/screens/home_cleaning_service_details_screen.dart';
import 'package:superapp/widgets/custom_network_image.dart';

class HomeServicesScreen extends StatefulWidget {
  const HomeServicesScreen({super.key});

  @override
  State<HomeServicesScreen> createState() => _HomeServicesScreenState();
}

class _HomeServicesScreenState extends State<HomeServicesScreen> {

  final List<String> images = [
    AppImages.homeCleaning,
    AppImages.acCleaning,
    AppImages.furnitureCleaning,
    AppImages.kitchenCleaning,
  ];
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
            const SizedBox(width: 3),
            Text(
              "HomeServices",
              style: textTheme(
                context,
              ).bodyLarge?.copyWith(fontWeight: FontWeight.bold, fontSize: 20,
                color: Theme.of(context).primaryColor
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
      body: SafeArea(child: ListView(
        children: [
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimensions.homePagePadding),
            child: Text("Top Offers",
                style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w600
                )),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 190,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: images.length,
              padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.homePagePadding,
              ),
              separatorBuilder: (context, index) => SizedBox(width: 10),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Get.to(HomeCleaningServiceDetailsScreen());                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                         images[index],
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size .width * 0.4
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 25),
        ],
      )),
    );
  }
}
